package ojt.project.dao;


import ojt.project.dto.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserDAO {
    void insertUser(User user) throws Exception;

    User selectUser(String id) throws Exception;
}
