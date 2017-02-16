Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:38984 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdBPHcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 02:32:14 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: fix wrong setting of vendor ID
Date: Thu, 16 Feb 2017 15:29:35 +0800
Message-Id: <1487230175-213629-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The TRM says that the vendor ID in RC's configure
space could be rewrote and the value must be the same
as the value read from the local core configure space.
But we misread that and didn't notice it before. Actually
we should only able to rewrite it from the local core
configure space. This patch fix that issue in order to make
lspci show the correct IP vendor infomation.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c0b3b65..26ddd35 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -125,6 +125,7 @@
 #define   PCIE_CORE_INT_CT			BIT(11)
 #define   PCIE_CORE_INT_UTC			BIT(18)
 #define   PCIE_CORE_INT_MMVC			BIT(19)
+#define PCIE_CORE_CONFIG_VENDOR		(PCIE_CORE_CTRL_MGMT_BASE + 0x44)
 #define PCIE_CORE_INT_MASK		(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
 #define PCIE_RC_BAR_CONF		(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
 
@@ -138,7 +139,6 @@
 		 PCIE_CORE_INT_MMVC)
 
 #define PCIE_RC_CONFIG_BASE		0xa00000
-#define PCIE_RC_CONFIG_VENDOR		(PCIE_RC_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
@@ -637,7 +637,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	dev_dbg(dev, "current link width is x%d\n", status);
 
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
-			    PCIE_RC_CONFIG_VENDOR);
+			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
 			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
 			    PCIE_RC_CONFIG_RID_CCR);
-- 
1.9.1
