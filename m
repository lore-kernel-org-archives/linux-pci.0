Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:19565 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964921AbdBQX0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2017 18:26:32 -0500
Date: Sat, 18 Feb 2017 02:26:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] PCI: dwc: uninitialized variable in dw_handle_msi_irq()
Message-ID: <20170217232618.GC26717@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The bug is that "val" is unsigned long but we only initialize 32 bits
of it.  Then we test "if (val)" and that might be true not because we
set the bits but because some were never initialized.

Fixes: f342d940ee0e ("PCI: exynos: Add support for MSI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis.  Not tested.

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index af8f6e92e885..5bfc377b83e4 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -257,17 +257,18 @@ static struct irq_chip dw_msi_irq_chip = {
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
-	unsigned long val;
+	u32 val;
 	int i, pos, irq;
 	irqreturn_t ret = IRQ_NONE;
 
 	for (i = 0; i < MAX_MSI_CTRLS; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				(u32 *)&val);
+				    &val);
 		if (val) {
 			ret = IRQ_HANDLED;
 			pos = 0;
-			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
+			while ((pos = find_next_bit((unsigned long *)&val, 32,
+						    pos)) != 32) {
 				irq = irq_find_mapping(pp->irq_domain,
 						i * 32 + pos);
 				dw_pcie_wr_own_conf(pp,
