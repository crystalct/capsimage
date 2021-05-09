TARGET		:=	libcapsimg.a
CSOURCES	:= $(wildcard src/Codec/*.c) $(wildcard src/CAPSImg/*.c) $(wildcard src/Core/*.c) $(wildcard src/Device/*.c) $(wildcard src/Core/*.c) $(wildcard src/LibIPF/*.c)
CPPSOURCES	:= $(wildcard src/CAPSImg/*.cpp)  $(wildcard src/Codec/*.cpp) $(wildcard src/Core/*.cpp) $(wildcard src/Device/*.cpp)
INCLUDES	:=	src src/CAPSImg src/Codec src/Core src/Device src/Core src/LibIPF
ENDIANNESS_DEFINES =  -DWORDS_BIGENDIAN
CC = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-gcc.exe
CC_AS = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-gcc.exe
CXX = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-g++.exe
AR = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-ar.exe

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------

CFLAGS		=	-O3 -Wall -DPS3 -D__CELLOS_LV2__ $(MACHDEP) $(INCLUDE) \
			
CXXFLAGS	=	$(CFLAGS) -Wno-sign-compare -Wno-missing-braces -Wno-parentheses

#---------------------------------------------------------------------------------
# build a list of include paths
#---------------------------------------------------------------------------------
export INCLUDE	:=	$(foreach dir,$(INCLUDES), -I$(CURDIR)/$(dir)) \
					$(foreach dir,$(LIBDIRS),-I$(dir)/include) \
					-I$(CURDIR)/$(BUILD) -I$(CELL_SDK)/target/ppu/include 

OBJS = $(CSOURCES:.c=.o) $(CPPSOURCES:.cpp=.o)

.PHONY: $(TARGET) clean

#---------------------------------------------------------------------------------
$(TARGET): $(OBJS)
	$(AR) rcs $@ $^
	
#---------------------------------------------------------------------------------
clean:
	@echo clean ...
	@rm -fr src/CAPSImg/*.o src/Codec/*.o src/Core/*.o src/Device/*.o
	@rm -fr *.a


