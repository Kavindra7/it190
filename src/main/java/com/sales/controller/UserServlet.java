
package com.sales.controller;

import com.google.gson.Gson;
import com.sales.service.IUserLogic;
import com.sales.service.UserLogic;
import com.sales.models.SystemUser;
import com.sales.utils.CUD_Response;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IUserLogic userLogic = new UserLogic();       
        request.setAttribute("systemUsers", userLogic.GetAllUsersUnderBranch());
        request.getRequestDispatcher("/WEB-INF/views/User.jsp").forward(request, response);
        //request.getRequestDispatcher("/WEB-INF/views/branchList.jsp").forward(request, response);
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String id =request.getParameter("id");
        String username = request.getParameter("username");
        String branch =request.getParameter("branch");
        String address = request.getParameter("address");
        String userType =request.getParameter("type");
        String nic = request.getParameter("nic");
        String email =request.getParameter("email");
        String phone = request.getParameter("contact");
        String password = request.getParameter("password"); 
        String salt = request.getParameter("salt");
        if(action.equals("CreateUser"))
        {
            IUserLogic userLogic = new UserLogic();
            SystemUser systemUser = new SystemUser(0,username,email,userType);
            CUD_Response CUDresponse = new CUD_Response (userLogic.RegisterUserinSystem(systemUser));
            
            response.setContentType("application/json");
            // Get the printwriter object from response to write the required json object to the output stream      
            PrintWriter out = response.getWriter();
            // Assuming your json object is **jsonObject**, perform the following, it will return your json object  
            out.print(new Gson().toJson(CUDresponse));
            out.flush();
        }
        if(action.equals("EditUser"))
        {
            IUserLogic userLogic = new UserLogic();
            SystemUser systemUser = new SystemUser(Integer.parseInt(id),username,email,userType);
            CUD_Response CUDresponse = new CUD_Response (userLogic.UpdateUserinSystem(systemUser));
            
            response.setContentType("application/json");
            // Get the printwriter object from response to write the required json object to the output stream      
            PrintWriter out = response.getWriter();
            // Assuming your json object is **jsonObject**, perform the following, it will return your json object  
            out.print(new Gson().toJson(CUDresponse));
            out.flush();
        }
        if(action.equals("DeleteUser"))
        {
            IUserLogic userLogic = new UserLogic();
            //SystemUser systemUser = new SystemUser(Integer.parseInt(id),username,email,password,Integer.parseInt(branch),phone,"",userType);
            CUD_Response CUDresponse = new CUD_Response (userLogic.RemoveUserFromSystem(Integer.parseInt(id)));
            
            response.setContentType("application/json");
            // Get the printwriter object from response to write the required json object to the output stream      
            PrintWriter out = response.getWriter();
            // Assuming your json object is **jsonObject**, perform the following, it will return your json object  
            out.print(new Gson().toJson(CUDresponse));
            out.flush();
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
