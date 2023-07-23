const express = require("express");
const adminrouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../models/product");
const Order = require('../models/order')

adminrouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, price, description, category, quantity, images } = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });
        product = await product.save();
        res.json(product);

    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
}); // admin route1
///api to get all the product
adminrouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminrouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);

        res.json(product);
    }
    catch (e) {
        res.status(500).json({ error: e.message });

    }


});


adminrouter.get('/admin/get-orders', admin, async (re, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


adminrouter.post("/admin/change-order-status", admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }


});

adminrouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const orders = await Order.find({});
        let totalEarnings = 0;
        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }

        }
        //category wise order fetching
        let mobileEarnings = await fetchCategoryWiseProduct('Mobiles');
        let BooksEarnings = await fetchCategoryWiseProduct('Books');
        let EssentialsEarnings = await fetchCategoryWiseProduct('Essentials');
        let AppliancesEarnings = await fetchCategoryWiseProduct('Appliances');
        let FashionEarnings = await fetchCategoryWiseProduct('Fashion');
        
        let earnings = {
            totalEarnings,
            mobileEarnings,
            EssentialsEarnings,
            BooksEarnings,
            AppliancesEarnings,
            FashionEarnings
        }
        res.json(earnings); 


    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
async function fetchCategoryWiseProduct(category) {
    let earnings = 0;
    let categoryOrders = await Order.find({
        'products.product.category': category
    });

    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j <  categoryOrders[i].products.length; j++) {
            earnings += categoryOrders[i].products[j].quantity *  categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}


module.exports = adminrouter;   


