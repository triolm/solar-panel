class Observer {
    double lat, lon;
    Earth earth;
    final Vector xPrime, yPrime, zPrime;

    Observer(double lat, double lon, Earth earth) {
        this.lat = lat;
        this.lon = lon;
        this.earth = earth;

        xPrime = new Vector(Math.cos(23.5), 0, -sin(23.5)).normalize();
        yPrime = new Vector(0, 1, 0).normalize();
        zPrime = new Vector(Math.sin(23.5), 0, cos(23.5)).normalize();
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

    Point getPos() {
        return earth.getPos().add(getPosVector());
    }

    void tick() {
        lon -= (2*Math.PI)/earth.getSiderealDay();
    }

    void draw() {
        fill(255, 255, 255);
        println(Math.pow(getPosVector().getDY(), 1/3));
        if (getPosVector().getDY() < 0) {
            circle((float)getPosVector().getDZ(),
                (float)getPosVector().getDX(),
                20f);
        }
    }
}
