object sonidos {
  const property musicaNivel1 = "theme1.mp3"
  const property musicaMenu = "themeMenu.mp3"
  const property nombreGame = "mario_gametitle.wav"
  const property marioMuere = "marioDead.wav"
  const property marioPierdeVida = "marioPierdeVida.wav"
  const property marioMuerePorFuego = "morirPorFuego.wav"
  const property marioCae = "marioCae.wav"
  const property moverCursor = "cursorNavegar.mp3"
  const property click = "click.mp3"
  const property ganar = "win.wav"
  const property iniciarNivel = "iniciarNivel.wav"
  const property marioCamina = ["marioWalk1.wav", "marioWalk2.wav", "marioWalk3.wav", "marioWalk4.wav", "marioWalk5.wav", "marioWalk6.wav"]
  const property marioHabla = ["marioComentario8.wav", "marioComentario7.wav", "marioComentario6.wav", "marioComentario5.wav", "marioComentario4.wav", "marioComentario3.wav", "marioComentario2.wav", "marioComentario1.wav"]
  const property marioSalta = ["mario_jump1.wav", "mario_jump2.wav", "mario_jump3.wav", "mario_jump4.wav"]

  var musicaActual = null

  method iniciarMusica(song) {
    if(musicaActual == null) { //Se podria hacer diferente
      if(musicaActual != null) musicaActual.stop()
      musicaActual = game.sound(song)
      musicaActual.shouldLoop(true)
      musicaActual.play()
      musicaActual.volume(0.25)
    }
  }

  method pararMusica() { 
  if(musicaActual != null)  musicaActual.stop() musicaActual = null
  }

  method iniciarSonido(sonido) {
    const sound = game.sound(sonido)
    sound.play()
  }

  method iniciarListaSonido(lista) {
    const sound = game.sound(lista.anyOne())
    sound.play()
  }

}
