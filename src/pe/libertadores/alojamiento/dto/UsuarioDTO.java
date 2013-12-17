package pe.libertadores.alojamiento.dto;

public class UsuarioDTO {

    private int idUsuario;
	private int idPersona;
	private int idPerfil;
	private String user;
	private String pwd;
	
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public int getIdPersona() {
		return idPersona;
	}
	public void setIdPersona(int idPersona) {
		this.idPersona = idPersona;
	}
	public int getIdPerfil() {
		return idPerfil;
	}
	public void setIdPerfil(int idPerfil) {
		this.idPerfil = idPerfil;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	@Override
	public String toString() {
		return "UsuarioDTO [idUsuario=" + idUsuario + ", idPersona="
				+ idPersona + ", idPerfil=" + idPerfil + ", user=" + user
				+ ", pwd=" + pwd + "]";
	}	

}
