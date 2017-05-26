Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756697AbdEZQm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 May 2017 12:42:59 -0400
Date: Fri, 26 May 2017 11:42:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Imre Deak <imre.deak@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [GIT PULL] PCI fixes for v4.12
Message-ID: <20170526164256.GA8204@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix PCI_ENDPOINT build error (merged for v4.12)

  - fix Switchtec driver (merged for v4.12)

  - fix imx6 config read timeouts, fallout from changing to non-postable
    reads

  - add PM "needs_resume" flag for i915 suspend issue


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.12-fixes-1

for you to fetch changes up to 4d071c3238987325b9e50e33051a40d1cce311cc:

  PCI/PM: Add needs_resume flag to avoid suspend complete optimization (2017-05-23 14:18:17 -0500)

----------------------------------------------------------------
pci-v4.12-fixes-1

----------------------------------------------------------------
Geert Uytterhoeven (1):
      PCI: endpoint: Make PCI_ENDPOINT depend on HAS_DMA

Imre Deak (1):
      PCI/PM: Add needs_resume flag to avoid suspend complete optimization

Logan Gunthorpe (2):
      switchtec: Use new cdev_device_add() helper function
      switchtec: Fix minor bug with partition ID register

Lucas Stach (1):
      PCI: imx6: Fix config read timeout handling

 drivers/pci/dwc/pci-imx6.c     | 33 ++++++++++++++++++++++++++++++---
 drivers/pci/endpoint/Kconfig   |  1 +
 drivers/pci/pci.c              |  3 ++-
 drivers/pci/switch/switchtec.c | 16 ++++++----------
 include/linux/pci.h            |  5 +++++
 5 files changed, 44 insertions(+), 14 deletions(-)
