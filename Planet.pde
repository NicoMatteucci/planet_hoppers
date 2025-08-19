public class Planet {
  private float radius, mass;
  private float x, u; // position
  private float y, v; // velocity
  private color appearance;

  public Planet(float _radius, float _mass, float _x, float _y) {
    this.radius = _radius;
    this.mass = _mass;
    this.x = _x;
    this.y = _y;
    this.u = 0;
    this.v = 0;
    this.appearance = color(255, 255, 255);
  }
  
  float getMass(){ return this.mass; }
  
  float getX(){ return this.x; }
  
  float getY(){ return this.y; }
  
  float[] getPosition() {
    float position [] = new float[2];
    position[0] = this.x;
    position[1] = this.y;
    return position;
  }

  void render(float tx, float ty, float tzoom) {
    fill(this.appearance);
    circle((this.x - tx)* tzoom, (ty - this.y)*tzoom, this.radius * 2 * tzoom);
  }
}
