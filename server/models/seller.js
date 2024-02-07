const mongoose = require('mongoose');
const { productSchema } = require('./product');

const sellerSchema = mongoose.Schema({

    sellername: {
        required: true,
        type: String,
        trim: true
    },
    shopname: {
        required: true,
        type: String,
        trim: true
    },
    shopAddress: {
        required: true,
        type: String,
        trim: true
    },
    shopLicenseNumber: {
        required: true,
        type: String,
        trim: true
    },
    shopCategory: {
        required: true,
        type: String,
        trim: true
    },
    shopOwnershipType: {
        required: true,
        type: String,
        trim: true
    },
    phone: {
        type: String,
        default: '',
    },
    address: {
        type: String,
        default: '',
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter the valid email address",
        }
    },
    password: {
        required: true,
        type: String,
    },

    bankname: {
        type: String,
        default: '',
    },

    accountNumber: {
        type: String,
        default: '',
    },

    ifscCode: {
        type: String,
        default: '',
    },

    upiId: {
        type: String,
        default: '',
    },

    type: {
        type: String,
        default: 'seller'
    },


});

const Seller = mongoose.model("Seller", sellerSchema);
module.exports = Seller;