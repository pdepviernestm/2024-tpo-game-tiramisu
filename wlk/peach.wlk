import sonidos.*
import mario.*
import nivel1.*

object peach {
    var property position = game.at(2, 13)
    const imagenes = ["peach3.png","peach1.png","peach2.png"]
    var indice = 0
    var imagen = "peach3.png"

    method image() = imagen


    method moverseAutomaticamente() {
      game.onTick(500, "Peach se mueve", {
        if(indice < 2) indice += 1 else indice = 0
        imagen = imagenes.get(indice)
        })
    }

    
    method actuar() {
        //SE GANA EL GAME Y ELLA DICE ALGO
    }
}

