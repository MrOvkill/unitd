import unitd.window;
import unitd.core;
import unitd.event;

import derelict.opengl;

import std.stdio;

class FlatQuad : Renderable
{
  public override void render(float dt)
  {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(0.3f, 0.3f, 0.3f, 0.3f);
  }
}

int main(string[] args)
{
  UDInit();
  writefln("new NamedObject('frank').str() = %s", new RotatedObject().str());
  writefln("loading TypedObject('frank').str() into TypedObject = %s", TypedObject.load(new TypedObject("frank").str()).str());
  UDWindow window = new UDWindow("Hello, world!", 800, 600);
  window.show();
  window.addRenderable(new FlatQuad());
  window.mainLoop();
  window.destroy();
  return 0;
}
