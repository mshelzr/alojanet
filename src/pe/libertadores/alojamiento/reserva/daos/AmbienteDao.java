package pe.libertadores.alojamiento.reserva.daos;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import pe.libertadores.dto.AmbienteDTO;

public class AmbienteDao {

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

	@SuppressWarnings("unchecked")
	public List<AmbienteDTO> listFullAmbs(){
		SqlSession session = sqlMapper.openSession();
		List<AmbienteDTO> ambs = new ArrayList<AmbienteDTO>();
		try {
			ambs =(List<AmbienteDTO>) session.selectList("q_listarAmbientes");
		} catch (Exception e) {

		}
		finally{
			session.close();
		}
		return ambs;
	}
	
	@SuppressWarnings("unchecked")
	public List<AmbienteDTO> listaCodigoAmbs(){
		SqlSession session = sqlMapper.openSession();
		List<AmbienteDTO> ambs = new ArrayList<AmbienteDTO>();
		try {
			ambs =(List<AmbienteDTO>) session.selectList("q_listaAmbienteCodigo");
		} catch (Exception e) {

		}
		finally{
			session.close();
		}
		return ambs;
	}
	public int updateAmbientes(AmbienteDTO amb){
		SqlSession session = sqlMapper.openSession();
		int salida = -1;
		try {
			salida = session.update("q_updateAmbiente", amb);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			session.close();
		}
		return salida;
	}
	
	public int registraAmbiente(AmbienteDTO amb){
		SqlSession session = sqlMapper.openSession();
		int salida = -1;
		try {
			salida = session.insert("q_registraAmbiente", amb);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			session.close();
		}
		return salida;
	}
	//eliminaVendedor
	public int eliminaVendedor(int idAmbiente){
		SqlSession session = sqlMapper.openSession();
		int salida = -1;
		try {
			salida = session.delete("q_deleteAmbiente", idAmbiente);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			session.close();
		}
		return salida;
	}

}
