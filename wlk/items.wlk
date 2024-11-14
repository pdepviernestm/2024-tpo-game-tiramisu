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
    game.schedule(1000, {menuPerder.actuar()})
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

  method actuar() {
    self.detener()

  }

  method desplazar() {
    if(position.y() < -1) self.detener()
    else  
    {
      if(direccion) { self.position(self.position().right(1)) }
      else { self.position(self.position().left(1)) }
    }
    game.whenCollideDo(self, { elemento => elemento.detener() self.detener()})
  }

method iniciar() {
    game.addVisual(self)
    nombreBala = "Bala".concat(numeroBala.stringValue())
    game.onTick(80, nombreBala, { menuPausa.comprobacionPara({self.desplazar()}) })
}

  method detener() {
    position = game.at(-1, -1)
    game.removeVisual(self)
    game.removeTickEvent(nombreBala)
  }
}

//CORAZONES
object corazones { 
    const x = 11
    const y = 14
    const cant = 3
    const corazones = []
    
    method agregarCorazon() {
        (1..cant).forEach({ i =>
            const corazon = new Corazon(ejeXPixel = x + i, ejeYPixel = y)
            corazones.add(corazon) 
            game.addVisual(corazon)
        })
    }
    
    method quitarCorazon() { 
        const corazon = corazones.last()
        corazon.quitarCorazon()
        corazones.remove(corazon)
    }
}

class Corazon {
    const ejeXPixel
    const ejeYPixel
    var imagen = "marioVida.png"

    var property colisionable = false 
    var property escalable = false 

    method position() = game.at(ejeXPixel, ejeYPixel)

    method image() = imagen

    method quitarCorazon() {
        imagen = "marioVidaDead.png"
    }

    method actuar() {}
}