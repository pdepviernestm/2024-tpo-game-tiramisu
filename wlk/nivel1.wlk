import wollok.game.*
import base.*
import mario.*
import escalera.*
import corazones.*
import sonidos.*
import menu.*
import donkeyKong.*
import peach.*
import barril.*

object nivel1 {
	const bases = []
	const escaleras = []

	//TECLAS: Mario//
    const teclasDer = [keyboard.right(), keyboard.d()]
	const teclasIzq = [keyboard.left(), keyboard.a()]
	const teclasSaltar = [keyboard.space()]
	const teclasEscalarArriba = [keyboard.up(), keyboard.w()]
	const teclasEscalarAbajo = [keyboard.down(), keyboard.s()]
	
    method cargarNivel() {
		sonidos.iniciarSonido(sonidos.iniciarNivel())
		sonidos.iniciarMusica(sonidos.musicaNivel1())

		//CARGAR: Bases//
		bases.add(new Base(ejeXBase = 0, ejeYBase = 1, ancho = 13))
		bases.add(new Base(ejeXBase = 1, ejeYBase = 4, ancho = 15))
		bases.add(new Base(ejeXBase = 0, ejeYBase = 7, ancho = 13))
		bases.add(new Base(ejeXBase = 2, ejeYBase = 10, ancho = 18))
		bases.add(new Base(ejeXBase = 1, ejeYBase = 12, ancho = 5))
		bases.forEach({ n => n.crearPiso() })

		//CARGAR: Escaleras//
		escaleras.add(new Escalera(ejeXBase = 5, ejeYBase = 2, alto = 2))
		escaleras.add(new Escalera(ejeXBase = 10, ejeYBase = 1, alto = 1))
		escaleras.add(new Escalera(ejeXBase = 8, ejeYBase = 6, alto = 1))
		escaleras.add(new Escalera(ejeXBase = 12, ejeYBase = 5, alto = 2))
		escaleras.add(new Escalera(ejeXBase = 2, ejeYBase = 8, alto = 2))
		escaleras.add(new Escalera(ejeXBase = 5, ejeYBase = 11, alto = 1))
		escaleras.forEach({ n => n.crearEscalera() })

		//CARGAR: Vida//
	    corazones.agregarCorazon()

		//Cargar: Objetos//
	    game.showAttributes(mario)
	    game.addVisual(mario)
		game.addVisual(donkey)
		game.addVisual(peach)
		game.addVisual(barriles)
		game.addVisual(paraguas)
		game.addVisual(sombrero)
		game.addVisual(cartera)

//DEFINIR TECLAS 
        keyboard.p().onPressDo({menuPausa.actuar()})

		keyboard.i().onPressDo { sonidos.cambiarVolumen(0.05) }
    	keyboard.k().onPressDo { sonidos.cambiarVolumen(-0.05) }

	    teclasDer.forEach { n => n.onPressDo({ mario.andar(0) })}
        teclasIzq.forEach { n => n.onPressDo({ mario.andar(1) })}

	    teclasSaltar.forEach { n => n.onPressDo({ mario.saltar() })}

	    teclasEscalarArriba.forEach { n => n.onPressDo({ mario.escalar(1) })}
	    teclasEscalarAbajo.forEach { n => n.onPressDo({ mario.escalar(-1) })}


//EVENTOS REPETITIVOS
	    game.onTick(300, "Se cae", { if(!mario.enBase() and !menuPausa.actuando() and !mario.enEscalera()) mario.caer() })

	    game.onTick(10000, "Comentarios", { if(!menuPausa.actuando())sonidos.iniciarListaSonido(sonidos.marioHabla()) })

		game.onTick(1000, "Donkey Kong lanza Barriles", {if(!menuPausa.actuando())donkey.lanzarBarril()})
		
		game.onTick(500, "Peach se mueve", {if(!menuPausa.actuando())peach.moverse()})

		//game.onTick(1000, "Barrilazo", {})

//COLISIONES (TODOS LOS OBJETOS COLISIONABLES DEBEN TENER EL METHOD ACTUAR)
	    game.onCollideDo(mario, { elemento => elemento.actuar() })
    }
}
