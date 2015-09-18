Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58811 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbbIRPMm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 11:12:42 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH v5 5/5] PCI: designware: Set up high part of MSI target address
Date: Fri, 18 Sep 2015 17:12:39 +0200
Message-Id: <1442589159-28201-6-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
References: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set up the high part of the MSI target address to allow the MSI target to
be above 4GB on 64bit and PAE systems.

[bhelgaas: changelog]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 3a2b8bce27a6..4eada6bc5fef 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -205,12 +205,16 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
+	u64 msi_target;
+
 	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
+	msi_target = virt_to_phys((void *)pp->msi_data);
 
 	/* program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			virt_to_phys((void *)pp->msi_data));
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
+			    (u32)(msi_target & 0xffffffff));
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
+			    (u32)(msi_target >> 32 & 0xffffffff));
 }
 
 static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
@@ -299,12 +303,15 @@ no_valid_irq:
 static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
 {
 	struct msi_msg msg;
+	u64 msi_target;
 
 	if (pp->ops->get_msi_addr)
-		msg.address_lo = pp->ops->get_msi_addr(pp);
+		msi_target = pp->ops->get_msi_addr(pp);
 	else
-		msg.address_lo = virt_to_phys((void *)pp->msi_data);
-	msg.address_hi = 0x0;
+		msi_target = virt_to_phys((void *)pp->msi_data);
+
+	msg.address_lo = (u32)(msi_target & 0xffffffff);
+	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
 
 	if (pp->ops->get_msi_data)
 		msg.data = pp->ops->get_msi_data(pp, pos);
-- 
2.5.1

