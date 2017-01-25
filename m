Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:60128
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751304AbdAYIye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Jan 2017 03:54:34 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <paul.gortmaker@windriver.com>,
        <robh@kernel.org>, <colin.king@canonical.com>,
        <linux-pci@vger.kernel.org>, <marc.zyngier@arm.com>
CC: <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rgummal@xilinx.com>,
        <arnd@arndb.de>, "Bharat Kumar Gogada" <bharatku@xilinx.com>
Subject: [PATCH v2 1/2] PCI: Xilinx NWL: Modifying irq chip for legacy interrupts
Date: Wed, 25 Jan 2017 14:22:32 +0530
Message-ID: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- Few wifi end points which only support legacy interrupts,
performs hardware reset functionalities after disabling interrupts
by invoking disable_irq and then re-enable using enable_irq, they
enable hardware interrupts first and then virtual irq line later.
- The legacy irq line goes low only after DEASSERT_INTx is
received.As the legacy irq line is high immediately after hardware
interrupts are enabled but virq of EP is still in disabled state
and EP handler is never executed resulting no DEASSERT_INTx.If dummy
irq chip is used, interrutps are not masked and system is
hanging with CPU stall.
- Adding irq chip functions instead of dummy irq chip for legacy
interrupts.
- Legacy interrupts are level sensitive, so using handle_level_irq
is more appropriate as it is masks interrupts until End point handles
interrupts and unmasks interrutps after End point handler is executed.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 43eaa4a..6ac3e1d 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -395,10 +395,44 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void nwl_mask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct nwl_pcie *pcie;
+	u32 mask;
+	u32 val;
+
+	pcie = irq_desc_get_chip_data(desc);
+	mask = 1 << (data->hwirq - 1);
+	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
+	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
+}
+
+static void nwl_unmask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct nwl_pcie *pcie;
+	u32 mask;
+	u32 val;
+
+	pcie = irq_desc_get_chip_data(desc);
+	mask = 1 << (data->hwirq - 1);
+	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
+	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
+}
+
+static struct irq_chip nwl_leg_irq_chip = {
+	.name = "nwl_pcie:legacy",
+	.irq_enable = nwl_unmask_leg_irq,
+	.irq_disable = nwl_mask_leg_irq,
+	.irq_mask = nwl_mask_leg_irq,
+	.irq_unmask = nwl_unmask_leg_irq,
+};
+
 static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 			  irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
-- 
2.1.1

