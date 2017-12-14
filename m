Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41464 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdLNNpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:45:55 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/4] PCI: tegra: Reorder parameters in offset computations
Date: Thu, 14 Dec 2017 14:45:43 +0100
Message-Id: <20171214134545.11143-3-thierry.reding@gmail.com>
In-Reply-To: <20171214134545.11143-1-thierry.reding@gmail.com>
References: <20171214134545.11143-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The current computation of the configuration space offset is slightly
difficult to read because the fields aren't naturally ordered. This is
no doubt done to put extended register and register fields together,
but that's confusing because they are separate in the address mapping
given in the comment above the computations.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 8a07c6f9e1b0..26b734c84850 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -372,11 +372,11 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  * address (access to which generates correct config transaction) falls in
  * this 4 KiB region.
  */
-static unsigned long tegra_pcie_conf_offset(unsigned char b, unsigned int devfn,
-					    int where)
+static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
+					   unsigned int where)
 {
-	return (b << 16) | (PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) |
-	       (((where & 0xf00) >> 8) << 24) | (where & 0xff);
+	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
+	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
 }
 
 static int tegra_pcie_add_bus(struct pci_bus *bus)
-- 
2.15.1
