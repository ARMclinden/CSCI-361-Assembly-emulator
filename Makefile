# --- Configuration ---
NASM     = "c:\program files\nasm\nasm.exe"
# Path for lld-link.exe
LINK     = lib/lld-link.exe

OBJ_DIR  = build32
SRC_DIR  = src
LIBS     = lib\msvcrt.lib lib\kernel32.lib lib\interupt.obj

# Flagi
# -g -F cv8 for NASM gives PDB for lld-link
NASM_FLAGS = -f win32 -g -F cv8
LINK_FLAGS = /SUBSYSTEM:CONSOLE /ENTRY:main /NODEFAULTLIB /DYNAMICBASE:NO /DEBUG /PDB:$(OBJ_DIR)\main.pdb

# --- Building rules ---
all: main.exe

main.exe: $(OBJ_DIR)\main.obj
	".\$(LINK)" $(OBJ_DIR)\main.obj $(LIBS) $(LINK_FLAGS) /OUT:"$(OBJ_DIR)\main.exe"

$(OBJ_DIR)\main.obj: $(SRC_DIR)\main.asm | $(OBJ_DIR)
	$(NASM) $(NASM_FLAGS) $(SRC_DIR)\main.asm -o $(OBJ_DIR)\main.obj

$(OBJ_DIR):
	mkdir $(OBJ_DIR)

clean:
	del /q $(OBJ_DIR)\*.* main.exe