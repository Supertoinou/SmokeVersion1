class ParticuleEmitter {
  
   private PImage [] textures; 
   private ArrayList<Particule> particules;
   private int quantity;
   private PVector position;
   private boolean full;

   public ParticuleEmitter (PVector position, int quantity, int nbrTexture, int size) {
     this.particules = new ArrayList<Particule>();
     this.quantity = quantity;
     this.position = position;
     this.textures = new PImage [nbrTexture];
     this.full = false;
     
     float halfsize = size / 2;
     float lim = halfsize * halfsize + halfsize * halfsize;
     for (int k = 0; k < nbrTexture; k++) {
       PImage texture = createImage (size, size, ARGB);
       int [] pixel = texture.pixels;
       float xoff = 0;
       float yoff = 0;
       noiseSeed (int (random (100000)));
       texture.loadPixels ();
       for (int y = 0; y < size; y++) {
         yoff += 0.02;
         xoff = 0;
         for (int x = 0; x < size; x++) {
           xoff += 0.02;  
           float diffX = x - halfsize;
           float diffY = y - halfsize;
           float dist = diffX * diffX + diffY * diffY;
           float i = noise (xoff, yoff) * (0.85 - pow ((dist / lim), 2) * 4);
           i *= 255;
           int index = x + y * size;
           pixel [index] = color (i + 20, i);
         }
       }
       texture.updatePixels ();
       textures [k] = texture;
     }
   }
   
   public void update () {
     if (!full && particules.size() < quantity) {
      emit ();
     }
     else {
       full = true;
     }
     for (Particule p : particules) {
       if (p.isOut()) {
         resetParticule (p);
       }
       else {
         p.update();
       }
     }
   }
   
   private PImage getRandomTexture () {
     int index = floor (random (textures.length));
     return textures [index];
   }
   
   private void emit () {
     PImage texture = getRandomTexture ();
     Particule p = new Particule (texture);  
     resetParticule (p);
     particules.add (p);
   }
   
   private void resetParticule (Particule p) {
     p.reset (
       new PVector (
         randomGaussian () * 10 + position.x,
         randomGaussian () * 10 + position.y
       ),
       new PVector (
         randomGaussian () * 0.15,
         randomGaussian () * 0.15 - 1.0
       ),
       255,
       1
     );
   }
  
}
