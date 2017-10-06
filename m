Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752577AbdJFSuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 14:50:55 -0400
Date: Fri, 6 Oct 2017 13:50:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [GIT PULL] PCI fixes for v4.14
Message-ID: <20171006185054.GA23061@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix legacy IDE probe issues exposed by recent PCI core IRQ mapping
    changes (Bartlomiej Zolnierkiewicz, Lorenzo Pieralisi)


The following changes since commit 9561475db680f7144d2223a409dd3d7e322aca03:

  PCI: Fix race condition with driver_override (2017-09-25 18:34:54 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.14-fixes-4

for you to fetch changes up to b1f9e5e355e909000fcccfd2bc31f7c1ded358ab:

  ide: fix IRQ assignment for PCI bus order probing (2017-10-03 14:03:31 -0500)

----------------------------------------------------------------
pci-v4.14-fixes-4

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      ide: free hwif->portdev on hwif_init() failure
      ide: pci: free PCI BARs on initialization failure

Lorenzo Pieralisi (1):
      ide: fix IRQ assignment for PCI bus order probing

 drivers/ide/ide-probe.c    |  1 +
 drivers/ide/ide-scan-pci.c | 13 +++++++---
 drivers/ide/setup-pci.c    | 63 +++++++++++++++++++++++++++++-----------------
 3 files changed, 50 insertions(+), 27 deletions(-)
