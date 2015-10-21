Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47496 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbJUSnI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 14:43:08 -0400
Subject: [PATCH v4 3/4] PCI: designware: Use common LTSSM_STATE_L0 definition
To: Fabio Estevam <festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com, l.stach@pengutronix.de
Date: Wed, 21 Oct 2015 13:43:05 -0500
Message-ID: <20151021184305.28724.39145.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a common #define for LTSSM_STATE_L0 and use it in all the
DesignWare-based drivers.

Based-on-patch-from: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |    1 -
 drivers/pci/host/pci-layerscape.c  |    3 +--
 drivers/pci/host/pcie-designware.h |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 95a8b13..c00ba57 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -25,7 +25,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        1
-#define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
 #define OB_XLAT_EN_VAL		        2
 
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index f02752e..930b193 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -29,7 +29,6 @@
 /* PEX1/2 Misc Ports Status Register */
 #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
 #define LTSSM_STATE_SHIFT	20
-#define LTSSM_PCIE_L0		0x11 /* L0 state */
 
 /* Symbol Timer Register and Filter Mask Register 1 */
 #define PCIE_STRFMR1 0x71c
@@ -55,7 +54,7 @@ static int ls_pcie_link_up(struct pcie_port *pp)
 	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
 	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
 
-	if (state < LTSSM_PCIE_L0)
+	if (state < LTSSM_STATE_L0)
 		return 0;
 
 	return 1;
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f3a7583..33f74a8 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -23,6 +23,7 @@
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
 #define LTSSM_STATE_RCVRY_LOCK		0x0d
+#define LTSSM_STATE_L0			0x11
 #define LTSSM_STATE_MASK		0x1f
 
 struct pcie_port {

