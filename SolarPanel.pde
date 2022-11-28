import java.util.Calendar;
import java.text.DateFormatSymbols;

final String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

Earth e;

Observer o;

//settings ----
double framesPerDay = 3;
double years = 2;

//counters ----
double tick = 0;
double totalLight = 0;
double daySegments = 0;

//light trackers ----
double dailyLight = 0;
//displayed daily light so it is easier to see daily light at high speeds
double prevDailyLight = 0;
double avgYearlyLight = 0;
double maxLight =0;
double minLight = Integer.MAX_VALUE;

boolean pause = false;

Calendar c;
void setup() {
    size(1600, 900);

    //earth config
    e = new Earth(1.496e11d,
        365.25*24*60*60,
        24*60*60,
        6371000d, Math.toRadians(23.5));

    //observer
    o = new Observer(Math.toRadians(23.5), 0, e);

    //keep track of date
    c = Calendar.getInstance();
    c.set(0, 11, 20);
}
void draw() {
    background(10, 0, 20);

    if (!(keyPressed && key == ' ')) {
        //tick (1/frames per day) days
        for (int i = 0; i < e.getDay() / framesPerDay && tick < e.getYear() * years; i++, tick++) {
            e.tick();
            o.tick();
            dailyLight += o.getSunlight();
        }

        daySegments++;
    }

    //once per day --
    if (daySegments == framesPerDay && tick < e.getYear() * years) {
        //increment calendar
        c.add(Calendar.DAY_OF_YEAR, 1);

        //check if light is greater than max or less than min
        maxLight = dailyLight < maxLight ? maxLight : dailyLight;
        minLight = dailyLight > minLight ? minLight : dailyLight;

        //update total
        totalLight += dailyLight;

        //recalculate average (average light per second * seconds per year)
        avgYearlyLight = e.getYear() * totalLight / tick;

        //update displayed daily light
        prevDailyLight = dailyLight;

        //reset day
        dailyLight = 0;
        daySegments = 0;
    }

    //text ----
    fill(255, 255, 255);
    textSize(30);
    //days elapsed
    text("Days: " + (int) tick / (60*60*24), 20, 40);
    //calendar date
    text("Date: " + months[c.get(Calendar.MONTH)]  + " " +  c.get(Calendar.DAY_OF_MONTH), 20, 80);
    //light counters
    text("Daily Light: " + prevDailyLight, 20, 120);
    text("Total Light: " + totalLight, 20, 160);
    text("Average Yearly Light: " + avgYearlyLight, 20, 200);
    text("Max Light: " + maxLight, 20, 240);
    text("Min Light: " + minLight, 20, 280);

    //flip canvas and center sun
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
