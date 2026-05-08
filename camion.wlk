import cosas.*

//Camion que kkeve cosas sin sobrepesar hacia su destino	
//Las cosas tienen un nivel de pelogridad
//Segun el nivel de pelifrosidad de las cosas oueden ir oir determinada ruta o no 

object camion {
	const property cosas = #{}
	const tara = 1000

	// PESO Y EXCESO DE PESO
	method pesoTotal() {
	  return tara + self.pesoCarga()
	}

	method pesoCarga() {
	  return cosas.sum({unaCosa => unaCosa.peso()})
	}
	
	method estaExcedido() {
	  return self.pesoTotal() > 2500
	  /* if (self.pesoTotal() > 2500){
		self.error("El peso esta Excedido")
	  } */
	}
		
	// CARGA Y DESCARGA
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(unaCosa) {
	  cosas.remove(unaCosa)
	}

	method puedeCargar(unaCosa) {
		if (!self.cosas().contains(unaCosa)){
			self.cargar(unaCosa)
		}else{
			self.error("No se puede cargar algo que ya esta cargado")
		}
	}

	method puedeDescargar(unaCosa) {
	  if(self.cosas().contains(unaCosa)) {
		self.descargar(unaCosa)
	  }else{
		self.error("No se puede descargar algo que no este")
	  }
	}

	//PESO PAR
	method esPesoPar(unaCosa) {
	  return unaCosa.peso().even()
	}	

	method todasSonPares() {
	  return cosas.all({ unaCosa => self.esPesoPar(unaCosa)})
	}

	//PESA EXACTAMENTE
	method pesaExactamente(pesoBuscado) {
	  return cosas.any({ unaCosa => unaCosa.peso() == pesoBuscado})
	}

	//PELIGROSIDAD
	method tienePeligrosidadCon(peligrosidad) {
	  return cosas.find({ unaCosa => unaCosa.peligrosidad() == peligrosidad})
	}

	//COSAS PELIGROSAS
	method cosasPeligrosas(peligrosidad) {
	  return cosas.filter({ unaCosa => unaCosa.peligrosidad() > peligrosidad})
	}

	method masPeligrosoQue(cosaPeligrosa) {
	  return cosas.filter({unaCosa => unaCosa.peligrosidad() > cosaPeligrosa.peligrosidad()})
	}

	//PUEDE CIRCULAR EN RUTA
	method puedeCicularRuta(peligrosidadMaxima) {
	  return !self.estaExcedido() && self.todasSonSegurasDe(peligrosidadMaxima)
	}
	method todasSonSegurasDe(peligrosidad) {
	  return cosas.all({ unaCosa => unaCosa.peligrosidad() <= peligrosidad})
	}

	//TIENE ALGO QUE PESA ENTRE DOS VALORES
	method tieneAlgoQuePesaEntre(min, max) {
	  return cosas.any( {unaCosa => unaCosa.peso().between(min, max)} )
	}

	//COSA MAS PESADA
	method cosaMasPesada() {
	  return cosas.max({unaCosa => unaCosa.peso()})
	}

	//PESOS DE TODAS LAS COSAS
	method pesosDeLasCosas() {
	  return cosas.map({unaCosa => unaCosa.peso()})
	}

	//TOTAL DE BULTOS
	method totalBultos() {
	  return cosas.sum({ unaCosa => unaCosa.bultos() })
	}

	//ACCIDENTE
	method accidente() {
	  self.cosas().forEach({unaCosa => unaCosa.accidente()})
	}

	//TRASNPORTE
	method puedeTrasnportar(destino, camino) {
	  return camino.puedeCircular(self)
	}


	method transportar(destino, camino) {
	  if (camino.puedeCircular(self)){
		destino.depositarCosasDe(self)
		self.cosas().clear()
		
	  }else{
		self.error("no puede cirular por " + camino.toString() + " ya que no cumple con los requisitos")
	  }
	}
}

object almacen {
  const almacen = #{}

  method cargar(unCosa) {
	almacen.add(unCosa)
  }

  method almacen() {
	return almacen
  }

  method depositarCosasDe(transporte) {
	almacen.addAll(transporte.cosas())
  }
}

object ruta9 {

  const peligrosidadMaxima = 20

  method puedeCircular(transporte) {
	return transporte.puedeCicularRuta(peligrosidadMaxima)
  }
}

object caminosVecinales {

	var property pesoMaximo = 2500
  method puedeCircular(transporte) {
	return transporte.pesoTotal() <= pesoMaximo
  }
}
