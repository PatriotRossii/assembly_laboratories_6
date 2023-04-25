#include <cstdint>

using namespace std;

extern "C" int IntegerDiv_(
    uint8_t a, uint16_t b, uint32_t c, uint64_t d,
    uint8_t e, uint16_t f, uint32_t g, uint64_t h,
    uint64_t* quo, uint64_t* rem
) {
    int mul = a * b * c * d;
    int div = e + f + g + h;

    *quo = mul / div;
    *rem = mul % div;

    return 0;
}