package ojt.project.service;


import ojt.project.dao.UserDAO;
import ojt.project.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDAO userDAO;

    final int FAIL = 0;


    @Override
    public int insertUser(User user) {
        try {
            if (userDAO.selectUser(user.getId()) != null) {
                return FAIL;
            }
            userDAO.insertUser(user);
        } catch (Exception e) {
            e.printStackTrace();
            return FAIL;
        }
        return 1;
    }

    @Override
    public User selectUser(String id) {
        try {
            User user = userDAO.selectUser(id);
            return user;
        } catch (Exception e) {
            return null;

        }
    }


}



