import nivel1.*
import sonidos.*


class Menu {
  var property image
  var property botones
  var property position = game.origin()

  method iniciar() {
    game.addVisual(self)
    game.addVisual(cursor)
    botones.forEach({ boton => game.addVisual(boton) })
  }

  method cerrar() {
    game.allVisuals().forEach({ n => game.removeVisual(n) })
  }

  method iniciarTeclas() {
    keyboard.i().onPressDo { sonidos.cambiarVolumen(0.05) }
    keyboard.k().onPressDo { sonidos.cambiarVolumen(-0.05) }
    keyboard.up().onPressDo({ cursor.desplazar(-1) })
    keyboard.down().onPressDo({ cursor.desplazar(1) })
    keyboard.enter().onPressDo({ cursor.seleccionar() })
  }
}

object menuPrincipal inherits Menu(image = "menuPrincipal.jpg", botones = [botonJugar, botonControles, botonSalir]){
  override method iniciar() {
    super()
    cursor.iniciar(botones)
  }
  method inicioPrincipal(){
    sonidos.iniciarSonido(sonidos.nombreGame())
    sonidos.iniciarMusica(sonidos.musicaMenu())
    self.iniciar()
    self.iniciarTeclas()
  }
}

object menuControles inherits Menu(image = "controlesMenu.jpg", botones = [botonVolver]) {
  override method iniciar() {
    super()
    cursor.iniciar(botones)
  }
}

class MenuFinal {
  const sonido
  const property image
  const property position = game.origin()
  method actuar(){
    game.addVisual(self)
    game.sound(sonido).play()
    sonidos.pararMusica()
    game.schedule(250, { game.stop() })
  }
  
}
object menuPerder inherits MenuFinal (image = "menuPerder0.png", sonido = sonidos.marioMuere()){}
object menuGanar inherits MenuFinal (image = "menuGanar0.png", sonido = sonidos.ganar()){}
object menuPausa inherits MenuFinal (image = "menuPausa0.png", sonido = sonidos.click()){
  var property actuando = false
    override method actuar() {
    if(actuando){
    game.removeVisual(self)
    sonidos.despausarMusica()
    actuando = false
    }
    else{
    sonidos.pausarMusica()
    game.addVisual(self)
    actuando = true
    }
  }
}

object cursor {
  var indice = 0
  var botonesActuales = menuPrincipal.botones()
  var property position = botonesActuales.get(indice).position().right(5)
  
  method image() = "mouse.png"
  
  method iniciar(botones) {
    botonesActuales = botones
    indice = 0
    if(botones == menuPrincipal.botones())
      self.nuevaPosition(botonesActuales.get(indice).position().right(5))
    else
      self.nuevaPosition(botonesActuales.get(indice).position().right(3))
  }

  method nuevaPosition(newPosition) { position = newPosition }

  method desplazar(desplazamiento) {
    const nuevoIndice = indice + desplazamiento
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
    menuPrincipal.cerrar()
    nivel1.cargarNivel()
  }
}

object botonControles inherits Boton(imagen="botonControles.png", ejeX = 1.5, ejeY = 4) {
  override method actuar() {
    menuPrincipal.cerrar()
    menuControles.iniciar()
  }
}

object botonSalir inherits Boton(imagen = "botonSalir.png", ejeX = 1.5, ejeY = 3) {
  override method actuar() {
    sonidos.pararMusica()
    menuPrincipal.cerrar()
    sonidos.iniciarSonido(sonidos.marioHabla().get(2))
    game.schedule(500, { game.stop() })
  }
}

object botonVolver inherits Boton(imagen = "botonAtras.png", ejeX = 10.5, ejeY = 1) {
  override method actuar() {
    menuControles.cerrar()
    menuPrincipal.iniciar()
  }
}

