-module(joe).

-export([start/0]).

start() ->
	Handle = bitcask:open("joe_database", [read_write]),
	N = fetch(Handle),
	store(Handle, N+1),
	io:format("Joe has been run ~p times~n", [N]),
	bitcask:close(Handle),
	init:stop().
	
store(Handle, N) ->
	bitcask:put(Handle, <<"joe_executions">>, term_to_binary(N)).
	
fetch(Handle) ->
	case bitcask:get(Handle, <<"joe_executions">>) of
		not_found -> 1;
		{ok, Bin} -> binary_to_term(Bin)
	end.