import nivel1.*
import sonidos.*
const botones = [botonJugar, botonControles, botonSalir]



object menu {
  var property image = "menuPrincipal.jpg"
  var property position = game.origin()

  method iniciar() {
    sonidos.iniciarSonido(sonidos.nombreGame())
    game.addVisual(self)
    botones.forEach { n => game.addVisual(n) }
    sonidos.iniciarMusica(sonidos.musicaMenu())
    game.addVisual(cursor)

    keyboard.up().onPressDo{ cursor.subir(botones) }
	  keyboard.down().onPressDo{ cursor.bajar(botones) }
	  keyboard.enter().onPressDo{ cursor.seleccionar(botones) }
  }
}

object cursor {
  method image() = "mouse.png" 
  var indice = 0
  var property position = botonJugar.position().right(5)
  
  method subir(lista) {
    if(indice > 0) {
      sonidos.iniciarSonido(sonidos.moverCursor())
      indice -= 1
      position = lista.get(indice).position().right(5)
    }
  }

  method bajar(lista) {
    if(indice < lista.size() - 1){
      sonidos.iniciarSonido(sonidos.moverCursor())
      indice += 1
      position = lista.get(indice).position().right(5)
    }
  }

  method seleccionar(lista) {
    sonidos.iniciarSonido(sonidos.click())
    lista.get(indice).actuar()
  }
}

object pausa {
  method actuar() {}
}

class Boton {
  const imagen
  const ejeX
  const ejeY
  method image() = imagen
  var property position = game.at(ejeX, ejeY)
}


//CAMBIÉ LAS CLASES POR OBJETOS//
object botonJugar inherits Boton(imagen = "botonJugar.png", ejeX = 1.5, ejeY = 5) {
  method actuar() {
    sonidos.pararMusica()
    game.removeVisual(cursor)
    game.removeVisual(menu)
    botones.forEach { n => game.removeVisual(n) }
    nivel1.cargarNivel()
  }
}

object botonControles inherits Boton(imagen="botonControles.png", ejeX=1.5, ejeY=4) {
  method actuar() {
    game.removeVisual(menu)
    game.removeVisual(cursor)
    botones.forEach({ n => game.removeVisual(n) })
    controlesMenu.actuar()
    
  }
}

object botonSalir inherits Boton(imagen = "botonSalir.png", ejeX = 1.5, ejeY = 3) {
  method actuar() {
    sonidos.pararMusica()
    game.removeVisual(menu)
    game.removeVisual(cursor)
    botones.forEach({ n => game.removeVisual(n) })
    sonidos.iniciarSonido(sonidos.marioHabla().get(2))
    game.schedule(500, {game.stop()})
    
  }
}

object controlesMenu {
  var property image = "controlesMenu.jpg"
  var property position = game.origin()

  const property botonesV = [botonVolver]
  method actuar() {
    game.addVisual(self)
    game.addVisual(botonVolver)
    game.addVisual(cursor2)

    keyboard.enter().onPressDo{ botonVolver.actuar() }
  }
  
}

object cursor2 {
  method image() = "mouse.png"
  const property position = botonVolver.position().right(3)
  
}

object botonVolver inherits Boton(imagen = "botonAtras.png", ejeX = 10.5, ejeY = 1) {
  method actuar() {
    game.removeVisual(controlesMenu)
    game.removeVisual(cursor2)
    game.removeVisual(self)
    menu.iniciar()
  }
}