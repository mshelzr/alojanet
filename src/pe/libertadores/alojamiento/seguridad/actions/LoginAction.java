package pe.libertadores.alojamiento.seguridad.actions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import pe.libertadores.alojamiento.reserva.actions.MyUtil;
import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;
import pe.libertadores.dto.MenuDTO;
import pe.libertadores.dto.PersonaDTO;
import pe.libertadores.dto.UsuarioDTO;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

@ParentPackage(value = "alojamiento")
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String mensaje;
	
	//registro
	private String nombres;
	private String apePaterno;
	private String apeMaterno;
	private String numDocumento;
	private String direccion;
	private int telf;
	private String email;

	private UsuarioDao usuarioDao=new UsuarioDao();
	
	@Action(value = "dialogLogueo", results = { @Result(name = "success", type = "json") })
	public String dialogLogueo(){
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response= ServletActionContext.getResponse();
		response.setContentType("text/html");
		
		String username=request.getParameter("user");
		String password=request.getParameter("pwd");

		UsuarioDTO usuarioDTO=new UsuarioDTO();
		usuarioDTO.setUser(username);
		usuarioDTO=usuarioDao.validarUsuario(usuarioDTO);
		
		Map<String,Object> resultMap=new HashMap<String,Object>();
		
		if(usuarioDTO!=null){
			if(usuarioDTO.getPwd().equals(password)){
				MyUtil.iniciarSesion(response, usuarioDTO.getUser());
				
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

	@Action(value="logout",results={@Result(location="layoutPortal",name="success",type="tiles")})
	public String cerrarSesion(){
		HttpServletRequest req = ServletActionContext.getRequest();		
		HttpServletResponse resp = ServletActionContext.getResponse();
		
		Cookie idUsuario=new Cookie("idUsuario", "");
		Cookie idPerfil=new Cookie("idPerfil", "");
		
		resp.addCookie(idUsuario);
		resp.addCookie(idPerfil);
		Cookie[] cooks=req.getCookies();
		
		for (Cookie c : cooks) {
			c.setValue("");
			c.setMaxAge(0);
			resp.addCookie(c);
		}
		
		//replaced session by a cookie
//		Map<String,Object> sesion=ActionContext.getContext().getSession();
//		sesion.remove("s_usuario");
//		sesion.remove("s_menu");
		return SUCCESS;
	}

	@Action(value="registro",results={@Result(name="success",type="json")})
	public String registro(){
		
		System.out.println(nombres);
		System.out.println(apePaterno);
		System.out.println(apeMaterno);
		System.out.println(numDocumento);
		System.out.println(direccion);
		System.out.println(telf);
		System.out.println(email);		
				
		PersonaDTO p=new PersonaDTO();
		p.setNombres(nombres);
		p.setApePaterno(apePaterno);
		p.setApeMaterno(apeMaterno);
		p.setNumDocumento(numDocumento);
		p.setTelf(telf);
		p.setEmail(email);		
		
		usuarioDao.registroPersonaUsuarioClienteWithPersona(p);
		//cookies
		HttpServletResponse response=ServletActionContext.getResponse();
//		MyUtil.validarUsuarioUtil(response, user, pwd);
		
		Map<String,Object> resultMap=new HashMap<String,Object>();
		resultMap.put("result", "success");
		JSONObject js=JSONObject.fromObject(resultMap);
		this.setMensaje(js.toString());
		
		
		return SUCCESS;
	}	
	
	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public void setApePaterno(String apePaterno) {
		this.apePaterno = apePaterno;
	}

	public void setApeMaterno(String apeMaterno) {
		this.apeMaterno = apeMaterno;
	}

	public void setNumDocumento(String numDocumento) {
		this.numDocumento = numDocumento;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public void setTelf(int telf) {
		this.telf = telf;
	}

	public void setEmail(String email) {
		this.email = email;
	}


}