import mario.*

class Fuego {
    const ejeXBase
    const ejeYBase
    const ancho
    const fuegos = []
    method crearFuego() {
        (0..ancho).forEach { i =>
            const fuego = new Pixel(ejeXPixel = ejeXBase + i, ejeYPixel = ejeYBase)
            const pixelInvisible = new PixelInvisible(ejeXP = ejeXBase + i, ejeYP = ejeYBase)
            game.addVisual(pixelInvisible)
            game.addVisual(fuego)
            fuegos.add(fuego)}
    }
    method cambiarFotos() {
    (0..ancho).forEach { i =>const fuego = fuegos.get(i) 
    fuego.cambiar()}
}
}

class PixelInvisible {
    const ejeXP 
    const ejeYP
    const property soyBase = false
    const property soyEscalera = false
    method position() = game.at(ejeXP , ejeYP + 1)
    method actuar() { 
        mario.tocarFuego()
    }
}

class Pixel {
    const ejeXPixel
    const ejeYPixel
    const imagenes = ["fuego.png","fuegoP.png","fuego4.png"]
    var imagen = imagenes.head()
    method image() = imagen
    const property soyBase = false
    const property soyEscalera = false
    method position() = game.at(ejeXPixel, ejeYPixel)

    method cambiar() {
    const imagenesDisponibles = imagenes.filter({unaImagen => (unaImagen != imagen)})
    imagen = imagenesDisponibles.anyOne()

}

    method actuar() {  
        mario.tocarFuego()
    }
}