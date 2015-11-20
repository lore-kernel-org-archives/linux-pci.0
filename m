Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Nov 2015 15:46:09 +0100
Message-ID: <CAJZ5v0juTw+mUuKhX=g=Rg2Fb2s09UCBCZPbOFEkSguA20GYYg@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.4-rc2
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-rc2

to receive power management and ACPI material for v4.4-rc2 with
top-most commit a3767e3c9da514e63e898772b72b932f9eb3b062

 Merge branches 'acpi-smbus', 'acpi-ec' and 'acpi-pci'

on top of commit 8005c49d9aea74d382f474ce11afbbc7d7130bec

 Linux 4.4-rc1

These are mostly fixes and cleanups (ACPI core, PM core, cpufreq,
ACPI EC driver, device properties) including three reverts of recent
intel_pstate driver commits due to a regression introduced by one
of them plus support for Atom Airmont cores in intel_pstate (which
really boils down to adding new frequency tables for Airmont) and
additional turbostat updates.

Specifics:

 - Revert three recent intel_pstate driver commits one of which
   introduced a regression and the remaining two depend on the
   problematic one (Rafael Wysocki).

 - Fix breakage related to the recently introduced ACPI _CCA object
   support in the PCI DMA setup code (Suravee Suthikulpanit).

 - Fix up the recently introduced ACPI CPPC support to only
   use the hardware-reduced version of the PCCT structure as
   the only architecture to support it (ARM64) will only use
   hardware-reduced ACPI anyway (Ashwin Chaugule).

 - Fix a cpufreq mediatek driver build problem (Arnd Bergmann).

 - Fix the SMBus transaction handling implementation in the ACPI
   core to avoid re-entrant calls to wait_event_timeout() which
   makes intermittent boot stalls related to the Smart Battery
   Subsystem initialization go away and revert a workaround of
   another problem with the same underlying root cause (Chris
   Bainbridge).

 - Fix the generic wakeup interrupts framework to avoid using
   invalid IRQ numbers (Dmitry Torokhov).

 - Remove a redundant check from the ACPI EC driver (Markus Elfring).

 - Modify the intel_pstate driver so it can support more Atom flavors
   than just one (Baytrail) and add support for Atom Airmont cores
   (which require new freqnency tables) to it (Philippe Longepe).

 - Clean up MSR-related symbols in turbostat (Len Brown).

Thanks!


---------------

Arnd Bergmann (1):
      cpufreq: mediatek: fix build error

Ashwin Chaugule (1):
      ACPI / CPPC: Use h/w reduced version of the PCCT structure

Chris Bainbridge (2):
      ACPI / SMBus: Fix boot stalls / high CPU caused by reentrant code
      Revert "ACPI / SBS: Add 5 us delay to fix SBS hangs on MacBook"

Dmitry Torokhov (1):
      PM / wakeirq: check that wake IRQ is valid before accepting it

Len Brown (2):
      tools/power turbostat: use new name for MSR_PLATFORM_INFO
      x86: remove unused definition of MSR_NHM_PLATFORM_INFO

Markus Elfring (1):
      ACPI-EC: Drop unnecessary check made before calling acpi_ec_delete_query()

Philippe Longepe (2):
      cpufreq: intel_pstate: Replace BYT with ATOM
      cpufreq: intel_pstate: Add separate support for Airmont cores

Rafael J. Wysocki (3):
      Revert "cpufreq: intel_pstate: Avoid calculation for max/min"
      Revert "cpufreq: intel_pstate: Use ACPI perf configuration"
      Revert "Documentation: kernel_parameters for Intel P state driver"

Suravee Suthikulpanit (1):
      PCI: Fix OF logic in pci_dma_configure()

---------------

 Documentation/kernel-parameters.txt   |   3 -
 arch/x86/include/asm/msr-index.h      |   3 +-
 drivers/acpi/cppc_acpi.c              |   2 +-
 drivers/acpi/ec.c                     |   2 +-
 drivers/acpi/sbshc.c                  |  48 +-----
 drivers/base/power/wakeirq.c          |   6 +
 drivers/cpufreq/Kconfig.arm           |   1 +
 drivers/cpufreq/Kconfig.x86           |   1 -
 drivers/cpufreq/intel_pstate.c        | 316 ++++++++--------------------------
 drivers/pci/probe.c                   |   4 +-
 tools/power/x86/turbostat/turbostat.c |   8 +-
 11 files changed, 95 insertions(+), 299 deletions(-)
