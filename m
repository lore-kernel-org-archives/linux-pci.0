Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:4767 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbcAZXbe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2016 18:31:34 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2] PCI: iproc: Fix BCMA PCIe bus scanning regression
Date: Tue, 26 Jan 2016 15:31:40 -0800
Message-ID: <1453851100-15196-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") causes
regression on EP device detection on BCMA based platforms. This patch
fixes the issue by allowing multiple devices to be configured on the
same bus, for all PAXB based child buses. In addition, this patch also
adds check to prevent non-zero function from being used on bus 0 (root
bus).

Function 'iproc_pcie_device_is_valid' is now removed with checks
folding into 'iproc_pcie_map_cfg_bus' to make them more clear and less
error-prone

Reported-by: Rafal Milecki <zajec5@gmail.com>
Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 5816bce..67396ab 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -170,20 +170,6 @@ static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
 	writel(val, pcie->base + offset + (window * 8));
 }
 
-static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
-					      unsigned int slot,
-					      unsigned int fn)
-{
-	if (slot > 0)
-		return false;
-
-	/* PAXC can only support limited number of functions */
-	if (pcie->type == IPROC_PCIE_PAXC && fn >= MAX_NUM_PAXC_PF)
-		return false;
-
-	return true;
-}
-
 /**
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
@@ -199,11 +185,11 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 	u32 val;
 	u16 offset;
 
-	if (!iproc_pcie_device_is_valid(pcie, slot, fn))
-		return NULL;
-
 	/* root complex access */
 	if (busno == 0) {
+		if (slot > 0 || fn > 0)
+			return NULL;
+
 		iproc_pcie_write_reg(pcie, IPROC_PCIE_CFG_IND_ADDR,
 				     where & CFG_IND_ADDR_MASK);
 		offset = iproc_pcie_reg_offset(pcie, IPROC_PCIE_CFG_IND_DATA);
@@ -213,6 +199,14 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 			return (pcie->base + offset);
 	}
 
+	/*
+	 * PAXC is connected to internally emulated EP within the SoC. It
+	 * allows only one device and supports limited number of functions
+	 */
+	if (pcie->type == IPROC_PCIE_PAXC)
+		if (slot > 0 || fn >= MAX_NUM_PAXC_PF)
+			return NULL;
+
 	/* EP device access */
 	val = (busno << CFG_ADDR_BUS_NUM_SHIFT) |
 		(slot << CFG_ADDR_DEV_NUM_SHIFT) |
-- 
1.9.1

