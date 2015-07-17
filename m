Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jul 2015 02:32:55 +0200
Message-ID: <CAJZ5v0h+Nbh8SwS1xzHFw=cBZ1U0scBdSFrZaAAdH6cB+vXnbQ@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI fixes for v4.2-rc3
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
 pm+acpi-4.2-rc3

to receive power management and ACPI fixes for v4.2-rc3 with
top-most commit 17ffc8b083ac299ff798419d1887b7cdcd4ae4d2

 Merge branches 'pm-cpuidle', 'pm-cpufreq' and 'acpi-resources'

on top of commit bc0195aad0daa2ad5b0d76cce22b167bc3435590

 Linux 4.2-rc2

These fix two bugs in the cpufreq core (including one recent
regression), fix a 4.0 PCI regression related to the ACPI resources
management and quieten an RCU-related lockdep complaint about a
tracepoint in the suspend-to-idle code.

Specifics:

 - Fix a recently introduced issue in the cpufreq policy object
   reinitialization that leads to CPU offline/online breakage
   (Viresh Kumar).

 - Make it possible to access frequency tables of offline CPUs
   which is needed by thermal management code among other things
   (Viresh Kumar).

 - Fix an ACPI resource management regression introduced during
   the 4.0 cycle that may cause incorrect resource validation
   results to appear in 32-bit x86 kernels due to silent truncation
   of 64-bit values to 32-bit (Jiang Liu).

 - Fix up an RCU-related lockdep complaint about suspicious RCU
   usage in idle caused by using a suspend tracepoint in the
   core suspend-to-idle code (Rafael J Wysocki).

Thanks!

---------------

Jiang Liu (1):
      ACPI / PCI: Fix regressions caused by resource_size_t overflow
with 32-bit kernel

Rafael J. Wysocki (1):
      suspend-to-idle: Prevent RCU from complaining about tick_freeze()

Viresh Kumar (2):
      cpufreq: Initialize the governor again while restoring policy
      cpufreq: Allow freq_table to be obtained for offline CPUs

---------------

 drivers/acpi/resource.c      | 24 +++++++++++++++---------
 drivers/cpufreq/cpufreq.c    | 10 ++++++++++
 drivers/cpufreq/freq_table.c |  9 ---------
 drivers/cpuidle/cpuidle.c    |  9 +++++++--
 4 files changed, 32 insertions(+), 20 deletions(-)
