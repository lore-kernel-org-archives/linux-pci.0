Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0053.outbound.protection.outlook.com ([104.47.37.53]:60224
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeG3S6f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 14:58:35 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>
CC: <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, <stelford@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 1/5] PCI: cadence: Use AXI region 0 to signal interrupts from EP
Date: Mon, 30 Jul 2018 18:22:00 +0100
Message-ID: <1532971320-6966-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IRQ physical address is allocated from region 0, rather than
the highest region.  Update the driver to reserve this region in
the bitmap, and to use region 0 for all types of interrupt.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 9e87dd7..6692654 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -258,7 +258,6 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 r = ep->max_regions - 1;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -268,8 +267,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, r,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, 0,
 							     ep->irq_phys_addr);
 		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn = fn;
@@ -347,8 +346,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, fn, ep->max_regions - 1,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region(pcie, fn, 0,
 					      false,
 					      ep->irq_phys_addr,
 					      pci_addr & ~pci_addr_mask,
@@ -517,6 +516,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 		goto free_epc_mem;
 	}
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
 
 	return 0;
 
-- 
1.7.1
