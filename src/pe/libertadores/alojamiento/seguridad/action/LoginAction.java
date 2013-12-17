package pe.libertadores.alojamiento.seguridad.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.dto.MenuDTO;
import pe.libertadores.alojamiento.dto.UsuarioDTO;
import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage(value = "alojamiento")
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String user;
	private String pwd;
	private String mensaje;

	private UsuarioDao usuarioDao=new UsuarioDao();

	@Action(value = "/dialogLogueo", results = { @Result(name = "success", type = "json") })
	public String validarUsuario(){
		HttpServletRequest request = ServletActionContext.getRequest();

		String username=request.getParameter("username");
		String password=request.getParameter("password");

		UsuarioDTO usuarioDTO=new UsuarioDTO();
		usuarioDTO.setUser(username);
		usuarioDTO=usuarioDao.validarUsuario(usuarioDTO);
		Map<String,Object> resultMap=new HashMap<String,Object>();
		if(usuarioDTO!=null){
			if(usuarioDTO.getPwd().equals(password)){
				Map<String, Object> sesion=ActionContext.getContext().getSession();
				List<MenuDTO> menuEmbebed=usuarioDao.listarMenuByIdPerfil(usuarioDTO.getIdPerfil());
				List<MenuDTO> menuPadre = new ArrayList<MenuDTO>();
				List<MenuDTO> menuHijo = new ArrayList<MenuDTO>();
				for (MenuDTO m : menuEmbebed) {
					if(m.getLvl()==1)
						menuPadre.add(m);
					else if(m.getLvl()>1)
						menuHijo.add(m);
				}
				System.out.println(55);
				sesion.put("s_usuario", usuarioDTO);
				System.out.println(66);
				sesion.put("s_menuPadre", menuPadre);
				System.out.println(77);
				sesion.put("s_menuHijo", menuHijo);
				String url=request.getHeader("Referer");		    	
				int desde=url.lastIndexOf("/");
				//detectamos si la cabecera tiene datos GET
				int hasta=url.indexOf("?");
				int notLogout=url.indexOf("logout.action");
				if(notLogout==-1){
					if(hasta!=-1){
						url=url.substring(desde+1, hasta);
					}else{
						url=url.substring(desde+1, url.length());			
					}
				}else{
					url="home.action";
				}

				System.out.println("url: " + url);
				resultMap.put("urlRedirect", url);
				resultMap.put("success", "success");

			}else{
				resultMap.put("errorpwd","wrongpwd");
			}
		}else{
			resultMap.put("erroruser","wronguser");
		}
		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMensaje(js.toString());
		return SUCCESS;
	}

	@Action(value="logout",results={@Result(location="home",name="success",type="tiles")})
	public String cerrarSesion(){
		Map<String,Object> sesion=ActionContext.getContext().getSession();
		sesion.remove("s_usuario");
		sesion.remove("s_menu");
		return SUCCESS;
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

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}


}