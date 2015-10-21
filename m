Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47440 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbbJUSmy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 14:42:54 -0400
Subject: [PATCH v4 1/4] PCI: designware: Use common LTSSM_STATE_MASK
 definition
To: Fabio Estevam <festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com, l.stach@pengutronix.de
Date: Wed, 21 Oct 2015 13:42:50 -0500
Message-ID: <20151021184250.28724.41928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Add a common #define for LTSSM_STATE_MASK and use it in all the
DesignWare-based drivers.

Note that this changes LTSSM_STATE_MASK from 6 bits (0x3f) to 5 bits (0x1f)
for i.MX6 and Layerscape.  We believe this is safe for all DesignWare-based
PCIe cores.

[bhelgaas: changelog, move removal of unused SPEAr13xx #defines to separate
patch, add only LTSSM_STATE_MASK and change all users for reviewability]
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-imx6.c        |    3 +--
 drivers/pci/host/pci-keystone-dw.c |    1 -
 drivers/pci/host/pci-layerscape.c  |    1 -
 drivers/pci/host/pcie-designware.h |    2 ++
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 6f43086..7b0d120 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -55,7 +55,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
-#define PCIE_PHY_DEBUG_R0_LTSSM_MASK		(0x3f << 0)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
@@ -508,7 +507,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
 		return 0;
 
-	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
+	if ((debug_r0 & LTSSM_STATE_MASK) != 0x0d)
 		return 0;
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index e71da99..95a8b13 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -25,7 +25,6 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        1
-#define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
 #define OB_XLAT_EN_VAL		        2
diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index b2328ea1..f02752e 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -29,7 +29,6 @@
 /* PEX1/2 Misc Ports Status Register */
 #define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
 #define LTSSM_STATE_SHIFT	20
-#define LTSSM_STATE_MASK	0x3f
 #define LTSSM_PCIE_L0		0x11 /* L0 state */
 
 /* Symbol Timer Register and Filter Mask Register 1 */
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..a1a76ff 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,6 +22,8 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+#define LTSSM_STATE_MASK		0x1f
+
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;

