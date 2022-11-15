class Observer {
    double lat, lon;
    Earth earth;
    final Vector xPrime, yPrime, zPrime;

    Observer(double lat, double lon, Earth earth) {
        this.lat = lat;
        this.lon = lon;
        this.earth = earth;

        xPrime = new Vector(Math.cos(23.5), 0, -sin(23.5));
        yPrime = new Vector(0, 1, 0);
        zPrime = new Vector(Math.sin(23.5), 0, cos(23.5));
    }

    double getLat() {
        return lat;
    }

    double getLon() {
        return lon;
    }

    double getX() {
        return Math.cos(lon) * earth.getRad() * Math.cos(lat);
    }

    double getY() {
        return Math.sin(lon) * earth.getRad() * Math.cos(lat);
    }

    double getZ() {
        return Math.sin(lat) * earth.getRad();
    }
}
