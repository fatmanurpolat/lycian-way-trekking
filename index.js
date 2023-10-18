const express = require('express');
const dotenv = require('dotenv')
const bodyParser = require('body-parser')
const cors = require('cors')
const createError = require('http-errors')
const locaitonRoutes = require('./Routes/Location.js')
const userRoutes = require('./Routes/User.js')
const routeRoutes = require('./Routes/Route.js')

dotenv.config();
const app = express();
app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.json({ extended: true }))
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());






app.use('/api/location',locaitonRoutes);
app.use('/api/user',userRoutes);
app.use('/api/route',routeRoutes);


// Errors
app.use(async (req, res, next) => {
    next(createError.NotFound());
})

app.use((err, req, res, next) => {
    res.status(err.status || 500)
    res.send({
        error: {
            status: err.status || 500,
            message: err.message
        }
    })
})

app.listen(process.env.PORT, () => {
    console.log(`Server on ${process.env.PORT}`);
});
