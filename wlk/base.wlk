class Base {
    const ejeXBase
    const ejeYBase
    const ancho
    method crearPiso() {
        (1..ancho).forEach { i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase + i, ejeYPixel = ejeYBase)
            const pixelInvisible = new PixelInvisible(ejeXP = ejeXBase + i, ejeYP = ejeYBase)
            game.addVisual(pixelInvisible)
            game.addVisual(pixel)
            }
    }
}

class PixelInvisible {
    const ejeXP 
    const ejeYP
    const property soyBase = true
    const property soyEscalera = false
    method position() = game.at(ejeXP , ejeYP + 1)
    method actuar() { 
    }
}

class Pixel {
    const ejeXPixel
    const ejeYPixel
    const property soyBase = false
    const property soyEscalera = false
    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = "pixelBase.png"

    method actuar() {  
    }
}

