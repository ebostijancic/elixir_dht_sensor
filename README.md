# DHT

This Elixir app provides functions for reading data from a compatible DHT sensor.

The DHT11 protocol is implemented in C and available through Erlang's
native implemented functions. It requires [WiringPi](http://wiringpi.com), a GPIO
access library for the BCM2825 used in the Raspberry PI.

# Usage

```elixir
pin = 4

# read from sensor
{temp, humidity} = DHT.read(pin)
IO.puts "Temp: #{temp} / Humidity: #{humidity}"

# pull from sensor every three seconds
DHT.stream(pin, 3_000)
|> Stream.each(&IO.inspect/1)
|> Stream.run()
```

## Installation

1. Add `dht` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:dht, github: "almightycouch/elixir-dht-sensor"}]
end
```

2. Ensure `dht` is started before your application:

```elixir
def application do
  [applications: [:dht]]
end
```
