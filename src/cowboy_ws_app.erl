%%%-------------------------------------------------------------------
%% @doc cowboy_ws public API
%% @end
%%%-------------------------------------------------------------------

-module(cowboy_ws_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    cowboy_ws_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
