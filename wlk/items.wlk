import menu.*
import mario.*

class Item {
    const x
    const y
    var property position = game.at(x,y)
    const property image

    var property colisionable = false
    var property escalable = false

    method actuar() {
        mario.items().add(self)
        //peach hace un sonido
        game.removeVisual(self)
    }
}

class Pistola inherits Item {
  var property cantidadBalas = 3

  override method actuar() {
    game.removeVisual(self)
    keyboard.t().onPressDo({ if(self.cantidadBalas() > 0 ) mario.disparar(self) })
  }

  method usarBala() { cantidadBalas -= 1 }
}

class Bala {
  var property colisionable = false
  var property escalable = false

  var property direccion = mario.sentidoActual()
  var property image = "bala.png"
  var property position = new MutablePosition(x = mario.sentidoActual().desplazar(mario.position()).x(), y = mario.position().y())

  method desplazar() {
    if(!menuPausa.actuando()) {
      if(position.y() < -1) self.detener()
      else position = direccion.desplazar(position)
    }
  }

  method iniciar() { game.onTick(30, "Avanzar", {
    self.desplazar() 
    game.whenCollideDo(self, { elemento => if(!elemento.escalable()) game.removeVisual(elemento) game.schedule(500, {menuPerder.actuar()}) }) })
  }

  method detener() { game.removeVisual(self) }
}