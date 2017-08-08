Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ravi Shankar Jonnalagadda <venkata.ravi.jonnalagadda@xilinx.com>
To: <bhelgaas@google.com>, <michal.simek@xilinx.com>,
        <soren.brinkmann@xilinx.com>, <lorenzo.pieralisi@arm.com>,
        <bharat.kumar.gogada@xilinx.com>, <vjonnal@xilinx.com>,
        <paul.gortmaker@windriver.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vinod.koul@intel.com>, <dmaengine@vger.kernel.org>
Subject: [PATCH 1/4] PCI:xilinx-nwl: Enable Root DMA
Date: Tue, 8 Aug 2017 16:42:16 +0530
Message-ID: <1502190739-13474-2-git-send-email-vjonnal@xilinx.com>
In-Reply-To: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
References: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enabling Root DMA interrupts

Adding Root DMA translations to bridge for Register Access

Signed-off-by: Ravi Shankar Jonnalagadda <vjonnal@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index eec641a..5766582 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -39,6 +39,11 @@
 #define E_ECAM_CONTROL			0x00000228
 #define E_ECAM_BASE_LO			0x00000230
 #define E_ECAM_BASE_HI			0x00000234
+#define E_DREG_CTRL			0x00000288
+#define E_DREG_BASE_LO			0x00000290
+
+#define DREG_DMA_EN			BIT(0)
+#define DREG_DMA_BASE_LO		0xFD0F0000
 
 /* Ingress - address translations */
 #define I_MSII_CAPABILITIES		0x00000300
@@ -57,6 +62,10 @@
 #define MSGF_MSI_STATUS_HI		0x00000444
 #define MSGF_MSI_MASK_LO		0x00000448
 #define MSGF_MSI_MASK_HI		0x0000044C
+/* Root DMA Interrupt register */
+#define MSGF_DMA_MASK			0x00000464
+
+#define MSGF_INTR_EN			BIT(0)
 
 /* Msg filter mask bits */
 #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
@@ -766,6 +775,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
 
+	/* Enabling DREG translations */
+	nwl_bridge_writel(pcie, DREG_DMA_EN, E_DREG_CTRL);
+	nwl_bridge_writel(pcie, DREG_DMA_BASE_LO, E_DREG_BASE_LO);
+	/* Enabling Root DMA interrupts */
+	nwl_bridge_writel(pcie, MSGF_INTR_EN, MSGF_DMA_MASK);
+
 	/* Enable all legacy interrupts */
 	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
-- 
2.1.1
