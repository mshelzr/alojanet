package pe.libertadores.alojamiento.dto;

public class MenuDTO{
	
	private int idMenu;
	private String name;
	private String label;
	private String description;
	private int lvl;
	private int cnt_children;
	private int is_branch;
	
	public int getIdMenu() {
		return idMenu;
	}
	public void setIdMenu(int idMenu) {
		this.idMenu = idMenu;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getLvl() {
		return lvl;
	}
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	public int getCnt_children() {
		return cnt_children;
	}
	public void setCnt_children(int cnt_children) {
		this.cnt_children = cnt_children;
	}
	public int getIs_branch() {
		return is_branch;
	}
	public void setIs_branch(int is_branch) {
		this.is_branch = is_branch;
	}
	@Override
	public String toString() {
		return "MenuDTO [idMenu=" + idMenu + ", name=" + name + ", label="
				+ label + ", description=" + description + ", lvl=" + lvl
				+ ", ctn_children=" + cnt_children + ", is_branch=" + is_branch
				+ "]";
	}
	
	
	
}
