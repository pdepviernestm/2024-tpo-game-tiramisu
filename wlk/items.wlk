import menu.*
import mario.*
import sonidos.*


class Item {
  const x
  const y
  var property image
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

object sombrero inherits Item(x = 12, y = 2, image = "sombrero.png") {
	override method actuar() {
    super()
    game.addVisual(pistola)
    game.onTick(5, "Aparición pistola", { pistola.aparecer() })
	}
}

object pistola inherits Item(x = 2, y = 5, image = "aparicion0.png") {
  var indice = 0
  var property cantidadBalas = 5
  const property aparicion = ["aparicion1.png", "aparicion2.png", "aparicion3.png", "pistola.png"]

  override method actuar() {
    game.removeVisual(self)
    keyboard.y().onPressDo({ if(self.cantidadBalas() > 0 ) mario.disparar(self) })
  }

  method usarBala() { cantidadBalas -= 1 }

  method aparecer() {
    if(indice < 3) indice += 1
    else game.removeTickEvent("Aparición pistola")
    image = aparicion.get(indice)
  }
}

class Bala {
  const property numeroBala
  var property nombreBala = ""
  var property imagen = "bala.png"
  var property escalable = false
  var property colisionable = false
  var property direccion
  var property position = new MutablePosition(x = mario.position().x(), y = mario.position().y())

  method image() = imagen

  method desplazar() {
    if(!menuPausa.actuando()) {
      if(position.y() < -1) self.detener()
      else  
      {
        if(direccion) { self.position(self.position().right(1)) }
        else { self.position(self.position().left(1)) }
      }
    }
  }

  method iniciar() {
    game.addVisual(self)
    nombreBala = "Bala".concat(numeroBala.stringValue())
    game.onTick(20, nombreBala, { self.desplazar() })
    game.whenCollideDo(self, { elemento => elemento.detener() })
  }
  
  method detener() {
    game.removeVisual(self)
    game.removeTickEvent(nombreBala)
  }
}