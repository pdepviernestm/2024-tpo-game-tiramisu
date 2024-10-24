import sonidos.*
import mario.*
import nivel1.*


object peach {
    var property position = game.at(2, 13)
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
        conMario = true
        sonidos.iniciarSonido(sonidos.ganar())
        //menuGanar.cargar()
    }
}