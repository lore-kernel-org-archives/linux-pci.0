Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbdIES1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:27:02 -0400
Subject: [PATCH 1/4] PCI: iproc: Rename PCI_EXP_CAP to IPROC_PCI_EXP_CAP
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Tue, 05 Sep 2017 13:27:00 -0500
Message-ID: <20170905182700.27030.79516.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_EXP_CAP is an iProc-specific value, so rename it to IPROC_PCI_EXP_CAP
to make it obvious that it's not related to the generic values like
PCI_EXP_RTCTL, etc.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2e5aaaff55..4e83a9ffa5e2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -93,7 +93,7 @@
 #define IMAP_VALID_SHIFT             0
 #define IMAP_VALID                   BIT(IMAP_VALID_SHIFT)
 
-#define PCI_EXP_CAP			0xac
+#define IPROC_PCI_EXP_CAP		0xac
 
 #define IPROC_PCIE_REG_INVALID 0xffff
 
@@ -528,7 +528,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 			return ret;
 
 		/* Don't advertise CRS SV support */
-		if ((where & ~0x3) == PCI_EXP_CAP + PCI_EXP_RTCTL)
+		if ((where & ~0x3) == IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL)
 			*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 		return PCIBIOS_SUCCESSFUL;
 	}
@@ -710,7 +710,6 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	u32 hdr_type, link_ctrl, link_status, class, val;
-	u16 pos = PCI_EXP_CAP;
 	bool link_is_active = false;
 
 	/*
@@ -745,7 +744,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 				     4, class);
 
 	/* check link status to see if link is active */
-	iproc_pci_raw_config_read32(pcie, 0, pos + PCI_EXP_LNKSTA,
+	iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
 				    2, &link_status);
 	if (link_status & PCI_EXP_LNKSTA_NLW)
 		link_is_active = true;
@@ -756,20 +755,20 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 #define PCI_TARGET_LINK_SPEED_GEN2    0x2
 #define PCI_TARGET_LINK_SPEED_GEN1    0x1
 		iproc_pci_raw_config_read32(pcie, 0,
-					  pos + PCI_EXP_LNKCTL2, 4,
-					  &link_ctrl);
+					    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
+					    4, &link_ctrl);
 		if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
 		    PCI_TARGET_LINK_SPEED_GEN2) {
 			link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
 			link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
 			iproc_pci_raw_config_write32(pcie, 0,
-						pos + PCI_EXP_LNKCTL2,
-						4, link_ctrl);
+					IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
+					4, link_ctrl);
 			msleep(100);
 
 			iproc_pci_raw_config_read32(pcie, 0,
-						pos + PCI_EXP_LNKSTA,
-						2, &link_status);
+					IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
+					2, &link_status);
 			if (link_status & PCI_EXP_LNKSTA_NLW)
 				link_is_active = true;
 		}
