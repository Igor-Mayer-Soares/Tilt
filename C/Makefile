# Nome do executável
TARGET = MyProgram.exe

# Diretórios
SRCDIR = src
LIBDIR = lib
OBJDIR = obj

# Compilador e flags
CC = gcc
CFLAGS_RELEASE = -Wall -O2 -I$(LIBDIR) # Flags para compilação normal
CFLAGS_DEBUG = -Wall -g -I$(LIBDIR)   # Flags para depuração

# Lista de arquivos .c
SRC = $(SRCDIR)\gnc.c $(SRCDIR)\atp.c $(SRCDIR)\math_utils.c $(SRCDIR)\pid.c

# Lista de arquivos .obj correspondentes
OBJ = $(OBJDIR)\gnc.obj $(OBJDIR)\atp.obj $(OBJDIR)\math_utils.obj $(OBJDIR)\pid.obj

# Regra padrão
!IF "$(MODE)" == "debug"
CFLAGS = $(CFLAGS_DEBUG)
!ELSE
CFLAGS = $(CFLAGS_RELEASE)
!ENDIF

# Regra padrao
all: $(OBJDIR) $(TARGET)

# Cria o executável a partir dos arquivos objeto
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $(TARGET)

# Cria o diretório obj se nao existir
$(OBJDIR):
	@if not exist $(OBJDIR) mkdir $(OBJDIR)

# Regra explícita para compilar os arquivos fonte
$(OBJDIR)\gnc.obj: $(SRCDIR)\gnc.c
	$(CC) $(CFLAGS) -c $(SRCDIR)\gnc.c -o $(OBJDIR)\gnc.obj

$(OBJDIR)\atp.obj: $(SRCDIR)\atp.c
	$(CC) $(CFLAGS) -c $(SRCDIR)\atp.c -o $(OBJDIR)\atp.obj

$(OBJDIR)\pid.obj: $(SRCDIR)\pid.c
	$(CC) $(CFLAGS) -c $(SRCDIR)\pid.c -o $(OBJDIR)\pid.obj

$(OBJDIR)\math_utils.obj: $(SRCDIR)\math_utils.c
	$(CC) $(CFLAGS) -c $(SRCDIR)\math_utils.c -o $(OBJDIR)\math_utils.obj

# Limpeza dos arquivos compilados
clean:
	@if exist $(OBJDIR) rmdir /S /Q $(OBJDIR)
	@if exist $(TARGET) del $(TARGET)
