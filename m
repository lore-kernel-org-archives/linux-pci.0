Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:39493 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdGNMHu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jul 2017 08:07:50 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Niklas Cassel <niklass@axis.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to dw_pcie_readX_dbi/dw_pcie_writeX_dbi
Date: Fri, 14 Jul 2017 14:07:33 +0200
Message-ID: <20170714120735.11993-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since the introduction of the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros,
most dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..) calls
have been converted to dw_pcie_readX_dbi/dw_pcie_writeX_dbi calls.
Convert the remaining calls.

Niklas Cassel (2):
  PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
  PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi
    macros

 drivers/pci/dwc/pci-dra7xx.c     | 14 ++++++--------
 drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
 2 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.11.0
