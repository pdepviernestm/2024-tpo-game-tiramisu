class Escalera {
    const ejeXBase
    const ejeYBase
    const alto

    method crearEscalera() {
        (0..alto).forEach({ i =>
            const pixel = new Pixel(ejeXPixel = ejeXBase, 
                                    ejeYPixel = ejeYBase + i, 
                                    colisionable = false , 
                                    escalable = true)
            game.addVisual(pixel)
        })
    }
}

class Base {
  const ejeXBase
  const ejeYBase
  const ancho
 
  method crearPiso() {
    (0..ancho).forEach({ i =>
        const pixel = new Pixel(ejeXPixel = ejeXBase + i, 
                                ejeYPixel = ejeYBase, 
                                colisionable = true , 
                                escalable = false)
      game.addVisual(pixel)
    })
  }
}

class Pixel {
    const ejeXPixel
    const ejeYPixel
    var property colisionable 
    var property escalable

    method position() = game.at(ejeXPixel, ejeYPixel)
    method image() {
        return if(escalable) {"escaleraPixel.png"} 
        else{"pixelBase.png"}
    }
    
    method actuar() {} 

    method detener() {}
}


