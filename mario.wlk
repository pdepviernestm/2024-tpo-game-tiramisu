object mario {
  var property position = game.origin()
  var property saltando = 0
  var imagen = "marioD.png"
  method image() = imagen


    method position(newPos) {
    position = newPos
  }
  
  method autoPosition(newPos) {
    position = newPos
    
  }
  
  method positionDer(newPos) {
    self.position(newPos)
    if(imagen == "marioD.png") imagen = "marioDD.png"
    else imagen = "marioD.png"
  }
  
  method positionIzq(newPos) {
    self.position(newPos)
    if(imagen == "marioI.png") imagen = "marioII.png"
    else imagen = "marioI.png"
  }

  
  method saltar() {
    //cambiar a bool
    if (saltando == 0) {
    self.saltando(1) 
    //imagen se costruya a partir de la orientacion
    if(imagen == "marioD.png" || imagen== "marioDD.png")imagen= "marioUpD.png"
    else if(imagen == "marioI.png" || imagen=="marioII.png") imagen= "marioUpI.png"
    
    self.position(self.position().up(1))
    game.schedule(1000, { self.position(self.position().down(1)) 
    self.saltando(0) })
    }
  }
}