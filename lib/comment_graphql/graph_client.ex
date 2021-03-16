
defmodule CommentGraphql.Client do

  alias Commentapi.CommentService.Stub

  # 5. alias proto generated modules that were going to use
  alias Commentapi.{
    CreateCommentRequest,
    CreateCommentResponse,

    GetCommentRequest,
    GetCommentResponse,

    DeleteCommentRequest,
    DeleteCommentResponse,

    UpdateCommentRequest,
    UpdateCommentResponse,

    CreateReplyRequest,
    CreateReplyResponse,

    GetReplyRequest,
    GetReplyResponse,

    DeleteReplyRequest,
    DeleteReplyResponse,

    UpdateReplyRequest,
    UpdateReplyResponse

  }

  @server_repo_url "localhost:8080"



  ################################# comment ######################################
  def create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %CreateCommentRequest{} = request} <- build_request_create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url),
         {:ok, %CreateCommentResponse{comment: comment}} <-
           Stub.create_comment(channel, request) do
      {:ok, comment}
    end
  end

  defp build_request_create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url), do: {:ok, CreateCommentRequest.new(comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url)}

  def get_comment(postid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %GetCommentRequest{} = request} <- build_request_get_comment(postid),
         {:ok, %GetCommentResponse{comments: getting_comment}} <- Stub.get_comment(channel, request) do

         getting_comment
    end
  end

  defp build_request_get_comment(postid) do
  {:ok,  GetCommentRequest.new(postid: postid) }
  end

  def update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %UpdateCommentRequest{} = request} <- build_request_update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url),
         {:ok, %UpdateCommentResponse{status: true}} <-
           Stub.update_comment(channel, request) do
      {:ok, comment}
    end
  end

  defp build_request_update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url), do: {:ok, UpdateCommentRequest.new(comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url)}

  def delete_comment(commentid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %DeleteCommentRequest{} = request} <- build_request_delete_comment(commentid),
         {:ok, %DeleteCommentResponse{status: status}} <-
           Stub.delete_comment(channel, request) do
      {:ok, status}
    end
  end

  defp build_request_delete_comment( commentid), do: {:ok, DeleteCommentRequest.new(commentid: commentid)}


  ########################################### reply ##################################

  def get_reply(commentid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %GetReplyRequest{} = request} <- build_request_get_reply(commentid),
         {:ok, %GetReplyResponse{replies: reply}} <-
           Stub.get_reply(channel, request) do
      reply
    end
  end

  defp build_request_get_reply(commentid), do: {:ok, GetReplyRequest.new(commentid: commentid)}

  def update_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %UpdateReplyRequest{} = request} <- build_request_update_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url),
         {:ok, %UpdateReplyResponse{status: true}} <-
           Stub.update_reply(channel, request) do
      {:ok, reply}
    end
  end

  defp build_request_update_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url), do: {:ok, UpdateReplyRequest.new(reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url)}

  def create_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %CreateReplyRequest{} = request} <- build_request_create_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url),
         {:ok, %CreateReplyResponse{reply: reply}} <-
           Stub.create_reply(channel, request) do
      {:ok, reply}
    end
  end

  defp build_request_create_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url), do: {:ok, CreateReplyRequest.new(reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url)}

  def delete_reply(replyid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %DeleteReplyRequest{} = request} <- build_request_delete_reply( replyid),
         {:ok, %DeleteReplyResponse{status: status}} <-
           Stub.delete_reply(channel, request) do
      {:ok, status}
    end
  end

  defp build_request_delete_reply(replyid), do: {:ok, DeleteReplyRequest.new(replyid: replyid)}


end
