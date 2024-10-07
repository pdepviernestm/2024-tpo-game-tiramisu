import base.*

object mario {
  var property position = game.at(0,2)
  var property saltando = false 
  var property andar = false
  var property mirarDer = true
  var imagen = "marioD3.png"

  method image() = imagen
  
  method position(newPos) {
    position = newPos
    }
  
  method derecha() {
    if (self.dentroDePantalla(self.position().right(1))){
      if (andar){
      imagen = "marioD3.png"
      andar = false
      }
    else {
      imagen = "marioDD3.png"
      andar = true
      }
    mirarDer = true
    self.position(self.position().right(1)) 
    }
  }
  method izquierda() {
    if (self.dentroDePantalla(self.position().left(1))){
    if (andar){
      imagen = "marioI3.png"
      andar = false
      }
    else {
      imagen = "marioII3.png"
      andar = true
      }
    mirarDer = false
    self.position(self.position().left(1)) 
    }
  }
  method dentroDePantalla(pos) = ((pos.x() > -1) and (pos.x() < game.width()))

  method saltar() {
    if (not(saltando)) {
      var imagenOld
      self.saltando(true) 
      andar = false

      if(mirarDer) {
        imagen= "marioUpD3.png"
        imagenOld = "marioD3.png"
        } 
    
      else{ 
        imagen= "marioUpI3.png"
        imagenOld = "marioI3.png"
        }
    
    self.position(self.position().up(1))
    game.schedule(1000, { 
      self.position(self.position().down(1)) 
      game.schedule(20,  {imagen = imagenOld}) 
    self.saltando(false) })
    }
  }

  method enBase() = game.colliders(self).any({ elem => elem.soyBase()})

  method caer() {
    if (self.dentroDePantalla(self.position().down(1))){
      self.position(self.position().down(1))
    }
    else self.endGame()
  }
  
  method endGame() {
      if (mirarDer) imagen = "marioDeadD.png"
      else imagen = "marioDeadI.png"

      game.schedule(1000, { game.stop() })
  }
}