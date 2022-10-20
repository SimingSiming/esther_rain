void draw_project_info()
{   
    hint(DISABLE_DEPTH_TEST);
    cam.beginHUD();
    cp5.draw();

    //textFont(mono);
    textAlign(LEFT);

    pushMatrix();
    translate(0, 25, 0);
    textSize(28);
    fill(#FFFFFF);
    text("Message Rain", 35, 30);
    textSize(18);
    fill(#FFFFFF,200);
    text("life-long project | 17-10-2022 | Siming Su", 35, 1050);
    popMatrix();

    textSize(24);
    fill(#FFFFFF,200);
    text(currentDateTime, 35, 500);

    textSize(20);
    fill(#658354);
    text("Count of Missing", 35, 560);
    fill(#FFFFFF,200);
    text(String.valueOf(counter_miss),350,560);

    textSize(20);
    fill(#FF0000);
    text("Count of Loving", 35, 580);
    fill(#FFFFFF,200);
    text(String.valueOf(counter_love),350,580);

    textSize(20);
    fill(#C1C1C1);
    text("Count of Thinking", 35, 600);
    fill(#FFFFFF,200);
    text(String.valueOf(counter_think),350,600);

    cam.endHUD();
    hint(ENABLE_DEPTH_TEST);

}
