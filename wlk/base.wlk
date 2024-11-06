import mario.*

class Base {
    const ejeXBase
    const ejeYBase
    const ancho
 
    method crearPiso() {
        (0..ancho).forEach({ i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase + i, ejeYPixel = ejeYBase)
            game.addVisual(pixel)
            })
    }
}


class Pixel {
    const ejeXPixel
    const ejeYPixel
    var property colisionable = true
    var property escalable = false
    
    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = "pixelBase.png"

    method actuar() {
    }
    
}