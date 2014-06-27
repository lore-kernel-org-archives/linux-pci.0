Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:34485 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750971AbaF0Q42 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jun 2014 12:56:28 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com>
References: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1403888155-9709-2-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 27 Jun 2014 17:55:54 +0100
Subject: [PATCH 1/2] PCI: host: pcie-rcar: Use correct initial HW settings
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Although the R-Car PCIe driver works as it is, there are a number of
incorrect settings that this patch corrects. It corrects:
 - enabling the PCI Express Extended Cap ID.
 - setting Data Link Layer Link Active Reporting Capable.
 - terminating list of capabilities.

It also removes enabling the MAC data scrambling as this is the
default HW setting, and removes incorrect code to enable slave bus
mastering as this is done by the PCI core.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c06b888..680a8cc 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -483,14 +483,15 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
 
 	/* Initialize default capabilities. */
-	rcar_rmw32(pcie, REXPCAP(0), 0, PCI_CAP_ID_EXP);
+	rcar_rmw32(pcie, REXPCAP(0), 0xff, PCI_CAP_ID_EXP);
 	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
 		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
 	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
 		PCI_HEADER_TYPE_BRIDGE);
 
 	/* Enable data link layer active state reporting */
-	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), 0, PCI_EXP_LNKCAP_DLLLARC);
+	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_DLLLARC,
+		PCI_EXP_LNKCAP_DLLLARC);
 
 	/* Write out the physical slot number = 0 */
 	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
@@ -499,10 +500,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	rcar_rmw32(pcie, TLCTLR+1, 0x3f, 50);
 
 	/* Terminate list of capabilities (Next Capability Offset=0) */
-	rcar_rmw32(pcie, RVCCAP(0), 0xfff0, 0);
-
-	/* Enable MAC data scrambling. */
-	rcar_rmw32(pcie, MACCTLR, SCRAMBLE_DISABLE, 0);
+	rcar_rmw32(pcie, RVCCAP(0), 0xfff00000, 0);
 
 	/* Enable MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI))
@@ -519,11 +517,6 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	/* Enable INTx interrupts */
 	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
 
-	/* Enable slave Bus Mastering */
-	rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
-		PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-		PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);
-
 	wmb();
 
 	return 0;
-- 
2.0.0

