defmodule KdWeb.HomeLiveTest do
  use KdWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "GET /" do
    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Kd.Repo)
      Ecto.Adapters.SQL.Sandbox.mode(Kd.Repo, {:shared, self()})

      # seeding
      words = [
        %Kd.Word{
          level: 1,
          main: "សន្យា",
          subscript: "",
          subword: "",
          pronunciation: "[សន់-យ៉ា]",
          part_of_speech: "កិ.",
          definition: "ប្ដេជ្ញា, សន្មត :",
          example: "សន្យាពីរខែនឹងយកប្រាក់មកសង។",
          note: "(ម.ព. សញ្ញា ផង)។"
        },
        %Kd.Word{
          level: 2,
          main: "សន្យា",
          subscript: "",
          subword: "ខសន្យា",
          pronunciation: "[ខ-សាន់-យ៉ា]",
          part_of_speech: "ន.",
          definition: "សេចក្ដីប្ដេជ្ញា ឬការនិយាយកំណត់ដាក់លក្ខខណ្ឌច្បាស់លាស់ :",
          example: "ខ្ញុំខ្ចីប្រាក់គេដោយមានខសន្យាថាត្រូវសងប្រាក់ការទៅម្ចាស់គេតាមការព្រមព្រៀង។",
          note: ""
        },
        %Kd.Word{
          level: 1,
          main: "សន្យាសភាព",
          subscript: "",
          subword: "",
          pronunciation: "[ស័ន-យ៉ា-សៈ-ភាប]",
          part_of_speech: "ន.",
          definition: "មរណភាពយ៉ាងឆាប់ភ្លាម :",
          example: "ទទួលសន្យាសភាពដោយអាសន្នរោគ (ព.ខ្ព.)។",
          note: ""
        }
      ]

      Enum.each(words, fn word -> Kd.Repo.insert!(word) end)
      :ok
    end

    test "when search return multiple entries", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      view
      |> form("#form1", %{q: "សន្យា"})
      |> render_submit()

      assert render_async(view, 100) =~ "សន្យាសភាព"

      # uncomment to view output in browser
      # view |> open_browser()
    end

    test "when search return single entry", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/")

      view
      |> form("#form1", %{q: "សន្យាសភាព"})
      |> render_submit()

      refute render_async(view, 100) =~ "ខសន្យា"

      view |> open_browser()
    end
  end
end
