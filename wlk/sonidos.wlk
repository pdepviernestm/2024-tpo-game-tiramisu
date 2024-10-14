object sonidos {
    const property  musicaNivel1 = "level1song.wav"
    const property marioMuere = "marioDead.wav"
    const property marioSalta = "marioJump.wav"
    const property marioCamina = ["marioWalk1.wav","marioWalk2.wav","marioWalk3.wav","marioWalk4.wav","marioWalk5.wav","marioWalk6.wav"]
    const property marioPierdeVida = "marioPierdeVida.wav"

    const song = game.sound(sonidos.musicaNivel1())

method iniciarMusica() {
  	song.shouldLoop(true)
    song.play()
    song.volume(0.25)
}

method pararMusica() {
    song.stop()
} 


}

object imagenes {
  
}