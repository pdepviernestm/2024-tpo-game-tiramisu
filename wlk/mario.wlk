import base.*
import sonidos.*
import corazones.*
import peach.*
import barril.*
import items.*
import direccion.*

import menu.menuPerder

object mario {
  const property marioGirando = ["marioMuriendo1.png", "marioMuriendo2.png", "marioMuriendo3.png", "marioMuriendo4.png", "marioMuriendo1.png"] 
  var property position = new MutablePosition(x = 0, y = 2)
  var property saltando = false
  var property andar = false
  var property mirarDer = true
  var property vida = 3
  var property puedeCaer = true
  var property sentidoActual = derecha

  var property escalable = false
  var property colisionable = false
  
  var imagen = "marioD.png"
  const property items = []

  method image() = imagen

  method detener() {}

  method caminar(sentido) {
    var imagen1
    var imagen2
    if(sentido.desplazar(position) == derecha.desplazar(position)) {
      imagen1 = "marioD.png"
      imagen2 = "marioDD.png"
      sentidoActual = izquierda.invertir()
      mirarDer = true
    }
    else {
      imagen1 = "marioI.png"
      imagen2 = "marioII.png"
      sentidoActual = derecha.invertir()
      mirarDer=false
    }
    if(self.dentroDePantalla(sentido.desplazar(position))) {
      if(andar) {
        imagen = imagen1
        andar = false
      }
      else {
        imagen = imagen2
        game.schedule(500, { imagen = imagen1 andar = false })
        andar = true
      }
      position = sentido.desplazar(position)
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
    game.schedule(300, {
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
      return self.sobreEscalera(position)
    else
      return self.sobreEscalera(position.down(1))
  }

  method sobreEscalera(pos) = game.getObjectsIn(pos).any({ n => n.escalable()})

  method enBase() {
    const bloqueDeAbajo = self.position().down(1)
    return game.getObjectsIn(bloqueDeAbajo).any({ n => n.colisionable()})
  }

  method caer() {
    if(!self.enBase()and !self.sobreEscalera(position))
    {
      const nuevaPos = self.position().down(1)
      if (!self.dentroDePantalla(nuevaPos)) self.quitarVida()
      else if(self.puedeCaer() and not(self.saltando())) {
      self.position(nuevaPos)
    }}
  }

  method agregarItem(unItem) {
    items.add(unItem)
    game.removeVisual(unItem)
    if(items.size() == 3) peach.libre()
    else sonidos.iniciarSonido(sonidos.peachFeliz())
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
    self.position(game.at(1, 2))
    imagen = "marioD.png"
  }

  method disparar(pistola) {
    const imagenOld = imagen
    pistola.usarBala()
    if(mirarDer)
      imagen = "marioDisparaD.png"
    else
      imagen = "marioDisparaI.png"
    game.schedule(250, { imagen = imagenOld })
    const bala = new Bala(numeroBala = pistola.cantidadBalas(), direccion = self.sentidoActual())
    game.addVisual(bala)
    bala.iniciar()
  }
}