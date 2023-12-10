#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* Opens the input file given as the first argument, defaulting to './input'. */
FILE*
open_input(int argc, char** argv)
{
  char input_path[256] = {0};

  if (argc < 2) {
    strncpy(input_path, "./input", 256);
  } else {
    strncpy(input_path, argv[1], 256);
  }

  printf("Using '%s' as input\n", input_path);

  FILE* input = fopen(input_path, "r");
  if (input == NULL) {
    printf("Error: could not open input from '%s'\n", input_path);
    exit(1);
  }

  return input;
}

typedef struct record {
  long time;
  long distance;
  struct record* next;
} record_t;

/* Parses the input file into a linked list of records. */
record_t*
parse_records_a(FILE* input)
{
  record_t* head = NULL;
  record_t* tail = NULL;

  /* Time: 2 4 3 ... */
  char times_line[256] = {0};
  if (fgets(times_line, 256, input) == NULL) {
    printf("Error: could not read times line\n");
    exit(1);
  }

  /* Distance: 12 34 32 ... */
  char distances_line[256] = {0};
  if (fgets(distances_line, 256, input) == NULL) {
    printf("Error: could not read distances line\n");
    exit(1);
  }

  char* times = strtok_r(times_line + 6, " ", (char**) &times_line);
  char* distances = strtok_r(distances_line + 10, " ", (char**) &distances_line);

  while (times != NULL && distances != NULL) {
    record_t* record = malloc(sizeof(record_t));
    record->time = atol(times);
    record->distance = atol(distances);
    record->next = NULL;

    if (head == NULL) {
      head = record;
      tail = record;
    } else {
      tail->next = record;
      tail = record;
    }

    times = strtok_r(NULL, " ", (char **) &times_line);
    distances = strtok_r(NULL, " ", (char **) &distances_line);
  }

  return head;
}

/* Parses the input file, ignoring whitespace, into a linked list with a single record. */
record_t*
parse_records_b(FILE* input)
{
  char times_line[256] = {0};
  if (fgets(times_line, 256, input) == NULL) {
    printf("Error: could not read times line\n");
    exit(1);
  }

  char distances_line[256] = {0};
  if (fgets(distances_line, 256, input) == NULL) {
    printf("Error: could not read distances line\n");
    exit(1);
  }

  int i, j;
  char time_string[256] = {0};
  for (i = 0, j = 0; i < strlen(times_line); ++i) {
    if (isdigit(times_line[i])) {
      time_string[j++] = times_line[i];
    }
  }
  time_string[j] = '\0';

  char distance_string[256] = {0};
  for (i = 0, j = 0; i < strlen(distances_line); ++i) {
    if (isdigit(distances_line[i])) {
      distance_string[j++] = distances_line[i];
    }
  }
  distance_string[j] = '\0';

  record_t* record = malloc(sizeof(record_t));
  record->time = atol(time_string);
  record->distance = atol(distance_string);
  record->next = NULL;

  return record;
}

/* Returns the number of possible ways to beat the record. */
int
possible_wins(record_t* record)
{
  long wins = 0;

  for (long hold = 0; hold < record->time; ++hold) {
    long speed = hold;
    long remaining = record->time - hold;
    long distance = remaining * speed;

    if (distance > record->distance) {
      ++wins;
    }
  }

  return wins;
}

/* Returns the product of the number of possible ways to beat each record. */
int
product_of_possible_wins(record_t* record)
{
  long product = 1;

  while (record != NULL) {
    product *= possible_wins(record);
    record = record->next;
  }

  return product;
}

/* Solves the puzzle given an input file and a parsing function. */
long
solve(FILE* input, record_t* (*parse)(FILE*))
{
  rewind(input);

  record_t* records = parse(input);

  return product_of_possible_wins(records);
}

int
main(int argc, char** argv)
{
  FILE* input = open_input(argc, argv);

  /* Part A */
  long part_a = solve(input, *parse_records_a);
  printf("Part A: %ld\n", part_a);

  /* Part B */
  long part_b = solve(input, *parse_records_b);
  printf("Part B: %ld\n", part_b);

  fclose(input);

  exit(0);
}
