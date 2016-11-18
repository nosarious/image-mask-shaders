# image-mask-shaders
a Processing sketch to test two shaders masked over video

processing has grown quite a bit since I first met it in 2010 or so. Even so, there are a few things which feel missing.

One of which is the use of shaders for handling some processing-intensive tasks, such as masking.

I am used to openframeworks, and while processing can do some things, it certainly isn't very easy.

None the less, here is a test with two masked shaders over video from the camera.

The shaders are rendered into two seperate fram buffers (PGraphics) which are then placed into a masking shader.

The shaders are modified ones I found on shadertoy. I left the authors names intact present them only to test this theory.


