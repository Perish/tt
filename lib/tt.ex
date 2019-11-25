defmodule Tt do
  def start(:normal, []) do
    {:ok, listen_socket} = :gen_tcp.listen(5678, [:binary, packet: :raw, active: false, reuseaddr: true])
    IO.puts("Start tcp/ip port: 5678")
    accept_request(listen_socket)
  end

  def accept_request(listen_socket) do
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)
    {:ok, bin} = :gen_tcp.recv(client_socket, 0)
    IO.puts "bin --- #{inspect bin}"
    response = """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 6

    Hello!
    """
    :ok = :gen_tcp.send(client_socket, response)
    :ok = :gen_tcp.close(client_socket)
    accept_request(listen_socket)
  end
end
