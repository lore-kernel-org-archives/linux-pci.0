Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45164 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbcHQT7r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 15:59:47 -0400
Subject: [PATCH v6 0/4] pcie-designware: add iATU unroll feature
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 17 Aug 2016 14:59:39 -0500
Message-ID: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Original description from Joao:

  The new DWC PCIe Core version (4.80) implements iATU in a different
  way.  This new mechanism is called iATU Unroll Mode. The Core still
  supports the "old" mechanism calling it Legacy Mode if configured to
  do so, but the standard way will be using Unroll.  This patch adds
  the necessary support for the mechanism and makes some minor
  improvements to the existent one.

I made a few changes from the v5 series Joao posted, so I'm posting
the patches I applied as this v6.

changes v5->v6:
  - Add a patch to change the signature of dw_pcie_readl_rc() from
    this:
      void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
    to this:
      u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
    Note that this also affects Exynos.
  - Move loop checking for iATU enable to a separate patch.
  - Change iATU register definitions to be offsets (not register
    numbers).  This is to match the existing style of the pre-unroll
    definitions.
  - Rename dw_pcie_get_atu_mode() and related things to
    dw_pcie_iatu_unroll_enabled() so they're more descriptive.

---

Bjorn Helgaas (1):
      PCI: designware: Return data directly from dw_pcie_readl_rc()

Joao Pinto (3):
      PCI: designware: Move link wait definitions to .c file
      PCI: designware: Wait for iATU enable
      PCI: designware: Add iATU Unroll feature


 drivers/pci/host/pci-exynos.c      |    9 ++
 drivers/pci/host/pcie-designware.c |  138 ++++++++++++++++++++++++++++++------
 drivers/pci/host/pcie-designware.h |    9 +-
 3 files changed, 123 insertions(+), 33 deletions(-)
