Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754246AbdLNXeR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 18:34:17 -0500
Date: Thu, 14 Dec 2017 17:34:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: [GIT PULL] PCI fixes for v4.15
Message-ID: <20171214233408.GA68544@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - add a pci_get_domain_bus_and_slot() stub for the CONFIG_PCI=n case to
    avoid build breakage in the v4.16 merge window if a
    pci_get_bus_and_slot() -> pci_get_domain_bus_and_slot() patch gets
    merged before the PCI tree (Randy Dunlap)

  - fix an AMD boot regression in the 64bit BAR support added in v4.15
    (Christian König)

  - fix an R-Car use-after-free that causes a crash if no PCIe card is
    present (Geert Uytterhoeven)


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.15-fixes-1

for you to fetch changes up to 0c31f1d7be1b5c4858b1d714dcefa25f41428cab:

  PCI: rcar: Fix use-after-free in probe error path (2017-12-12 11:01:47 -0600)

----------------------------------------------------------------
pci-v4.15-fixes-1

----------------------------------------------------------------
Christian König (2):
      x86/PCI: Fix infinite loop in search for 64bit BAR placement
      x86/PCI: Only enable a 64bit BAR on single-socket AMD Family 15h

Geert Uytterhoeven (1):
      PCI: rcar: Fix use-after-free in probe error path

Randy Dunlap (1):
      PCI: Add pci_get_domain_bus_and_slot() stub

 arch/x86/pci/fixup.c         | 27 +++++++++++++++++++++------
 drivers/pci/host/pcie-rcar.c |  8 ++++----
 include/linux/pci.h          |  3 +++
 3 files changed, 28 insertions(+), 10 deletions(-)
