import menu.*
import sonidos.*
import mario.*
import nivel1.*


object peach {
    var property position = game.at(2, 13)
    var property colisionable = false 
    var property escalable = false 
    
    const imagenes = ["peach3.png","peach1.png","peach2.png"]
    var indice = 0
    var conMario = false
    var imagen = "peach3.png"
    method image() = imagen

    method moverse() {
        if(!conMario){
        if(indice < 2) indice += 1 else indice = 0
        imagen = imagenes.get(indice)
        }}
    
    method actuar() {
        if(mario.items().size() == 3)
        conMario = true
        menuGanar.actuar()
    }
}

class Item {
    var property position
    const property image

    var property colisionable = false
    var property escalable = false

    method actuar() {
        mario.items().add(self)
        //peach hace un sonido
        game.removeVisual(self)
    }
}

object paraguas inherits Item(position = game.at(3, 2), image = "paraguas.png") {}
object sombrero inherits Item(position = game.at(5, 2), image = "sombrero.png") {}
object cartera inherits Item(position = game.at(9, 2), image = "cartera.png") {}
