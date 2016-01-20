Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:48143 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbcATWzO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2016 17:55:14 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafal Milecki <zajec5@gmail.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH] PCI: iproc: Fix BCMA PCIe bus scanning regression
Date: Wed, 20 Jan 2016 14:55:10 -0800
Message-ID: <1453330510-21926-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 943ebae781f5 ("PCI: iproc: Add PAXC interface support") causes
regression on EP device detection on BCMA based platforms. This patch
fixes the issue by allowing multiple devices to be configured on the
same bus, for all PAXB based child buses

Reported-by: Rafal Milecki <zajec5@gmail.com>
Fixes: 943ebae781f5 ("PCI: iproc: Add PAXC interface support")
Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 5816bce..4627561 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -171,10 +171,11 @@ static inline void iproc_pcie_ob_write(struct iproc_pcie *pcie,
 }
 
 static inline bool iproc_pcie_device_is_valid(struct iproc_pcie *pcie,
+					      unsigned int busnum,
 					      unsigned int slot,
 					      unsigned int fn)
 {
-	if (slot > 0)
+	if ((pcie->type == IPROC_PCIE_PAXC || busnum == 0) && slot > 0)
 		return false;
 
 	/* PAXC can only support limited number of functions */
@@ -199,7 +200,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 	u32 val;
 	u16 offset;
 
-	if (!iproc_pcie_device_is_valid(pcie, slot, fn))
+	if (!iproc_pcie_device_is_valid(pcie, busno, slot, fn))
 		return NULL;
 
 	/* root complex access */
-- 
1.9.1

