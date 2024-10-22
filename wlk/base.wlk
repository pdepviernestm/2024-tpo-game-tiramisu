class Base {
    const ejeXBase
    const ejeYBase
    const ancho
    const property soyBase = true
    //const property soyEscalera = false
 
    method crearPiso() {
        (1..ancho).forEach({ i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase + i, ejeYPixel = ejeYBase)
            game.addVisual(pixel)
            })
    }
}


class Pixel {
    const ejeXPixel
    const ejeYPixel
    const property soyBase = true
    const property soyEscalera = false
    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() = "pixelBase.png"

    method actuar() {}
}