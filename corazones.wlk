const corazon = new Corazones(x = 9, y = 14, cant = 5)

class Corazones {
    const x
    const y
    const cant
    var corazones = [] 
     
    method agregarCorazon() {
        (1..cant).forEach { i =>
            const corazon = new Corazon(ejeXPixel = x + i, ejeYPixel = y)
            corazones.add(corazon) 
            game.addVisual(corazon)
        }
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
    
    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = imagen
    
    method quitarCorazon() {
        imagen = "marioVidaDead.png"
    }
}