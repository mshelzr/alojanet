package test;

public class MenuDTO {

	private long idMenu;
	private String descripcion;
	private String url;
	
	public long getIdMenu() {
		return idMenu;
	}
	public void setIdMenu(long idMenu) {
		this.idMenu = idMenu;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	@Override
	public String toString() {
		return "MenuDTO [idMenu=" + idMenu + ", descripcion=" + descripcion
				+ ", url=" + url + "]";
	}
	
	
	
}
