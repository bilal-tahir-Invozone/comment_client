defmodule CommentGraphql.GraphQL.Schema do

  use Absinthe.Schema

  alias CommentGraphql.Client




  object :result do
    field :success, :boolean
  end

  object :get_comments do

    field :commentid, :integer
    field :comments, :string
    field :isdeletedbyadmin, :boolean
    field :likecount, :integer
    field :postid, :integer
    field :replyid, :integer
    field :status, :integer
    field :userid, :integer
    field :userlikes, :integer
    field :media_url, :string

  end

  object :get_replies do

    field :commentid, :integer
    field :reply, :string
    field :isdeletedbyadmin, :boolean
    field :likecount, :integer
    field :postid, :integer
    field :replyid, :integer
    field :status, :integer
    field :userid, :integer
    field :userlikes, :integer
    field :media_url, :string

  end

  query do
    field :get_comments, list_of(:get_comments) do
      resolve fn(_arg, _context) ->
        comments = ImpowerElixir.HandleDb.get_posts_comment()
        {:ok, comments}
      end
    end
  end

  mutation do

    field :update_reply, :result do

      arg :reply, non_null(:string)
      arg :isdeletedbyadmin, :boolean
      arg :userid, :integer
      arg :replyid, :integer
      arg :postid, :integer
      arg :status, :integer
      arg :likecount, :integer
      arg :userlikes, :integer
      arg :commentid, :integer
      arg :media_url, :string


      resolve fn(%{reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

        reply_update = CommentGraphql.Client.update_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url)
        case reply_update do
          {:ok, _} ->
            {:ok, %{success: true}}
          {:error , _} ->
            {:ok, %{success: false}}
        end
      end
    end

    field :create_reply, :result do

      arg :isdeletedbyadmin, :boolean
      arg :userid, :integer
      arg :reply, non_null(:string)
      arg :replyid , :integer
      arg :postid, :integer
      arg :status, :integer
      arg :likecount, :integer
      arg :userlikes, :integer
      arg :commentid, :integer
      arg :media_url, :string

      resolve fn(%{isdeletedbyadmin: isdeletedbyadmin, userid: userid, reply: reply, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

        reply = CommentGraphql.Client.create_reply(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url)
        case reply do
          {:ok, _} ->
            {:ok, %{success: true}}
          {:error , _} ->
            {:ok, %{success: false}}
        end
      end
    end

    field :get_repy_id, list_of(:get_replies) do
      arg :commentid, non_null(:integer)

      resolve fn(%{commentid: commentid}, _context) ->

        data = CommentGraphql.Client.get_reply(commentid)
        {:ok, data}

      end
    end

    field :delete_reply, :result do
      arg :replyid, non_null(:integer)

      resolve fn(%{replyid: replyid}, _context) ->


        delete_replyid = CommentGraphql.Client.delete_reply(replyid)
        case delete_replyid do
          {:ok, true} ->
            {:ok, %{success: true}}
          {:ok, false} ->
            {:ok, %{success: false}}
        end
      end
    end

    field :update_comment, :result do

      arg :comments, non_null(:string)
      arg :isdeletedbyadmin, :boolean
      arg :userid, :integer
      arg :replyid, :integer
      arg :postid, :integer
      arg :status, :integer
      arg :likecount, :integer
      arg :userlikes, :integer
      arg :commentid, :integer
      arg :media_url, :string

      resolve fn(%{comments: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

        comment_update = CommentGraphql.Client.update_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url)
        case comment_update do
          {:ok, _} ->
            {:ok, %{success: true}}
          {:error , _} ->
            {:ok, %{success: false}}
        end
      end
    end

    field :delete_comment, :result do
      arg :commentid, non_null(:integer)

      resolve fn(%{commentid: commentid}, _context) ->

        delete_comment = CommentGraphql.Client.delete_comment(commentid)
        case delete_comment do
          {:ok, true} ->
            {:ok, %{success: true}}
          {:ok, false} ->
            {:ok, %{success: false}}
        end
      end
    end


    field :get_comments_id, list_of(:get_comments) do
      arg :postid, non_null(:integer)

      resolve fn(%{postid: postid}, _context) ->

        data = CommentGraphql.Client.get_comment(postid)

        {:ok, data}

      end
    end



    field :create_comment, :result do

      arg :comments, non_null(:string)
      arg :isdeletedbyadmin, :boolean
      arg :userid, :integer
      arg :replyid, :integer
      arg :postid, :integer
      arg :status, :integer
      arg :likecount, :integer
      arg :userlikes, :integer
      arg :commentid, :integer
      arg :media_url, :string

      resolve fn(%{comments: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, userlikes: userlikes, likecount: likecount, commentid: commentid, media_url: media_url}, _context) ->

        comment = CommentGraphql.Client.create_comment(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url)
        case comment do
          {:ok, _} ->
            {:ok, %{success: true}}
          {:error , _} ->
            {:ok, %{success: false}}
        end
      end
    end
  end
end
