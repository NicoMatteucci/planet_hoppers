public class Projectile {
  private float radius, mass;
  private float x, u; // position
  private float y, v; // velocity
  private float campoX, campoY;
  private color appearance;

  public Projectile(float _radius, float _mass, float _x, float _y) {
    this.radius = _radius;
    this.mass = _mass;
    this.x = _x;
    this.y = _y;
    this.u = 0;
    this.v = 0;
    this.appearance = color(255, 100, 100);
  }
  
  void setVelocity(float u, float v){
    this.u = u;
    this.v = v;
  }

  void gravity(Planet [] planets) {
    float G = 0.1;
    this.campoX = 0;
    this.campoY = 0;
    for (int i = 0; i< planets.length; i++) {
      float M = planets[i].getMass();
      float rx = this.x - planets[i].getX();
      float ry = this.y - planets[i].getY();
      float rsq = rx * rx + ry * ry;
      float campo = - G * M / rsq;
      this.campoX += campo * rx / sqrt(rsq);
      this.campoY += campo * ry / sqrt(rsq);
    }
  }

  void kinematics(float diferential) {
    this.u += diferential * this.campoX;
    this.v += diferential * this.campoY;
    
    this.x += diferential * this.u;
    this.y += diferential * this.v;
  }

  float[] getPosition() {
    float position [] = new float[2];
    position[0] = this.x;
    position[1] = this.y;
    return position;
  }

  void render(float tx, float ty, float tzoom) { // luego se hará el cohete
    fill(this.appearance);
    circle((this.x - tx)* tzoom, (ty - this.y)*tzoom, this.radius * 2 * tzoom);
  }
}
