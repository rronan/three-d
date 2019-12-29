uniform mat4 modelMatrix;

layout (std140) uniform Camera
{
    mat4 viewProjection;
    mat4 view;
    mat4 projection;
    vec3 position;
    float padding;
} camera;

in vec3 position;
in vec2 uv_coordinate;

out vec2 uv;

mat3 rotation(vec3 source_dir, vec3 target_dir)
{
    float c = dot(target_dir, source_dir);
    float s = cross(target_dir, source_dir).y;
    return mat3(c, 0.0, s,
                0.0,  1.0, 0.0,
                -s,  0.0,  c);
}

void main()
{
    uv = uv_coordinate;
    vec3 dir = normalize(vec3(camera.position.x - modelMatrix[0][3], 0.0, camera.position.z - modelMatrix[2][3]));
    gl_Position = camera.viewProjection * modelMatrix * vec4(rotation(vec3(0.0, 0.0, 1.0), dir) * position, 1.);
}