Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:11461
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403811AbeHATBQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 15:01:16 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/3] PCI: xilinx-nwl: Save error IRQ number in device_node private data
Date: Wed, 1 Aug 2018 22:14:47 +0530
Message-ID: <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xilinx ZynqMP PS PCIe has dedicated interrupt line for
reporting PCIe errors along with AER.
Save this error irq number in struct device_node private data,
this will be used via PCI qiurks for AER kernel service.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840..d505fe5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -663,6 +663,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	u32 breg_val, ecam_val, first_busno = 0;
 	int err;
+#ifdef CONFIG_PCIEAER
+	struct device_node *node = dev->of_node;
+#endif
 
 	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
 	if (!breg_val) {
@@ -744,6 +747,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 			pcie->irq_misc);
 		return err;
 	}
+#ifdef CONFIG_PCIEAER
+	node->data =  &pcie->irq_misc;
+#endif
 
 	/* Disable all misc interrupts */
 	nwl_bridge_writel(pcie, (u32)~MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
-- 
1.7.1
