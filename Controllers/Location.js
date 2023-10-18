const Locaiton = require('../Models/Location.js')

const saveLocation = async(req,res,next) => {
    try {
        const { userId, latitude, longtude } = req.body;
        const location = new Locaiton(userId,latitude,longtude,"Any");
        // const locationId = location.save();
        
        res.status(201).json({message:"Location saved", location});
    } catch (error) {
        next(error)
    }    
    
}



module.exports = {
    saveLocation
}