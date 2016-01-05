Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:49563 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752476AbcAENAy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2016 08:00:54 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v2 1/4] PCI: rcar: remove unused pci_sys_data structure in pcie-rcar
Date: Tue,  5 Jan 2016 13:00:28 +0000
Message-Id: <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
with global function pointer") removed the struct pci_sys_data
dependency from the ARM pcibios functions, so remove it from this
driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 v2:
   - No changes.
---
 drivers/pci/host/pcie-rcar.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 5c29626..c72c0ae 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -124,16 +124,7 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 }
 
 /* Structure representing the PCIe interface */
-/*
- * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
- * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
- * that when we use a gen_pci pointer as sysdata, it is also a pointer to
- * a struct pci_sys_data.
- */
 struct rcar_pcie {
-#ifdef CONFIG_ARM
-	struct pci_sys_data	sys;
-#endif
 	struct device		*dev;
 	void __iomem		*base;
 	struct list_head	resources;
-- 
2.5.0

