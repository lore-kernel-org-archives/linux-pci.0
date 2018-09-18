Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16271 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727756AbeIRUtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 16:49:11 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <lorenzo.pieralisi@arm.com>
CC: <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 1/5] PCI: cadence: Use AXI region 0 to signal interrupts from EP
Date: Tue, 18 Sep 2018 16:15:47 +0100
Message-ID: <1537283747-12589-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IRQ physical address is allocated from region 0, rather than
the highest region.  Update the driver to reserve this region in
the bitmap, and to use region 0 for all types of interrupt.

This corrects a problem which prevents the interrupt being
signalled correctly if using the first address in the AXI region,
since an offset of zero will always be mapped to region 0.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index e3fe412..a67dc91 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -259,7 +259,6 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 r = ep->max_regions - 1;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -269,8 +268,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
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
@@ -348,8 +347,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
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
@@ -510,6 +509,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 		goto free_epc_mem;
 	}
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
 
 	return 0;
 
-- 
1.9.0
