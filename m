Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34669 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeGELb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2018 07:31:28 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jul 2018 13:31:27 +0200
Message-ID: <CAJZ5v0hTE4OMOQ7wJ0S5eEwK+ZzYo4HVaGHvJiDPVA4xJc2hyQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.18-rc4
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
 pm-4.18-rc4

with top-most commit 88b96088e94ec66f6c9015eee28cb9d053be69c0

 Merge branch 'pm-pci'

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063

 Linux 4.18-rc3

to receive power management fixes for 4.18-rc4.

These fix a PCI power management regression introduced during the
4.17 cycle and fix up the recently added support for devices in
multiple power domains.

Specifics:

 - Resume parallel PCI (non-PCIe) bridges on suspend-to-RAM (ACP S3)
   to avoid confusing the platform firmware which started to happen
   after a core power management regression fix that went in during
   the 4.17 cycle (Rafael Wysocki).

 - Fix up the recently added support for devices in multiple power
   domains by avoiding to power up the entire domain unnecessarily
   when attaching a device to it (Ulf Hansson).

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM

Ulf Hansson (1):
      PM / Domains: Don't power on at attach for the multi PM domain case

---------------

 drivers/base/power/domain.c | 16 +++++++++-------
 drivers/pci/pci-acpi.c      | 12 ++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)
