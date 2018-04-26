Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41087 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbeDZOmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 10:42:43 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Apr 2018 16:42:42 +0200
Message-ID: <CAJZ5v0isQnkPq-47G4n5C3vyNoY2xWokzVTC35MBSPGivfxqjQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc3

with top-most commit e140c4af1b63125dff629e8339793390201e2470

 Merge branches 'acpi-pm' and 'pm-cpufreq'

on top of commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e

 Linux 4.17-rc2

to receive power management fixes for 4.17-rc3.

These are a Low Power S0 Idle quirk, a hibernation handling fix for
the PCI bus type and a brcmstb-avs-cpufreq driver fixup removing
development debug code from it.

Specifics:

 - Blacklist the Low Power S0 Idle _DSM on ThinkPad X1 Tablet(2016)
   where it causes issues and make it use ACPI S3 which works instead
   of the non-working suspend-to-idle by default (Chen Yu).

 - Fix the handling of hibernation in the PCI core for devices with
   the DPM_FLAG_SMART_SUSPEND flag set to fix a regression affecting
   intel-lpss I2C devices (Mika Westerberg).

 - Drop development debug code from the brcmstb-avs-cpufreq driver
   (Markus Mayer).

Thanks!


---------------

Chen Yu (1):
      ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(2016)

Markus Mayer (1):
      cpufreq: brcmstb-avs-cpufreq: remove development debug support

Mika Westerberg (1):
      PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart
suspend is set

---------------

 drivers/acpi/sleep.c                  |  13 ++
 drivers/cpufreq/Kconfig.arm           |  10 --
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 323 +---------------------------------
 drivers/pci/pci-driver.c              |   5 +-
 4 files changed, 17 insertions(+), 334 deletions(-)
