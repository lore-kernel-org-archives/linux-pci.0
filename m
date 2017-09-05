Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbdIES1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:27:16 -0400
Subject: [PATCH 3/4] PCI: xgene: Define XGENE_PCI_EXP_CAP and use generic
 PCI_EXP_RTCTL offset
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Tue, 05 Sep 2017 13:27:14 -0500
Message-ID: <20170905182714.27030.75573.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Apparently the PCIe capability is at address 0x40 in config space of X-Gene
v1 Root Ports.  Add a definition of that and use the generic PCI_EXP_RTCTL
offset into the capability.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index bd897479a215..af47ebd70e22 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -61,7 +61,7 @@
 #define SZ_1T				(SZ_1G*1024ULL)
 #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
 
-#define ROOT_CAP_AND_CTRL		0x5C
+#define XGENE_V1_PCI_EXP_CAP		0x40
 
 /* PCIe IP version */
 #define XGENE_PCIE_IP_VER_UNKN		0
@@ -189,7 +189,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 	 * Avoid this by not claiming to support CRS.
 	 */
 	if (pci_is_root_bus(bus) && (port->version == XGENE_PCIE_IP_VER_1) &&
-	    ((where & ~0x3) == ROOT_CAP_AND_CTRL))
+	    ((where & ~0x3) == XGENE_V1_PCI_EXP_CAP + PCI_EXP_RTCTL))
 		*val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
 
 	if (size <= 2)
