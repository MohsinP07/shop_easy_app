const express = require('express');
const Seller = require('../models/seller');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const sellerAuthRouter = express.Router();
const seller_auth = require('../middlewares/seller_auth');
const { Product } = require('../models/product');

//SIGN UP ROUTE FOR SELLER
sellerAuthRouter.post('/seller/signup', async (req, res) => {

    try {
        const { sellername, shopname, shopAddress, shopLicenseNumber, shopCategory, shopOwnershipType, phone, address, email, password, bankname, accountNumber, ifscCode, upiId } = req.body;

        const existingSeller = await Seller.findOne({ email }); // to find any one document in seller collection with the same email property

        if (existingSeller) {
            return res.status(400).json({
                msg: "Seller with same email already exists!"
            });
        }

        const hashedPassword = await bcryptjs.hash(password, 8); // ecrypting the password, 8 is the salt not the length

        let seller = new Seller({
            sellername,
            shopname,
            shopAddress,
            shopLicenseNumber,
            shopCategory,
            shopOwnershipType,
            phone,
            address,
            email,
            password: hashedPassword,
            bankname,
            accountNumber,
            ifscCode,
            upiId
        })
        console.log(seller);
        seller = await seller.save();
        res.json(seller); // send the data to client side


    }
    catch (e) {

        res.status(500).json({ error: e.message });
    }

    //get the data from client
    //post that data in database
    //return that data to user
});

//SIGN IN ROUTE FOR SELLER
sellerAuthRouter.post('/seller/signin', async (req, res) => {

    try {
        const { email, password } = req.body;

        const seller = await Seller.findOne({ email });
        if (!seller) {
            return res.status(400)
                .json({ msg: "Seller with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, seller.password);
        if (!isMatch) {
            return res.status(400)
                .json({ msg: "Incorrect password!" });
        }

        const token = jwt.sign({ id: seller._id }, "passwordKeySeller"); //signing the id with jwt
        res.json({ token, ...seller._doc })
        //{
        // 'token': 'tokenSomething,'  
        // 'name': 'Mohsin',
        // 'email': 'mohsinpatel.7@yahoo.com'   
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

//Add a new route for updating user information
sellerAuthRouter.put('/seller/updateProfile', seller_auth, async (req, res) => {
    try {
        const sellerId = req.seller; // Get the user ID from the authenticated user
        const { sellername, address, phone } = req.body; // Get the updated information

        // Update the user's information in the database
        await Seller.findByIdAndUpdate(sellerId, { sellername, address, phone });

        res.json({ msg: "Seller information updated successfully" });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

sellerAuthRouter.put('/seller/updateBankDetails', seller_auth, async (req, res) => {
    try {
        const sellerId = req.seller; // Get the user ID from the authenticated seller
        const { bankname, accountNumber, ifscCode, upiId } = req.body; // Get the updated information

        // Update the sellers's information in the database
        await Seller.findByIdAndUpdate(sellerId, { bankname, accountNumber, ifscCode, upiId });

        res.json({ msg: "Seller bank information updated successfully" });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

sellerAuthRouter.put('/seller/updateShopDetails', seller_auth, async (req, res) => {
    try {
        const sellerId = req.seller; // Get the user ID from the authenticated seller
        const { shopname, shopAddress, shopLicenseNumber, shopCategory, shopOwnershipType } = req.body; // Get the updated information

        // Update the sellers's information in the database
        await Seller.findByIdAndUpdate(sellerId, { shopname, shopAddress, shopLicenseNumber, shopCategory, shopOwnershipType });

        res.json({ msg: "Seller shop information updated successfully" });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


//Checken token validity
sellerAuthRouter.post('/tokenIsValidSeller', async (req, res) => {

    try {

        const token = req.header('x-auth-seller-token');
        if (!token) return res.json(false);

        const verified = jwt.verify(token, 'passwordKeySeller');
        if (!verified) return res.json(false);

        const seller = await Seller.findById(verified.id); //verifying the id with jwt
        if (!seller) return res.json(false);

        return res.json(true);

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

// get seller data
sellerAuthRouter.get('/', seller_auth, async (req, res) => {
    const seller = await Seller.findById(req.seller);
    res.json({ ...seller._doc, token: req.token });
});

//Exporting so that it can be used by other files
module.exports = sellerAuthRouter;