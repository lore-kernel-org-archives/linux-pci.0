Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:40683 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdEDIlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2017 04:41:08 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: Configure RC's MPS setting
Date: Thu,  4 May 2017 16:40:04 +0800
Message-Id: <1493887204-5501-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The default value of MPS for RC is 128 bytes, but actually
it could support 256 bytes. So this patch fix this issue.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0e020b6..a05fec5 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -146,6 +146,9 @@
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
 #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
 #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
+#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
+#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
+#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
 #define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
 #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
 #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
@@ -664,6 +667,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
 	}
 
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
+	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
+	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+
 	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
 
 	rockchip_pcie_write(rockchip,
-- 
1.9.1
