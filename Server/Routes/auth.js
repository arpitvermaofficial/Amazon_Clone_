const express =require("express");
const authrouter=express.Router();
const User=require("../models/user");
const bcryptjs=require("bcrypt");
const jwt=require("jsonwebtoken");
const auth=require("../middleware/auth.js")

authrouter.post("/api/signup",async (req,res)=>{
    const {name,email,password}=req.body;
    try{
        const existinguser=await User.findOne({email});
    if(existinguser){
       return  res.status(400).json({'msg':"user with same email is already exist"})
    }
    const hashpassword=await bcryptjs.hash(password,8);
    let user=new User({
        email,
        password:hashpassword,
        name,
    })
    user=await user.save();
    res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }
    

}); // signup route
////Signin route
authrouter.post("/api/signin",async (req,res)=>{
     try{
        const {email,password}=req.body;
        const user=await User.findOne({email});
        if(!user){
            return res.status(400).json({msg:"user with this email is not exist"});
        }
        const ismatch=await bcryptjs.compare(password,user.password);
        if(!ismatch){
            return res.status(400).json({msg:"Incorrect password"});
        }
        const token=jwt.sign({id:user._id},"passwordkey");
        res.json({token,...user._doc});
         
     }
     catch(e){ 
        res.status(500).json({error:e.message});
     }
}); // signin route


authrouter.post("/tokenIsvalid",async (req,res)=>{
    try{
      const token=req.header("x-auth-token");
      if(!token){
          return res.json(false);
      }
      const verified=jwt.verify(token,"passwordkey");
      if(!verified){
        return res.json(false);
      }
      const user=await User.findById(verified.id);
      if(!user){
        return res.json(false);
      }
      res.json(true);
        
    }
    catch(e){ 
       res.status(500).json({error:e.message});
    }
}); // tokenvsalidation route

//get user data
authrouter.get("/", auth,async (req,res)=>{

    const user=await User.findById(req.user);
    res.json({  ...user._doc,token :req.token});
});


module.exports=authrouter;