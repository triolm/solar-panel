Earth e = new Earth(1.496e11d,
    365.25*24*60*60,
    23*360+54*60+4,
    6_371_000);
void setup() {
    size(1600, 900);
}
void draw() {
    background(20, 10, 0);
    translate(width/2, height/2);
    for (int i = 0; i < 100000; i++) {
        e.tick();
    }
    e.draw();
    drawSun();
}


void drawSun() {
    fill(255,200,0);
    circle(0, 0, 50);
}
