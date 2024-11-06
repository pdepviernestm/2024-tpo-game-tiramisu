import menu.*
import base.*
import sonidos.*
import corazones.*

object mario {
  const property marioGirando = ["marioMuriendo1.png", "marioMuriendo2.png", "marioMuriendo3.png", "marioMuriendo4.png", "marioMuriendo1.png"] 
  var property position = new MutablePosition(x=0,y=2)
  var property saltando = false
  var property andar = false
  var property mirarDer = true
  var property vida = 5
  var property puedeCaer = true
  var imagen = "marioD.png"
  const property items = []

  method image() = imagen

  method andar(donde) {
    var voy
    var imagen1
    var imagen2

    if (donde == 0) {
      imagen1 = "marioD.png"
      imagen2 = "marioDD.png"
      voy = self.position().right(1)
      }
    else {
      imagen1 = "marioI.png"
      imagen2 = "marioII.png"
      voy = self.position().left(1)
    }
    if(self.dentroDePantalla(voy) and !menuPausa.actuando()){
      if (andar){
        imagen = imagen1
        andar = false
      }
      else {
        imagen = imagen2
        game.schedule(500,  {imagen = imagen1 andar = false}) 
        andar = true
      }
      self.position(voy)
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

  method escalar(donde) {
    if(self.puedoEscalar(donde) and not(saltando) ){
      self.position(self.position().up(donde))
      if(mirarDer){ imagen = "marioEscala1D.png" 
      mirarDer=false
      }
      else {
        imagen = "marioEscala1I.png" 
        mirarDer=true
      }
    }
  }

  method puedoEscalar(donde) {
    if(donde == 1)
      return self.enEscalera()
    else
      return self.sobreEscalera()
  }

  method enEscalera() = game.colliders(self).any({elem => elem.escalable()})
 
  method sobreEscalera() {
    const bloqueDeArriba = self.position().down(1)
    return game.getObjectsIn(bloqueDeArriba).any({ n => n.escalable()})
  }

  method enBase() {
    const bloqueDeAbajo = self.position().down(1)
    return game.getObjectsIn(bloqueDeAbajo).any({ n => n.colisionable()})
  }

  method caer() {
    const nuevaPos = self.position().down(1)
      if (!self.dentroDePantalla(nuevaPos)) self.quitarVida()
      else if(self.puedeCaer() and not(self.saltando())) {
      self.position(nuevaPos)
    }
  }

  method quitarVida() {
    if(vida > 1) {
      vida -= 1
      sonidos.iniciarSonido(sonidos.marioPierdeVida())
      corazones.quitarCorazon()
      self.reaparecer()
      }
    else {
      if (mirarDer) imagen = "marioDeadD.png"
        else imagen = "marioDeadI.png"
        menuPerder.actuar()
    }
  }
  
  method reaparecer() {
    self.position(game.at(1,2))
    imagen = "marioD.png"
  }
}

