Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Mar 2015 01:32:22 +0100
Message-ID: <CAJZ5v0jUbdNRvoYwW=LrC+fnyAB2=OEO6yidNNFnKhugZx_D1A@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for 4.0-rc5
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
 pm+acpi-4.0-rc5

to receive power management and ACPI fixes for v4.0-rc5 with top-most
commit 9c86286a60b28bd25cb1c70eb2aba34f182d1063

 Merge branches 'pm-cpuidle', 'powercap', 'irq-pm' and 'acpi-resources'

on top of commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda

 Linux 4.0-rc4

These are fixes for recent regressions (PCI/ACPI resources and
at91 RTC locking), a stable-candidate powercap RAPL driver fix
and two ARM cpuidle fixes (one stable-candidate too).

Specifics:

 - Revert a recent PCI commit related to IRQ resources management
   that introduced a regression for drivers attempting to bind to
   devices whose previous drivers did not balance pci_enable_device()
   and pci_disable_device() as expected (Rafael J Wysocki).

 - Fix a deadlock in at91_rtc_interrupt() introduced by a typo in a
   recent commit related to wakeup interrupt handling (Dan Carpenter).

 - Allow the power capping RAPL (Running-Average Power Limit) driver
   to use different energy units for domains within one CPU package
   which is necessary to handle Intel Haswell EP processors correctly
   (Jacob Pan).

 - Improve the cpuidle mvebu driver's handling of Armada XP SoCs by
   updating the target residency and exit latency numbers for those
   chips (Sebastien Rannou).

 - Prevent the cpuidle mvebu driver from calling cpu_pm_enter() twice
   in a row before cpu_pm_exit() is called on the same CPU which
   breaks the core's assumptions regarding the usage of those
   functions (Gregory Clement).

Thanks!


---------------

Dan Carpenter (1):
      rtc: at91rm9200: double locking bug in at91_rtc_interrupt()

Gregory CLEMENT (1):
      cpuidle: mvebu: Fix the CPU PM notifier usage

Jacob Pan (1):
      powercap / RAPL: handle domains with different energy units

Rafael J. Wysocki (1):
      Revert "x86/PCI: Refine the way to release PCI IRQ resources"

Sebastien Rannou (1):
      cpuidle: mvebu: Update cpuidle thresholds for Armada XP SOCs

---------------

 arch/x86/include/asm/pci_x86.h     |  2 ++
 arch/x86/pci/common.c              | 34 +++++-------------------
 arch/x86/pci/intel_mid_pci.c       |  4 +--
 arch/x86/pci/irq.c                 | 15 ++++++++++-
 drivers/acpi/pci_irq.c             |  9 ++++++-
 drivers/cpuidle/cpuidle-mvebu-v7.c | 12 ++++-----
 drivers/powercap/intel_rapl.c      | 54 +++++++++++++++++++++++++++-----------
 drivers/rtc/rtc-at91rm9200.c       |  2 +-
 8 files changed, 78 insertions(+), 54 deletions(-)
