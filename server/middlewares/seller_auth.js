const jwt = require('jsonwebtoken');

const seller_auth = async (req, res, next) => {
    try {
        const token = req.header("x-auth-seller-token");
        if (!token) {
            return res.status(401).json({ msg: "No auth token, access denied!" });
        }
        const verified = jwt.verify(token, 'passwordKeySeller');
        if (!verified) return res.status(401).json({ msg: 'Token verification failed, authorization denied' });

        req.seller = verified.id;
        req.token = token;
        next();

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
}

module.exports = seller_auth;