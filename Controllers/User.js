const User = require('../Models/User.js')
const { Save, GetUsers } = require('../Repositories/UserRepository.js')



const saveUser = async(req,res,next) => {
    try {
        const { name, surname } = req.body;

        const user = new User(name,surname);
        const userId = await Save(user);

        res.status(201).json({ id: userId , message:'User successfully created.'})
    } catch (error) {
        next(error)
    }
}

const getUsers = async(req,res,next) => {
    try {
        const users = await GetUsers();
        res.status(200).json(users)
    } catch (error) {
        next(error)
    }
}



module.exports = {
    saveUser,
    getUsers
}