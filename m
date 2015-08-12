Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbbHLJd6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 05:33:58 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH v3 4/5] PCI: designware: change prototype of get_msi_addr
Date: Wed, 12 Aug 2015 11:33:55 +0200
Message-Id: <1439372036-15303-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use phys_addr_t to allow the MSI target address to be above the
4GB mark for 64bit or PAE systems. No functional change for the
current 32bit platform users as phys_addr_t maps to u32 for them.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-keystone-dw.c | 2 +-
 drivers/pci/host/pcie-designware.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index f34892e0edb4..bf4e7e9aea4b 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -70,7 +70,7 @@ static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
 	*bit_pos = offset >> 3;
 }
 
-u32 ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
+phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
 
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
2.4.6

