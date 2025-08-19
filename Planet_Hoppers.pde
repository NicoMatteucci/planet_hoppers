Planet planetSystem[];
Projectile projectiles[];
Camera mainCamera;
int substeps = 10;
float G = 0.1;

void setup() {
  size(800, 600);
  planetSystem = new Planet[1];
  projectiles = new Projectile[1];

  mainCamera = new Camera(0, 0, 1);
  planetSystem[0] = new Planet(200, 10000, -400, 0);
  projectiles[0] = new Projectile(10, 1, 0, 0);
  //projectiles[0].setVelocity(0, 1);
}

void draw() {
  translate(400, 300);
  background(50);

  //mainCamera.setCam(mouseX-400, 300 - mouseY, 0.5);
  mainCamera.focusOnProjectile(projectiles[0]);
  //System.out.printf("camera x: %d camera y: %d \n", mouseX-400, 300 - mouseY);

  for (int i = 0; i< projectiles.length; i++) {
    for (int j = 0; j< substeps; j++) {
      projectiles[i].gravity(planetSystem);
      projectiles[i].kinematics(1.0 / substeps);
    }
  }

  for (int i = 0; i< planetSystem.length; i++) {
    mainCamera.renderPlanet(planetSystem[i]);
  }

  for (int i = 0; i< projectiles.length; i++) {
    mainCamera.renderProjectile(projectiles[i]);
  }
}
