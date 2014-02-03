package pe.libertadores.alojamiento.reserva.actions;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pe.libertadores.alojamiento.seguridad.dao.UsuarioDao;
import pe.libertadores.dto.MenuDTO;
import pe.libertadores.dto.UsuarioDTO;

import com.google.gson.Gson;

public class MyUtil {


	public static boolean esUsuario(String user, String pwd){
		
		UsuarioDao usuarioDao=new UsuarioDao();
		
		UsuarioDTO usu=new UsuarioDTO();
		usu.setUser(user);
		usu.setPwd(pwd);
		usu=usuarioDao.validarUsuario(usu);
		if(usu!=null){
			if(usu.getPwd().equals(pwd)){
				return true;
			}
		}
		return false;
	}

	public static void iniciarSesion(HttpServletResponse response, String user){
		response.setContentType("text/html");
		
		UsuarioDao usuarioDao=new UsuarioDao();
		
		UsuarioDTO usu=new UsuarioDTO();
		usu.setUser(user);
		usu=usuarioDao.validarUsuario(usu);
		
		List<MenuDTO> menuEmbebed=usuarioDao.listarMenuByIdPerfil(usu.getPerfilDTO().getIdPerfil());
		List<MenuDTO> menuPadre = new ArrayList<MenuDTO>();
		List<MenuDTO> menuHijo = new ArrayList<MenuDTO>();
		for (MenuDTO m : menuEmbebed) {
			if(m.getLvl()==1)
				menuPadre.add(m);
			else if(m.getLvl()>1)
				menuHijo.add(m);
		}
		Gson gs=new Gson();
		String jsMenuPadre=gs.toJson(menuPadre);
		String jsMenuHijo=gs.toJson(menuHijo);
		//cookies
		Cookie idUsuario=new Cookie("idUsuario", Integer.toString(usu.getIdUsuario()));
		Cookie idPerfil=new Cookie("idPerfil",Integer.toString(usu.getPerfilDTO().getIdPerfil()));
		Cookie coUsuario=new Cookie("jsNombreCompleto",usu.getPersonaDTO().getNombres().concat(", " + usu.getPersonaDTO().getApePaterno()));
		Cookie menuPadreC=new Cookie("menuPadre",jsMenuPadre);
		Cookie menuHijoC=new Cookie("menuHijo",jsMenuHijo);

		idUsuario.setMaxAge(60*60);
		idPerfil.setMaxAge(60*60);
		coUsuario.setMaxAge(60*60);
		menuPadreC.setMaxAge(60*60);
		menuHijoC.setMaxAge(60*60);

		response.addCookie(idUsuario);
		response.addCookie(idPerfil);
		response.addCookie(coUsuario);
		response.addCookie(menuPadreC);
		response.addCookie(menuHijoC);
	}
	
	public static String getValueCookie(HttpServletRequest request, String name){
		Cookie[] cooks=request.getCookies();		

		String val="";
		for (Cookie c : cooks) {
			if(c.getName().equals(name)){
				val=c.getValue();		
			}
		}
		
		return val;
	}

}
