package pe.libertadores.dto;

// Generated 04-ene-2014 20:15:56 by Hibernate Tools 4.0.0

/**
 * UsuarioDTO generated by hbm2java
 */
public class UsuarioDTO implements java.io.Serializable {

	private int idUsuario;
	private PerfilDTO perfilDTO;
	private PersonaDTO personaDTO;
	private String user;
	private String pwd;

	public UsuarioDTO() {
	}

	public UsuarioDTO(int idUsuario, PerfilDTO perfilDTO,
			PersonaDTO personaDTO, String user, String pwd) {
		super();
		this.idUsuario = idUsuario;
		this.perfilDTO = perfilDTO;
		this.personaDTO = personaDTO;
		this.user = user;
		this.pwd = pwd;
	}
	
	public int getIdUsuario() {
		return this.idUsuario;
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}

	public PerfilDTO getPerfilDTO() {
		return this.perfilDTO;
	}

	public void setPerfilDTO(PerfilDTO perfilDTO) {
		this.perfilDTO = perfilDTO;
	}

	public PersonaDTO getPersonaDTO() {
		return this.personaDTO;
	}

	public void setPersonaDTO(PersonaDTO personaDTO) {
		this.personaDTO = personaDTO;
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Override
	public String toString() {
		return "UsuarioDTO [idUsuario=" + idUsuario + ", perfilDTO="
				+ perfilDTO + ", personaDTO=" + personaDTO + ", user=" + user
				+ ", pwd=" + pwd + "]";
	}

	
}
