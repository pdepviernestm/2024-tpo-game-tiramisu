import mario.*

class Escalera {
    const ejeXBase
    const ejeYBase
    const alto

    method crearEscalera() {
        (0..alto).forEach({ i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase, ejeYPixel = ejeYBase + i)
            game.addVisual(pixel)
        })
    }
}

class Pixel {
    const ejeXPixel
    const ejeYPixel
    var property romper = false
    var property colisionable = false 
    var property escalable = true 

    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = "escaleraPixel.png"
    
    method actuar() {
    }  
}