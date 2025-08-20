public class Camera {
  private float x, y, zoom;

  public Camera(float _x, float _y, float _zoom) {
    this.x = _x;
    this.y = _y;
    this.zoom = _zoom;
  }

  void renderPlanet(Planet aPlanet) {
    aPlanet.render(this.x, this.y, this.zoom);
  }

  void renderProjectile(Projectile aProjectile) {
    aProjectile.render(this.x, this.y, this.zoom);
  }

  void focusOnProjectile(Projectile aProjectile) {
    float position []=aProjectile.getPosition();
    this.x = position[0];
    this.y = position[1];
  }
  
  void focusOnPlanet(Planet aPlanet) {
    float position []=aPlanet.getPosition();
    this.x = position[0];
    this.y = position[1];
  }

  void moveCam(float x, float y, float zoom) {
    this.x += x;
    this.y += y;
    if ( this.zoom + zoom > 0) {
      this.zoom += zoom;
    }
  }

  void setCam(float x, float y, float zoom) {
    this.x = x;
    this.y = y;
    if ( zoom > 0) {
      this.zoom = zoom;
    }
  }
}
