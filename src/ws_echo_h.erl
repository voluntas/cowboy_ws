-module(ws_echo_h).

-export([init/2]).
-export([websocket_init/1]).
-export([websocket_handle/2]).
-export([websocket_info/2]).

-include_lib("eunit/include/eunit.hrl").


init(Req, _) ->
    ?debugHere,
    Opts = #{idle_timeout => infinity,
             compress => true},
    {cowboy_websocket, Req, Opts}.


websocket_init(State) ->
    Pid = self(),
    _ = spawn_link(fun() -> loop(Pid, 0) end),
    {[], State}.


websocket_handle({text, _Msg}, State) ->
    {[], State};
websocket_handle(_Data, State) ->
    {[], State}.


websocket_info({counter, Counter}, State) ->
    {[{text, integer_to_binary(Counter)}], State};
websocket_info(_Info, State) ->
    {[], State}.




loop(ParentPid, Counter) ->
    ParentPid ! {counter, Counter},
    timer:sleep(50),
    loop(ParentPid, Counter + 1).
