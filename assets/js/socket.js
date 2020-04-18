// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()
// Now that you are connected, you can join channels with a topic:

const createSocket = topicId => {
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { renderComments(resp.comments) })
    .receive("error", resp => {
      console.log("Unable to join", resp)
    })

  channel.on(`comments:${topicId}:new`, renderComment);

  document.getElementById("comment-btn").addEventListener("click", () => {
    const content = document.querySelector("textarea").value;

    channel.push("comment:add", { content: content });
  });
};

function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector(".collection").innerHTML = renderedComments.join("");
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector(".collection").innerHTML += renderedComment;
}

function commentTemplate(comment) {
  const name = comment.user.name;
  const username = comment.user.username;
  const avatar = `<%= gravatar(${comment.user.email})  %>`

  const getAvatar = function(avatar = "gravatar") {
    return avatar;
  };

  const getName = function(name = "Anon") {
    return name;
  };

  const getUsername = function(username = "@anon") {
    return username;
  };

  return `
      <li class="row collection-item teal-text text-darken-4" style="font-family: 'Lato'; margin-top: 2rem">
        <div class="col s2">${getAvatar(avatar)}</div>
        <div class="col s9"> ${comment.content} </div>
        <div class="align-right teal-text text-lighten-2 col s3" style="font-family: 'Lato'">
          <i class="material-icons left" style="margin-right: -0.3rem">keyboard_arrow_left</i>
          <i class="material-icons left">fingerprint</i>
          <em>${getName(name)}</em> 
          <strong> - ${getUsername(username)}</strong>
        </div>
      </li>
    `;
}

window.createSocket = createSocket;

export default socket
