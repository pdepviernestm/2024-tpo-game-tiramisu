class Direccion {
  method desplazar(position)
}

object izquierda inherits Direccion {
  override method desplazar(position) = position.left(1)

  method invertir() = derecha
}

object derecha inherits Direccion {
  override method desplazar(position) = position.right(1)

  method invertir() = izquierda
}

object abajo inherits Direccion {
  override method desplazar(position) = position.down(1)
}