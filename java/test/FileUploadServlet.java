package test;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

@WebServlet("/FileUploadServlet")
@MultipartConfig(
        location = "/temp",
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 5,    // 5 MB
        maxRequestSize = 1024 * 1024 * 5 * 5  // 25 MB
)
public class FileUploadServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
        	request.setCharacterEncoding("UTF-8");
            Part filePart = request.getPart("carImage");
            InputStream fileContent = filePart.getInputStream();

            int carId = Integer.parseInt(request.getParameter("carId"));
            String carName= (String)request.getParameter("carName");
            String carBrand= (String)request.getParameter("carBrand");
            String carType= (String)request.getParameter("carType");
            String carFuel= (String)request.getParameter("carFuel");
            String carPrice= (String)request.getParameter("carPrice");
            String carLink= (String)request.getParameter("carLink");
            // 파일 내용을 byte 배열로 읽어오기
            byte[] fileBytes = new byte[(int) filePart.getSize()];
            fileContent.read(fileBytes);

            // 여기에서 데이터베이스에 저장 또는 다른 작업 수행
            CarDAO carDAO = new CarDAO();
            carDAO.insertCar(carId,carName,carBrand,carType,carFuel,carPrice,carLink, fileBytes);

            // 결과를 request에 저장
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('파일이 성공적으로 업로드되었습니다.');");
            out.println("window.location.href = 'main.jsp';");
            out.println("</script>");
        } catch (Exception e) {
            // 오류 처리
            e.printStackTrace();

            // 파일 업로드 중 오류가 발생한 경우, 결과를 alert 창으로 띄우고 다시 파일 업로드 페이지로 이동
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('파일 업로드 중 오류가 발생했습니다.');");
            out.println("window.location.href = 'main.jsp';");
            out.println("</script>");
        }
    }
}
