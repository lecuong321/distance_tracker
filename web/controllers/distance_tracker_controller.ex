defmodule DistanceTracker.TrackerController do
	use DistanceTracker.Web, :controller

	alias DistanceTracker.{Tracker, Repo, ErrorView}
	alias Plug.Conn

	def index(conn, _params) do
		trackers = Repo.all(Tracker)
		render(conn, "index.json", trackers: trackers)
	end

	def show(conn, %{"id" => uuid}) do
		with tracker = %Tracker{} <- Repo.get(Tracker, uuid) do
			render(conn, "show.json", tracker: tracker)
		else
			nil ->
				conn
				|> put_status(404)
				|> render(ErrorView, "404.json", error: "Not found")
		end
	end

	def create(conn, params) do
		#{:ok, date} = NaiveDateTime.from_iso8601(params["completed_at"])
		# use NaiveDateTime voi params
		#  "distance": 1400,
		#	  "activity": "swimming5",
		#	  "completed_at": 2018-01-16 00:51:07"
		#}

		#{:ok, date, 0} = DateTime.from_iso8601(params["completed_at"]) 
		# use DateTime voi params
		#  "distance": 1400,
		#	  "activity": "swimming5",
		#	  "completed_at": "2018-01-16T00:50:07Z"
		#}
		#{:ok, datetime, 0} = DateTime.from_iso8601("2015-01-23T23:50:07Z")
		#https://hexdocs.pm/elixir/DateTime.html#content
  		
  		date = parse_date(params["completed_at"])
		params = Map.put(params, "completed_at", date)

  		#params = %{params | "completed_at" => date}

		changeset = Tracker.changeset(%Tracker{}, params)

		with {:ok, tracker} <- Repo.insert(changeset) do
			conn
			|> Conn.put_status(201)
			|> render("show.json", tracker: tracker)
		else
			{:error, %{errors: errors}} ->
				conn
				|> put_status(422)
				|> render(ErrorView, "422.json", %{errors: errors})
		end
	end

	def delete(conn, %{"id" => uuid}) do
	  with tracker = %Tracker{} <- Repo.get(Tracker, uuid) do
	    Repo.delete!(tracker)
	    conn
	    |> Conn.put_status(204)
	    |> Conn.send_resp(:no_content, "")
	  else
	    nil ->
	      conn
	      |> put_status(404)
	      |> render(ErrorView, "404.json", error: "Not found")
	  end
	end

	defp parse_date(nil), do: nil
	
  	defp parse_date(date_as_string) do
	    with {:ok, date, _} <- DateTime.from_iso8601(date_as_string) do
	      date
	    else
	      _ -> nil
	    end
  	end
end