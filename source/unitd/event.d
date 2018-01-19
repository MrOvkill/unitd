module unitd.event;

import unitd.core;

import std.stdio;
import std.conv;
import std.json;

class Event : NamedObject
{

  protected string event;

  public this(string event)
  {
    super("unitd.event.Event", "event");
    this.event = event;
  }

  public string evt()
  {
    return this.event;
  }

  public override string str()
  {
    JSONValue jv = parseJSON(super.str());
    jv.object["event"] = this.event;
    return toJSON(jv);
  }

}

class DefaultEvent : Event
{
  public this()
  {
    super("default");
  }
}

class EventHandler : NamedObject
{

  public this(string name)
  {
    super(name);
  }

  public bool handle(Event evt)
  {
    return false;
  }

  public void log(Event evt, string message)
  {
    writef("[event] %s %s", evt.str(), message);
  }

}

class DefaultEventHandler : EventHandler
{
  public this()
  {
    super("default");
  }

  public override bool handle(Event evt)
  {
    if(evt == new DefaultEvent()) {
      super.log(evt, "Default event");
    }
    return false;
  }
}

class EventManager
{

  protected EventHandler[] handlers;

  public this()
  {
    this.handlers = [];
  }
}
