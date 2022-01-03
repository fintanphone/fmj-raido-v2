file(REMOVE_RECURSE
  "bootloader/bootloader.bin"
  "bootloader/bootloader.elf"
  "bootloader/bootloader.map"
  "config/sdkconfig.cmake"
  "config/sdkconfig.h"
  "flash_project_args"
  "persistent_sockets.bin"
  "persistent_sockets.map"
  "project_elf_src_esp32.c"
  "CMakeFiles/persistent_sockets.elf.dir/project_elf_src_esp32.c.obj"
  "persistent_sockets.elf"
  "persistent_sockets.elf.pdb"
  "project_elf_src_esp32.c"
)

# Per-language clean rules from dependency scanning.
foreach(lang C)
  include(CMakeFiles/persistent_sockets.elf.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
