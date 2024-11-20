local a=require"cc.expect"local b,c=a.expect,a.range;local d={["<"]=1,["="]=2,[">"]=0}local e={["="]=0,[">"]=1}local f={t=0,s=1,m=2}local g={daily=0,["12h"]=1,["6h"]=2,["4h"]=3,["3h"]=4,["2h"]=5,hourly=6,["45m"]=7,["30m"]=8,["15m"]=9}local h={}h.any="minecraft:air"function h.new(i)b(1,i,"boolean","table")local j=type(i)=="boolean"and{cyclic=i,entries={}}or i;j.ctx=j.ctx or{station=0,condition=0}return setmetatable(j,{__index=h})end;function h:entry(k,i)b(1,k,"string")b(2,i,"table")self.ctx.station=self.ctx.station+1;self.ctx.condition=1;self.entries[self.ctx.station]={instruction={id=k,data=i},conditions={}}return self end;function h:condition(k,i)b(1,k,"string")b(2,i,"table")local l=self.entries[self.ctx.station].conditions;l[self.ctx.condition]=l[self.ctx.condition]or{}table.insert(l[self.ctx.condition],{id=k,data=i})return self end;function h:OR()self.ctx.condition=self.ctx.condition+1;return self end;function h:serialize(m)self.ctx=nil;return m and textutils.serializeJSON(self)or textutils.serialize(self)end;function h:to(n)b(1,n,"string")return self:entry("create:destination",{text=n})end;function h:rename(n)b(1,n,"string")return self:entry("create:rename",{text=n})end;function h:section(o,p,q,r)b(1,o,"string")b(2,p,"string")b(3,q,"boolean")b(4,r,"boolean")return self:entry("createrailwaysnavigator:travel_section",{train_group=o,train_line=p,include_previous_station=q,usable=r})end;function h:throttle(s)b(1,s,"number")c(s,5,100)return self:entry("create:throttle",{value=s})end;function h:through(n)b(1,n,"string")return self:entry("railways:waypoint_destination",{text=n})end;function h:setlink(t,u,v)b(1,t,"string")b(2,u,"string")b(3,v,"number")return self:entry("railways:redstone_link",{frequency={{id=t,count=1},{id=u,count=1}},power=v})end;function h:fixtimings()return self:entry("createrailwaysnavigator:reset_timings",{})end;function h:wait(w,x)b(1,w,"number")b(2,x,"string","nil")x=x or"s"return self:condition("create:delay",{value=w,time_unit=f[x]})end;function h:time(y,z,A)b(1,y,"number")b(2,z,"number")b(3,A,"string")c(y,0,23)c(z,0,59)return self:condition("create:time_of_day",{hour=y,minute=z,rotation=g[A]})end;function h:fluid(B,C,D)b(1,B,"string")b(2,C,"string")b(3,D,"number")return self:condition("create:fluid_threshold",{bucket={id=B,count=1},threshold=tostring(D),operator=d[C],measure=0})end;function h:item(B,C,D)b(1,B,"string")b(2,C,"string")b(3,D,"number")return self:condition("create:item_threshold",{bucket={id=B,count=1},threshold=tostring(D),operator=d[C],measure=0})end;function h:getlink(t,u,E)b(1,t,"string")b(2,u,"string")b(3,E,"boolean")return self:condition("create:redstone_link",{frequency={{id=t,count=1},{id=u,count=1}},inverted=E and 0 or 1})end;function h:passengers(C,F)b(1,C,"string")b(2,F,"number")return self:condition("create:player_count",{count=F,exact=e[C]})end;function h:cargoidle(w,x)b(1,w,"number")b(2,x,"string","nil")x=x or"s"return self:condition("create:idle",{value=w,time_unit=f[x]})end;function h:unloaded()return self:condition("create:unloaded",{})end;function h:powered()return self:condition("create:powered",{})end;function h:loaded()return self:condition("railways:loaded",{})end;function h:waitdynamic(w,G,x)b(1,w,"number")b(2,G,"number")b(3,x,"string","nil")x=x or"s"return self:condition("createrailwaysnavigator:dynamic_delay",{value=w,min=G,time_unit=f[x]})end;function h:energy(C,D)b(1,C,"string")b(2,D,"number")return self:condition("createaddition:energy_threshold",{threshold=D,operator=d[C],measure=0})end;return h
