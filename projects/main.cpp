#include <fmt/format.h>
#include <fmt/color.h>

int main()
{
    fmt::print(fg(fmt::color::crimson) | fmt::emphasis::bold,
               "Hello, {}!\n", "world");
    fmt::print(fg(fmt::color::floral_white) | fmt::emphasis::bold,
               "םולש, {}!\n", "םלוע");
    return 0;
}
