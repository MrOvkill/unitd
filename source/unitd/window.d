module unitd.window;

import unitd.event;
import unitd.core;

import derelict.sdl2.sdl;
import derelict.opengl;

import std.conv;
import std.string;

void UDInit()
{
  DerelictSDL2.load();
  DerelictGL3.load();
}

class UDWindow
{

  public string title;
  public int width;
  public int height;

  public SDL_Window* window;
  public SDL_GLContext context;

  public bool shouldClose;

  public Renderable[] renderables;

  public this(string title, int width, int height)
  {
    this.title = title;
    this.width = width;
    this.height = height;
    this.shouldClose = false;
    this.renderables = [];
  }

  public void addRenderable(Renderable renderable)
  {
    this.renderables ~= renderable;
  }

  public void show()
  {
    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);
    SDL_GL_SetSwapInterval(1);
    this.window = SDL_CreateWindow(
      toStringz(this.title),
      SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
      this.width, this.height,
      SDL_WINDOW_OPENGL
    );
    this.context = SDL_GL_CreateContext(this.window);
    DerelictGL3.reload();
    glEnable(GL_DEPTH_TEST);
  }

  public void mainLoop()
  {
    SDL_Event e;
    while(!this.shouldClose)
    {
      while( SDL_PollEvent( &e ) != 0 )
      {
        if( e.type == SDL_QUIT )
        {
            this.shouldClose = true;
        }
      }

      for(int i = 0; i < this.renderables.length; i++)
      {
        this.renderables[i].pre();
      }

      for(int i = 0; i < this.renderables.length; i++)
      {
        this.renderables[i].render(10);
      }

      for(int i = 0; i < this.renderables.length; i++)
      {
        this.renderables[i].post();
      }

      SDL_GL_SwapWindow(this.window);
    }
  }

  public void destroy()
  {
    SDL_DestroyWindow(this.window);
    SDL_Quit();
  }
}
