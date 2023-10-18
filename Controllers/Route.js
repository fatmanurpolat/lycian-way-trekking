const Route = require("../Models/Route.js");
const { Add, GetRoutes } = require('../Repositories/RouteRepository.js');

const addRoute = async (req, res, next) => {
    try {
        const {
            altitude,
            difficulty,
            startPoint,
            endPoint,
            name,
            routeInformation
        } = req.body;

        const route = new Route(altitude,
            difficulty,
            startPoint,
            endPoint,
            name,
            routeInformation
        );

        const routeId = await Add(route);
        res.status(201).json({ id: routeId, message:'New Route successfully added.'});
    } catch (error) {
        next(error)
    }
}

const getRoutes = async(req,res,next) => {
    try {
        const routes = await GetRoutes();
        res.status(200).json(routes)
    } catch (error) {
        next(error)
    }
}

module.exports = {
    addRoute,
    getRoutes
}