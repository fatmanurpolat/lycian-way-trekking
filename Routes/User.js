const express = require('express')
const { saveUser, getUsers, getUserById } = require('../Controllers/User.js')

const router = express.Router();

router.post('/save', saveUser);
router.get('/users', getUsers);
router.get('/:userId', getUserById);

module.exports = router