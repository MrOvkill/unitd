module unitd.color;

enum Colors
{
  BLACK = new Color(0),
  DARK_GREY = new Color(.15f),
  GREY = new Color(.45f),
  LIGHT_GREY = new Color(.75f),
  OFF_WHITE = new Color(.9f),
  WHITE = new Color(1.0f)
}

class Color
{
  public float r;
  public float g;
  public float b;
  public float a;

  public this(float r, float g, float b, float a)
  {
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }

  public this(float r, float g, float b)
  {
    this(r, g, b, 1.0f);
  }

  public this(float x)
  {
    this(x, x, x, 1.0f);
  }

  public this()
  {
    this(0.0f);
  }

}
