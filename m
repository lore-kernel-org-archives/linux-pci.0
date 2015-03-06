Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Mar 2015 16:16:57 +0100
Message-ID: <CAJZ5v0htZRux=ZADN8+k3VcNsyadhQiv2iOpBz6zhNO3VDp7VQ@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for 4.0-rc3
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.0-rc3

to receive power management and ACPI fixes for v4.0-rc1 with top-most
commit e178e7d6df38dab67f51df4282927c4c7392879f

 Merge branches 'pm-domains' and 'pm-cpufreq'

on top of commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b

 Linux 4.0-rc2

These are fixes for recent regressions (ACPI resources management,
suspend-to-idle), stable-candidate fixes (ACPI backlight), fixes
related to the wakeup IRQ management changes made in v3.18, other
fixes (suspend-to-idle, cpufreq ppc driver) and a couple of cleanups
(suspend-to-idle, generic power domains, ACPI backlight).

Specifics:

 - Fix ACPI resources management problems introduced by the recent
   rework of the code in question (Jiang Liu) and a build issue
   introduced by those changes (Joachim Nilsson).

 - Fix a recent suspend-to-idle regression on systems where entering
   idle states causes local timers to stop, prevent suspend-to-idle
   from crashing in restricted configurations (no cpuidle driver,
   cpuidle disabled etc.) and clean up the idle loop somewhat while
   at it (Rafael J Wysocki).

 - Fix build problem in the cpufreq ppc driver (Geert Uytterhoeven).

 - Allow the ACPI backlight driver module to be loaded if ACPI is
   disabled which helps the i915 driver in those configurations
   (stable-candidate) and change the code to help debug unusual use
   cases (Chris Wilson).

 - Wakeup IRQ management changes in v3.18 caused some drivers on the
   at91 platform to trigger a warning from the IRQ core related to
   an unexpected combination of interrupt action handler flags.
   However, on at91 a timer IRQ is shared with some other devices
   (including system wakeup ones) and that leads to the unusual
   combination of flags in question.  To make it possible to avoid
   the warning introduce a new interrupt action handler flag (which
   can be used by drivers to indicate the special case to the core)
   and rework the problematic at91 drivers to use it and work as
   expected during system suspend/resume.  From Boris Brezillon,
   Rafael J Wysocki and Mark Rutland.

 - Clean up the generic power domains subsystem's debugfs interface
   (Kevin Hilman).

Thanks!


---------------

Boris BREZILLON (6):
      PM / wakeup: export pm_system_wakeup symbol
      rtc: at91sam9: rework wakeup and interrupt handling
      rtc: at91rm9200: rework wakeup and interrupt handling
      clk: at91: implement suspend/resume for the PMC irqchip
      watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
      tty: serial: atmel: rework interrupt and wakeup handling

Chris Wilson (2):
      ACPI / video: Load the module even if ACPI is disabled
      ACPI / video: Propagate the error code for acpi_video_register

Geert Uytterhoeven (1):
      cpufreq: ppc: Add missing #include <asm/smp.h>

Jiang Liu (2):
      x86/PCI/ACPI: Ignore resources consumed by host bridge itself
      x86/PCI/ACPI: Relax ACPI resource descriptor checks to work
around BIOS bugs

Joachim Nilsson (1):
      PCI: versatile: Update for list_for_each_entry() API change

Kevin Hilman (1):
      PM / Domains: cleanup: rename gpd -> genpd in debugfs interface

Mark Rutland (2):
      genirq / PM: better describe IRQF_NO_SUSPEND semantics
      genirq / PM: describe IRQF_COND_SUSPEND

Rafael J. Wysocki (5):
      idle / sleep: Avoid excessive disabling and enabling interrupts
      cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too
      cpuidle: Clean up fallback handling in cpuidle_idle_call()
      genirq / PM: Add flag for shared NO_SUSPEND interrupt lines
      cpuidle / sleep: Use broadcast timer for states that stop local timer

---------------

 Documentation/power/suspend-and-interrupts.txt | 22 ++++++--
 arch/x86/pci/acpi.c                            | 11 ++--
 drivers/acpi/resource.c                        |  4 +-
 drivers/acpi/video.c                           | 20 +++++--
 drivers/base/power/domain.c                    | 24 ++++-----
 drivers/base/power/wakeup.c                    |  1 +
 drivers/clk/at91/pmc.c                         | 20 ++++++-
 drivers/clk/at91/pmc.h                         |  1 +
 drivers/cpufreq/ppc-corenet-cpufreq.c          |  2 +
 drivers/cpuidle/cpuidle.c                      | 61 +++++++++------------
 drivers/pci/host/pci-versatile.c               |  2 +-
 drivers/rtc/rtc-at91rm9200.c                   | 62 +++++++++++++++++-----
 drivers/rtc/rtc-at91sam9.c                     | 73 +++++++++++++++++++++-----
 drivers/tty/serial/atmel_serial.c              | 49 +++++++++++++++--
 drivers/watchdog/at91sam9_wdt.c                |  3 +-
 include/linux/cpuidle.h                        | 17 +++++-
 include/linux/interrupt.h                      |  9 +++-
 include/linux/irqdesc.h                        |  1 +
 kernel/irq/manage.c                            |  7 ++-
 kernel/irq/pm.c                                |  7 ++-
 kernel/sched/idle.c                            | 54 +++++++++++--------
 21 files changed, 331 insertions(+), 119 deletions(-)
