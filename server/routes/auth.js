const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const authRouter = express.Router();

//SIGN UP ROUTE
authRouter.post('/api/signup', async (req, res) => {

    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email }); // to find any one document in user collection with the same email property

        if (existingUser) {
            return res.status(400).json({
                msg: "User with same email already exists!"
            });
        }

        const hashedPassword = await bcryptjs.hash(password, 8); // ecrypting the password, 8 is the salt not the length

        let user = new User({
            email,
            password: hashedPassword,
            name
        })

        user = await user.save();
        res.json(user); // send the data to client side


    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

    //get the data from client
    //post that data in database
    //return that data to user
});

//SIGN IN ROUTE 
authRouter.post('/api/signin', async (req, res) => {

    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400)
                .json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400)
                .json({ msg: "Incorrect password!" });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey"); //signing the id with jwt
        res.json({ token, ...user._doc })
        //{
        // 'token': 'tokenSomething,'  
        // 'name': 'Mohsin',
        // 'email': 'mohsinpatel.7@yahoo.com'   
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

//Checken token validity
authRouter.post('/tokenIsValid', async (req, res) => {

    try {

        const token = req.header('x-auth-token');
        if (!token) return res.json(false);

        const verified = jwt.verify(token, 'passwordKey');
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id); //verifying the id with jwt
        if (!user) return res.json(false);

        return res.json(true);

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }

});

// get user data

authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});

//Exporting so that it can be used by other files
module.exports = authRouter;