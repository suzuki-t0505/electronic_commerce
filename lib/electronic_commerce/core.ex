defmodule ElectronicCommerce.Core do
  alias ElectronicCommerce.{Repo, User, AddressBook, Item, Order, OrderDetail}
  alias Ecto.Multi
  import Ecto.Query

  def create_user(user_params, address_book_params) do
    Multi.new()
    |> Multi.insert(:user, User.changeset(%User{}, user_params))
    |> Multi.insert(:address_book, fn %{user: user} ->
      AddressBook.changeset(%AddressBook{user: user}, address_book_params)
    end)
    |> Repo.transaction()
  end

  def create_address_book(user_id, params) do
    if user = Repo.get(User, user_id) do
      %AddressBook{user: user}
      |> AddressBook.changeset(params)
      |> Repo.insert()
    else
      nil
    end
  end

  def create_item(params) do
    %Item{}
    |> Item.changeset(params)
    |> Repo.insert()
  end

  def buy_items(user_id, address_book_id, param_list) do
    transaction =
      Multi.new()
      |> Multi.run(:user, fn repo, _changes ->
        case repo.get(User, user_id) do
          nil -> {:error, "user not found"}
          user -> {:ok, user}
        end
      end)
      |> Multi.run(:address_book, fn repo, %{user: user} ->
        query =
          from(ab in AddressBook,
            where: ab.id == ^address_book_id and ab.user_id == ^user.id)

        case repo.one(query) do
          nil -> {:error, "address_book not found"}
          address_book -> {:ok, address_book}
        end
      end)
      |> Multi.run(:items, fn repo, _changes ->
        item_ids =
          Enum.map(param_list, fn %{item_id: item_id} -> item_id end)

        query =
          from(i in Item, where: i.id in ^item_ids)

        case repo.all(query) do
          [] -> {:error, "not found items"}
          items -> {:ok, items}
        end
      end)
      |> Multi.insert(:order, fn %{user: user, address_book: address_book} ->
        total_price =
          Enum.reduce(param_list, 0, fn %{item_id: item_id, number_ordered: number_ordered}, acc ->
            get_total_price(item_id, number_ordered) + acc
          end)

        params = %{order_date: Date.utc_today(), total_price: total_price}

        Order.changeset(%Order{user: user, address_book: address_book}, params)
      end)

    Enum.with_index(param_list, 1)
    |> Enum.reduce(transaction, fn {%{item_id: item_id, number_ordered: number_ordered}, index}, multi ->
      Multi.insert(multi, "order_detail_#{index}", fn %{order: order, items: items} ->
        [item] = Enum.filter(items, fn item -> item.id == item_id end)
        total_price = get_total_price(item_id, number_ordered)

        params = %{number_ordered: number_ordered, total_price: total_price}

        OrderDetail.changeset(%OrderDetail{item: item, order: order}, params)
      end)
    end)
    |> Repo.transaction()
  end

  defp get_total_price(item_id, number_ordered) do
    # itemのみの合計金額をクエリで取得
    query =
      from(i in Item,
        where: i.id == ^item_id,
        select: i.price * ^number_ordered
      )

    Repo.one(query)
  end
end
