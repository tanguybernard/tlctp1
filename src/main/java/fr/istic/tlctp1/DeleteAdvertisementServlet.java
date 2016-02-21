package fr.istic.tlctp1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class DeleteAdvertisementServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		ObjectifyService.ofy().delete().type(Advertisement.class).id(Long.parseLong(req.getParameter("ide")));
        resp.sendRedirect("/index.jsp");
	}
}
