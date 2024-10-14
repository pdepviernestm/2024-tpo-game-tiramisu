class Escalera {
    const ejeXBase
    const ejeYBase
    const alto
    method crearEscalera() {
        (1..alto).forEach { i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase , ejeYPixel = ejeYBase + i)
            game.addVisual(pixel)
        }
    }
}

class Pixel {
    const ejeXPixel
    const ejeYPixel
    const property soyBase = false
    const property soyEscalera = true
    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = "escaleraPixel.png"
}