import base.*
import escalera.*
import mario.*

object barriles {
    var property position = game.at(14, 11)

    method image() = "barriles.png"
}

class Barril {
    var property position = game.at(11, 11)
    var property direccionActual = izquierda
    var image = "barril1.png"
    var cayo = false

    method cayo(unBool) { cayo = unBool }

    method image() = image

    method mover() { //NO MODIFICA LA IMAGEN//
        const objetosDeAbajo = game.getObjectsIn(abajo.desplazar(position))
        if(position.y() < -1)
            self.detener()
        if(objetosDeAbajo.isEmpty())
        {
            position = abajo.desplazar(position)
            self.cayo(true)
        }
        else
        {
            const select = objetosDeAbajo.anyOne()
            if(select.soyBase())
            {
                if(cayo) { self.cayo(false) direccionActual = direccionActual.invertir() position = direccionActual.desplazar(position) }
                else position = direccionActual.desplazar(position)
            }
            else
            {
                position = abajo.desplazar(position)
                self.cayo(true)
            }
        }
    }

    method detener() { game.removeVisual(self) }

    method iniciar(){
        game.onTick(60, "Avanzar", { self.mover() })
    }

    method actuar() { mario.quitarVida() }
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
