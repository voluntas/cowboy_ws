-module(cowboy_ws_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                                      {'_', [
                                             {"/", cowboy_static, {priv_file, cowboy_ws, "index.html"}},
                                             {"/echo", ws_echo_h, []}
                                            ]}
                                     ]),
    {ok, _} = cowboy:start_clear(http, [{port, 5000}], #{
                                                         env => #{dispatch => Dispatch}
                                                        }),
    cowboy_ws_sup:start_link().


stop(_State) ->
    ok.
