const express = require('express');
const sellerRouter = express.Router();
const seller_auth = require('../middlewares/seller_auth');
const { Product } = require('../models/product');
const Order = require('../models/order');


//Add Product
sellerRouter.post("/seller/add-product", seller_auth, async (req, res) => {

    try {

        const { name, description, images, quantity, price, category, sellerId, sellerShopName } = req.body;

        let product = Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
            sellerId,
            sellerShopName
        });

        product = await product.save();
        res.json(product); // send to client side

    }
    catch (e) {

        res.status(500).json({ error: e.message });
    }

});

sellerRouter.get("/seller/products/me", seller_auth, async (req, res) => {
    try {
        const products = await Product.find({ sellerId: req.seller });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//Delete the product

sellerRouter.post('/seller/delete-product', seller_auth, async (req, res) => {

    try {
        const { id } = req.body;

        let product = await Product.findByIdAndDelete(id);

        res.json(product);

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

sellerRouter.get('/seller/get-orders', seller_auth, async (req, res) => {

    try {

        const orders = await Order.find({ 'products.product.sellerId': req.seller, });
        res.json(orders);


    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

sellerRouter.post('/seller/change-order-status', seller_auth, async (req, res) => {

    try {
        const { id, status } = req.body;

        let order = await Order.findById(id);
        order.status = status;
        order = order.save();

        res.json(order);

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});


sellerRouter.get("/seller/analytics", seller_auth, async (req, res) => {
    try {
        const sellerId = req.seller;

        // Fetch all orders for the seller
        const orders = await Order.find({ 'products.product.sellerId': sellerId });
        let totalEarnings = 0;

        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings +=
                    orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }

        // CATEGORY WISE ORDER FETCHING
        let mobileEarnings = await fetchCategoryWiseProduct("Mobiles", sellerId);
        let essentialEarnings = await fetchCategoryWiseProduct("Essentials", sellerId);
        let applianceEarnings = await fetchCategoryWiseProduct("Appliances", sellerId);
        let booksEarnings = await fetchCategoryWiseProduct("Books", sellerId);
        let fashionEarnings = await fetchCategoryWiseProduct("Fashion", sellerId);

        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialEarnings,
            applianceEarnings,
            booksEarnings,
            fashionEarnings,
        };

        res.json(earnings);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Modify the fetchCategoryWiseProduct function to accept sellerId as a parameter
async function fetchCategoryWiseProduct(category, sellerId) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        "products.product.category": category,
        'products.product.sellerId': sellerId, // Filter by sellerId
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnings +=
                categoryOrders[i].products[j].quantity *
                categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}


module.exports = sellerRouter;

