package pe.libertadores.alojamiento.seguridad.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage(value = "alojamiento")
public class InitAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Action(value = "/home", results = { @Result(location="home" ,name = "success", type = "tiles") })
	public String initHome(){
		
		return SUCCESS;
	}

}
