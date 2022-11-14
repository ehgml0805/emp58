<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%
/*
map 타입 이해:  map 안하면 class를 아래처럼 매번 사용(만들어야) 해야함
	Class student{
	public String name;
	public Int age;
}
	Student s new Student();
	s.name="김도희";
	s.age=29;
	System.out.print(s.name);
	System.out.print(s.age);
	
배열 집합이면?
	Student s1=new Student();
	s1.name="김민송";
	s1.age=26;
	Student s2=new Student();
	s2.name="김설";
	s2.age=29;
	ArrayList<Student> student =new ArrayList<Student>();
	studentList.add(1);
	studentList.add(2);
	System.out.print("StudentList 출력");
	for(Student st: studentList){
		System.out.println(st.name);
		System.out.println(st.age);
	}
*/

HashMap<String, Object> m = new HashMap<String, Object>();//오브젝트 타입으로 넣으면
m.put("name", "김도희");// 원래는 형변환 해야댐
m.put("age", "29");
System.out.println(m.get("name"));
System.out.println(m.get("age"));

//배열 집합이면?
HashMap<String, Object> m1 = new HashMap<String, Object>();
m1.put("name", "김민송");
m1.put("age", "26");
HashMap<String, Object> m2 = new HashMap<String, Object>();//
m2.put("name", "김설");
m2.put("age", "29");	
ArrayList<HashMap<String,Object>> mapList=new ArrayList<HashMap<String,Object>>();
mapList.add(m1);
mapList.add(m2);
System.out.println("mapList 출력");
for(HashMap<String, Object> hm: mapList){
System.out.println(hm.get("name"));
System.out.println(hm.get("age"));
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>