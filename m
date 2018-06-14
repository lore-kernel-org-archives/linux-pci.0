Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:35182 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935633AbeFNBg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 21:36:56 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 10/10] PCI: rockchip: Use pci_host_alloc_intx_irqd() helper to get irq domain for INTx
Date: Thu, 14 Jun 2018 09:36:37 +0800
Message-Id: <1528940197-183694-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/controller/pcie-rockchip-host.c | 38 +++--------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 1372d27..eb62ba4 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -699,39 +699,6 @@ static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 	rockchip_pcie_enable_bw_int(rockchip);
 }
 
-static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-				  irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = rockchip_pcie_intx_map,
-};
-
-static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
-{
-	struct device *dev = rockchip->dev;
-	struct device_node *intc = of_get_next_child(dev->of_node, NULL);
-
-	if (!intc) {
-		dev_err(dev, "missing child interrupt-controller node\n");
-		return -EINVAL;
-	}
-
-	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-						    &intx_domain_ops, rockchip);
-	if (!rockchip->irq_domain) {
-		dev_err(dev, "failed to get a INTx IRQ domain\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie *rockchip,
 				     int region_no, int type, u8 num_pass_bits,
 				     u32 lower_addr, u32 upper_addr)
@@ -990,8 +957,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	rockchip_pcie_enable_interrupts(rockchip);
 
-	err = rockchip_pcie_init_irq_domain(rockchip);
-	if (err < 0)
+	rockchip->irq_domain = pci_host_alloc_intx_irqd(dev, rockchip, false,
+							NULL, NULL);
+	if (IS_ERR(rockchip->irq_domain))
 		goto err_deinit_port;
 
 	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-- 
1.9.1
