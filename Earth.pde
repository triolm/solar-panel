class Earth {
    double distToSun, yearLen, siderealDayLen, angularPos,radius;

    public Earth(double distToSun, double yearLen, double siderealDayLen, double radius) {
        this.distToSun = distToSun;
        this.yearLen = yearLen;
        this.siderealDayLen = siderealDayLen;
        this.angularPos = 0;
        this.radius = radius;
    }

    double getZ(){
        return 0;
    }
    
    double getX(){
        return Math.cos(angularPos) * distToSun;
    }
    
    double getY(){
        return Math.sin(angularPos) * distToSun;
    }
    
    double getRad(){
        return radius;
    }
    
    Point getPos(){
        return new Point(this.getX(), this.getY(), this.getX());
    }

    void tick() {
        angularPos += (2*Math.PI) / yearLen;
        angularPos = angularPos % (2*Math.PI);
    }

    void draw() {
        fill(0,150,255);
        circle((float)(300*Math.cos(angularPos)), (float)(300*Math.sin(angularPos)), 30f);
    }
}
