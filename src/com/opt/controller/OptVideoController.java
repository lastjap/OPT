package com.opt.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.opt.biz.OPTBizImpl;
import com.opt.dto.MemberDto;
import com.opt.dto.VideoClipDto;
import com.opt.dto.VideoComment;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/video.do")
public class OptVideoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println("[ video.do?" + command + " ]");
		OPTBizImpl biz = new OPTBizImpl();
		PrintWriter out = response.getWriter();
		
		if (command.equals("videoList")) {
			HttpSession session = request.getSession();
			String videoarea = request.getParameter("videoarea");			
			int page = Integer.parseInt(request.getParameter("page"));
			MemberDto memberDto = (MemberDto)session.getAttribute("memdto");
			
			if (videoarea.equals("main")) {
				int allCount = biz.selectVideoList().size();
				int listCount = 10;
				int totalPage = (allCount - 1) / listCount + 1;
				int blockCount = 5;
				int absolutePage = 0;
				int endPage = 0;

				if (page < 1) {
					page = 1;
				} else if (page > totalPage) {
					page = totalPage;
				}

				if (page % 5 == 0) {
					absolutePage = ((page / 5) * 5) - 4;
					endPage = (page / 5) * 5;
				} else {
					absolutePage = ((page / 5) * 5) + 1;
					endPage = ((page / 5) * 5) + 5;
				}

				if (endPage > totalPage) {
					endPage = totalPage;
				}

				int start = (page - 1) * listCount + 1;
				int end = page * listCount;
				request.setAttribute("list", biz.videoListPage(start, end));
				request.setAttribute("page", page);
				request.setAttribute("blockCount", blockCount);
				request.setAttribute("totalPage", totalPage);
				request.setAttribute("absolutePage", absolutePage);
				request.setAttribute("endPage", endPage);
				
				dispatch(request, response, "videoboard.jsp");
			} else {
				int allCount = biz.myVideolist(memberDto.getOpt_no_seq()).size();
				int listCount = 10;
				int totalPage = (allCount - 1) / listCount + 1;
				int blockCount = 5;
				int absolutePage = 0;
				int endPage = 0;

				if (page < 1) {
					page = 1;

				} else if (page > totalPage) {
					page = totalPage;
				}

				if (page % 5 == 0) {
					absolutePage = ((page / 5) * 5) - 4;
					endPage = (page / 5) * 5;

				} else {
					absolutePage = ((page / 5) * 5) + 1;
					endPage = ((page / 5) * 5) + 5;
				}

				if (endPage > totalPage) {
					endPage = totalPage;
				}

				int start = (page - 1) * listCount + 1;
				int end = page * listCount;
				request.setAttribute("list", biz.myVideoListPage(memberDto.getOpt_no_seq(), start, end));
				request.setAttribute("page", page);
				request.setAttribute("blockCount", blockCount);
				request.setAttribute("totalPage", totalPage);
				request.setAttribute("absolutePage", absolutePage);
				request.setAttribute("endPage", endPage);
				
				dispatch(request, response, "myvideolist.jsp");
			}
		} else if (command.equals("searchVideo")) {
			String searchoption = request.getParameter("searchoption");
			String searchtext = request.getParameter("searchtext");

			int page = Integer.parseInt(request.getParameter("page"));
			int allCount = biz.searchVideo(searchoption, searchtext).size();
			int listCount = 10;
			int totalPage = (allCount - 1) / listCount + 1;
			int blockCount = 5;
			int absolutePage = 0;
			int endPage = 0;

			if (page < 1) {
				page = 1;

			} else if (page > totalPage) {
				page = totalPage;
			}

			if (page % 5 == 0) {
				absolutePage = ((page / 5) * 5) - 4;
				endPage = (page / 5) * 5;

			} else {
				absolutePage = ((page / 5) * 5) + 1;
				endPage = ((page / 5) * 5) + 5;
			}

			if (endPage > totalPage) {
				endPage = totalPage;
			}

			int start = (page - 1) * listCount + 1;
			int end = page * listCount;
			request.setAttribute("list", biz.searchVideoPage(searchoption, searchtext, start, end));
			request.setAttribute("page", page);
			request.setAttribute("blockCount", blockCount);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("absolutePage", absolutePage);
			request.setAttribute("endPage", endPage);

			dispatch(request, response, "videoSearch.jsp");
		} else if (command.equals("videoupload")) {
			int opt_no_seq = Integer.parseInt(request.getParameter("opt_no_seq"));
			String video_title = request.getParameter("video_title");
			String video_content = request.getParameter("video_content");
			String video_url = request.getParameter("video_url");
			VideoClipDto dto = new VideoClipDto();
			dto.setOpt_no_seq(opt_no_seq);
			dto.setVideo_title(video_title);
			dto.setVideo_content(video_content);
			dto.setVideo_url(video_url);
			int res = biz.insertVideo(dto);
			if (res > 0) {
				System.out.println("등록 성공");
			} else {
				System.out.println("등록 실패");
			}

			dispatch(request, response, "video.do?command=videoList&page=1&videoarea=my");
		} else if (command.equals("deletevideo")) {
			int video_no_seq = Integer.parseInt(request.getParameter("videoseq"));

			biz.deleteVideoComment(video_no_seq);
			int res = biz.deleteVideo(video_no_seq);

			if (res > 0) {
				System.out.println("삭제 성공");
				dispatch(request, response, "video.do?command=videoList&page=1&videoarea=my");
			} else {
				System.out.println("삭제 실패");
				dispatch(request, response, "video.do?command=videoList&page=1&videoarea=my");
			}
		} else if (command.equals("multiDel")) {
			String[] seq = request.getParameterValues("chk");
			biz.multiDelVideoComment(seq);
			
			if (biz.multiDelVideo(seq)) {
				alert("삭제성공", "video.do?command=videoList&page=1&videoarea=my", response);
			} else {
				alert("삭제실패", "video.do?command=videoList&page=1&videoarea=my", response);
			}
		} else if (command.equals("updatevideo")) {
			int video_no_seq = Integer.parseInt(request.getParameter("videoseq"));
			VideoClipDto videoDto = biz.videoSelectOne(video_no_seq);
			request.setAttribute("videoDto", videoDto);
			dispatch(request, response, "videoUpdate.jsp");
		} else if (command.equals("videoupdateres")) {
			int video_no_seq = Integer.parseInt(request.getParameter("videoseq"));
			String video_title = request.getParameter("video_title");
			String video_content = request.getParameter("video_content");
			String video_url = request.getParameter("video_url");
			VideoClipDto videoDto = new VideoClipDto();
			videoDto.setVideo_no_seq(video_no_seq);
			videoDto.setVideo_title(video_title);
			videoDto.setVideo_content(video_content);
			videoDto.setVideo_url(video_url);
			int res = biz.updateVideo(videoDto);
			if (res > 0) {
				dispatch(request, response, "video.do?command=videoList&page=1&videoarea=my");
			} else {
				dispatch(request, response, "video.do?command=updatevideo&videoseq=" + video_no_seq);
			}
		} else if (command.equals("videoDetail")) {
			int no = Integer.parseInt(request.getParameter("videoseq"));
			biz.videoCount(no);

			VideoClipDto videoDto = biz.videoSelectOne(no);
			List<VideoComment> list = biz.videoCommentList(no);
			request.setAttribute("videoDto", videoDto);
			request.setAttribute("list", list);
			request.setAttribute("videoList", biz.videoListPage(1, 5));

			dispatch(request, response, "videodetail.jsp");

		} else if (command.equals("videoAnswerinsert")) {
			HttpSession session = request.getSession();
			MemberDto memdto = (MemberDto) session.getAttribute("memdto");
			VideoComment videocomment = new VideoComment();

			int video_no_seq = Integer.parseInt(request.getParameter("no"));
			int opt_no = memdto.getOpt_no_seq();
			String video_reple = request.getParameter("video_reple");
			videocomment.setVideo_reple(video_reple);
			videocomment.setOpt_no_seq(opt_no);
			videocomment.setVideo_no_seq(video_no_seq);

			int res = biz.insertVideocomment(videocomment);
			if (res > 0) {
				System.out.println("작성성공!");
				response.sendRedirect("video.do?command=videoDetail&videoseq=" + video_no_seq + "&page=1");
			} else {
				System.out.println("작성 실패!");
				response.sendRedirect("video.do?command=videoDetail&videoseq=" + video_no_seq + "&page=1");
			}
		} else if (command.equals("videoAnswerUpdate")) {
			int video_comment_seq = Integer.parseInt(request.getParameter("commentseq"));
			String videoseq = request.getParameter("videoseq");
			String page = request.getParameter("page");

			VideoComment videoComment = new VideoComment();
			videoComment = biz.videoCommentselectone(video_comment_seq);
			request.setAttribute("videoComment", videoComment);
			request.setAttribute("page", page);
			request.setAttribute("videoseq", videoseq);

			dispatch(request, response, "videoAnswerUpdate.jsp");
		} else if (command.equals("videoAnswerUpdateres")) {
			int video_comment_seq = Integer.parseInt(request.getParameter("video_comment_seq"));
			int videoseq = Integer.parseInt(request.getParameter("videoseq"));
			String video_reple = request.getParameter("video_reple");

			VideoComment videocomment = new VideoComment();
			videocomment.setVideo_comment_seq(video_comment_seq);
			videocomment.setVideo_reple(video_reple);

			int res = biz.videoCommentUpdate(videocomment);

			if (res > 0) {
				System.out.println("수정성공!");
				response.sendRedirect("video.do?command=videoDetail&videoseq=" + videoseq + "&page=1");
			} else {
				System.out.println("수정 실패!");
				response.sendRedirect("video.do?command=videoDetail&videoseq=" + videoseq + "&page=1");
			}
		} else if (command.equals("DeletevideoAnswer")) {
			int commentseq = Integer.parseInt(request.getParameter("commentseq"));
			int page = Integer.parseInt(request.getParameter("page"));
			int video_no_seq = Integer.parseInt(request.getParameter("videoseq"));
			int res = biz.videoCommentDelete(commentseq);
			if (res > 0) {
				System.out.println("삭제 성공");
				dispatch(request, response, "video.do?command=videoDetail&videoseq=" + video_no_seq + "&page=" + page);
			} else {
				System.out.println("삭제 실패");
				dispatch(request, response, "video.do?command=videoDetail&videoseq=" + video_no_seq + "&page=" + page);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String tempSavePath = request.getSession().getServletContext().getRealPath("video");
		String savePath = tempSavePath.replace('\\', '/');

		File targetDir = new File(savePath);
		if (!targetDir.exists()) {
			targetDir.mkdirs();
		}

		int sizeLimit = 1024 * 1024 * 1500;
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
				new DefaultFileRenamePolicy());
		OPTBizImpl biz = new OPTBizImpl();

		String command = multi.getParameter("command");
		System.out.println("[ video.do? post : " + command + " ]");
		if (command.equals("videoupload")) {
			int opt_no_seq = Integer.parseInt(multi.getParameter("opt_no_seq"));
			String video_title = multi.getParameter("video_title");
			String video_content = multi.getParameter("video_content");
			String video_url = multi.getFilesystemName("video_url");
			String m_fileFullPath = savePath + "/" + video_url;
			VideoClipDto dto = new VideoClipDto();
			dto.setOpt_no_seq(opt_no_seq);
			dto.setVideo_title(video_title);
			dto.setVideo_content(video_content);
			dto.setVideo_url(video_url);

			int res = biz.insertVideo(dto);
			if (res > 0) {
				System.out.println("등록 성공");
			} else {
				System.out.println("등록 실패");
			}

			response.sendRedirect("video.do?command=videoList&page=1&videoarea=my");
		} else if (command.equals("videoupdateres")) {
			int video_no_seq = Integer.parseInt(multi.getParameter("videoseq"));
			String video_title = multi.getParameter("video_title");
			String video_content = multi.getParameter("video_content");
			String video_url = multi.getFilesystemName("video_url");
			String m_fileFullPath = savePath + "/" + video_url;
			VideoClipDto videoDto = new VideoClipDto();
			videoDto.setVideo_no_seq(video_no_seq);
			videoDto.setVideo_title(video_title);
			videoDto.setVideo_content(video_content);
			videoDto.setVideo_url(video_url);
			int res = biz.updateVideo(videoDto);
			if (res > 0) {
				System.out.println("수정 성공");
				response.sendRedirect("video.do?command=videoList&page=1&videoarea=my");
			} else {
				System.out.println("수정 실패");
				response.sendRedirect("video.do?command=updatevideo&videoseq=" + video_no_seq);
			}
		}
	}

	public void dispatch(HttpServletRequest request, HttpServletResponse response, String url)
			throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	public void alert(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		out.print("<script> alert('" + msg + "'); location.href='" + url + "'; </script>");
	}

}
