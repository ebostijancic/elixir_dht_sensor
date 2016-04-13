defmodule DHT do
  @moduledoc """
  Provides function for reading data from the DHT11 sensor.
  """

  defdelegate read(pin), to: DHT.Sensor

  defdelegate stream(pin), to: DHT.Sensor
  defdelegate stream(pin, interval), to: DHT.Sensor
end
