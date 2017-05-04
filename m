Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:53553 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdEDC0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2017 22:26:36 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] PCI: rockchip: reconfigure configuration space header type
Date: Thu,  4 May 2017 10:24:51 +0800
Message-Id: <1493864691-102523-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
References: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per PCIe base specification(Revision 3.1a), section 7.5.3,
type 1 configuration space header should be used when accessing
PCIe switch. So we need to reconfigure the header according to
the bus number we are accessing. Otherwise we could not visit the
buses behind the switch.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 76bb508..b2d7e53 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -380,6 +380,13 @@ static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
+	if (bus->parent->number == rockchip->root_bus_nr)
+		rockchip_pcie_cfg_configuration_accesses(rockchip,
+						AXI_WRAPPER_TYPE0_CFG);
+	else
+		rockchip_pcie_cfg_configuration_accesses(rockchip,
+						AXI_WRAPPER_TYPE1_CFG);
+
 	if (size == 4) {
 		*val = readl(rockchip->reg_base + busdev);
 	} else if (size == 2) {
@@ -404,6 +411,13 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 	if (!IS_ALIGNED(busdev, size))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
+	if (bus->parent->number == rockchip->root_bus_nr)
+		rockchip_pcie_cfg_configuration_accesses(rockchip,
+						AXI_WRAPPER_TYPE0_CFG);
+	else
+		rockchip_pcie_cfg_configuration_accesses(rockchip,
+						AXI_WRAPPER_TYPE1_CFG);
+
 	if (size == 4)
 		writel(val, rockchip->reg_base + busdev);
 	else if (size == 2)
-- 
1.9.1
