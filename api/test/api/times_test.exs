defmodule Gotham.TimesTest do
  use Gotham.DataCase

  alias Gotham.Times

  describe "hours" do
    alias Gotham.Times.Hour

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def hour_fixture(attrs \\ %{}) do
      {:ok, hour} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Times.create_hour()

      hour
    end

    test "list_hours/0 returns all hours" do
      hour = hour_fixture()
      assert Times.list_hours() == [hour]
    end

    test "get_hour!/1 returns the hour with given id" do
      hour = hour_fixture()
      assert Times.get_hour!(hour.id) == hour
    end

    test "create_hour/1 with valid data creates a hour" do
      assert {:ok, %Hour{} = hour} = Times.create_hour(@valid_attrs)
      assert hour.end == ~N[2010-04-17 14:00:00]
      assert hour.start == ~N[2010-04-17 14:00:00]
    end

    test "create_hour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Times.create_hour(@invalid_attrs)
    end

    test "update_hour/2 with valid data updates the hour" do
      hour = hour_fixture()
      assert {:ok, %Hour{} = hour} = Times.update_hour(hour, @update_attrs)
      assert hour.end == ~N[2011-05-18 15:01:01]
      assert hour.start == ~N[2011-05-18 15:01:01]
    end

    test "update_hour/2 with invalid data returns error changeset" do
      hour = hour_fixture()
      assert {:error, %Ecto.Changeset{}} = Times.update_hour(hour, @invalid_attrs)
      assert hour == Times.get_hour!(hour.id)
    end

    test "delete_hour/1 deletes the hour" do
      hour = hour_fixture()
      assert {:ok, %Hour{}} = Times.delete_hour(hour)
      assert_raise Ecto.NoResultsError, fn -> Times.get_hour!(hour.id) end
    end

    test "change_hour/1 returns a hour changeset" do
      hour = hour_fixture()
      assert %Ecto.Changeset{} = Times.change_hour(hour)
    end
  end
end
