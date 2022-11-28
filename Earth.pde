class Earth {
    double distToSun, yearLen, dayLen, siderealDayLen, angularPos, radius, tilt, scale;
    float displaySize;

    public Earth(double distToSun, double yearLen, double dayLen, double radius, double tilt) {
        this.distToSun = distToSun;
        this.yearLen = yearLen;
        this.dayLen = dayLen;
        this.siderealDayLen = (yearLen*dayLen)/(yearLen+dayLen);
        this.angularPos = 0;
        this.radius = radius;
        this.tilt = tilt;

        //visualization variables
        this.scale = this.distToSun / 600;
        this.displaySize = 100f;
    }

    double getTilt() {
        return tilt;
    }
    //getters
    double getRad() {
        return radius;
    }

    double getYear() {
        return this.yearLen;
    }

    Point getPos() {
        return new Point(this.getX(), this.getY(), this.getZ());
    }

    double getAngularPos() {
        return this.angularPos;
    }

    double getSiderealDay() {
        return siderealDayLen;
    }

    double getDay() {
        return dayLen;
    }
    
    //coordinates
    double getX() {
        return Math.cos(angularPos) * distToSun;
    }

    double getY() {
        return Math.sin(angularPos) * distToSun;
    }

    double getZ() {
        return 0;
    }

    void tick() {
        angularPos += (2*Math.PI) / yearLen;
        angularPos = angularPos % (2*Math.PI);
    }

    float getDisplayX() {
        return (float)(this.getX() / scale);
    }

    float getDisplaySize() {
        return displaySize;
    }

    void draw() {
        fill(0, 150, 255);
        circle(getDisplayX(), 0, displaySize);
        drawAxis();
    }

    void drawAxis() {
        strokeWeight(3);
        stroke(255, 255, 255);
        //draw line at tilt angle
        line(getDisplayX() - (float)(Math.sin(tilt) * displaySize * 2/3),
            -(float) (Math.cos(tilt) * displaySize * 2/3),
            getDisplayX() + (float)(Math.sin(tilt) * displaySize * 2/3),
            (float) (Math.cos(tilt) * displaySize * 2/3));
        noStroke();
    }
}
