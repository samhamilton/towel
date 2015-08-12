defmodule Maybe do
  def wrap(m = {:ok, _}), do: m
  def wrap(m = {:error, _}), do: m

  def wrap(nil), do: error
  def wrap(v), do: ok(v)

  def unwrap({t, v}) when t in [:ok, :error], do: unwrap(v)
  def unwrap(x), do: x

  def ok(v), do: {:ok, v}

  def error, do: {:error, nil}
  def error(r), do: {:error, r}

  def combine(ms) when is_list(ms) do
    try do
      List.foldr ms, {:ok, []}, fn
        {:ok, v}, {:ok, vs} -> {:ok, [v|vs]}
        {:error, reason}, _ -> throw reason
      end
    catch
      reason -> {:error, reason}
    end
  end
end