defmodule NoosphericalWeb.CommentLive.Index do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias Noospherical.Articles
  alias NoosphericalWeb.CommentLive

  def render(assigns) do
    ~L"""
    <div class="main" style="margin-top: 5rem">
      <div class="js-comment">
        <%= f = form_for @changeset, "#", class: "comment_form", phx_submit: "save", phx_hook: "Comment" %>
          <%= textarea f, :body, rows: 2, required: true, placeholder: "Cool beans..." %>
          <div class="comment_form-footer">
            <button class ="btn red darken-2" type="submit">Comment</button>
          </div>
        </form>
      </div>

      <div class="comment_list" id="root-comments" phx-update="append">
        <%= for comment <- @comments do %>
          <%= live_component @socket, CommentLive.Show, id: comment.id, comment: comment, kind: :parent %>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    comments = Articles.list_root_comments()
    changeset = Articles.change_comment()
    socket = assign(socket, changeset: changeset, comments: comments)
    if connected?(socket), do: Articles.subscribe("lobby")

    {:ok, socket, temporary_assigns: [comments: []]}
  end

  def handle_event("save", %{"comment" => comment_params}, socket) do
    case Articles.create_comment(comment_params) do
      {:ok, comment} ->
        {:noreply, assign(socket, comments: [comment], changeset: Articles.change_comment())}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({Articles, :new_comment, comment}, socket) do
    if comment.parent_id do
      send_update(CommentLive.Show, id: comment.parent_id, children: [comment])
      {:noreply, socket}
    else
      {:noreply, assign(socket, comments: [comment])}
    end
  end
end
