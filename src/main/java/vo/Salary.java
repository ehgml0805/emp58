package vo;

public class Salary {
	//public int empNo;
	public Employee emp;
	//이렇게 하면 조인인것도 아닌것도 가능 단점은? 셀러리 테이블만 건들고 싶어도 임플로이즈도 만들어야 해
	public int salary;
	public String fromDate;
	public String toDate;

	/*
	public static void main(String [] args) {
		Salary s=new Salary();
		s.emp=new Employee();// 이거 안쓰면 안됨
		s.emp.empNo=1;
	
	}
	*/

}

