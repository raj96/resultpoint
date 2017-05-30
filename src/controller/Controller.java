package controller;

import java.io.IOException;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.MD5;
import dao.RegisterDao;
import dao.SigninDao;
import dao.SubmitDao;
import logic.ChangePassword;
import logic.FileUploader;
import logic.RegisterUser;
import logic.SignIn;
import logic.SubmitInfo;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/controller.Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final int 	REGISTER 					= 1,
    					SIGNIN 						= 2,
    					SUBMIT						= 3,
    					ADMINREGISTER				= 4,
    					ADMINLOGIN					= 5,
    					LOGOUT						= 6,
    					UPLOAD_CATEGORY_SET			= 7,
    					UPLOAD						= 8,
    					CHANGE_PASSWORD				= 9;
    
    private final int 	USER_OK		 		= 1,
						FORM2_NOT_FILLED 	= 2,
						CRED_ERROR 			= 3,
						USER_DOES_NOT_EXIST = 4,
						UNKNOWN_ERROR		= 5;
     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("In DoGet");
		try {
			final int actionid = Integer.parseInt(request.getParameter("actionid"));
			switch(actionid){
				case UPLOAD_CATEGORY_SET: {
					try {
						String uploadid = ((String) request.getParameter("uploadid"));
						System.out.println(uploadid);
						request.getSession().setAttribute("uid", uploadid);
						System.out.println("In UCS");
						request.getRequestDispatcher("dashboard.jsp").include(request, response);
					}
					catch(Exception e) {
						request.setAttribute("errormsg", "Invalid Action");
						request.getRequestDispatcher("error.jsp").forward(request, response);
					}
					break;
				}
				case LOGOUT: {
					try {
						request.getSession().removeAttribute("email");
						request.getSession().removeAttribute("name");
						response.sendRedirect(request.getContextPath());
					}
					catch(Exception e) {
						request.setAttribute("errormsg","Not for external use");
						request.getRequestDispatcher("error.jsp").forward(request, response);
					}
					break;
				}
				default:
					throw new Exception();
			}
		}
		catch(Exception e){
			response.getWriter().append("Unauthorized Accesss on "+LocalDateTime.now().getMonthValue()+" "+LocalDateTime.now().getYear());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		final String actionid = request.getParameter("actionid");
		if(actionid==null || actionid.isEmpty()){
			response.getWriter().append("Unauthorized Accesss on "+LocalDateTime.now());
			return;
		}
		final int aid = Integer.parseInt(actionid);
		
		switch(aid) {
			case REGISTER: {
				RegisterDao rd = new RegisterDao();
				rd.setName(request.getParameter("name"));
				rd.setEmail(request.getParameter("email"));
				rd.setPasssword(dao.MD5.md5(request.getParameter("password")));
				rd.setGender(request.getParameter("gender"));
				rd.setBday(request.getParameter("birth_date"));
				rd.setCollege_name(request.getParameter("college_name"));
				rd.setCollege_name(request.getParameter("degree_name"));
				rd.setDept_name(request.getParameter("dept_name"));
				rd.setSem(request.getParameter("semester"));
				rd.setRoll_no(request.getParameter("rollno"));
				System.out.println("RD set");
				RegisterUser ru = new RegisterUser(rd);
				System.out.println("RU created");
				if(ru.register()){
					System.out.println("5tg");
					request.getSession().setAttribute("name", rd.getName());
					System.out.println("Got Name");
					request.getSession().setAttribute("email", rd.getEmail());
					System.out.println("Got Mail");
					System.out.println("Before Request Dispatcher");
					request.getRequestDispatcher("index2.jsp").forward(request, response);
					System.out.println("After RD");
				}
				else{
					response.setContentType("text/html");
					request.setAttribute("errormsg", "You are already registered");
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
				break;
			}
			
			case SUBMIT: {
				SubmitDao sd = new SubmitDao();
				
				sd.setEmail(request.getParameter("email"));
				sd.setFathers_name(request.getParameter("fathers_name"));
				sd.setMothers_name(request.getParameter("mothers_name"));
				sd.setFathers_occ(request.getParameter("fathers_occ"));
				sd.setMothers_occ(request.getParameter("mothers_occ"));
				sd.setCurr_addr(request.getParameter("curr_addr"));
				sd.setPerm_addr(request.getParameter("perm_addr"));
				sd.setMobile_no(request.getParameter("mobile_no"));
				sd.setGuardians_name(request.getParameter("guardians_name"));
				sd.setPmobile_no(request.getParameter("pmobile_no"));
				sd.setEmail(request.getParameter("email"));
				System.out.println("Email: "+request.getParameter("email"));
				SubmitInfo si = new SubmitInfo(sd);
				
				if(si.submit()){
					response.setContentType("text/html");
					request.getSession().setAttribute("email", request.getParameter("email"));
					request.getSession().setAttribute("name", request.getParameter("name"));
					request.getRequestDispatcher("dashboard.jsp").forward(request, response);
				}
				else {
					response.setContentType("text/html");
					request.setAttribute("errormsg", "Invalid Access");
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
				break;
			}
			case SIGNIN: {
				SigninDao sd = new SigninDao();
				sd.setEmail(request.getParameter("email"));
				sd.setPassword(MD5.md5(request.getParameter("password")));
			
				SignIn si = new SignIn(sd);
				int result = si.checkSignIn();
				
				switch(result) {
					case USER_OK: {
						
						request.getSession().setAttribute("email", sd.getEmail());
						request.getSession().setAttribute("name", sd.getName());
						
						request.getRequestDispatcher("dashboard.jsp").forward(request, response);
						break;
					}
					case FORM2_NOT_FILLED: {
						request.getSession().setAttribute("email", sd.getEmail());
						request.getSession().setAttribute("name", sd.getName());
						System.out.println("Email: "+sd.getEmail()+"\tName: "+sd.getName());
						
						request.getRequestDispatcher("index2.jsp").forward(request, response);
						break;
					}
					case CRED_ERROR: {
						request.getSession().setAttribute("email", sd.getEmail());
						request.setAttribute("errormsg", "Password/Email mismatch: Please <a href="+request.getContextPath()+">Login</a> Again");
						request.getRequestDispatcher("error.jsp").forward(request, response);
						break;
					}
					case USER_DOES_NOT_EXIST: {
						request.setAttribute("errormsg", "Account does not exist");
						request.getRequestDispatcher("error.jsp").forward(request, response);
						break;
					}
					case UNKNOWN_ERROR: {
						request.setAttribute("errormsg", "Unknown Error Occurred");
						request.getRequestDispatcher("error.jsp").forward(request, response);
						break;
					}
				}
				break;
			}
			case LOGOUT: {
				try {
					request.getSession().removeAttribute("email");
					request.getSession().removeAttribute("name");
					response.sendRedirect(request.getContextPath());
				}
				catch(Exception e) {
					request.setAttribute("errormsg","Not for external use");
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
				break;
			}
			
			case UPLOAD: {
				try {
					String uid = (String)request.getSession().getAttribute("uid");
					System.out.println("UID: "+uid);
					System.out.println(request.getContentType());
					FileUploader fu = new FileUploader(request,request.getSession().getAttribute("email").toString(),uid);
					if(!fu.save())
						throw new Exception("Cannot Upload");
					else{
						request.setAttribute("successmsg", "File uploaded successfully<br/><a href="+request.getContextPath()+">Go Back</a>");
						request.getRequestDispatcher("success.jsp").forward(request, response);
					}
				}
				catch(Exception e) {
					e.printStackTrace();
					request.setAttribute("errormsg", "Could not upload.Please try again uploading from your <a href="+request.getContextPath()+">Dashboard</a>");
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
				break;
			}
			
			case CHANGE_PASSWORD: {
				try {
					String email = request.getSession().getAttribute("email").toString();
					String pass = MD5.md5(request.getParameter("old_password"));
					String npass = MD5.md5(request.getParameter("npassword"));
					
					ChangePassword cp = new ChangePassword(pass,npass,email);
					
					if(cp.change()){
						request.setAttribute("successmsg", "Password Successfully Changed.<a href="+request.getContextPath()+">Go Back</a>");
						request.getRequestDispatcher("success.jsp").forward(request, response);
					}
					else
						throw new Exception();
					
				}
				catch(Exception e) {
					request.setAttribute("errormsg", "Couldn't Change Password.Go to your <a href="+request.getContextPath()+">Account</a>");
					request.getRequestDispatcher("error.jsp").forward(request, response);
				}
				break;
			}
			
		}
	}

}
