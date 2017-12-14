Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46704 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbdLNNpw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:45:52 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/4] PCI: tegra: Clarify configuration space address computations
Date: Thu, 14 Dec 2017 14:45:42 +0100
Message-Id: <20171214134545.11143-2-thierry.reding@gmail.com>
In-Reply-To: <20171214134545.11143-1-thierry.reding@gmail.com>
References: <20171214134545.11143-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Tegra uses a non-compatible variant of ECAM where the extended register
field is separate from the register field. Clarify that the register
offset also factors into the computation of the configuration space
addresses.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index f6d0430e6704..8a07c6f9e1b0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -364,11 +364,13 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  *
  * Mapping the whole extended configuration space would require 256 MiB of
  * virtual address space, only a small part of which will actually be used.
- * To work around this, a 4K of region is used to generate required
- * configuration transaction with relevant B:D:F values. This is achieved by
- * dynamically programming base address and size of AFI_AXI_BAR used for
- * end point config space mapping to make sure that the address (access to
- * which generates correct config transaction) falls in this 4K region
+ *
+ * To work around this, a 4 KiB region is used to generate the required
+ * configuration transaction with relevant B:D:F and register offset values.
+ * This is achieved by dynamically programming base address and size of
+ * AFI_AXI_BAR used for end point config space mapping to make sure that the
+ * address (access to which generates correct config transaction) falls in
+ * this 4 KiB region.
  */
 static unsigned long tegra_pcie_conf_offset(unsigned char b, unsigned int devfn,
 					    int where)
-- 
2.15.1
