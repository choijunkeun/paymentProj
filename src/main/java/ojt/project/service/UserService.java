package ojt.project.service;


import ojt.project.dto.User;

public interface UserService {
    int insertUser(User user) throws Exception;

    User selectUser(String id) throws Exception;

}
