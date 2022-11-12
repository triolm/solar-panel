class Earth {
    double distToSun, yearLen, siderealDayLen, angularPos;

    public Earth(double distToSun, double yearLen, double siderealDayLen) {
        this.distToSun = distToSun;
        this.yearLen = yearLen;
        this.siderealDayLen = siderealDayLen;
        this.angularPos = 0;
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
