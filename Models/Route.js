class Route {
    constructor(altitude, difficulty, startPoint, endPoint, name, routeInformation) {
        this.altitude = altitude;
        this.difficulty = difficulty;
        this.startPoint = startPoint;
        this.endPoint = endPoint;
        this.name = name;
        this.routeInformation = routeInformation;
    }
}

module.exports = Route