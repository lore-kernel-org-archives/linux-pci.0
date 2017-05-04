Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33702 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdEDUKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2017 16:10:35 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] PCI: tegra: Support MSI 64-bit addressing
Date: Thu,  4 May 2017 22:10:31 +0200
Message-Id: <20170504201032.32633-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The MSI target address can reside beyond the 32-bit boundary on devices
with more than 2 GiB of system memory. The PCI host bridge on Tegra can
easily support 64-bit addresses, so make sure to pass the upper 32 bits
of the target address to endpoints when allocating MSI entries.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index ecf8b4f1bf05..e69f828a9ab2 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -235,6 +235,7 @@ struct tegra_msi {
 	struct irq_domain *domain;
 	unsigned long pages;
 	struct mutex lock;
+	u64 phys;
 	int irq;
 };
 
@@ -1468,9 +1469,8 @@ static int tegra_msi_setup_irq(struct msi_controller *chip,
 
 	irq_set_msi_desc(irq, desc);
 
-	msg.address_lo = virt_to_phys((void *)msi->pages);
-	/* 32 bit address only */
-	msg.address_hi = 0;
+	msg.address_lo = lower_32_bits(msi->phys);
+	msg.address_hi = upper_32_bits(msi->phys);
 	msg.data = hwirq;
 
 	pci_write_msi_msg(irq, &msg);
@@ -1519,7 +1519,6 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	struct tegra_msi *msi = &pcie->msi;
 	struct device *dev = pcie->dev;
-	unsigned long base;
 	int err;
 	u32 reg;
 
@@ -1553,10 +1552,10 @@ static int tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 
 	/* setup AFI/FPCI range */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
-	base = virt_to_phys((void *)msi->pages);
+	msi->phys = virt_to_phys((void *)msi->pages);
 
-	afi_writel(pcie, base >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
-	afi_writel(pcie, base, AFI_MSI_AXI_BAR_ST);
+	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
+	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
 	/* this register is in 4K increments */
 	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
 
-- 
2.12.0
