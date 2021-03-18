%%--------------------------------------------------------------------
%% Copyright (c) 2020 DGIOT Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-define(SWAGGER(Name, Ver), atom_to_list(Name) ++ "_" ++ binary_to_list(Ver) ++ ".json").

%% 禁跨域
% -define(ACCESS_CONTROL_ALLOW_HEADERS, false).
%% 跨域头
-define(ACCESS_CONTROL_ALLOW_HEADERS, <<"Origin, sessionToken, X-Requested-With, Content-Type, Accept,WG-App-Version, WG-Device-Id, WG-Network-Type, WG-Vendor, WG-OS-Type, WG-OS-Version, WG-Device-Model, WG-CPU, WG-Sid, WG-App-Id, WG-Token">>).


%% 默认请求头
-define(HEADER, #{
    <<"server">> => <<"API Server">>,
    <<"access-control-allow-origin">> => <<"*">>,
    <<"access-control-allow-credentials">> => <<"true">>,
    <<"access-control-allow-methods">> => <<"GET, POST, OPTIONS, PUT, DELETE">>
}).

-define(WSOPTIONS,
    fun() ->
        {ws, Port, Options} = lists:keyfind(ws, 1, emqx:get_env(listeners, [])),
        Options
    end).

%% 默认路由
-define(ROUTER(DocRoot), [
    {"/iot/static/[...]", shuwa_iot_router, {iot, DocRoot}},
    {"/iot/:Product/[...]", shuwa_iot_router, {product, DocRoot}}
] ++ shuwa_edashboard:dispatch()).


%% 默认HTTP Server名称
-define(WEBSERVER, shuwa_rest).
-define(APP, shuwa_web_manager).
