import nivel1.*
import sonidos.*


const botonesMenuPrincipal = [botonJugar, botonControles, botonSalir]
const botonesMenuControles = [botonVolver]

object menu {
  var property image = "menuPrincipal.jpg"
  var property position = game.origin()
  var controlesIniciados = false

  method iniciar() {
    sonidos.iniciarSonido(sonidos.nombreGame())
    game.addVisual(self)
    botonesMenuPrincipal.forEach({ boton => game.addVisual(boton) })
    sonidos.iniciarMusica(sonidos.musicaMenu())
    game.addVisual(cursor)
    cursor.iniciar(botonesMenuPrincipal)

    if(!controlesIniciados) {
      controlesIniciados = true
      keyboard.u().onPressDo({ cursor.desplazar(-1) })
      keyboard.j().onPressDo({ cursor.desplazar(1) })
      keyboard.enter().onPressDo({ cursor.seleccionar() })
    }
  }

  method cerrar() {
    game.removeVisual(self)
    game.removeVisual(cursor)
    botonesMenuPrincipal.forEach({ boton => game.removeVisual(boton) })
  }
}

object cursor {
  var indice = 0
  var botonesActuales = botonesMenuPrincipal
  var property position = botonesActuales.get(indice).position().right(5)
  
  method image() = "mouse.png"
  
  method iniciar(botones) { //Inicia el cursor, dependiende del menu (botones)
    botonesActuales = botones
    indice = 0
    position = botonesActuales.get(indice).position().right(5)
  }

  method desplazar(desplazamiento) {
    var nuevoIndice = indice + desplazamiento
    if (nuevoIndice >= 0 and nuevoIndice < botonesActuales.size()) {
      sonidos.iniciarSonido(sonidos.moverCursor())
      indice = nuevoIndice
      position = botonesActuales.get(indice).position().right(5)
    }
  }

  method seleccionar() {
    sonidos.iniciarSonido(sonidos.click())
    botonesActuales.get(indice).actuar()
  }
}

class Boton {
  const ejeX
  const ejeY
  const imagen
  var property position = game.at(ejeX, ejeY)
  
  method image() = imagen

  method actuar()
}

object botonJugar inherits Boton(imagen = "botonJugar.png", ejeX = 1.5, ejeY = 5) {
  override method actuar() {
    sonidos.pararMusica()
    menu.cerrar()
    nivel1.cargarNivel()
  }
}

object botonControles inherits Boton(imagen="botonControles.png", ejeX = 1.5, ejeY = 4) {
  override method actuar() {
    menu.cerrar()
    menuControles.iniciar()
  }
}

object botonSalir inherits Boton(imagen = "botonSalir.png", ejeX = 1.5, ejeY = 3) {
  override method actuar() {
    sonidos.pararMusica()
    menu.cerrar()
    sonidos.iniciarSonido(sonidos.marioHabla().get(2))
    game.schedule(500, { game.stop() })
  }
}

object menuControles {
  var property position = game.origin()
  var property image = "controlesMenu.jpg"
  
  method iniciar() {
    game.addVisual(self)
    game.addVisual(botonVolver)
    cursor.iniciar(botonesMenuControles)
  }

  method cerrar() {
    game.removeVisual(self)
    game.removeVisual(botonVolver)
  }
}

object botonVolver inherits Boton(imagen = "botonAtras.png", ejeX = 10.5, ejeY = 1) {
  override method actuar() {
    menuControles.cerrar()
    menu.iniciar()
  }
}
