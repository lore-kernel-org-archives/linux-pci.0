Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Dec 2015 15:07:23 +0100
Message-ID: <CAJZ5v0g4AfzTSr8d8O8DY1aUT1-T-fnab2=CO42HE=Xe6QkbUQ@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for v4.4-rc4
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
 pm+acpi-4.4-rc4

to receive power management and ACPI fixes for v4.4-rc4 with
top-most commit d441fe25e7de576e36a3cd96f22b737d2f15372a

 Merge branches 'pm-domains' and 'pm-cpufreq'

on top of commit 31ade3b83e1821da5fbb2f11b5b3d4ab2ec39db8

 Linux 4.4-rc3

These fix a recent regression in the ACPI PCI host bridge
initialization code, clean up some recent changes (generic
power domains framework, ACPI AML debugger support), fix
three older but annoying bugs (PCI power management. generic
power domains framework, cpufreq) and a build problem (device
properties framework), and update a stale MAINTAINERS entry
(ACPI backlight driver).

Specifics:

 - Fix a regression in the ACPI PCI host bridge initialization code
   introduced by the recent consolidation of the host bridge handling
   on x86 and ia64 that forgot to take one special piece of code
   related to NUMA on x86 into account (Liu Jiang).

 - Improve the Kconfig help description of the new ACPI AML debugger
   support option to avoid possible confusion (Peter Zijlstra).

 - Remove a piece of code in the generic power domains framework
   that should have been removed by one of the recent commits
   modifying that code (Ulf Hansson).

 - Reduce the log level of a PCI PM message that generates a lot
   of false-positive log noise for some drivers and improve the
   message itself while at it (Imre Deak).

 - Fix the OF-based domain lookup code in the generic power domains
   framework to make it drop references to DT nodes correctly (Eric
   Anholt).

 - Prevent the cpufreq core from setting the policy back to the
   default after a CPU offline/online cycle for cpufreq drivers
   providing the ->setpolicy callback (Srinivas Pandruvada).

 - Fix a build problem for CONFIG_ACPI unset in the device
   properties framework (Hanjun Guo).

 - Fix a stale file path in the ACPI backlight driver entry in
   MAINTAINERS (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      MAINTAINERS: ACPI / video: update a file name in drivers/acpi/

Eric Anholt (1):
      PM / Domains: Fix bad of_node_put() in failure paths of
genpd_dev_pm_attach()

Hanjun Guo (1):
      ACPI / property: fix compile error for
acpi_node_get_property_reference() when
      CONFIG_ACPI=n

Imre Deak (1):
      PCI / PM: Tune down retryable runtime suspend error messages

Liu Jiang (1):
      x86/PCI/ACPI: Fix regression caused by commit 4d6b4e69a245

Peter Zijlstra (1):
      ACPI: Better describe ACPI_DEBUGGER

Srinivas Pandruvada (1):
      cpufreq: use last policy after online for drivers with ->setpolicy

Ulf Hansson (1):
      PM / Domains: Validate cases of a non-bound driver in genpd governor

---------------

 MAINTAINERS                          |  2 +-
 arch/x86/pci/bus_numa.c              | 13 ++-----------
 drivers/acpi/Kconfig                 |  4 ++--
 drivers/acpi/pci_root.c              |  7 +++++++
 drivers/base/power/domain.c          |  3 +--
 drivers/base/power/domain_governor.c |  3 ---
 drivers/cpufreq/cpufreq.c            | 14 ++++++++++----
 drivers/pci/pci-driver.c             | 16 ++++++++++++++--
 include/linux/acpi.h                 |  4 ++--
 include/linux/cpufreq.h              |  1 +
 10 files changed, 40 insertions(+), 27 deletions(-)
