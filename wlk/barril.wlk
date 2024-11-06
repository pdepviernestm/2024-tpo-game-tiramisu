import base.*
import escalera.*
import mario.*
import menu.menuPausa


object barriles {
    var property position = game.at(14, 11)

    method image() = "barriles.png"
}

class Barril {
    var property colisionable = false
    var property escalable = false
    
    var property direccionActual = izquierda

    var property position = new MutablePosition(x=11, y=11)
    var image = imagenes.get(index)
    var cayo = false
    var index = 0
    const property imagenes = ["barril1.png", "barril2.png", "barril3.png", "barril4.png"]

    method cayo(unBool) { cayo = unBool }

    method image() = image

    method cambiarImagen() {
        if(index < 3) index += 1 
        else index = 0
        image = imagenes.get(index)
    }

    method mover() { 
        if(!menuPausa.actuando()){
        const objetosDeAbajo = game.getObjectsIn(abajo.desplazar(position))
        if(position.y() < -1)
            self.detener()
        if(objetosDeAbajo.isEmpty()) { position = abajo.desplazar(position) self.cayo(true) }
        else{
            if(objetosDeAbajo.contains(mario)) { position = abajo.desplazar(position) self.cayo(true) }
            else{
                const select = objetosDeAbajo.anyOne()
                if(select.colisionable()){
                    if(cayo) { self.cayo(false) direccionActual = direccionActual.invertir() position = direccionActual.desplazar(position) }
                    else position = direccionActual.desplazar(position)
                    self.cambiarImagen()
                }
                else{
                    position = abajo.desplazar(position)
                    self.cayo(true)
                }
            }
        }
    }
    }
    method detener() { game.removeVisual(self) }

    method iniciar(){
        game.onTick(60, "Avanzar", { self.mover() })
    }

    method actuar() { 
        mario.quitarVida() 
        game.removeVisual(self)
    }
}

object barrilEnLlamas {
    var property position = game.at(12, 2)

    method image() = "barrilEnLlamas.png"
}

class Direccion {
    method desplazar(position)
}

object izquierda inherits Direccion {
    override method desplazar(position) = position.left(1)

    method invertir() = derecha
}

object derecha inherits Direccion {
    override method desplazar(position) = position.right(1)

    method invertir() = izquierda
}

object abajo inherits Direccion {
    override method desplazar(position) = position.down(1)
}
