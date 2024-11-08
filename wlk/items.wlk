import menu.*
import mario.*
import sonidos.*



class Item {
  const x
  const y
  const property image
  var property escalable = false
  var property colisionable = false
  var property position = game.at(x, y)

  method actuar() {
    mario.agregarItem(self)
  }
   method detener() {
    game.removeVisual(self)
    game.removeTickEvent(self)
  }
}

class Pistola inherits Item {
  var property cantidadBalas = 100

  override method actuar() {
    game.removeVisual(self)
    keyboard.t().onPressDo({ if(self.cantidadBalas() > 0 ) mario.disparar(self) })
  }

  method usarBala() { cantidadBalas -= 1 }
}

class Bala {
  const property numeroBala
  var property nombreBala = ""
  var property imagen = ""
  var property escalable = false
  var property colisionable = false

  var property direccion
  var property position = new MutablePosition(x = direccion.desplazar(mario.position()).x(), y = mario.position().y())

  method image() = imagen

  method desplazar() {
    if(!menuPausa.actuando()) {
      if(position.y() < -1) self.detener()
      else  
      {
        if(mario.mirarDer()) { imagen = "balaD.png" position = direccion.desplazar(position) }
        else { imagen = "balaI.png" position = direccion.desplazar(position) }
      }
    }
  }

  method iniciar() {
    nombreBala = "Bala".concat(numeroBala.stringValue())
    game.onTick(30, nombreBala, { self.desplazar() })
    game.whenCollideDo(self, {
      elemento => elemento.detener() })
  }
  
  method detener() {
    game.removeVisual(self)
    game.removeTickEvent(nombreBala)
  }
}