object knightRider {

	method peso() {
	  return 500
	}
	//method peso() { return 500 }
	method peligrosidad() {
	  return 10
	}
	method bultos() = 1
	//method nivelPeligrosidad() { return 10 }
}

object arenaGranel {
  var property peso = 0
  method peso() {
	return peso
  }
  method peligrosidad() {
	return 1
  }

  method bultos() = 1
}

object bumblebee {
  var property modoAuto = true
  method peso(){
	return 800
  }
  method peligrosidad() {
	return if (modoAuto){
		15
	}else{
		30
	}
  }

  method bultos() = 2
}

object paqueteLadrillos {
  var property cantLadrillos = 0

  method peso() {
	return 2 * cantLadrillos
  }

  method peligrosidad() {
	return 2
  }

  method bultos() {
	return if (cantLadrillos <= 100){
		1
	}else if(cantLadrillos <= 300){
		2
	}else{
		3
	}
  }
}

object bateriaAntiaerea {
  var property hayMisiles = true

  method peso() {
	return if (hayMisiles){
		300
	}else{
		200
	}
  }

  method peligrosidad() {
	return if (hayMisiles){
		100
	}else{
		0
	}
  }

  method bultos() {
	return if (self.hayMisiles()) {
		2
	}else{
		1
	}
  }
}

object residuosRadiactivos {
  var property peso = 0

  method peligrosidad() {
	return 200
  } 

  method bultos() = 1
}

// MAS COSAS
object contenedorPortuario {
  const peso = 100
  const carga = #{} 

  method cargar(cosa) {
	carga.add(cosa)
  }

  method peso() {
	return peso + self.pesoDeCosas()
  }

  method pesoDeCosas() {
	return carga.sum({unaCosa => unaCosa.peso()})
  }

  method peligrosidad() {
	return if(carga.isEmpty()){
		0
	}else{
		self.cargaMasPeligrosa()
	}
  }
  method cargaMasPeligrosa() {
	return carga.max({carga => carga.peligrosidad()}).peligrosidad()
  }

  method bultos() {
	return 1 + carga.sum({ c => c.bultos() })
  }
}

object embalajeSeguridad {
  var property cargaEnvuelta = bumblebee

  method peso() {
	return cargaEnvuelta.peso()
  }

  method peligrosidad() {
	return cargaEnvuelta.peligrosidad()/2
  }

  method bultos() = 2
}




