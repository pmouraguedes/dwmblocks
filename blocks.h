// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/

    {"", "~/software/dwmblocks/scripts/sprint_progress.sh", 1200, 0},

    {"󰋊 ", "df -h / | awk 'NR==2 {printf \"%s/%s\", $3, $2}'", 30, 0},

    {"RAM: ",
     "free -h | awk '/^Mem/ {printf \"%s/%s\", $3, $2}' | sed 's/i//g'", 30, 0},

    {" ", "~/software/dwmblocks/scripts/cpu.sh", 10, 0},

    {"", "~/software/dwmblocks/scripts/igpu.sh", 10, 0},

    // {"", "~/software/dwmblocks/scripts/egpu.sh", 10, 0},

    {"", "~/software/dwmblocks/scripts/wifi.sh", 10, 0},

    {"", "~/software/dwmblocks/scripts/vpn.sh", 10, 0},

    {"  ",
     "cat /sys/class/power_supply/BAT0/capacity | awk '{print $1\"%\"}'", 60,
     0},

    {" ", "~/software/dwmblocks/scripts/packages.sh", 7200, 0},

    {"", "~/software/dwmblocks/scripts/weather.sh", 1200, 0},

    {"", "date '+%F %T'", 1, 0},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
