
package com.sales.service;

import com.sales.models.SystemUser;
import java.util.ArrayList;


public interface IUserLogic {
    
     SystemUser getUserById(int Id);
    SystemUser getUserByEmailPassword(String Email, String Password);
    ArrayList<SystemUser> GetAllUsersUnderBranch();
    boolean RemoveUserFromSystem(int UserId);
    boolean RegisterUserinSystem(SystemUser systemUser);
    boolean UpdateUserinSystem(SystemUser systemUser);
}
