#include <iostream>
#include <iomanip>
#include <bitset>
#include <cstdint>

using namespace std;

extern "C" int IntegerDiv_(
	uint8_t a, uint16_t b, uint32_t c, uint64_t d,
	uint8_t e, uint16_t f, uint32_t g, uint64_t h,
	uint64_t* quo, uint64_t* rem
);
static void PrintResult(
	const char* msg,
	int rc, uint64_t* quo, uint64_t* rem
) {
	cout << msg << '\n';

	if (rc == 1) {
		cout << "Ошибка: деление на ноль" << '\n';
		return;
	}

	cout << "Целая часть: " << *quo << '\n';
	cout << "Остаток: " << *rem << '\n';

	cout << std::endl;
}

int main() {
	{
		uint8_t a = 15, e = 7;
		uint16_t b = 125, f = 255;
		uint32_t c = 5000, g = 386;
		uint64_t h = 10000, d = 22, quo, rem;

		int rc = IntegerDiv_(a, b, c, d, e, f, g, h, &quo, &rem);
		PrintResult("Пример 1", rc, &quo, &rem);
	}
	{
		uint8_t a = 89, e = 255;
		uint16_t b = 125, f = 1299;
		uint32_t c = 432, g = 1024;
		uint64_t h = 116204, d = 45, quo, rem;

		int rc = IntegerDiv_(a, b, c, d, e, f, g, h, &quo, &rem);
		PrintResult("Пример 2", rc, &quo, &rem);
	}
	{
		uint8_t a = 89, e = 0;
		uint16_t b = 125, f = 0;
		uint32_t c = 432, g = 0;
		uint64_t h = 0, d = 45, quo, rem;

		int rc = IntegerDiv_(a, b, c, d, e, f, g, h, &quo, &rem);
		PrintResult("Пример 3", rc, &quo, &rem);
	}

}