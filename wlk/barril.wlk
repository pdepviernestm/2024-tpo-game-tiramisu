import base.*
import escalera.*
import mario.*
import direccion.*
import menu.menuPausa

object barriles {
  var property position = game.at(14, 11)

  method image() = "barriles.png"
  
  method actuar() {} 
}

class Barril {
  var property colisionable = false
  var indice = 0
  var cayo = false
  const property numeroBarril
  var property romper = true
  var property nombreBarril = ""
  var property escalable = false
  var image = imagenes.get(indice)
  var property direccionActual = izquierda
  var property position = new MutablePosition(x = 11, y = 11)
  const property imagenes = ["barril1.png", "barril2.png", "barril3.png", "barril4.png"]

  method cayo(unBool) { cayo = unBool }

  method image() = image

  method cambiarImagen() {
    if(indice < 3) indice += 1 
    else indice = 0
    image = imagenes.get(indice)
  }

  method mover() {
    if(!menuPausa.actuando()) {
      const objetosDeAbajo = game.getObjectsIn(abajo.desplazar(position))
      if(position.y() < -1)
        self.detener()
      if(objetosDeAbajo.isEmpty()) { position = abajo.desplazar(position) image = "barril0.png" self.cayo(true) }
      else
      {
        if(objetosDeAbajo.contains(mario)) { position = abajo.desplazar(position) self.cayo(true) }
        else
        {
          const select = objetosDeAbajo.anyOne()
          if(select.colisionable()) {
            if(cayo) { self.cayo(false) direccionActual = direccionActual.invertir() position = direccionActual.desplazar(position) }
            else position = direccionActual.desplazar(position)
            self.cambiarImagen()
          }
          else { image = "barril0.png" position = abajo.desplazar(position) self.cayo(true) }
        }
      }
    }
  }

  method detener() {
    game.removeVisual(self)
    game.removeTickEvent(nombreBarril)
  }

  method iniciar() {
    nombreBarril = "Barril".concat(numeroBarril.stringValue())
    game.onTick(60, nombreBarril, { self.mover() })
  }

  method actuar() { 
    mario.quitarVida()
    self.detener()
  }
}