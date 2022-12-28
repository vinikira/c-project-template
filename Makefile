CC := gcc
SRC_DIR := src
TEST_DIR := test
BUILD_DIR := build
BIN_DIR := bin
TARGET := $(BIN_DIR)/runner
TESTER := $(BIN_DIR)/tester

SRC_EXT := c
TEST_EXT := c
SOURCES := $(shell find $(SRC_DIR) -type f -name *.$(SRC_EXT))
OBJECTS := $(patsubst $(SRC_DIR)/%, $(BUILD_DIR)/%, $(SOURCES:.$(SRC_EXT)=.o))
CFLAGS := -g -Wall -Werror -std=c11 -pedantic -static
LIB := -pthread -L lib 
INC := -I include

$(TARGET): $(OBJECTS)
	@mkdir -p $(BIN_DIR)
	@echo " Linking..."
	@echo " $(CC) $(CFLAGS) $^ -o $(TARGET) $(LIB)"; $(CC) $(CFLAGS) $^ -o $(TARGET) $(LIB)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT)
	@mkdir -p $(BUILD_DIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<";  $(CC) $(CFLAGS) $(INC) -c -o $@ $<

$(TESTER):
	$(CC) $(CFLAGS) $(TEST_DIR)/%.$(TEST_EXT)

clean:
	@echo " Cleaning..."
	@echo "$(RM) -r $(BUILD_DIR) $(TARGET) $(BIN_DIR)"; $(RM) -r $(BUILD_DIR) $(TARGET) $(BIN_DIR)

.PHONY: clean
