import java.util.Calendar;
import java.text.DateFormatSymbols;

final String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

Earth e;

Observer o;

//settings ----
double framesPerDay = 5;
double years = 4;

//counters ----
double tick;
double totalLight;
double daySegments;

//light trackers ----
double dailyLight;

//displayed daily light so it is easier to see daily light at high speeds
double prevDailyLight;
double avgYearlyLight;
double maxLight, minLight;
String maxLightDay, minLightDay;

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
    o = new Observer(Math.toRadians(23.4), 0, e);

    //keep track of date
    c = Calendar.getInstance();
    c.set(2022, 11, 20);

    //counters ----
    tick = 0;
    totalLight = 0;
    daySegments = 0;

    //light trackers ----
    dailyLight = 0;
    //displayed daily light so it is easier to see daily light at high speeds
    prevDailyLight = 0;
    avgYearlyLight = 0;
    maxLight =0;
    minLight = Integer.MAX_VALUE;
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

    //once per day ----
    if (daySegments == framesPerDay && tick < e.getYear() * years) {
        //increment calendar
        c.add(Calendar.DAY_OF_YEAR, 1);

        //check if light is greater than max or less than min
        if (dailyLight > maxLight ) {
            maxLight =  dailyLight;
            maxLightDay = months[c.get(Calendar.MONTH)]  + " " +  c.get(Calendar.DAY_OF_MONTH);
        }
        if (dailyLight < minLight ) {
            minLight =  dailyLight;
            minLightDay = months[c.get(Calendar.MONTH)]  + " " +  c.get(Calendar.DAY_OF_MONTH);
        }

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
    textAlign(LEFT);
    //days elapsed
    text("Days: " + (int) tick / (60*60*24), 20, 40);
    //calendar date
    text("Date: " + months[c.get(Calendar.MONTH)]  + " " +  c.get(Calendar.DAY_OF_MONTH) + ", " + c.get(Calendar.YEAR), 20, 80);
    //light counters
    text("Daily Light: " + prevDailyLight, 20, 120);
    text("Total Light: " + totalLight, 20, 160);
    text("Average Yearly Light: " + avgYearlyLight, 20, 200);
    text("Max Light: " + maxLight + " " + maxLightDay, 20, 240);
    text("Min Light: " + minLight + " " + minLightDay, 20, 280);
    drawPause(keyPressed && key == ' ');

    //flip canvas and center sun
    translate(width/2, height/2);
    scale(1, -1);

    if (tick/(60*60*24) % 365 > 78 && tick/(60*60*24) % 365 < 104) {
        drawSun(255);
        e.draw();
        drawSun(175);
    } else {
        drawSun(255);
        e.draw();
    }
    o.draw();
}


void drawSun(int opacity) {
    fill(255, 200, 0, opacity);
    circle(0, 0, 150);
}

void keyPressed() {
    //reset
    if (key == 'r') {
        setup();
    }
}

void drawPause(boolean paused) {
    fill(255, 255, 255);
    textAlign(RIGHT);
    if (paused) {
        rect(width - 35, 15, 10, 40);
        rect(width - 55, 15, 10, 40);
    } else {
        text("Hold space to pause", width - 20, 45);
    }
    text("Press R to reset", width - 20, 85);
}
