Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33719 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcCYCAf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2016 22:00:35 -0400
MIME-Version: 1.0
Date: Fri, 25 Mar 2016 03:00:32 +0100
Message-ID: <CAJZ5v0jZxKwpdQq1fpnBZoxcaCYw4S9rsjgB9kPKRAx24A0_qg@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI material for v4.6-rc1, part 2
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc1-2

to receive the second batch of power management and ACPI updates for
v4.6-rc1 with top-most commit ee0140dc8ffc89bdc7b74a858089d5a75a654b4a

 Merge branches 'acpi-soc', 'acpi-misc', 'acpi-pci' and 'device-properties'

on top of commit 277edbabf6fece057b14fb6db5e3a34e00f42f42

 Merge tag 'pm+acpi-4.6-rc1-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

Included are fixups on top of the previous PM/ACPI pull request and
other material that didn't make into it but still should go into 4.6.

Among other things, there's a fix for an intel_pstate driver
issue uncovered by recent cpufreq changes, a workaround for a
boot hang on Skylake-H related to the handling of deep C-states
by the platform and a PCI/ACPI fix for the handling of IO port
resources on non-x86 architectures plus some new device IDs and
similar.

Specifics:

 - Fix for an intel_pstate driver issue related to the handling of
   MSR updates uncovered by the recent cpufreq rework (Rafael Wysocki).

 - cpufreq core cleanups related to starting governors and frequency
   synchronization during resume from system suspend and a locking
   fix for cpufreq_quick_get() (Rafael Wysocki, Richard Cochran).

 - acpi-cpufreq and powernv cpufreq driver updates (Jisheng Zhang,
   Michael Neuling, Richard Cochran, Shilpasri Bhat).

 - intel_idle driver update preventing some Skylake-H systems
   from hanging during initialization by disabling deep C-states
   mishandled by the platform in the problematic configurations (Len
   Brown).

 - Intel Xeon Phi Processor x200 support for intel_idle (Dasaratharaman
   Chandramouli).

 - cpuidle menu governor updates to make it always honor PM QoS
   latency constraints (and prevent C1 from being used as the
   fallback C-state on x86 when they are set below its exit latency)
   and to restore the previous behavior to fall back to C1 if the next
   timer event is set far enough in the future that was changed in 4.4
   which led to an energy consumption regression (Rik van Riel, Rafael
   Wysocki).

 - New device ID for a future AMD UART controller in the ACPI driver
   for AMD SoCs (Wang Hongcheng).

 - Rockchip rk3399 support for the rockchip-io-domain adaptive voltage
   scaling (AVS) driver (David Wu).

 - ACPI PCI resources management fix for the handling of IO space
   resources on architectures where the IO space is memory mapped
   (IA64 and ARM64) broken by the introduction of common ACPI
   resources parsing for PCI host bridges in 4.4 (Lorenzo Pieralisi).

 - Fix for the ACPI backend of the generic device properties API
   to make it parse non-device (data node only) children of an
   ACPI device correctly (Irina Tirdea).

 - Fixes for the handling of global suspend flags (introduced in 4.4)
   during hibernation and resume from it (Lukas Wunner).

 - Support for obtaining configuration information from Device Trees
   in the PM clocks framework (Jon Hunter).

 - ACPI _DSM helper code and devfreq framework cleanups (Colin Ian
   King, Geert Uytterhoeven).

Thanks!


---------------

Colin Ian King (1):
      ACPI / util: cast data to u64 before shifting to fix sign extension

Dasaratharaman Chandramouli (1):
      intel_idle: Support for Intel Xeon Phi Processor x200 Product Family

David Wu (1):
      PM / AVS: rockchip-io: add io selectors and supplies for rk3399

Geert Uytterhoeven (1):
      PM / devfreq: Spelling s/frequnecy/frequency/

Irina Tirdea (1):
      ACPI / property: fix data node parsing in acpi_get_next_subnode()

Jisheng Zhang (1):
      cpufreq: acpi-cpufreq: make Intel/AMD MSR access, io port access static

Jon Hunter (1):
      PM / clk: Add support for obtaining clocks from device-tree

Len Brown (1):
      intel_idle: prevent SKL-H boot failure when C8+C9+C10 enabled

Lorenzo Pieralisi (1):
      PCI: ACPI: IA64: fix IO port generic range check

Lukas Wunner (2):
      PM / sleep: Clear pm_suspend_global_flags upon hibernate
      ACPI / PM: Runtime resume devices when waking from hibernate

Michael Neuling (1):
      cpufreq: powernv: Define per_cpu chip pointer to optimize hot-path

Rafael J. Wysocki (6):
      intel_pstate: Do not call wrmsrl_on_cpu() with disabled interrupts
      cpuidle: menu: Fall back to polling if next timer event is near
      cpufreq: Introduce cpufreq_start_governor()
      cpufreq: Introduce cpufreq_update_current_freq()
      cpufreq: Always update current frequency before startig governor
      cpufreq: governor: Always schedule work on the CPU running update

Richard Cochran (2):
      cpufreq: Make cpufreq_quick_get() safe to call
      cpufreq: acpi-cpufreq: Clean up hot plug notifier callback

Rik van Riel (1):
      cpuidle: menu: use high confidence factors only when considering polling

Shilpasri G Bhat (1):
      cpufreq: powernv: Add sysfs attributes to show throttle stats

Wang Hongcheng (1):
      ACPI / APD: Add device HID for future AMD UART controller

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |  69 +++++++++++
 .../bindings/power/rockchip-io-domain.txt          |  11 ++
 drivers/acpi/acpi_apd.c                            |   1 +
 drivers/acpi/property.c                            |   1 +
 drivers/acpi/resource.c                            |  14 ++-
 drivers/acpi/sleep.c                               |   1 +
 drivers/acpi/utils.c                               |   2 +-
 drivers/base/power/clock_ops.c                     |  89 ++++++++++++++
 drivers/cpufreq/acpi-cpufreq.c                     |  18 +--
 drivers/cpufreq/cpufreq.c                          |  98 ++++++++-------
 drivers/cpufreq/cpufreq_governor.c                 |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  73 ++++++-----
 drivers/cpufreq/powernv-cpufreq.c                  | 124 +++++++++++++------
 drivers/cpuidle/governors/menu.c                   |  50 ++++----
 drivers/devfreq/Kconfig                            |   2 +-
 drivers/idle/intel_idle.c                          | 133 +++++++++++++++++----
 drivers/power/avs/rockchip-io-domain.c             |  58 +++++++++
 include/linux/pm_clock.h                           |   9 ++
 kernel/power/hibernate.c                           |   1 +
 19 files changed, 593 insertions(+), 163 deletions(-)
