Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27988 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbEMGhy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 02:37:54 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhangjukuo@huawei.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] PCI: designware: Add 8 lanes support
Date: Wed, 13 May 2015 14:44:34 +0800
Message-ID: <1431499474-102380-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds 8 lanes support. Following suggestion from Arnd, just split
this patch from http://www.spinics.net/lists/linux-pci/msg40467.html

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pcie-designware.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84f..4ce0aa5 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -31,6 +31,7 @@
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
 #define PORT_LINK_MODE_2_LANES		(0x3 << 16)
 #define PORT_LINK_MODE_4_LANES		(0x7 << 16)
+#define PORT_LINK_MODE_8_LANES		(0xf << 16)
 
 #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
 #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
@@ -38,6 +39,7 @@
 #define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
 #define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
 #define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
+#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
 
 #define PCIE_MSI_ADDR_LO		0x820
 #define PCIE_MSI_ADDR_HI		0x824
@@ -778,6 +780,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	case 4:
 		val |= PORT_LINK_MODE_4_LANES;
 		break;
+	case 8:
+		val |= PORT_LINK_MODE_8_LANES;
+		break;
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
 
@@ -794,6 +799,9 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	case 4:
 		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
+	case 8:
+		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
+		break;
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
-- 
1.9.1

