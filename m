Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45428 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755838AbdLTTG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 14:06:28 -0500
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2017 20:06:27 +0100
Message-ID: <CAJZ5v0jGE6d+-3PGztvzWAdHvuB4=y4tDYeNSYnwmRyU7kCLwg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.15-rc5
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
 pm-4.15-rc5

with top-most commit 63d15e8c2ac134b3fd5460d19043ffde6f6eeb61

 Merge branch 'pm-pci'

on top of commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b

 Linux 4.15-rc4

to receive power management fixes for 4.15-rc5.

These fix a regression in the ondemand and conservative cpufreq
governors that was introduced during the 4.13 cycle, a recent
regression in the imx6q cpufreq driver and a regression in the PCI
handling of hibernation from the 4.14 cycle.

Specifics:

 - Fix an issue in the PCI handling of the "thaw" transition during
   hibernation (after creating an image), introduced by a bug fix
   from the 4.13 cycle and exposed by recent changes in the IRQ
   subsystem, that caused pci_restore_state() to be called for
   devices in low-power states in some cases which is incorrect
   and breaks MSI management on some systems (Rafael Wysocki).

 - Fix a recent regression in the imx6q cpufreq driver that broke
   speed grading on i.MX6 QuadPlus by omitting checks causing
   invalid operating performance points (OPPs) to be disabled on
   that SoC as appropriate (Lucas Stach).

 - Fix a regression introduced during the 4.14 cycle in the ondemand
   and conservative cpufreq governors that causes the sampling
   interval used by them to be shorter than the tick period in some
   cases which leads to incorrect decisions (Rafael Wysocki).

Thanks!


---------------

Lucas Stach (1):
      cpufreq: imx6q: fix speed grading regression on i.MX6 QuadPlus

Rafael J. Wysocki (2):
      PCI / PM: Force devices to D0 in pci_pm_thaw_noirq()
      cpufreq: governor: Ensure sufficiently large sampling intervals

---------------

 drivers/cpufreq/cpufreq_governor.c | 19 ++++++++++++++++---
 drivers/cpufreq/imx6q-cpufreq.c    | 11 ++++++-----
 drivers/pci/pci-driver.c           |  7 ++++++-
 3 files changed, 28 insertions(+), 9 deletions(-)
