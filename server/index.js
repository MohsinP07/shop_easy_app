//IMPORTS FROM PACKAGES
const express = require('express'); //importing same like flutter
const mongoose = require('mongoose');

//IMPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user')

//INIT
const PORT = 3000;
const DB = "mongodb+srv://mohsinp07:Mohsin1301@cluster0.snxpwog.mongodb.net/?retryWrites=true&w=majority";
const app = express(); //initialising the express and saving it in app variable


//MIDDLEWARE
app.use(express.json());//it passes incoming requests with json payloads
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//CLIENT -> middleware -> SERVER -> CLIENT


//Connections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Connected at port ${PORT}`);
});