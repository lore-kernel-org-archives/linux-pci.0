Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jul 2017 15:03:33 +0200
Message-ID: <CAJZ5v0gqGooQGdBJw8jV77BPB5gwKUDKBas5N8VM-P7gQQ=8VA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.13-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-fixes-4.13-rc1

with top-most commit 6df609b24b23845d2ad85b01814e7ad27f607e92

 Merge branches 'pm-qos' and 'pm-devfreq'

on top of commit 1633b396105b69efe8bfc83e33662276cc8a7675

 Merge tag 'pm-extra-4.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for v4.13-rc1.

These fix a recently exposed issue in the PCI device wakeup code and
one older problem related to PCI device wakeup that has been reported
recently, modify one more piece of computations in intel_pstate to get
rid of a rounding error, fix a possible race in the schedutil cpufreq
governor, fix the device PM QoS sysfs interface to correctly handle
invalid user input, fix return values of two probe routines in
devfreq drivers and constify an attribute_group structure in devfreq.

Specifics:

 - Avoid clearing the PCI PME Enable bit for devices as a result of
   config space restoration which confuses AML executed afterward and
   causes wakeup events to be lost on some systems (Rafael Wysocki).

 - Fix the native PCIe PME interrupts handling in the cases when the
   PME IRQ is set up as a system wakeup one so that runtime PM remote
   wakeup works as expected after system resume on systems where that
   happens (Rafael Wysocki).

 - Fix the device PM QoS sysfs interface to handle invalid user input
   correctly instead of using an unititialized variable value as the
   latency tolerance for the device at hand (Dan Carpenter).

 - Get rid of one more rounding error from intel_pstate computations
   (Srinivas Pandruvada).

 - Fix the schedutil cpufreq governor to prevent it from possibly
   accessing unititialized data structures from governor callbacks in
   some cases on systems when multiple CPUs share a single cpufreq
   policy object (Vikram Mulukutla).

 - Fix the return values of probe routines in two devfreq drivers
   (Gustavo Silva).

 - Constify an attribute_group structure in devfreq (Arvind Yadav).

Thanks!


---------------

Arvind Yadav (1):
      PM / devfreq: constify attribute_group structures.

Dan Carpenter (1):
      PM / QoS: return -EINVAL for bogus strings

Gustavo A. R. Silva (2):
      PM / devfreq: rk3399_dmc: fix error return code in rk3399_dmcfreq_probe()
      PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()

Rafael J. Wysocki (2):
      PCI / PM: Restore PME Enable after config space restoration
      PCI / PM: Fix native PME handling during system suspend/resume

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix ratio setting for min_perf_pct

Vikram Mulukutla (1):
      cpufreq: schedutil: Fix sugov_start() versus sugov_update_shared() race

---------------

 drivers/base/power/sysfs.c           |  2 ++
 drivers/cpufreq/intel_pstate.c       |  2 +-
 drivers/devfreq/governor_userspace.c |  2 +-
 drivers/devfreq/rk3399_dmc.c         |  5 +++--
 drivers/devfreq/tegra-devfreq.c      |  6 +++---
 drivers/pci/pci-driver.c             |  2 ++
 drivers/pci/pci.c                    | 16 ++++++++--------
 drivers/pci/pci.h                    |  1 +
 drivers/pci/pcie/pme.c               | 35 +++++++++++++----------------------
 kernel/sched/cpufreq_schedutil.c     |  5 +++++
 10 files changed, 39 insertions(+), 37 deletions(-)
