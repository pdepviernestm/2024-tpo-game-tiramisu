import base.*
import mario.*
import escalera.*
import wollok.game.*
import corazones.*
import sonidos.*
import fuego.*
import menu.*

object nivel1 {
    const teclasDer = [keyboard.right(),keyboard.d()]
	const teclasIzq = [keyboard.left(),keyboard.a()]
	const teclasSaltar = [keyboard.space()]
	const teclasEscalarArriba = [keyboard.up(),keyboard.w()]
	const teclasEscalarAbajo = [keyboard.down(),keyboard.s()]

    const primerPiso = new Base(ejeXBase=-1, ejeYBase=1, ancho=13)
	const segundoPiso = new Base(ejeXBase=3, ejeYBase=4, ancho= 12)
	const tercerPiso = new Base(ejeXBase=-1, ejeYBase=7, ancho=10)
	
	const primerEscalera = new Escalera(ejeXBase = 10 , ejeYBase = 2, alto = 2)
    
	//const fuegoPiso = new Fuego(ejeXBase = 0 , ejeYBase = 0, ancho = 15)
    
    method cargarNivel() {
      
        sonidos.iniciarMusica(sonidos.musicaNivel1())

        primerPiso.crearPiso()
	    segundoPiso.crearPiso()
	    tercerPiso.crearPiso()

	    primerEscalera.crearEscalera()

	    //fuegoPiso.crearFuego()

	    corazon.agregarCorazon()

	    game.showAttributes(mario)
	    game.addVisual(mario)

//DEFINIR TECLAS
        keyboard.p().onPressDo({pausa.actuar()})

	    teclasDer.forEach { n =>  n.onPressDo({ mario.derecha() })}
	
        teclasIzq.forEach { n =>  n.onPressDo({ mario.izquierda() })}

	    teclasSaltar.forEach { n =>  n.onPressDo({ mario.saltar() })}
	
	    teclasEscalarArriba.forEach { n =>  n.onPressDo({ mario.escalar() })}
	    teclasEscalarAbajo.forEach { n =>  n.onPressDo({ mario.escalarAbajo() })}


//EVENTOS QUE SE REPITEN CADA CIERTO TIEMPO
	    game.onTick(250, "Se cae", { if(not(mario.enBase())) mario.caer() })

	    //game.onTick(500, "Fuego", { fuegoPiso.cambiarFotos() })

	    game.onTick(10000, "Comentarios", { sonidos.hablar() })

//COLISIONES (TODOS LOS OBJETOS COLISIONABLES DEBEN TENER EL METHOD ACTUAR)
	    game.onCollideDo(mario, { elemento => elemento.actuar() })

    }
}