package pe.libertadores.dto;

// Generated 04-ene-2014 20:15:56 by Hibernate Tools 4.0.0


/**
 * ClienteDTO generated by hbm2java
 */
public class ClienteDTO implements java.io.Serializable {

	private int idCliente;
	private PersonaDTO personaDTO;
	private String razonSocial;
	private int ruc;
	private int cantidadReservasCumplidas;
	private int estado;
	
	public ClienteDTO() {
	}

	public ClienteDTO(int idCliente, PersonaDTO personaDTO, String razonSocial,
			int ruc, int cantidadReservasCumplidas, int estado) {
		super();
		this.idCliente = idCliente;
		this.personaDTO = personaDTO;
		this.razonSocial = razonSocial;
		this.ruc = ruc;
		this.cantidadReservasCumplidas = cantidadReservasCumplidas;
		this.estado = estado;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public PersonaDTO getPersonaDTO() {
		return personaDTO;
	}

	public void setPersonaDTO(PersonaDTO personaDTO) {
		this.personaDTO = personaDTO;
	}

	public String getRazonSocial() {
		return razonSocial;
	}

	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public int getRuc() {
		return ruc;
	}

	public void setRuc(int ruc) {
		this.ruc = ruc;
	}

	public int getCantidadReservasCumplidas() {
		return cantidadReservasCumplidas;
	}

	public void setCantidadReservasCumplidas(int cantidadReservasCumplidas) {
		this.cantidadReservasCumplidas = cantidadReservasCumplidas;
	}

	public int getEstado() {
		return estado;
	}

	public void setEstado(int estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "ClienteDTO [idCliente=" + idCliente + ", personaDTO="
				+ personaDTO + ", razonSocial=" + razonSocial + ", ruc=" + ruc
				+ ", cantidadReservasCumplidas=" + cantidadReservasCumplidas
				+ ", estado=" + estado + "]";
	}

	
}
