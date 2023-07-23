const serverless = require('serverless-http');
const express = require("express");
const authrouter = require("./Routes/auth");
const mongoose = require("mongoose");
const adminrouter = require("./Routes/admin");
const productrouter=require("./Routes/product");
const userrouter=require("./Routes/user");

const PORT = process.env.PORT|| 3000;
const app = express();
const db="mongodb+srv://username:password@cluster0.qakp2nr.mongodb.net/?retryWrites=true&w=majority"
app.use(express.json());
app.use(authrouter);
app.use(adminrouter);
app.use(productrouter);
app.use(userrouter);

mongoose
    .connect(db)
    .then(() => {
        console.log("Connected to database");
    })
    .catch((err) => {
        console.log("Error connecting to database");
    }); // connect to database
app.listen(PORT, "0.0.0.0",() => {
    console.log(`Server is running on port ${PORT}`);
}); // listen to port 3000
module.exports.handler = serverless(app);