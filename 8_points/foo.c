#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int THRESHOLD = RAND_MAX - 10;

// ПРОГРАММА ЗАПУСКАЕТСЯ И ИСПОЛНЯЕТСЯ КОРРЕКТНО ПРИ НАЛИЧИИ ФАЙЛА input.txt
void get_array_size(int* size, FILE *input) {
	// scanf("%d", size);
	fscanf(input, "%d", size);
}

void get_array(int* a, int size, FILE *input) {
	for (int i = 0; i < size; ++i) {
		// scanf("%d", &(a[i]));
		fscanf(input, "%d", &(a[i]));
	}
}

void get_random_array(int* a, int size) {
	for (int i = 0; i < size; ++i) {
		// scanf("%d", &(a[i]));
		a[i] = rand() % 100 - 50;
	}
}

void create_new_arr(int* a, int* b, int size_a) {
	int j = 0;
	for (int i = 1; i < size_a; ++i) {
		if (a[i] != a[0] && a[i] != a[size_a-1]) {
			b[j] = a[i];
			++j;
		}
	}
}

void print_array(int* a, int size, FILE* output) {
	for (int i = 0; i < size; ++i) {
		fprintf(output, "%d ", a[i]);
		printf("%d ", a[i]);
	}
}

int main(int argc, char** argv) {
	if (argc != 4) {  // argv[0] is the name of executed file
        	printf("Command line must have 3 arguements - names of files input/output & seed for generator \n");
        	return 1;
        }
        
	int n, seed;
	seed = atoi(argv[3]);
	srand(seed);
	
	FILE *input, *output;
	input = fopen(argv[1], "r");
	get_array_size(&n, input);  // n читаем из файла
	int a[n];
	// get_array(a, n, input);
	fclose(input);
	
	 
	clock_t t;
        t = clock();  // НАЧАЛО ЗАМЕРА ВРЕМЕНИ
	get_random_array(a, n);  // массив генерим сами
	int needed_arguements_quality = 0;
	for (int i = 1; i < n-1; ++i) {
		if (a[i] != a[0] && a[i] != a[n-1]) {
			++needed_arguements_quality;
		}
	}
	// ДОП НАГРУЗКА (для замедления работы программы до минимум 1-ой секунды):
	const int quantity_of_cycles = 300000000;
	for (int j = 0; j < quantity_of_cycles; ++j) {
		needed_arguements_quality = 0;
		for (int i = 1; i < n-1; ++i) {
			if (a[i] != a[0] && a[i] != a[n-1]) {
				++needed_arguements_quality;
			}
		}
	}
	// КОНЕЦ ДОП. НАГРУЗКИ
	int b[needed_arguements_quality];
	create_new_arr(a, b, n);
	t = clock() - t;  // КОНЕЦ ЗАМЕРА ВРЕМЕНИ
	
	double time_taken = ((double) t)/ CLOCKS_PER_SEC; // in seconds
	
	output = fopen(argv[2], "w");
	print_array(b, needed_arguements_quality, output);
	fclose(output);
	
	printf("TIME: %f sec", time_taken); 
	
	return 0;
}
