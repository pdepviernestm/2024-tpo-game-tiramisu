object corazones { 
    const x = 9
    const y = 14
    const cant = 5
    const corazones = []
    
    method agregarCorazon() {
        (1..cant).forEach({ i =>
            const corazon = new Corazon(ejeXPixel = x + i, ejeYPixel = y)
            corazones.add(corazon) 
            game.addVisual(corazon)
        })
    }
    
    method quitarCorazon() { 
        const corazon = corazones.last()
        corazon.quitarCorazon()
        corazones.remove(corazon)
    }
}

class Corazon {
    const ejeXPixel
    const ejeYPixel
    var imagen = "marioVida.png"

    var property colisionable = false 
    var property escalable = false 

    method position() = game.at(ejeXPixel, ejeYPixel)

    method image() = imagen

    method quitarCorazon() {
        imagen = "marioVidaDead.png"
    }

    method actuar() {}
}