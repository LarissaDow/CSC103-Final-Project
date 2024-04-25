class Timer {
 //vars
  float Time;

 //constructor
  Timer(float set) {
    Time = set;
  }
  float getTime() { //returns current time
    return(Time);
  }
  void setTime(float set) { //set timer to time put as temporary varable
    Time = set;
  }
  void countUp() { //counts timer up by framerate
    Time += 1/frameRate;
  }
  void countDown() { //counts timer up by framerate
    Time -= 1/frameRate;
  }

}
