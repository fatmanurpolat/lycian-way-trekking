const express = require('express')
const { addRoute, getRoutes } = require('../Controllers/Route.js');

const router = express.Router();

router.post('/add', addRoute);
router.get('/routes', getRoutes);

module.exports = router