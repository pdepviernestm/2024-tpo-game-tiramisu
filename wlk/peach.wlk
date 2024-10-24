import mario.*
import nivel1.*

object peach {
    var property position = game.at(8, 13)
    const property image = "peach.png"

    method actuar() {
        if(mario.items().size() == 3)
            mario.winGame()
    }
}

class Item {
    var property position
    const property image

    method actuar() {
        mario.items().add(self)
        //peach hace un sonido
        game.removeVisual(self)
    }
}

object paraguas inherits Item(position = game.at(3, 2), image = "paraguas.png") {}
object sombrero inherits Item(position = game.at(5, 2), image = "sombrero.png") {}
object cartera inherits Item(position = game.at(9, 2), image = "cartera.png") {}
