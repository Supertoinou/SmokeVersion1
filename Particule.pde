class Particule {
  
  private PImage texture;
  private PVector position;
  private PVector velocity;
  private float lifespan;
  private float decayRate;
  
  public Particule ( PImage texture) {
    this.texture = texture;
    position = new PVector (0, 0);
    velocity = new PVector (0, 0);
  }
  
  public void reset (PVector position, PVector velocity, float lifespan, float decayRate) {
    this.position.x = position.x;
    this.position.y = position.y;
    this.velocity.x = velocity.x;
    this.velocity.y = velocity.y;
    this.lifespan = lifespan;
    this.decayRate = decayRate;
  }
  
  public void update () {
    lifespan -= decayRate;
    position.add (velocity);
    tint (255, lifespan);
    //shape (shape, position.x, position.y);
    image (texture, position.x, position.y);
  }
  
  public void addForce (PVector force) {
    velocity.add (force);  
  }
  
  public boolean isOut () {
    if (lifespan <= 0) {
      return true;
    }
    else {
      return false;
    }
  }
  
}
