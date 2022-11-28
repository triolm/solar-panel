import java.util.Calendar;
import java.text.DateFormatSymbols;

Earth e = new Earth(1.496e11d,
    365.25*24*60*60,
    24*60*60,
    6371000d, Math.toRadians(23.5));
//Earth e = new Earth(2000,
//    365.25*24*60*60,
//    23*3600+54*60+4,
//    150,
//    Math.toRadians(23.5));

Observer o = new Observer(Math.toRadians(23.5), 0, e);

double tick = 0;
double totalLight = 0;
double avgYearlyLight = 0;
double framesPerDay = 10;
double years = 4;
double daySegments = 0;
double dailyLight = 0;
double prevDailyLight = 0;
double maxLight =0;
double minLight = Integer.MAX_VALUE;
Calendar c;
void setup() {
    c = Calendar.getInstance();
    c.set(0, 11, 21);
    size(1600, 900);
}
void draw() {
    background(10, 0, 20);

    for (int i = 0; i < e.getDay() / framesPerDay && tick < e.getYear() * years; i++, tick++) {
        e.tick();
        o.tick();
        dailyLight += o.getSunlight();
    }

    if (tick == e.getYear()) {
        tick += 1;
        print(totalLight);
    }

    fill(255, 255, 255);
    textSize(30);
    
    text("Days: " + (int) tick / (60*60*24), 20, 40);

    //https://stackoverflow.com/questions/5799140/java-get-month-string-from-integer
    text("Date: " +
        new DateFormatSymbols().getMonths()[c.get(Calendar.MONTH)]
        + " " +  c.get(Calendar.DAY_OF_MONTH), 20, 80);

    
    text("Daily Light: " + prevDailyLight, 20, 120);
    text("Total Light: " + totalLight, 20, 160);
    text("Average Yearly Light: " + avgYearlyLight, 20, 200);
    
    text("Max Light: " + maxLight, 20, 240);
    text("Min Light: " + minLight, 20, 280);

    daySegments++;

    if (daySegments == framesPerDay && tick < e.getYear() * years) {
        c.add(Calendar.DAY_OF_YEAR, 1);
        maxLight = dailyLight < maxLight ? maxLight : dailyLight;
        minLight = dailyLight > minLight ? minLight : dailyLight;
        totalLight += dailyLight;
        avgYearlyLight = e.getYear() * totalLight / tick;
        prevDailyLight = dailyLight;
        dailyLight = 0;
        daySegments = 0;
    }

    translate(width/2, height/2);
    scale(1, -1);

    drawSun();
    e.draw();
    o.draw();
}


void drawSun() {
    fill(255, 200, 0);
    circle(0, 0, 150);
}
