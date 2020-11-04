defmodule Gotham.OwnerTest do
  use Gotham.DataCase

  alias Gotham.Owner

  describe "rights" do
    alias Gotham.Owner.Right

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def right_fixture(attrs \\ %{}) do
      {:ok, right} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Owner.create_right()

      right
    end

    test "list_rights/0 returns all rights" do
      right = right_fixture()
      assert Owner.list_rights() == [right]
    end

    test "get_right!/1 returns the right with given id" do
      right = right_fixture()
      assert Owner.get_right!(right.id) == right
    end

    test "create_right/1 with valid data creates a right" do
      assert {:ok, %Right{} = right} = Owner.create_right(@valid_attrs)
      assert right.name == "some name"
    end

    test "create_right/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Owner.create_right(@invalid_attrs)
    end

    test "update_right/2 with valid data updates the right" do
      right = right_fixture()
      assert {:ok, %Right{} = right} = Owner.update_right(right, @update_attrs)
      assert right.name == "some updated name"
    end

    test "update_right/2 with invalid data returns error changeset" do
      right = right_fixture()
      assert {:error, %Ecto.Changeset{}} = Owner.update_right(right, @invalid_attrs)
      assert right == Owner.get_right!(right.id)
    end

    test "delete_right/1 deletes the right" do
      right = right_fixture()
      assert {:ok, %Right{}} = Owner.delete_right(right)
      assert_raise Ecto.NoResultsError, fn -> Owner.get_right!(right.id) end
    end

    test "change_right/1 returns a right changeset" do
      right = right_fixture()
      assert %Ecto.Changeset{} = Owner.change_right(right)
    end
  end
end
