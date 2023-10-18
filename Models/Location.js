class Location {
    constructor(userId, latitude, longitude, timestamp) {
        this.userId = userId;
        this.latitude = latitude;
        this.longitude = longitude;
        this.timestamp = timestamp || admin.firestore.FieldValue.serverTimestamp();
    }

    async save() {
        const docRef = await db.collection('locations').add({
            userId: this.userId,
            latitude: this.latitude,
            longitude: this.longitude,
            timestamp: this.timestamp,
        });
        return docRef.id;
    }

    static async getLocationsByUserId(userId) {
        const querySnapshot = await db.collection('locations')
            .where('userId', '==', userId)
            .orderBy('timestamp', 'desc')
            .get();

        const locations = [];
        querySnapshot.forEach((doc) => {
            locations.push(doc.data());
        });

        return locations;
    }
}

module.exports = Location;