const db = require('../Helpers/firebase.js')
const createError = require('http-errors')

const routeColleciton = db.collection('allRoutes');

const Add = async(route) => {
    const routeData = {

    }

    const routeRef = await routeColleciton.add(routeData);;
    return routeRef.id;
}

const GetRoutes = async() => {
    try {
        const routesSnapshot = await routeColleciton.get();
        if (routesSnapshot.empty) throw createError[404]('There is no routes');

        const routes = []
        routesSnapshot.forEach((doc) => {
            const routeData = doc.data();
            const routeId = doc.id
            routes.push({ id: routeId, ...routeData});
        });

        return routes;
    } catch (error) {
        throw error
    }
}


module.exports = {
    Add,
    GetRoutes,
}