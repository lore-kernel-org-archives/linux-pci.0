Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:45819 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeEKNqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 May 2018 09:46:14 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 May 2018 15:46:12 +0200
Message-ID: <CAJZ5v0itrpj0DKaLqQXuavA4_zffVDtgMZoAm4WDOReLRvMUTg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.17-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc5

with top-most commit ef050374e1eedec45bd260e0ac9eb98f699267d2

 Merge branches 'pm-pci' and 'pm-docs'

on top of commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb

 Linux 4.17-rc4

to receive power management fixes for 4.17-rc5.

These fix two PCI power management regressions from the 4.13 cycle
and one cpufreq schedutil governor bug introduced during the 4.12
cycle, drop a stale comment from the schedutil code and fix two
mistakes in docs.

Specifics:

 - Restore device_may_wakeup() check in pci_enable_wake() removed
   inadvertently during the 4.13 cycle to prevent systems from
   drawing excessive power when suspended or off, among other
   things (Rafael Wysocki).

 - Fix pci_dev_run_wake() to properly handle devices that only can
   signal PME# when in the D3cold power state (Kai Heng Feng).

 - Fix the schedutil cpufreq governor to avoid using UINT_MAX
   as the new CPU frequency in some cases due to a missing check
   (Rafael Wysocki).

 - Remove a stale comment regarding worker kthreads from the
   schedutil cpufreq governor (Juri Lelli).

 - Fix a copy-paste mistake in the intel_pstate driver documentation
   (Juri Lelli).

 - Fix a typo in the system sleep states documentation (Jonathan
   Neusch=C3=A4fer).

Thanks!


---------------

Jonathan Neusch=C3=A4fer (1):
      PM: docs: sleep-states: Fix a typo ("includig")

Juri Lelli (2):
      PM: docs: intel_pstate: fix Active Mode w/o HWP paragraph
      cpufreq: schedutil: remove stale comment

Kai Heng Feng (1):
      PCI / PM: Always check PME wakeup capability for runtime wakeup suppo=
rt

Rafael J. Wysocki (2):
      cpufreq: schedutil: Avoid using invalid next_freq
      PCI / PM: Check device_may_wakeup() in pci_enable_wake()

---------------

 Documentation/admin-guide/pm/intel_pstate.rst |  2 +-
 Documentation/admin-guide/pm/sleep-states.rst |  2 +-
 drivers/pci/pci.c                             | 37 +++++++++++++++++++----=
----
 kernel/sched/cpufreq_schedutil.c              | 16 ++----------
 4 files changed, 31 insertions(+), 26 deletions(-)
