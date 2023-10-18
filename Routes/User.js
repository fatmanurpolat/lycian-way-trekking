const express = require('express')
const { saveUser, getUsers } = require('../Controllers/User.js')

const router = express.Router();

router.post('/save', saveUser);
router.get('/users', getUsers);

module.exports = router