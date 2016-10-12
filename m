Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932939AbcJLMx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:59 -0400
Subject: [PATCH v2 5/5] PCI: iproc: Hard-code PCIe capability offset instead
 of searching
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Wed, 12 Oct 2016 07:53:50 -0500
Message-ID: <20161012125350.24076.68204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We know where the PCIe capability lives in the host bridge's config space;
in fact, we already hard-coded the offset of the Link Control 2 register.

The hard-coded Link Control 2 offset was 0xdc.  Link Control 2 is at offset
0x30 into the PCIe capability, so the capability itself must be at
0xdc - 0x30 = 0xac.

Hard-code the PCIe capability offset, which means we don't have to search
for it and we can use the standard definitions for registers within the
capability.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index e9210f6..0b999a9 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -63,6 +63,8 @@
 #define OARR_SIZE_CFG_SHIFT          1
 #define OARR_SIZE_CFG                BIT(OARR_SIZE_CFG_SHIFT)
 
+#define PCI_EXP_CAP			0xac
+
 #define MAX_NUM_OB_WINDOWS           2
 
 #define IPROC_PCIE_REG_INVALID 0xffff
@@ -261,7 +263,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 	struct device *dev = pcie->dev;
 	u8 hdr_type;
 	u32 link_ctrl, class, val;
-	u16 pos, link_status;
+	u16 pos = PCI_EXP_CAP, link_status;
 	bool link_is_active = false;
 
 	/*
@@ -294,30 +296,27 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 	pci_bus_write_config_dword(bus, 0, PCI_BRIDGE_CTRL_REG_OFFSET, class);
 
 	/* check link status to see if link is active */
-	pos = pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP);
 	pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA, &link_status);
 	if (link_status & PCI_EXP_LNKSTA_NLW)
 		link_is_active = true;
 
 	if (!link_is_active) {
 		/* try GEN 1 link speed */
-#define PCI_LINK_STATUS_CTRL_2_OFFSET 0x0dc
 #define PCI_TARGET_LINK_SPEED_MASK    0xf
 #define PCI_TARGET_LINK_SPEED_GEN2    0x2
 #define PCI_TARGET_LINK_SPEED_GEN1    0x1
 		pci_bus_read_config_dword(bus, 0,
-					  PCI_LINK_STATUS_CTRL_2_OFFSET,
+					  pos + PCI_EXP_LNKCTL2,
 					  &link_ctrl);
 		if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
 		    PCI_TARGET_LINK_SPEED_GEN2) {
 			link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
 			link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
 			pci_bus_write_config_dword(bus, 0,
-					   PCI_LINK_STATUS_CTRL_2_OFFSET,
+					   pos + PCI_EXP_LNKCTL2,
 					   link_ctrl);
 			msleep(100);
 
-			pos = pci_bus_find_capability(bus, 0, PCI_CAP_ID_EXP);
 			pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA,
 						 &link_status);
 			if (link_status & PCI_EXP_LNKSTA_NLW)

