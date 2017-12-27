Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:46018 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751278AbdL0BAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Dec 2017 20:00:05 -0500
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v5 2/2] PCI: mediatek: Set up class type and vendor ID for MT7622
Date: Wed, 27 Dec 2017 08:59:54 +0800
Message-ID: <1514336394-17747-3-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
References: <1514336394-17747-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

The hardware default value of IDs and class type is not correct,
fix that by setup the correct values before start up.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 12 ++++++++++++
 include/linux/pci_ids.h          |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index fc29a9a..62aac0ea 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -74,6 +74,10 @@
 
 /* PCIe V2 per-port registers */
 #define PCIE_MSI_VECTOR		0x0c0
+
+#define PCIE_CONF_ID		0x100
+#define PCIE_CONF_CLASS		0x104
+
 #define PCIE_INT_MASK		0x420
 #define INTX_MASK		GENMASK(19, 16)
 #define INTX_SHIFT		16
@@ -393,6 +397,14 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		val |= PCIE_CSR_LTSSM_EN(port->slot) |
 		       PCIE_CSR_ASPM_L1_EN(port->slot);
 		writel(val, pcie->base + PCIE_SYS_CFG_V2);
+
+		/* Set up vendor ID and device ID for MT7622*/
+		val = PCI_VENDOR_ID_MEDIATEK;
+		writel(val, port->base + PCIE_CONF_ID);
+
+		/* Set up class code for MT7622 */
+		val = PCI_CLASS_BRIDGE_PCI << 16;
+		writel(val, port->base + PCIE_CONF_CLASS);
 	}
 
 	/* Assert all reset signals */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab20dc5..2480b0e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2113,6 +2113,8 @@
 
 #define PCI_VENDOR_ID_MYRICOM		0x14c1
 
+#define PCI_VENDOR_ID_MEDIATEK		0x14c3
+
 #define PCI_VENDOR_ID_TITAN		0x14D2
 #define PCI_DEVICE_ID_TITAN_010L	0x8001
 #define PCI_DEVICE_ID_TITAN_100L	0x8010
-- 
2.6.4
