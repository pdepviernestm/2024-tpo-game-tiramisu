class Base {
    const x 
    const y
    const soyBase = true
    const ancho = 15 
    const property position = game.at(x, y)
    const pixel1 new Pixel(x+1, y)
    const pixel2 new Pixel(x+2, y)




    method colision() {
    }
}

class Pixel {
    const x
    const y
    const property position = game.at(x, y) 
  method image() = "basePixel.png"

}