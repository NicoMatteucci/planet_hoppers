# PLANET HOPPERS

## About project: this is an open source rocket science physics model intended to be a future little game, movil app oriented.

## 🎮 Características

- Movimiento de nave con física arcade y rebote vectorial.
- Controles táctiles modulares (`ui_left`, `ui_right`, `ui_accept`) adaptados a cualquier resolución.
- Generación aleatoria de asteroides con tamaños y posiciones variables.
- Colisiones con rebote realista y sistema de vidas.
- HUD básico con score y vidas (en desarrollo).

---

## 📦 Estructura del proyecto

    res://    
    ├── android/  →  Configuración de exportación 
    ├── assets/                
    |    ├── sprites/ 
    |    └── sonidos/ 
    ├── autoload/  →  Script global con estado del juego              
    ├── scenes/  →  Escenas principales (nave, asteroides, controles) 
    ├── scripts/  →  Lógica de movimiento, colisiones y HUD 
    └── export_presets.cfg  →  Configuración de exportación Android


---

## 📱 Controles táctiles

- Zona izquierda → gira a la izquierda (`ui_left`)
- Zona derecha → gira a la derecha (`ui_right`)
- Toda la pantalla → thrust (`ui_accept`)

---

## 🚧 Estado actual

✅ Movimiento y colisiones básicas  
✅ Exportación funcional a Android  
🔜 HUD visual y sistema de score  
🔜 Efectos visuales y partículas  
🔜 Menú de inicio y Game Over

---

## 🛠️ Requisitos

- [Godot 4.x](https://godotengine.org/)
- Android SDK + JDK 17 (para exportar)
- Dispositivo Android para pruebas

---

## 🤝 Contribuciones

Este proyecto está en fase de prototipo. Si querés colaborar con arte pixelado, efectos, música o mejoras en la lógica, ¡bienvenido!

---

## 📃 Licencia

MIT — libre para usar, modificar y compartir.
