Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:43915 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbbFBCHy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 22:07:54 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhangjukuo@huawei.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] PCI: designware: set PORT_LOGIC_SPEED_CHANGE before linkup
Date: Tue, 2 Jun 2015 10:14:33 +0800
Message-ID: <1433211273-226508-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When connected some PCIe3.0 cards(e.g. LSI 2208 PCIe-RAID card, Mellanox IB card),
It will appear link unstable which will lead reading/writing fail.

Here just move the setting of PORT_LOGIC_SPEED_CHANGE bit before starting
building link. After doing this, it will work fine with above PCIe3.0 card.

This patch is based on v4.1-rc4

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/pcie-designware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84f..64ebc51 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -498,10 +498,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	/* program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
 
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
-
 #ifdef CONFIG_PCI_MSI
 	dw_pcie_msi_chip.dev = pp->dev;
 	dw_pci.msi_ctrl = &dw_pcie_msi_chip;
@@ -797,6 +793,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	}
 	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
 
+	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
+	val |= PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
+
 	/* setup RC BARs */
 	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
 	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
-- 
1.9.1

