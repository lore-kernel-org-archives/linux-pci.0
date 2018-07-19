Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeGST2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 15:28:51 -0400
Date: Thu, 19 Jul 2018 13:44:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180719184424.GA228321@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Fix crashes that happen when PHY drivers are left disabled in the V3
    Semiconductor, MediaTek, Faraday, Aardvark, DesignWare, Versatile,
    and X-Gene host controller drivers (Sergei Shtylyov)

  - Fix a NULL pointer dereference in the endpoint library configfs support
    (Kishon Vijay Abraham I)

  - Fix a race condition in Hyper-V IRQ handling (Dexuan Cui)


The following changes since commit 83235822b8b4fe47ecbd6b6bcbcc902860ac00fc:

  nfp: stop limiting VFs to 0 (2018-06-29 15:09:00 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-3

for you to fetch changes up to 270ed733e68955049b693bea8f4a1efb293a96ae:

  PCI: v3-semi: Fix I/O space page leak (2018-07-18 17:02:13 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-3

----------------------------------------------------------------
Dexuan Cui (1):
      PCI: hv: Disable/enable IRQs rather than BH in hv_compose_msi_msg()

Kishon Vijay Abraham I (1):
      PCI: endpoint: Fix NULL pointer dereference error when CONFIGFS is disabled

Sergei Shtylyov (8):
      PCI: OF: Fix I/O space page leak
      PCI: xgene: Fix I/O space page leak
      PCI: versatile: Fix I/O space page leak
      PCI: designware: Fix I/O space page leak
      PCI: aardvark: Fix I/O space page leak
      PCI: faraday: Fix I/O space page leak
      PCI: mediatek: Fix I/O space page leak
      PCI: v3-semi: Fix I/O space page leak

 drivers/pci/controller/dwc/pcie-designware-host.c |  3 +-
 drivers/pci/controller/pci-aardvark.c             |  2 +-
 drivers/pci/controller/pci-ftpci100.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c               |  8 +--
 drivers/pci/controller/pci-v3-semi.c              |  2 +-
 drivers/pci/controller/pci-versatile.c            |  2 +-
 drivers/pci/controller/pci-xgene.c                |  2 +-
 drivers/pci/controller/pcie-mediatek.c            |  2 +-
 drivers/pci/endpoint/pci-epf-core.c               | 62 ++++++++++++++++-------
 drivers/pci/of.c                                  |  2 +-
 drivers/pci/pci.c                                 | 38 ++++++++++++++
 include/linux/pci.h                               |  2 +
 12 files changed, 97 insertions(+), 30 deletions(-)
