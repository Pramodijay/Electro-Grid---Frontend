package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import db_connection.DB;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class Notice_Model {

	private String res;
	
	public String getRes() {
		return res;
	}

	public void setRes(String res) {
		this.res = res;
	}

	public String getNotice() {
		PreparedStatement ps;
		String data="";
		
		try {
			
			Connection conn = DB.getConn();
			ps = conn.prepareStatement("SELECT * FROM notice");
			
			ResultSet res_Set = ps.executeQuery();
			
			data = "<table>"
		            +"<tr>"
		            +"<th style='border-style: dotted;'>ID</th>"
	                +"<th style='border-style: dotted;'>Account ID</th>"
	                +"<th style='border-style: dotted;'>Bill ID</th>"
	                +"<th style='border-style: dotted;'>Bill Payment Amount</th>"
	                +"<th style='border-style: dotted;'>Customer Name</th>"
	                +"<th style='border-style: dotted;'>Payment Method</th>"
	                +"<th style='border-style: dotted;'>Description</th>"
	                +"<th style='border-style: dotted;'>Date</th>"
	                +"<th style='border-style: dotted;'>NIC</th>"
	                +"<th style='border-style: dotted;'>Type</th>"
	                +"<th style='border-style: dotted;'>Edit/Delete</th>"
	                +"</tr>";
			
			while (res_Set.next()) {
				
				    String button = "<button onclick='edit("+res_Set.getString(1)+")' >Edit</button><button onclick='deletes("+res_Set.getString(1)+")'>Delete</button>";
				
				
				data = data+"<tr><td style='border-style: dotted;'>"+res_Set.getString(1)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(2)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(3)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(4)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(5)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(6)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(7)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(8)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(9)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(10)+"</td>"
						+ "<td style='border-style: dotted;'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			ps.close();
			conn.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return data+"</table>";
	}
	
	public void addNotice(String account_id,String b_id,double b_amount,String c_name,String p_method,String description,String date,String c_nic,String type) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("insert into notice (account_id,b_id,b_amount,c_name,p_method,description,date,c_nic,type) values (?,?,?,?,?,?,?,?,?)");
			ps.setString(1, account_id);
			ps.setString(2, b_id);
			ps.setDouble(3, b_amount);
			ps.setString(4, c_name);
			ps.setString(5, p_method);
			ps.setString(6, description);
			ps.setString(7, date);
			ps.setString(8, c_nic);
			ps.setString(9, type);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void editNotice(int id,String account_id,String b_id,double b_amount,String c_name,String p_method,String description,String date,String c_nic,String type) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
				ps = conn.prepareStatement("UPDATE notice SET account_id=?,b_id=?,b_amount=?,c_name=?,p_method=?,description=?,date=?,c_nic=?,type=? where id=?");
				ps.setString(1, account_id);
				ps.setString(2, b_id);
				ps.setDouble(3, b_amount);
				ps.setString(4, c_name);
				ps.setString(5, p_method);
				ps.setString(6, description);
				ps.setString(7, date);
				ps.setString(8, c_nic);
				ps.setString(9, type);
				ps.setInt(10,id);
				ps.execute();
				ps.close();
				conn.close();
				setRes("Done");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void deleteNotice(int id) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("DELETE FROM notice WHERE id=?");
			ps.setInt(1, id);
			ps.execute();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}
	public JSONObject getOneUsers(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		JSONObject json = new JSONObject();
		
		try {
			connection = DB.getConn();
			
			preparedStatement = connection.prepareStatement("SELECT * FROM notice where id=?");
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next())
			{

				json.put("id", rs.getInt(1)); 
				json.put("account_id", rs.getString(2));
				json.put("b_id", rs.getString(3));
				json.put("b_amount", rs.getString(4));
				json.put("c_name", rs.getString(5));
				json.put("p_method", rs.getString(6));
				json.put("description", rs.getString(7));
				json.put("date", rs.getString(8));
				json.put("c_nic", rs.getString(9));
				json.put("type", rs.getString(10));
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
		return json;
	}	


}



