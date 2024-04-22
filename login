//Login page
package com.bookproject;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Color;
import java.awt.FlowLayout;
import javax.swing.JTextField;
import javax.swing.JPasswordField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.awt.event.ActionEvent;
import java.sql.*;
public class Login extends JFrame implements JDBCConnect {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField txtUserId;
	private JPasswordField txtPassword;
	public static Connection con;
	public Statement smt;
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Login frame = new Login();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		
	}

	/**
	 * Create the frame.
	 */
	public Login() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 667, 515);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblLogin = new JLabel("Login");
		lblLogin.setBounds(269, 52, 83, 37);
		lblLogin.setForeground(Color.RED);
		lblLogin.setFont(new Font("Tahoma", Font.BOLD, 30));
		contentPane.add(lblLogin);
		
		JLabel lblUserId = new JLabel("User ID");
		lblUserId.setFont(new Font("Times New Roman", Font.BOLD, 20));
		lblUserId.setBounds(156, 156, 96, 37);
		contentPane.add(lblUserId);
		
		txtUserId = new JTextField();
		txtUserId.setBounds(266, 158, 267, 26);
		contentPane.add(txtUserId);
		txtUserId.setColumns(10);
		
		JLabel lblPassword = new JLabel("Password");
		lblPassword.setFont(new Font("Times New Roman", Font.BOLD, 20));
		lblPassword.setBounds(156, 223, 96, 37);
		contentPane.add(lblPassword);
		
		txtPassword = new JPasswordField();
		txtPassword.setBounds(266, 231, 267, 26);
		contentPane.add(txtPassword);
		
		JButton btnNewButton = new JButton("Login");
		btnNewButton.addActionListener(new ActionListener() {
			@SuppressWarnings("unlikely-arg-type")
			public void actionPerformed(ActionEvent e) {
				
				String Uname=txtUserId.getText();
				String password=String.valueOf(txtPassword.getText());
				try {
					
					//step1:Register the Driver class
					Class.forName("com.mysql.cj.jdbc.Driver");
					//Step2: Connection creation
					con=DriverManager.getConnection
							("jdbc:mysql://localhost:3306/bookshop",
									"root","Root");
					System.out.println("connection established");
	
					//Step4: Execute queries
				
					PreparedStatement smt=con.prepareStatement("select * from login where username=?");
					
					smt.setString(1,Uname);
					ResultSet rs=smt.executeQuery();
					while(rs.next()) {
						
							System.out.println(rs.getString(2));
							if((Uname.equals(rs.getString(1)))&&(password.equals(rs.getString(2)))){
								Home home=new Home();
								home.setVisible(true);
							}
	    		      }
					//Step5:Close connection
					con.close();

				}catch(Exception e1) {
					System.out.println(e1);
				}
			}
		});
		btnNewButton.setForeground(Color.BLUE);
		btnNewButton.setFont(new Font("Tahoma", Font.BOLD, 25));
		btnNewButton.setBounds(267, 303, 115, 37);
		contentPane.add(btnNewButton);
		
		JButton btnReset = new JButton("Clear");
		btnReset.setForeground(Color.BLUE);
		btnReset.setFont(new Font("Tahoma", Font.BOLD, 25));
		btnReset.setBounds(413, 303, 105, 37);
		contentPane.add(btnReset);
	}
}
