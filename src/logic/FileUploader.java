package logic;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUploader {
	HttpServletRequest request;
	String savePath,userPath,typePath,caption;
	public FileUploader(HttpServletRequest r,String user_path,String type_path) {
		this.request = r;
		this.userPath = user_path;
		this.typePath = type_path;
		this.caption = "";
		savePath = request.getServletContext().getInitParameter("uploadDirectory");
		savePath = savePath+userPath+File.separator+typePath;
		System.out.println(savePath);
	}
	
	public boolean updateDb(String name){
		Connection con = OracleConnection.getConnection();
		String link = userPath + File.separator +typePath+ File.separator + name;
		
		String query = "INSERT INTO RESULT_INFO VALUES(?,?,?,?,id_seq.nextval)";
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, (String) request.getSession().getAttribute("email"));
			ps.setString(2, typePath);
			ps.setString(3, link);
			ps.setString(4, caption);
			if(ps.executeUpdate()>0)
				return true;
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return false;
	}
	
	public boolean save() {
		System.out.println("Inside Save");
		if(ServletFileUpload.isMultipartContent(request)){
			try {
				System.out.println("Inside Try");
				List<FileItem> multiparts = new ServletFileUpload(
						new DiskFileItemFactory()).parseRequest(request);
				System.out.println(multiparts.isEmpty());
				
				for(FileItem item: multiparts){
					if(item.isFormField()){
						caption = item.getString();	
						System.out.println(caption);
					}
				}
				
				for(FileItem item : multiparts){
					if(!item.isFormField()){
						String name = new File(item.getName()).getName();
						if(!updateDb(name))
							return false;
						File saveFolder = new File(savePath+ File.separator);
						File saveFile = new File(savePath+ File.separator + name);
						if(!saveFolder.exists())
							saveFolder.mkdirs();
						System.out.println("name "+name);
						if(saveFolder.exists())
							item.write(saveFile);
						else
							throw new Exception("Cannot Create Directory");
					}
				}
				System.out.println("Upload Done");
				//File uploaded successfully
				return true;
			} 
			catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		System.out.println("Not Multipart");
		return false;
	}
	
}