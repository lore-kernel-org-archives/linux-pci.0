Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34219 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbJBBLq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 21:11:46 -0400
MIME-Version: 1.0
Date: Fri, 2 Oct 2015 03:11:44 +0200
Message-ID: <CAJZ5v0jwdZM9ompxN+x8iMGWZBrKoRGpxXgoAqi4wrhO56LHXw@mail.gmail.com>
Subject: [GIT PULL] Power management and ACPI updates for v4.3-rc4
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.3-rc4

to receive power management and ACPI material for v4.3-rc4 with
top-most commit eb6d1c287ae1f7221248d5be26a5b1560073c09e

 Merge branches 'pm-cpuidle', 'pm-opp' and 'pm-tools'

on top of commit 9ffecb10283508260936b96022d4ee43a7798b4c

 Linux 4.3-rc3

These are fixes mostly, for a few changes made in this cycle
(the intel_idle driver, the OPP library, the ACPI EC driver,
turbostat) and for some issues that have just been discovered
(ACPI PCI IRQ management, PCI power management
documentation, turbostat), with a couple of cleanups on top
of them.

Specifics:

 - intel_idle driver fixup for the recently added Skylake chips
   support (Len Brown).

 - Operating Performance Points (OPP) library fix related to the
   recently added support for new DT bindings and a fix for a typo
   in a comment (Viresh Kumar, Stephen Boyd).

 - ACPI EC driver fix for a recently introduced memory leak in an
   error code path (Lv Zheng).

 - ACPI PCI IRQ management fix for the issue where an ISA IRQ is
   shared with a PCI device which requires it to be configured in a
   different way and may cause an interrupt storm to happen as a
   result with an extra ACPI SCI IRQ handling simplification on top
   of it (Jiang Liu).

 - Update of the PCI power management documentation that became
   outdated and started to actively confuse the readers to make
   it actually reflect the code (Rafael J Wysocki).

 - turbostat fixes including an IVB Xeon regression fix (related to
   the --debug command line option), Skylake adjustment for the TSC
   running at a frequency that doesn't match the base one exactly,
   and a Knights Landing quirk to account for the fact that it only
   updates APERF and MPERF every 1024 clock cycles plus bumping up
   the turbostat version number (Len Brown, Hubert Chrzaniuk).

Thanks!


---------------

Hubert Chrzaniuk (1):
      tools/power turbostat: KNL workaround for %Busy and Avg_MHz

Jiang Liu (2):
      ACPI, PCI, irq: Do not share PCI IRQ with ISA IRQ
      ACPI / PCI: Remove duplicated penalty on SCI IRQ

Len Brown (4):
      intel_idle: Skylake Client Support - updated
      tools/power turbostat: IVB Xeon: fix --debug regression
      tools/power turbostat: SKL: Adjust for TSC difference from base frequency
      tools/power turbosat: update version number

Lv Zheng (1):
      ACPI / EC: Fix a memory leak issue in acpi_ec_query()

Rafael J. Wysocki (1):
      PCI / PM: Update runtime PM documentation for PCI devices

Stephen Boyd (1):
      PM / OPP: Fix typo modifcation -> modification

Viresh Kumar (1):
      PM / OPP: of_property_count_u32_elems() can return errors

---------------

 Documentation/power/pci.txt           | 51 ++++++++++++++++++++++++++---------
 drivers/acpi/ec.c                     |  2 ++
 drivers/acpi/pci_irq.c                |  1 +
 drivers/acpi/pci_link.c               | 16 +++++++++--
 drivers/base/power/opp.c              | 17 ++++++++----
 drivers/idle/intel_idle.c             | 12 +++++++--
 drivers/pci/pci-driver.c              |  7 ++---
 include/linux/acpi.h                  |  1 +
 tools/power/x86/turbostat/turbostat.c | 39 +++++++++++++++++++++++----
 9 files changed, 116 insertions(+), 30 deletions(-)
