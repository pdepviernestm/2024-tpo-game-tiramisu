import nivel1.*
import sonidos.*



const botonJugar = new BotonJugar(imagen="botonJugar.png", ejeX=1.5, ejeY=5)
const botonOpciones = new BotonOpciones(imagen="botonOpciones.png", ejeX=1.5, ejeY=4)
const botonControles = new BotonControles(imagen="botonControles.png", ejeX=1.5, ejeY=3)
const botonSalir = new BotonSalir(imagen="botonSalir.png", ejeX=1.5, ejeY=2)

const botones = [botonJugar, botonOpciones, botonControles, botonSalir]  

object menu {
  var property image= "menuPrincipal.jpg"
  var property position = game.origin()


  method iniciar() {
    game.addVisual(self)
    botones.forEach { n => game.addVisual(n) }
    sonidos.iniciarMusica(sonidos.musicaMenu())
    game.addVisual(cursor)

    keyboard.up().onPressDo{cursor.subir()}
	  keyboard.down().onPressDo{cursor.bajar()}
	  keyboard.enter().onPressDo{cursor.seleccionar()} 
  }
}

object cursor {
  method image() = "mouse.png" 
  var indice = 0
  var property position = botonJugar.position() 
  
  method subir() {
    if(indice > 0){  
      indice -= 1    
      position = botones.get(indice).position()
      sonidos.moverElCursor()
    }
  }

  method bajar() {
    if(indice < botones.size() - 1){ 
      sonidos.moverElCursor()
      indice += 1    
      position = botones.get(indice).position()
    }
  }

  method seleccionar() {
    sonidos.hacerClick()
    botones.get(indice).actuar()
  }
}

object pausa {
  method actuar() {
    
  }
}

class Boton {
  const imagen
  const ejeX
  const ejeY
  method image() = imagen
  var property position = game.at(ejeX,ejeY)
  
}

class BotonJugar inherits Boton {
  method actuar() {
    //sonidos.pararMusica()
    game.removeVisual(cursor)
    game.removeVisual(menu)
    botones.forEach { n => game.removeVisual(n) }
    nivel1.cargarNivel()
  }
  
}

class BotonOpciones inherits Boton {
  method actuar() {
    game.removeVisual(menu)
    game.removeVisual(cursor)
    botones.forEach { n => game.removeVisual(n) }
    //opciones.actuar()
    //game.addVisual(opciones)
  }
}

class BotonControles inherits Boton {
  method actuar() {
    game.removeVisual(menu)
    game.removeVisual(cursor)
    botones.forEach { n => game.removeVisual(n) }
    //controles.actuar()
    //game.addVisual(controles)
  }
  
}

class BotonSalir inherits Boton {
  method actuar() {
    //sonidos.pararMusica()
    game.stop()
  }
  
}
