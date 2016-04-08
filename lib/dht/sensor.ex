defmodule DHT.Sensor do
  @moduledoc """
  Contains function for reading data from the DHT11 sensor.

  Some functions of this module are implemented in C and available through
  Erlang's native implemented functions.

  Here's a simple example to stream data from the sensor pulled every three
  seconds:

      DHT.Sensor.stream(4, 3_000)
      |> Stream.reject(&is_nil/1)
      |> Stream.each(&IO.inspect/1)
      |> Stream.run()
  """

  @on_load :load_nif

  @dht_pin 4
  @nif_path "./_build/nifs/libdht11"

  require Logger

  @doc """
  Loads and initializes the `libdht11.so` NIF library.

  You do not have to call this function as is it invoked automatically
  whenever the module is loaded.
  """
  def load_nif do
    case :erlang.load_nif(@nif_path, 0) do
      :ok ->
        setup
      {:error, {:load_failed, error}} ->
        Logger.warn error
    end
  end

  @doc false
  def setup do
    raise Code.LoadError, file: @nif_path
  end

  @doc """
  Streams data from the sensor pulled at the given interval.
  """
  def stream(pin, interval \\ 1_000) do
	Stream.interval(interval)
	|> Stream.map(fn _i ->
	  case read(pin) do
		{:ok, data} ->
		  data
		{:error, _error} ->
		  nil
	  end
	end)
  end

  @doc """
  Reads data from the sensor.
  """
  def read(_pin) do
    raise Code.LoadError, file: @nif_path
  end
end
