//Earth e = new Earth(1.496e11d,
//    365.25*24*60*60,
//    23*360+54*60+4,
//    6_371_000);
Earth e = new Earth(2000,
    365.25*24*60*60,
    23*3600+54*60+4,
    150,
    Math.toRadians(23.5));

Observer o = new Observer(0, 0, e);

void setup() {
    size(1600, 900);
}
void draw() {
    background(20, 10, 0);
    translate(width/2, height/2);
    scale(1, -1);
    
    for (int i = 0; i < 100000 / 100; i++) {
        e.tick();
        o.tick();
    }
    e.draw();
    o.draw();
    //drawSun();
}


void drawSun() {
    fill(255, 200, 0);
    circle(0, 0, 50);
}
