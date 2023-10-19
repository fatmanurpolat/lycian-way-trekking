const db = require('../Helpers/firebase.js');
const admin = require('firebase-admin')
const createError = require('http-errors')

const usersCollection = db.collection('user')

const Save = async(user) => {
    try {
        const userData = {
            name: user.name,
            surname: user.surname
        }
        const userRef = await usersCollection.add(userData);
    
        return userRef.id;
    } catch (error) {
        throw error
    }
} 

const GetUsers = async() => {
    try {
        const usersSnapshot = await usersCollection.get();
        if (usersSnapshot.empty) throw createError[404]('There is no users');
        
        const users = []
        usersSnapshot.forEach((doc) => {
            const userData = doc.data();
            const userId = doc.id;
            users.push({ id: userId, ...userData });
        }) ;
        
        return users
    } catch (error) {
        throw error
    }
}

const GetUserById = async(id) => {
    try {
        const userRecord = await admin.auth().getUser(id);
        const userData = userRecord.toJSON();
        return userData;
    } catch (error) {
        console.log(error);
        throw error
    }
}


module.exports = {
    Save,
    GetUsers,
    GetUserById
}