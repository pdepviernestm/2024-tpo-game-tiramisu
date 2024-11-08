import menu.*
import mario.*
import sonidos.*



class Item {
  const x
  const y
  const property image
  var property romper = false
  var property escalable = false
  var property colisionable = false
  var property position = game.at(x, y)

  method actuar() {
    mario.agregarItem(self)
  }
}

class Pistola inherits Item {
  var property cantidadBalas = 3
  var property balasDisparadas = 0

  override method actuar() {
    game.removeVisual(self)
    keyboard.t().onPressDo({ if(self.cantidadBalas() > 0 ) mario.disparar(self) })
  }

  method usarBala() {
    cantidadBalas -= 1
    balasDisparadas += 1
  }
}

class Bala {
  const property numeroBala
  var property nombreBala = ""
  var property image = "bala.png"
  var property escalable = false
  var property colisionable = false
  var property direccion
  var property position = new MutablePosition(x = direccion.desplazar(mario.position()).x(), y = mario.position().y())

  method desplazar() {
    if(!menuPausa.actuando()) {
      if(position.y() < -1) self.detener()
      else position = direccion.desplazar(position)
    }
  }

  method iniciar() {
    nombreBala = "Bala".concat(numeroBala.stringValue())
    game.onTick(30, nombreBala, { self.desplazar() })
    //game.whenCollideDo(self, { elemento => if(!elemento.escalable()) game.removeVisual(elemento) game.schedule(500, {menuPerder.actuar()}) }) })
  }

  method detener() {
    game.removeVisual(self)
    game.removeTickEvent(nombreBala)
  }
}