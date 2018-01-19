module unitd.core;

import unitd.model;

import std.json;

import gfm.math;

class PolygonObject : RenderableObject
{
  public Polygon polygon;

  public this(vec3d position, Polygon polygon)
  {
    super("unitd.core.PolygonObject", "PolygonObject", position, vec3d(0,0,0));
    this.polygon = polygon;
  }

  public Polygon getPolygon()
  {
    return this.polygon;
  }
}

class RenderableObject : RotatedObject
{
  public this(string type, string name, vec3d position, vec3d rotation)
  {
    super(type, name, position, rotation);
  }

  public this(string name, vec3d position, vec3d rotation)
  {
    this("unitd.core.RenderableObject", name, position, rotation);
  }

  public this(vec3d position, vec3d rotation)
  {
    this("RenderableObject", position, rotation);
  }

  public this(vec3d rotation)
  {
    this(vec3d(0,0,0), rotation);
  }

  public this()
  {
    this(vec3d(0,0,0));
  }

  public void preRender()
  {

  }

  public void render()
  {

  }

  public void postRender()
  {

  }

}

class RotatedObject : PositionedObject
{

  protected vec3d rotation;

  public this(string type, string name, vec3d position, vec3d rotation)
  {
    super(type, name, position);
    this.rotation = rotation;
  }

  public this(string name, vec3d position, vec3d rotation)
  {
    this("unitd.core.RotatedObject", name, position, rotation);
  }

  public this(vec3d position, vec3d rotation)
  {
    this("RotatedObject", position, rotation);
  }

  public this(vec3d rotation)
  {
    this(vec3d(0,0,0), rotation);
  }

  public this()
  {
    this(vec3d(0,0,0));
  }

  public vec3d getRotation()
  {
    return this.rotation;
  }

  public vec3d rotate(vec3d rotation)
  {
    return (this.rotation = (this.rotation + rotation));
  }

  public void setRotation(vec3d rotation)
  {
    this.rotation = rotation;
  }

  public override string str()
  {
    JSONValue jv = parseJSON(super.str());
    jv.object["rotation"] = [
      "x": this.rotation.x,
      "y": this.rotation.y,
      "z": this.rotation.z
    ];
    return toJSON(jv);
  }

  override bool opEquals(Object obj)
  {
    if(super.opEquals(obj))
    {
      RotatedObject ro = cast(RotatedObject) obj;
      return (ro.getRotation() == this.getRotation());
    }
    return false;
  }

}

class PositionedObject : NamedObject
{

  protected vec3d position;

  public this(string type, string name, vec3d position)
  {
    super(type, name);
    this.position = position;
  }

  public this(string name, vec3d position)
  {
    this("unitd.core.PositionedObject", name, position);
  }

  public this(vec3d position)
  {
    this("PositionedObject", position);
  }

  public this()
  {
    this(vec3d(0,0,0));
  }

  public vec3d getPosition()
  {
    return this.position;
  }

  public override string str()
  {
    JSONValue jv = parseJSON(super.str());
    jv.object["position"] = [
      "x": this.position.x,
      "y": this.position.y,
      "z": this.position.z
    ];
    return toJSON(jv);
  }

  override bool opEquals(Object obj)
  {
    if(super.opEquals(obj))
    {
      PositionedObject po = cast(PositionedObject)obj;
      return po.getPosition() == this.getPosition();
    }
    return false;
  }

}

class NamedObject : TypedObject
{

  protected string name;

  public this(string type, string name)
  {
    super(type);
    this.name = name;
  }

  public this(string name)
  {
    this("unitd.core.NamedObject", name);
  }

  public string getName()
  {
    return this.name;
  }

  public override string str()
  {
    JSONValue jv = parseJSON(super.str());
    jv.object["name"] = this.name;
    return toJSON(jv);
  }

  override bool opEquals(Object obj)
  {
    if(super.opEquals(obj))
    {
      NamedObject no = cast(NamedObject)obj;
      return no.getName() == this.getName();
    }
    return false;
  }

}

class TypedObject
{

  protected string type;

  public this(string type)
  {
    this.type = type;
  }

  public string typ()
  {
    return this.type;
  }

  public string str()
  {
    JSONValue jv = ["type": this.type];
    return toJSON(jv);
  }

  public static TypedObject load(string str)
  {
    TypedObject tr = new TypedObject(null);
    JSONValue jv = parseJSON(str);
    tr.type = jv.object["type"].str();
    return tr;
  }

  override bool opEquals(Object obj)
  {
    if(cast(TypedObject)obj) {
      TypedObject to = cast(TypedObject)obj;
      return to.type == this.type;
    }
    return false;
  }

}

class Renderable : Destroyable
{
  public void pre()
  {}
  public void render(float dt)
  {}
  public void post()
  {}
}

class Destroyable
{
  protected bool isDestroyed;

  public this()
  {
    this.isDestroyed = false;
  }
  bool destroyed()
  {
    return this.isDestroyed;
  }
  void destroy()
  {
    this.isDestroyed = true;
  }
}
