class Observer {
    double lat, lon;
    Earth earth;
    final Vector xPrime, yPrime, zPrime;

    Observer(double lat, double lon, Earth earth) {
        this.lat = lat;
        this.lon = lon;
        this.earth = earth;


        xPrime = new Vector(Math.cos(earth.getTilt()), 0, -Math.sin(earth.getTilt())).normalize();
        yPrime = new Vector(0, 1, 0).normalize();
        zPrime = new Vector(Math.sin(earth.getTilt()), 0, Math.cos(earth.getTilt())).normalize();
    }

    double getLat() {
        return lat;
    }

    double getLon() {
        return lon;
    }

    Vector getX() {
        return xPrime.scale(Math.cos(lon) * earth.getRad() * Math.cos(lat));
        //return new Vector(Math.cos(lon) * earth.getRad() * Math.cos(lat),0,0);
    }

    Vector getY() {
        return yPrime.scale(Math.sin(lon) * earth.getRad() * Math.cos(lat));
        //return new Vector(0,Math.sin(lon) * earth.getRad() * Math.cos(lat),0);
    }

    Vector getZ() {
        return zPrime.scale(Math.sin(lat) * earth.getRad());
        //return new Vector(0,0,Math.sin(lat) * earth.getRad());
    }

    Vector getPosVector() {
        return
            getX()
            .add(getY())
            .add(getZ());
    }

    Vector getVectorToSun() {
        return new Point(0, 0, 0).subtract(getPos());
    }

    double getSunlight() {
        double dp = (getPosVector().normalize()).dot(getVectorToSun().normalize());
        if (dp < 0)return 0;
        return 1000 * dp;
    }

    Point getPos() {
        return earth.getPos().add(getPosVector());
    }

    void tick() {
        lon -= (2*Math.PI)/earth.getSiderealDay();
    }

    void draw() {
        fill(255, 255, 255);
        Vector drawVector = getPosVector().normalize().scale(earth.getDisplaySize()/2);
        if (drawVector.getDY() < 0) {
            double scale = 2 * Math.pow(-drawVector.getDY(), 1.0/2);
            circle((float)drawVector.getDX() + earth.getDisplayX(),
                (float)drawVector.getDZ(),
                10f + (float) scale);
        }
    }
}
