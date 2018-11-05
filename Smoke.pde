ParticuleEmitter emitter;

void setup () {
  size (500, 500, P2D);
  textSize (20);
  
  emitter = new ParticuleEmitter (
    new PVector (200, 400),
    250,
    3,
    90
  );
}

void draw () {
  background (0);
  emitter.update();
  
  text ("Frame rate : " + ceil (frameRate), 0, 20);
}
