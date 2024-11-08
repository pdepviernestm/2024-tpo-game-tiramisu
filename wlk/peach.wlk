import menu.*
import sonidos.*
import mario.*
import nivel1.*

object peach {
  var property position = game.at(2, 13)
  var property colisionable = false 
  var property escalable = false
  var indice = 0
  var property liberable = false
  var conMario = false
  var imagen = "peach3.png"
  const imagenes = ["peach3.png","peach1.png","peach2.png"]

  method image() = imagen

  method moverse() {
    if(!conMario) {
      if(indice < 2) indice += 1 else indice = 0
        imagen = imagenes.get(indice)
    }
  }
    
  method actuar() {
    if(liberable){
      conMario = true
      menuGanar.actuar()
    }
  }
  method libre() {
    sonidos.iniciarSonido(sonidos.peachLibre())
    carcel.abrir()
    liberable = true
  }
}
object carcel {
  var property position = game.at(1, 13)
  var imagen = "celdaCerrada.png"

  method image() = imagen

  var property colisionable = false
  var property escalable = false

  method abrir() {
    imagen = "celdaAbierta.png"
  }
}

object objetoInvisible {
  const property position = peach.position().right(1)
  method actuar() {
    peach.actuar()
  }
}