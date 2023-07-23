const mongoose = require("mongoose");
const { productSchema } = require("./product");
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please Enter a valid email address",
    },
  },
  password: {
    required: true,
    trim: true,
    validate: {
      validator: (value) => {

        return value.length > 6;
      },
      message: "Please Enter a long password",
    },
    type: String,
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  cart: [
     {
       product: productSchema,
       quantity:{type:Number,
       required:true}
     }]
});


const User = mongoose.model('user', userSchema);
module.exports = User;