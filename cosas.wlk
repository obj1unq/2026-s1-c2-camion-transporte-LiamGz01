object knightRider {

	method peso() {
	  return 500
	}
	//method peso() { return 500 }
	method peligrosidad() {
	  return 10
	}
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
}

object paqueteLadrillos {
  var property cantLadrillos = 0

  method peso() {
	return 2 * cantLadrillos
  }

  method peligrosidad() {
	return 2
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
}

object residuosRadiactivos {
  var property peso = 0

  method peligrosidad() {
	return 200
  } 
}




