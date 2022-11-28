class Observer {
    double lat, lon;
    Earth earth;
    final Vector xPrime, yPrime, zPrime;

    Observer(double lat, double lon, Earth earth) {
        this.lat = lat;
        this.lon = lon;
        this.earth = earth;

        //rotation of coordinate system due to earth's tilt
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

    //coordinates
    Vector getX() {
        return xPrime.scale(Math.cos(lon) * earth.getRad() * Math.cos(lat));
    }

    Vector getY() {
        return yPrime.scale(Math.sin(lon) * earth.getRad() * Math.cos(lat));
    }

    Vector getZ() {
        return zPrime.scale(Math.sin(lat) * earth.getRad());
    }

    //displacement from the center of the earth as a vector
    Vector getPosVector() {
        return
            getX()
            .add(getY())
            .add(getZ());
    }


    Point getPos() {
        return earth.getPos().add(getPosVector());
    }

    //displacement from the center of the sun as a vector
    Vector getVectorToSun() {
        return new Point(0, 0, 0).subtract(getPos());
    }

    //dot producuct of normal unit vector from earth and vector from observer to sun
    double getSunlight() {
        double dp = (getPosVector().normalize()).dot(getVectorToSun().normalize());
        if (dp < 0)return 0;
        return 1000 * dp;
    }

    void tick() {
        lon -= (2*Math.PI)/earth.getSiderealDay();
    }

    void draw() {
        fill(255, 255, 255);
        //vector from the center of the displayed earth in terms of pixels
        Vector drawVector = getPosVector().normalize().scale(earth.getDisplaySize()/2);
        
        //view is sideways so y is depth
        if (drawVector.getDY() < 0) {
            double scale = 2 * Math.pow(-drawVector.getDY(), 1.0/2);
            circle((float)drawVector.getDX() + earth.getDisplayX(),
                (float)drawVector.getDZ(),
                10f + (float) scale);
        }
    }
}
