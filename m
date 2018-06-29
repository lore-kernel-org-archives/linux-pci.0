Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754380AbeF2Mkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 08:40:31 -0400
Date: Fri, 29 Jun 2018 07:40:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alan Douglas <adouglas@cadence.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180629124029.GA96021@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Fix crash caused by endpoint library initialization order change (Alan
    Douglas)

  - Fix shpchp NULL pointer dereference regression on non-ACPI platforms
    (Bjorn Helgaas)

  - Move PCI_DOMAINS selection to fix build regression (Lorenzo Pieralisi)


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-1

for you to fetch changes up to 925d31668d5b6c9849c50167f31f9b5cf9eec892:

  PCI: controller: Move PCI_DOMAINS selection to arch Kconfig (2018-06-26 15:37:37 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-1

----------------------------------------------------------------
Alan Douglas (1):
      PCI: Initialize endpoint library before controllers

Bjorn Helgaas (1):
      PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems

Lorenzo Pieralisi (1):
      PCI: controller: Move PCI_DOMAINS selection to arch Kconfig

 arch/arm/Kconfig                 |  8 +++++++-
 arch/arm/mach-bcm/Kconfig        |  1 +
 arch/arm/mach-socfpga/Kconfig    |  1 +
 drivers/pci/Makefile             |  6 +++---
 drivers/pci/controller/Kconfig   |  3 ---
 drivers/pci/hotplug/acpi_pcihp.c | 10 +++++++++-
 6 files changed, 21 insertions(+), 8 deletions(-)
