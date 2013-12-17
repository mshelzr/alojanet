package pe.libertadores.alojamiento.seguridad.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import pe.libertadores.alojamiento.dto.MenuDTO;
import pe.libertadores.alojamiento.dto.UsuarioDTO;

public class UsuarioDao {

	SqlSessionFactory sqlMapper = null;
	{
		String archivo = "pe/libertadores/alojamiento/utils/connection/mybatis/ConfiguracionIbatis.xml";
		try {
			Reader reader = Resources.getResourceAsReader(archivo);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public UsuarioDTO validarUsuario(UsuarioDTO usuario){
		SqlSession session = sqlMapper.openSession();
		UsuarioDTO usuarioDto=new UsuarioDTO();
		try {
			usuarioDto =(UsuarioDTO) session.selectOne("q_validarUsuario", usuario);
			return usuarioDto;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<MenuDTO> listarMenuByIdPerfil(int idPerfil){
		SqlSession session = sqlMapper.openSession();
		List<MenuDTO> listaMenuDTO=new ArrayList<MenuDTO>();
		try {
			listaMenuDTO = session.selectList("q_menu", idPerfil);
			return listaMenuDTO;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
		
	}
}
