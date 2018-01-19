module unitd.model;

import unitd.color;
import unitd.window;
import unitd.core;

import gfm.math;

class Polygon : Destroyable
{
  public vec3d[] vertices;
  public int[] indices;

  public this(vec3d[] vertices, int[] indices)
  {
    this.vertices = vertices;
    this.indices = indices;
  }

  public vec3d getVertex(int index)
  {
    return this.vertices[index];
  }

  public void setVertex(int index, vec3d value)
  {
    this.vertices[index] = value;
  }

  public int vertexCount()
  {
    return cast(int)this.vertices.length;
  }

  public int getIndex(int index)
  {
    return this.indices[index];
  }

  public void setIndex(int index, int index2)
  {
    this.indices[index] = index2;
  }

  public int indexCount()
  {
    return cast(int)this.indices.length;
  }
}

class PolygonRenderer : Renderable
{

}

class ColoredPolygon : Polygon
{
  public Color[] colors;

  public this(vec3d[] vertices, int[] indices, Color[] colors)
  {
    super(vertices, indices);
    this.colors = colors;
  }

  public Color getColor(int index)
  {
    return this.colors[index];
  }

  public void setColor(int index, Color color)
  {
    this.colors[index] = color;
  }

  public int colorCount()
  {
    return cast(int)this.colors.length;
  }
}
