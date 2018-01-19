module unitd.camera;

import gfm.math;

class Camera
{
  public vec3d position;
  public vec3d rotation;

  public this(vec3d position)
  {
    this.position = position;
  }
}
