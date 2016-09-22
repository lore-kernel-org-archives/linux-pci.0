Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35821 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758132AbcIVWiz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 18:38:55 -0400
Received: by mail-pa0-f47.google.com with SMTP id oz2so33366673pac.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 15:38:55 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Cc: Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Subject: [PATCH v2] PCI: rockchip: Increase the Max Credit update interval.
Date: Thu, 22 Sep 2016 15:38:12 -0700
Message-Id: <1474583892-8936-1-git-send-email-rajatja@google.com>
In-Reply-To: <1474578027-64292-1-git-send-email-rajatja@google.com>
References: <1474578027-64292-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This increases the likelihood of link state to automatically go to L1
and save some power.

The default credit update interval of 7.5 us results in the rootport
sending UpdateFC packets too often, thus reulting in the link never
going to L1, and always staying in L0/L0s. The value 24 us was chosen
after some experiments and peeking over the PCIe bus to see that we do
enter L1 substate when there is not enough traffic on the PCIe bus.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Update the register on Phy link bandwidth changes,
    since the value gets lost on such events.

 drivers/pci/host/pcie-rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c3593e6..99e700f 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -95,6 +95,11 @@
 #define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
 #define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
 #define   PCIE_CORE_PL_CONF_LANE_SHIFT		1
+#define PCIE_CORE_TXCREDIT_CFG1		(PCIE_CORE_CTRL_MGMT_BASE + 0x020)
+#define   PCIE_CORE_TXCREDIT_CFG1_MUI_MASK	0xFFFF0000
+#define   PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT	16
+#define   PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(x) \
+		(((x) >> 3) << PCIE_CORE_TXCREDIT_CFG1_MUI_SHIFT)
 #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define   PCIE_CORE_INT_PRFPE			BIT(0)
 #define   PCIE_CORE_INT_CRFPE			BIT(1)
@@ -224,6 +229,17 @@ static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
 }
 
+static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
+{
+	u32 val;
+
+	/* Update Tx credit maximum update interval */
+	val = rockchip_pcie_read(rockchip, PCIE_CORE_TXCREDIT_CFG1);
+	val &= ~PCIE_CORE_TXCREDIT_CFG1_MUI_MASK;
+	val |= PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(24000);	/* ns */
+	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
+}
+
 static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 				      struct pci_bus *bus, int dev)
 {
@@ -597,6 +613,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
 	} else if (reg & PCIE_CLIENT_INT_PHY) {
 		dev_dbg(dev, "phy link changes\n");
+		rockchip_pcie_update_txcredit_mui(rockchip);
 		rockchip_pcie_clr_bw_int(rockchip);
 	}
 
-- 
2.8.0.rc3.226.g39d4020

