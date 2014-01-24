package pe.libertadores.alojamiento.seguridad.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import pe.libertadores.dto.AcompananteReservaDTO;
import pe.libertadores.dto.ClienteDTO;
import pe.libertadores.dto.DetalleReservaDTO;
import pe.libertadores.dto.MenuDTO;
import pe.libertadores.dto.PersonaDTO;
import pe.libertadores.dto.PersonaTarjetaDTO;
import pe.libertadores.dto.ReservaDTO;
import pe.libertadores.dto.UsuarioDTO;

public class UsuarioDao {

	SqlSessionFactory sqlMapper = null;
	{
		String archivo = "mybatis/ConfiguracionIbatis.xml";
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

	public ClienteDTO registroPersonaUsuarioClienteWithPersona(PersonaDTO persona){
		SqlSession session = sqlMapper.openSession();

		try {
			session.insert("dml_registroPersona",persona);
			UsuarioDTO us=new UsuarioDTO();
			us.setPersonaDTO(persona);
			String giveUser=persona.getNombres().substring(0,1).concat(persona.getApePaterno()).toLowerCase();
			us.setUser(giveUser);
			us.setPwd(giveUser);
			session.insert("dml_registroUsuario",us);
			ClienteDTO cli=new ClienteDTO();
			cli.setPersonaDTO(persona);
			cli.setEstado(0);
			session.insert("dml_registroCliente",cli);
			session.commit();

			return cli;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return new ClienteDTO();
	}

	public void registroReservaDetalleReservaPersonaWithCliente(ReservaDTO r,DetalleReservaDTO dr,List<PersonaDTO> lps){
		SqlSession session = sqlMapper.openSession();

		try {
			if(r.getIdReserva()==0){
				session.insert("dml_registroReserva",r);
			}
			session.insert("dml_registroDetalleReserva",dr);
			for (PersonaDTO personaDTO : lps) {
				session.insert("dml_registroPersona",personaDTO);
				AcompananteReservaDTO acRs=new AcompananteReservaDTO();
				acRs.setIdDetalleReserva(dr.getIdDetalleReserva());
				acRs.setIdPersona(personaDTO.getIdPersona());
				session.insert("dml_registroAcompAndDetalleRes",acRs);
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public void modificarAcomp(List<PersonaDTO> lps){
		SqlSession session = sqlMapper.openSession();

		try {
			for (PersonaDTO personaDTO : lps) {
				session.update("m_modificarPersonaByIdPersona",personaDTO);
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public void registrarAcompByIdDetalleReserva(DetalleReservaDTO dr,List<PersonaDTO> lps){
		SqlSession session = sqlMapper.openSession();

		try {
			for (PersonaDTO personaDTO : lps) {
				session.insert("dml_registroPersona",personaDTO);
				AcompananteReservaDTO acRs=new AcompananteReservaDTO();
				acRs.setIdDetalleReserva(dr.getIdDetalleReserva());
				acRs.setIdPersona(personaDTO.getIdPersona());
				session.insert("dml_registroAcompAndDetalleRes",acRs);
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public void registrarTarjetaPorIdUsuario(ReservaDTO r, PersonaDTO p){
		SqlSession session = sqlMapper.openSession();

		try {
			PersonaTarjetaDTO perTar=new PersonaTarjetaDTO();
			perTar.setPersonaDTO(p);
			perTar.setReservaDTO(r);
			session.insert("dml_registroTarjetaAcomp",perTar);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public void registrarTarjetaAcomp(ReservaDTO r,List<PersonaDTO> lps){
		SqlSession session = sqlMapper.openSession();

		try {
			for (PersonaDTO personaDTO : lps) {
				PersonaTarjetaDTO perTar=new PersonaTarjetaDTO();
				perTar.setPersonaDTO(personaDTO);
				perTar.setReservaDTO(r);
				session.insert("dml_registroTarjetaAcomp",perTar);
			}
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	public void dml_modificarDetalleReservaToCheck(int idDetalleReserva,String estado ){
		SqlSession session = sqlMapper.openSession();
		try {
			Map<String, Object> param=new HashMap<String, Object>();
			param.put("desde", estado);
			param.put("hasta", idDetalleReserva);
			session.selectOne("dml_modificarDetalleReservaToCheck", param);
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	public ClienteDTO getClienteByIdUsuario(String user){
		SqlSession session = sqlMapper.openSession();
		ClienteDTO usuarioDto=new ClienteDTO();
		try {
			usuarioDto =(ClienteDTO) session.selectOne("q_getClienteByIdUsuario", user);
			return usuarioDto;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

}
