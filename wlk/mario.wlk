import base.*
import sonidos.*
import corazones.*



object mario {
  var property position = game.at(0,2)
  var property saltando = false
  var property escalando = false
  var property andar = false
  var property mirarDer = true
  var property vida = 5
  var property puedeMoverse = true
  var property puedeCaer = true
  var imagen = "marioD.png"


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
      game.schedule(1000,  {imagen = "marioD.png" andar = false}) 
      andar = true
      }
    mirarDer = true
    self.position(self.position().right(1))
    game.sound(sonidos.marioCamina().anyOne()).play() 
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
      game.schedule(1000,  {imagen = "marioI.png" andar = false}) 
      andar = true
      }
    mirarDer = false
    self.position(self.position().left(1)) 
    game.sound(sonidos.marioCamina().anyOne()).play() 
    }
  }

  method dentroDePantalla(pos) = ((pos.x() > -1) and (pos.x() < game.width()) 
            and (pos.y() > -1) and (pos.y() < game.height()))

  method saltar() {
    if (not(saltando)) {
      var imagenOld
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
    game.sound(sonidos.marioSalta()).play()
    self.position(self.position().up(1))
    game.schedule(500, { 
      self.position(self.position().down(1)) 
      game.schedule(20,  {imagen = imagenOld}) 
    self.saltando(false) })
    }
  }
  method escalar() {
    if(self.enEscalera()){
      if (not(escalando)){
        self.escalando(true)
        self.puedeCaer(false)
        self.puedeMoverse(false)
        self.position(self.position().up(1))
        if(mirarDer) imagen = "marioEscala1D.png"
        else imagen = "marioEscala1I.png"
        }
    }
  }


  method enEscalera() = game.colliders(self).any({elem => elem.soyEscalera()})
  method enBase() = game.colliders(self).any({ elem => elem.soyBase()})

  method caer() {
    if (self.dentroDePantalla(self.position().down(1)) and self.puedeCaer()){
      self.position(self.position().down(1))
    }
    else self.quitarVida()
    //else if(vida == 1) self.morirPorCaida()
  }
  method quitarVida() {
    if(vida > 1 and self.puedeMoverse()) {
      vida -= 1
      game.sound(sonidos.marioPierdeVida()).play()
      corazon.quitarCorazon()
      self.reaparecer()
      }
    else self.endGame()
  }
  
  method reaparecer() {
    self.position(game.at(0,2))
    imagen = "marioD.png"
  }
/*
  method morirPorCaida() {
    const marioGirando = ["marioMuriendo1.png", "marioMuriendo2.png", "marioMuriendo3.png", "marioMuriendo4.png", "marioMuriendo1.png"] 
    if(self.puedeMoverse()){
      self.puedeMoverse(false)
      self.puedeCaer(false)
    game.sound(sonidos.marioMuere()).play()
    game.schedule(500, { 
        5.times (
          game.schedule(500 ,  self.girar(marioGirando)))
        self.puedeCaer(false)
        game.schedule(2500, { game.stop() }) 
        })
    }
  }
  method girar(lista) {
      imagen = lista.head() 
      self.position(self.position().up(1))
      lista.remove(lista.head())
  }
*/

  method endGame() {
      if (mirarDer) imagen = "marioDeadD.png"
      else imagen = "marioDeadI.png"
      game.sound(sonidos.marioMuere()).play()
      game.schedule(1000, { game.stop() })
  }
}

//Arreglar que mario salta de a 3 bloques
//agregar sonidos
