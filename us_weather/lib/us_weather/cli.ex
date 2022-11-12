defmodule UsWeather.CLI do
  # @default_count 4
  @moduledoc """
  Handle the command line parsing and 
  #  the dispatch to
  #  the various functions that end up generating a
  #  table of the last _n_ issues in a github project
  """

  @weather_url "https://w1.weather.gov/xml/current_obs/KDTO.xml"

  def main(argv) do
    parse_args(argv)
    %HTTPoison.Response{body: body} = HTTPoison.get!(@weather_url)
    {xmerl, _} = body |> :erlang.binary_to_list |> :xmerl_scan.string()
    get_text(xmerl, 'location')
    get_text(xmerl, 'observation_time')
    get_text(xmerl, 'weather')
    get_text(xmerl, 'wind_string')
    get_text(xmerl, 'temperature_string')
  end

  defp get_text(xmerl, element) do
    {:xmlText, _list, _i, _l, data, :text} = hd(:xmerl_xpath.string('/current_observation/' ++ element ++ '/text()', xmerl))
    IO.puts(to_string(element) <> " -> #{data}")
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  #  Otherwise it is a github user name, project name, and (optionally)
  #  the number of entries to format.
  #  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse =
      OptionParser.parse(argv,
        switches: [help: :boolean],
        aliases: [h: :help]
      )

    case parse do
      {[help: true], _, _} ->
        :help

      # { _, [ user, project, count ], _ }
      # -> { user, project, count }
      # { _, [ user, project ], _ }
      # -> { user, project, @default_count }
      _ ->
        :help
    end
  end
end
