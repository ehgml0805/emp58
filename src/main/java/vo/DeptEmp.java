package vo;

public class DeptEmp {
	//테이블 칼럼과 일치하는 도메인 타입
	//단점: JOIN 결과를 처리할 수 없음.
	/*
	public int empNo;
	public int deptNo;
	public String fromDate;
	public String toDate;
	*/
	//장점: dept_emp 테이블의 행 뿐만 아니라 JOIN 결과의 행도 처리 가능
	//단점: 복잡
	public Employee emp;
	public Department dept;
	public String fromDate;
	public String toDate;
 }

	