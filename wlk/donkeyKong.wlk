import mario.*
import barril.*
import menu.menuPausa


object donkey {
  var property colisionable = false 
  var property escalable = false 

  var property position = game.at(11, 11)
  var image = "donkeyy.png"
	const serieBarril = ["donkey4.png", "donkey1.png", "donkey3.png"]
  var indice = 0

  method image() = image

  method actuar() {}
  
  method lanzarBarril() {
    if(indice < 2) indice += 1 else indice = 0
    image = serieBarril.get(indice)
    if(indice == 2) { const barril = new Barril() game.addVisual(barril) barril.iniciar() }
    
  }
}