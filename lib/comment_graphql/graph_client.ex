
defmodule CommentGraphql.Client do

  alias Commentapi.Comment.Stub

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
  def create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %CreateCommentRequest{} = request} <- build_request_create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid),
         {:ok, %CreateCommentResponse{comment: comment}} <-
           Stub.create_comment(channel, request) do
      {:ok, comment}
    end
  end

  defp build_request_create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid), do: {:ok, CreateCommentRequest.new(comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid)}

  def get_comment(postid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %GetCommentRequest{} = request} <- build_request_get_comment(postid),
         {:ok, %GetCommentResponse{comments: getting_comment}} <- Stub.get_comment(channel, request) do
        IO.puts "here is result"
        IO.inspect %GetCommentResponse{comments: getting_comment}
    end
  end

  defp build_request_get_comment(postid) do
  {:ok,  GetCommentRequest.new(postid: postid) }
  end

  def update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do
    with {:ok, channel} <- GRPC.Stub.connect(@server_repo_url),
         {:ok, %UpdateCommentRequest{} = request} <- build_request_update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid),
         {:ok, %UpdateCommentResponse{status: true}} <-
           Stub.update_comment(channel, request) do
      {:ok, comment}
    end
  end

  defp build_request_update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid), do: {:ok, UpdateCommentRequest.new(comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid)}





  ########################################### reply ##################################


end
