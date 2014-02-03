package pe.libertadores.dto;

// Generated 04-ene-2014 20:15:56 by Hibernate Tools 4.0.0


/**
 * MenuDTO generated by hbm2java
 */
public class MenuDTO implements java.io.Serializable {

	private int idMenu;
	private String name;
	private String label;
	private String description;
	private int lft;
	private int rht;
	private int lvl;
	
	public MenuDTO() {
	}

	public MenuDTO(int idMenu, String name, String label, String description,
			int lft, int rht, int lvl) {
		super();
		this.idMenu = idMenu;
		this.name = name;
		this.label = label;
		this.description = description;
		this.lft = lft;
		this.rht = rht;
		this.lvl = lvl;
	}

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

	public int getLft() {
		return lft;
	}

	public void setLft(int lft) {
		this.lft = lft;
	}

	public int getRht() {
		return rht;
	}

	public void setRht(int rht) {
		this.rht = rht;
	}

	public int getLvl() {
		return lvl;
	}

	public void setLvl(int lvl) {
		this.lvl = lvl;
	}

	@Override
	public String toString() {
		return "MenuDTO [idMenu=" + idMenu + ", name=" + name + ", label="
				+ label + ", description=" + description + ", lft=" + lft
				+ ", rht=" + rht + ", lvl=" + lvl + "]";
	}
	
	

}
