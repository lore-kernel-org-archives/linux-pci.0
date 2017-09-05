Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbdIES1J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:27:09 -0400
Subject: [PATCH 2/4] PCI: iproc: Clean up whitespace
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Tue, 05 Sep 2017 13:27:07 -0500
Message-ID: <20170905182707.27030.43056.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use tabs (not spaces) for indentation.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc.c |  231 ++++++++++++++++++++---------------------
 1 file changed, 115 insertions(+), 116 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 4e83a9ffa5e2..3a8b9d20ee57 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -31,71 +31,71 @@
 
 #include "pcie-iproc.h"
 
-#define EP_PERST_SOURCE_SELECT_SHIFT 2
-#define EP_PERST_SOURCE_SELECT       BIT(EP_PERST_SOURCE_SELECT_SHIFT)
-#define EP_MODE_SURVIVE_PERST_SHIFT  1
-#define EP_MODE_SURVIVE_PERST        BIT(EP_MODE_SURVIVE_PERST_SHIFT)
-#define RC_PCIE_RST_OUTPUT_SHIFT     0
-#define RC_PCIE_RST_OUTPUT           BIT(RC_PCIE_RST_OUTPUT_SHIFT)
-#define PAXC_RESET_MASK              0x7f
-
-#define GIC_V3_CFG_SHIFT             0
-#define GIC_V3_CFG                   BIT(GIC_V3_CFG_SHIFT)
-
-#define MSI_ENABLE_CFG_SHIFT         0
-#define MSI_ENABLE_CFG               BIT(MSI_ENABLE_CFG_SHIFT)
-
-#define CFG_IND_ADDR_MASK            0x00001ffc
-
-#define CFG_ADDR_BUS_NUM_SHIFT       20
-#define CFG_ADDR_BUS_NUM_MASK        0x0ff00000
-#define CFG_ADDR_DEV_NUM_SHIFT       15
-#define CFG_ADDR_DEV_NUM_MASK        0x000f8000
-#define CFG_ADDR_FUNC_NUM_SHIFT      12
-#define CFG_ADDR_FUNC_NUM_MASK       0x00007000
-#define CFG_ADDR_REG_NUM_SHIFT       2
-#define CFG_ADDR_REG_NUM_MASK        0x00000ffc
-#define CFG_ADDR_CFG_TYPE_SHIFT      0
-#define CFG_ADDR_CFG_TYPE_MASK       0x00000003
-
-#define SYS_RC_INTX_MASK             0xf
-
-#define PCIE_PHYLINKUP_SHIFT         3
-#define PCIE_PHYLINKUP               BIT(PCIE_PHYLINKUP_SHIFT)
-#define PCIE_DL_ACTIVE_SHIFT         2
-#define PCIE_DL_ACTIVE               BIT(PCIE_DL_ACTIVE_SHIFT)
-
-#define APB_ERR_EN_SHIFT             0
-#define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
-
-#define CFG_RETRY_STATUS             0xffff0001
-#define CFG_RETRY_STATUS_TIMEOUT_US  500000 /* 500 milliseconds */
+#define EP_PERST_SOURCE_SELECT_SHIFT	2
+#define EP_PERST_SOURCE_SELECT		BIT(EP_PERST_SOURCE_SELECT_SHIFT)
+#define EP_MODE_SURVIVE_PERST_SHIFT	1
+#define EP_MODE_SURVIVE_PERST		BIT(EP_MODE_SURVIVE_PERST_SHIFT)
+#define RC_PCIE_RST_OUTPUT_SHIFT	0
+#define RC_PCIE_RST_OUTPUT		BIT(RC_PCIE_RST_OUTPUT_SHIFT)
+#define PAXC_RESET_MASK			0x7f
+
+#define GIC_V3_CFG_SHIFT		0
+#define GIC_V3_CFG			BIT(GIC_V3_CFG_SHIFT)
+
+#define MSI_ENABLE_CFG_SHIFT		0
+#define MSI_ENABLE_CFG			BIT(MSI_ENABLE_CFG_SHIFT)
+
+#define CFG_IND_ADDR_MASK		0x00001ffc
+
+#define CFG_ADDR_BUS_NUM_SHIFT		20
+#define CFG_ADDR_BUS_NUM_MASK		0x0ff00000
+#define CFG_ADDR_DEV_NUM_SHIFT		15
+#define CFG_ADDR_DEV_NUM_MASK		0x000f8000
+#define CFG_ADDR_FUNC_NUM_SHIFT		12
+#define CFG_ADDR_FUNC_NUM_MASK		0x00007000
+#define CFG_ADDR_REG_NUM_SHIFT		2
+#define CFG_ADDR_REG_NUM_MASK		0x00000ffc
+#define CFG_ADDR_CFG_TYPE_SHIFT		0
+#define CFG_ADDR_CFG_TYPE_MASK		0x00000003
+
+#define SYS_RC_INTX_MASK		0xf
+
+#define PCIE_PHYLINKUP_SHIFT		3
+#define PCIE_PHYLINKUP			BIT(PCIE_PHYLINKUP_SHIFT)
+#define PCIE_DL_ACTIVE_SHIFT		2
+#define PCIE_DL_ACTIVE			BIT(PCIE_DL_ACTIVE_SHIFT)
+
+#define APB_ERR_EN_SHIFT		0
+#define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
+
+#define CFG_RETRY_STATUS		0xffff0001
+#define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
 
 /* derive the enum index of the outbound/inbound mapping registers */
-#define MAP_REG(base_reg, index)      ((base_reg) + (index) * 2)
+#define MAP_REG(base_reg, index)	((base_reg) + (index) * 2)
 
 /*
  * Maximum number of outbound mapping window sizes that can be supported by any
  * OARR/OMAP mapping pair
  */
-#define MAX_NUM_OB_WINDOW_SIZES      4
+#define MAX_NUM_OB_WINDOW_SIZES		4
 
-#define OARR_VALID_SHIFT             0
-#define OARR_VALID                   BIT(OARR_VALID_SHIFT)
-#define OARR_SIZE_CFG_SHIFT          1
+#define OARR_VALID_SHIFT		0
+#define OARR_VALID			BIT(OARR_VALID_SHIFT)
+#define OARR_SIZE_CFG_SHIFT		1
 
 /*
  * Maximum number of inbound mapping region sizes that can be supported by an
  * IARR
  */
-#define MAX_NUM_IB_REGION_SIZES      9
+#define MAX_NUM_IB_REGION_SIZES		9
 
-#define IMAP_VALID_SHIFT             0
-#define IMAP_VALID                   BIT(IMAP_VALID_SHIFT)
+#define IMAP_VALID_SHIFT		0
+#define IMAP_VALID			BIT(IMAP_VALID_SHIFT)
 
 #define IPROC_PCI_EXP_CAP		0xac
 
-#define IPROC_PCIE_REG_INVALID 0xffff
+#define IPROC_PCIE_REG_INVALID		0xffff
 
 /**
  * iProc PCIe outbound mapping controller specific parameters
@@ -307,80 +307,80 @@ enum iproc_pcie_reg {
 
 /* iProc PCIe PAXB BCMA registers */
 static const u16 iproc_pcie_reg_paxb_bcma[] = {
-	[IPROC_PCIE_CLK_CTRL]         = 0x000,
-	[IPROC_PCIE_CFG_IND_ADDR]     = 0x120,
-	[IPROC_PCIE_CFG_IND_DATA]     = 0x124,
-	[IPROC_PCIE_CFG_ADDR]         = 0x1f8,
-	[IPROC_PCIE_CFG_DATA]         = 0x1fc,
-	[IPROC_PCIE_INTX_EN]          = 0x330,
-	[IPROC_PCIE_LINK_STATUS]      = 0xf0c,
+	[IPROC_PCIE_CLK_CTRL]		= 0x000,
+	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
+	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
+	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
+	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
+	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 };
 
 /* iProc PCIe PAXB registers */
 static const u16 iproc_pcie_reg_paxb[] = {
-	[IPROC_PCIE_CLK_CTRL]         = 0x000,
-	[IPROC_PCIE_CFG_IND_ADDR]     = 0x120,
-	[IPROC_PCIE_CFG_IND_DATA]     = 0x124,
-	[IPROC_PCIE_CFG_ADDR]         = 0x1f8,
-	[IPROC_PCIE_CFG_DATA]         = 0x1fc,
-	[IPROC_PCIE_INTX_EN]          = 0x330,
-	[IPROC_PCIE_OARR0]            = 0xd20,
-	[IPROC_PCIE_OMAP0]            = 0xd40,
-	[IPROC_PCIE_OARR1]            = 0xd28,
-	[IPROC_PCIE_OMAP1]            = 0xd48,
-	[IPROC_PCIE_LINK_STATUS]      = 0xf0c,
-	[IPROC_PCIE_APB_ERR_EN]       = 0xf40,
+	[IPROC_PCIE_CLK_CTRL]		= 0x000,
+	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
+	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
+	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
+	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
+	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_OARR0]		= 0xd20,
+	[IPROC_PCIE_OMAP0]		= 0xd40,
+	[IPROC_PCIE_OARR1]		= 0xd28,
+	[IPROC_PCIE_OMAP1]		= 0xd48,
+	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
+	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 };
 
 /* iProc PCIe PAXB v2 registers */
 static const u16 iproc_pcie_reg_paxb_v2[] = {
-	[IPROC_PCIE_CLK_CTRL]         = 0x000,
-	[IPROC_PCIE_CFG_IND_ADDR]     = 0x120,
-	[IPROC_PCIE_CFG_IND_DATA]     = 0x124,
-	[IPROC_PCIE_CFG_ADDR]         = 0x1f8,
-	[IPROC_PCIE_CFG_DATA]         = 0x1fc,
-	[IPROC_PCIE_INTX_EN]          = 0x330,
-	[IPROC_PCIE_OARR0]            = 0xd20,
-	[IPROC_PCIE_OMAP0]            = 0xd40,
-	[IPROC_PCIE_OARR1]            = 0xd28,
-	[IPROC_PCIE_OMAP1]            = 0xd48,
-	[IPROC_PCIE_OARR2]            = 0xd60,
-	[IPROC_PCIE_OMAP2]            = 0xd68,
-	[IPROC_PCIE_OARR3]            = 0xdf0,
-	[IPROC_PCIE_OMAP3]            = 0xdf8,
-	[IPROC_PCIE_IARR0]            = 0xd00,
-	[IPROC_PCIE_IMAP0]            = 0xc00,
-	[IPROC_PCIE_IARR2]            = 0xd10,
-	[IPROC_PCIE_IMAP2]            = 0xcc0,
-	[IPROC_PCIE_IARR3]            = 0xe00,
-	[IPROC_PCIE_IMAP3]            = 0xe08,
-	[IPROC_PCIE_IARR4]            = 0xe68,
-	[IPROC_PCIE_IMAP4]            = 0xe70,
-	[IPROC_PCIE_LINK_STATUS]      = 0xf0c,
-	[IPROC_PCIE_APB_ERR_EN]       = 0xf40,
+	[IPROC_PCIE_CLK_CTRL]		= 0x000,
+	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
+	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
+	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
+	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
+	[IPROC_PCIE_INTX_EN]		= 0x330,
+	[IPROC_PCIE_OARR0]		= 0xd20,
+	[IPROC_PCIE_OMAP0]		= 0xd40,
+	[IPROC_PCIE_OARR1]		= 0xd28,
+	[IPROC_PCIE_OMAP1]		= 0xd48,
+	[IPROC_PCIE_OARR2]		= 0xd60,
+	[IPROC_PCIE_OMAP2]		= 0xd68,
+	[IPROC_PCIE_OARR3]		= 0xdf0,
+	[IPROC_PCIE_OMAP3]		= 0xdf8,
+	[IPROC_PCIE_IARR0]		= 0xd00,
+	[IPROC_PCIE_IMAP0]		= 0xc00,
+	[IPROC_PCIE_IARR2]		= 0xd10,
+	[IPROC_PCIE_IMAP2]		= 0xcc0,
+	[IPROC_PCIE_IARR3]		= 0xe00,
+	[IPROC_PCIE_IMAP3]		= 0xe08,
+	[IPROC_PCIE_IARR4]		= 0xe68,
+	[IPROC_PCIE_IMAP4]		= 0xe70,
+	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
+	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 };
 
 /* iProc PCIe PAXC v1 registers */
 static const u16 iproc_pcie_reg_paxc[] = {
-	[IPROC_PCIE_CLK_CTRL]         = 0x000,
-	[IPROC_PCIE_CFG_IND_ADDR]     = 0x1f0,
-	[IPROC_PCIE_CFG_IND_DATA]     = 0x1f4,
-	[IPROC_PCIE_CFG_ADDR]         = 0x1f8,
-	[IPROC_PCIE_CFG_DATA]         = 0x1fc,
+	[IPROC_PCIE_CLK_CTRL]		= 0x000,
+	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
+	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
+	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
+	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 };
 
 /* iProc PCIe PAXC v2 registers */
 static const u16 iproc_pcie_reg_paxc_v2[] = {
-	[IPROC_PCIE_MSI_GIC_MODE]     = 0x050,
-	[IPROC_PCIE_MSI_BASE_ADDR]    = 0x074,
-	[IPROC_PCIE_MSI_WINDOW_SIZE]  = 0x078,
-	[IPROC_PCIE_MSI_ADDR_LO]      = 0x07c,
-	[IPROC_PCIE_MSI_ADDR_HI]      = 0x080,
-	[IPROC_PCIE_MSI_EN_CFG]       = 0x09c,
-	[IPROC_PCIE_CFG_IND_ADDR]     = 0x1f0,
-	[IPROC_PCIE_CFG_IND_DATA]     = 0x1f4,
-	[IPROC_PCIE_CFG_ADDR]         = 0x1f8,
-	[IPROC_PCIE_CFG_DATA]         = 0x1fc,
+	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
+	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
+	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
+	[IPROC_PCIE_MSI_ADDR_LO]	= 0x07c,
+	[IPROC_PCIE_MSI_ADDR_HI]	= 0x080,
+	[IPROC_PCIE_MSI_EN_CFG]		= 0x09c,
+	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
+	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
+	[IPROC_PCIE_CFG_ADDR]		= 0x1f8,
+	[IPROC_PCIE_CFG_DATA]		= 0x1fc,
 };
 
 static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
@@ -511,7 +511,7 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 }
 
 static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
-				    int where, int size, u32 *val)
+				  int where, int size, u32 *val)
 {
 	struct iproc_pcie *pcie = iproc_data(bus);
 	unsigned int slot = PCI_SLOT(devfn);
@@ -552,8 +552,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
  * by 'pci_lock' in drivers/pci/access.c
  */
 static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
-					    int busno,
-					    unsigned int devfn,
+					    int busno, unsigned int devfn,
 					    int where)
 {
 	unsigned slot = PCI_SLOT(devfn);
@@ -726,16 +725,16 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 	}
 
 	/* make sure we are not in EP mode */
-	iproc_pci_raw_config_read32(pcie,  0, PCI_HEADER_TYPE, 1, &hdr_type);
+	iproc_pci_raw_config_read32(pcie, 0, PCI_HEADER_TYPE, 1, &hdr_type);
 	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
 		dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
 		return -EFAULT;
 	}
 
 	/* force class to PCI_CLASS_BRIDGE_PCI (0x0604) */
-#define PCI_BRIDGE_CTRL_REG_OFFSET 0x43c
-#define PCI_CLASS_BRIDGE_MASK      0xffff00
-#define PCI_CLASS_BRIDGE_SHIFT     8
+#define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
+#define PCI_CLASS_BRIDGE_MASK		0xffff00
+#define PCI_CLASS_BRIDGE_SHIFT		8
 	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
 				    4, &class);
 	class &= ~PCI_CLASS_BRIDGE_MASK;
@@ -751,9 +750,9 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 
 	if (!link_is_active) {
 		/* try GEN 1 link speed */
-#define PCI_TARGET_LINK_SPEED_MASK    0xf
-#define PCI_TARGET_LINK_SPEED_GEN2    0x2
-#define PCI_TARGET_LINK_SPEED_GEN1    0x1
+#define PCI_TARGET_LINK_SPEED_MASK	0xf
+#define PCI_TARGET_LINK_SPEED_GEN2	0x2
+#define PCI_TARGET_LINK_SPEED_GEN1	0x1
 		iproc_pci_raw_config_read32(pcie, 0,
 					    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
 					    4, &link_ctrl);
