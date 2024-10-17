object sonidos {
    const property musicaNivel1 = "theme1.mp3"
    const property musicaMenu = "themeMenu.mp3"
    const property marioMuere = "marioDead.wav"
    const property marioCamina = ["marioWalk1.wav","marioWalk2.wav","marioWalk3.wav","marioWalk4.wav","marioWalk5.wav","marioWalk6.wav"]
    const property marioPierdeVida = "marioPierdeVida.wav"
    const property marioMuerePorFuego = "morirPorFuego.wav"
    const property marioCae = "marioCae.wav"
    const property marioHabla = ["marioComentario8.wav","marioComentario7.wav","marioComentario6.wav","marioComentario5.wav","marioComentario4.wav","marioComentario3.wav","marioComentario2.wav","marioComentario1.wav"]
    const property marioSalta = ["mario_jump1.wav","mario_jump2.wav","mario_jump3.wav","mario_jump4.wav"]
    const property moverCursor = "cursorNavegar.mp3"
    const property click = "click.mp3"

    var musicaActual = null


method iniciarMusica(song) {
    musicaActual = song
    const cancion = game.sound(song)
  	cancion.shouldLoop(true)
    cancion.play()
    cancion.volume(0.25)
}

method moverElCursor() {
  game.sound(self.moverCursor()).play()
}

method hacerClick() {
  game.sound(self.click()).play()
}

method caminar() {
    game.sound(self.marioCamina().anyOne()).play() 
}

method hablar() {
    game.sound(self.marioHabla().anyOne()).play() 
}

method saltar(){
    game.sound(self.marioSalta().anyOne()).play() 
}
method pararMusica() {
    if(musicaActual != null) game.sound(musicaActual).stop()
}
}

object imagenes {
  
}