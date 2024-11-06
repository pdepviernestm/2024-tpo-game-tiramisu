import base.*
import sonidos.*
import corazones.*

object mario {
  const property marioGirando = ["marioMuriendo1.png", "marioMuriendo2.png", "marioMuriendo3.png", "marioMuriendo4.png", "marioMuriendo1.png"] 
  var property position = new MutablePosition(x=0,y=2)
  var property saltando = false
  var property escalando = false
  var property andar = false
  var property mirarDer = true
  var property vida = 5
  var property puedeMoverse = true
  var property puedeCaer = true
  const property soyBase = false
  var imagen = "marioD.png"
  const property items = []

  method image() = imagen
  
  method position(newPos) {
    position = newPos
    }

  method derecha() {
    if (self.dentroDePantalla(self.position().right(1)) and self.puedeMoverse()){
      if (andar){
      imagen = "marioD.png"
      andar = false
      }
    else {
      imagen = "marioDD.png"
      game.schedule(500,  {imagen = "marioD.png" andar = false}) 
      andar = true
      }
    mirarDer = true
    self.position(self.position().right(1))
    sonidos.iniciarListaSonido(sonidos.marioCamina())
    }
  }

  method izquierda() {
    if (self.dentroDePantalla(self.position().left(1)) and self.puedeMoverse()){
    if (andar){
      imagen = "marioI.png"
      andar = false
      }
    else {
      imagen = "marioII.png"
      game.schedule(500,  {imagen = "marioI.png" andar = false}) 
      andar = true
      }
    mirarDer = false
    self.position(self.position().left(1)) 
    sonidos.iniciarListaSonido(sonidos.marioCamina())
    }
  }

  method dentroDePantalla(pos) = ((pos.x() > -1) and (pos.x() < game.width()) 
    and (pos.y() > -1) and (pos.y() < game.height()))

  method saltar() {
    if (not(saltando)) {
      var imagenOld
      sonidos.iniciarListaSonido(sonidos.marioSalta())
      self.saltando(true) 
      andar = false

      if(mirarDer) {
        imagen= "marioUpD.png"
        imagenOld = "marioD.png"
        } 
    
      else{ 
        imagen= "marioUpI.png"
        imagenOld = "marioI.png"
        }
    self.position(self.position().up(1))
    game.schedule(500, { 
      if(not(self.enBase()))self.position(self.position().down(1)) 
      game.schedule(20,  {imagen = imagenOld}) 
    self.saltando(false)
    })
    }
  }
  method escalar() {
    if(self.enEscalera() ){
      if (not(escalando)){
        self.position(self.position().up(1))
        if(mirarDer){ imagen = "marioEscala1D.png" 
        mirarDer=false
        }
      else {
        imagen = "marioEscala1I.png" 
        mirarDer=true
        }
      }
    }
  }

  method escalarAbajo() {
    if(self.enEscalera() and not(self.enBase())){
      if (not(escalando)){
        self.position(self.position().down(1))
        if(mirarDer) imagen = "marioEscala1D.png"
        else imagen = "marioEscala1I.png"
        }
    }
  }

  method enEscalera() = game.colliders(self).any({elem => elem.soyEscalera()})

  //method enBase() = game.colliders(self).any({ elem => elem.soyBase()})

  method enBase() {
    const bloqueDeAbajo = self.position().down(1)
    return game.getObjectsIn(bloqueDeAbajo).any({ n => n.soyBase() })
 }

  method enFuego() = game.colliders(self).any({ elem => elem.soyFuego()})


  method caer() {
    if (self.dentroDePantalla(self.position().down(1)) and self.puedeCaer() and not(self.saltando())) {
      self.position(self.position().down(1))
      game.sound(sonidos.marioCae()).play()
    }
  }

  method quitarVida() {
    if(vida > 1) {
      vida -= 1
      game.sound(sonidos.marioPierdeVida()).play()
      corazones.quitarCorazon()
      self.reaparecer()
      }
    else self.endGame()
  }
  
  method reaparecer() {
    self.position(game.at(1,2))
    imagen = "marioD.png"
  }
  
  method tocarFuego() {
    if(vida >= 2){
    vida -= 2
    corazones.quitarCorazon()
    corazones.quitarCorazon()
    self.reaparecer()
    game.sound(sonidos.marioMuerePorFuego()).play()}
    else self.endGame()
  }

  method endGame() {
      if (mirarDer) imagen = "marioDeadD.png"
      else imagen = "marioDeadI.png"
      game.sound(sonidos.marioMuere()).play()
      sonidos.pararMusica()
      game.schedule(1000, { game.stop() })
  }
  
  method winGame() {
    game.stop()
  }
}

