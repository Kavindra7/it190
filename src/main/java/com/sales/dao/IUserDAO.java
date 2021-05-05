
package com.sales.dao;

import com.sales.models.SystemUser;
import java.util.ArrayList;


public interface IUserDAO {
    SystemUser GetUserById(int Id);   
    ArrayList<SystemUser> GetUsersUnderBranch();
    boolean UpdateUserDetails(SystemUser systemUser);
    int CreateUserDetails(SystemUser systemUser);
    boolean DeleteUserDetails(int userId);
}
