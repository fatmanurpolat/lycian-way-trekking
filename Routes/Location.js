const express = require('express');
const { saveLocation } = require('../Controllers/Location.js')


const router = express.Router();

router.post('/save',saveLocation);

module.exports = router