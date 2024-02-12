defmodule KdWeb.SpeechController do
  use KdWeb, :controller

  def index(conn, %{"text" => text}) do
    audio_file = "priv/static/audio/#{text}.mp3"

    conn
    |> put_resp_header("content-type", MIME.from_path(audio_file))
    |> put_resp_header("accept-ranges", "bytes")
    |> send_file(200, audio_file)
  end
end
