Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:33020 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeFMH1P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:27:15 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 08/10] PCI: xilinx-nwl: Use pci_host_alloc_intx_irqd() helper to get irq domain for INTx
Date: Wed, 13 Jun 2018 15:26:57 +0800
Message-Id: <1528874817-7911-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528874696-7524-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/controller/pcie-xilinx-nwl.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 6a4bbb5..b0d13bb 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -546,24 +546,12 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *legacy_intc_node;
-
-	legacy_intc_node = of_get_next_child(node, NULL);
-	if (!legacy_intc_node) {
-		dev_err(dev, "No legacy intc node found\n");
-		return -EINVAL;
-	}
 
-	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
-							PCI_NUM_INTX,
-							&legacy_domain_ops,
-							pcie);
-
-	if (!pcie->legacy_irq_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
+	pcie->legacy_irq_domain = pci_host_alloc_intx_irqd(dev, pcie, false,
+							   &legacy_domain_ops,
+							   NULL);
+	if (IS_ERR(pcie->legacy_irq_domain))
+		return PTR_ERR(pcie->legacy_irq_domain);
 
 	raw_spin_lock_init(&pcie->leg_mask_lock);
 	nwl_pcie_init_msi_irq_domain(pcie);
-- 
1.9.1
