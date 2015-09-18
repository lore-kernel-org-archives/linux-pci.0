Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35744 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915AbbIRPMm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 11:12:42 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH v5 4/5] PCI: designware: Make get_msi_addr() return phys_addr_t, not u32
Date: Fri, 18 Sep 2015 17:12:38 +0200
Message-Id: <1442589159-28201-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
References: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make get_msi_addr() return phys_addr_t, not u32.  This allows the MSI
target address to be above 4GB for 64bit or PAE systems.

No functional change for the current 32bit platform users as phys_addr_t
maps to u32 for them.

[bhelgaas: changelog]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pci-keystone-dw.c | 2 +-
 drivers/pci/host/pci-keystone.h    | 2 +-
 drivers/pci/host/pcie-designware.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index e71da991949b..3cf55cdb7f87 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -70,7 +70,7 @@ static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 	*bit_pos = offset >> 3;
 }
 
-u32 ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
+phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
 
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 478d932b602d..f0944e8c4b02 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -37,7 +37,7 @@ struct keystone_pcie {
 
 /* Keystone DW specific MSI controller APIs/definitions */
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset);
-u32 ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
+phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd276840d..35123d9362c5 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -70,7 +70,7 @@ struct pcie_host_ops {
 	void (*host_init)(struct pcie_port *pp);
 	void (*msi_set_irq)(struct pcie_port *pp, int irq);
 	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	u32 (*get_msi_addr)(struct pcie_port *pp);
+	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
-- 
2.5.1

