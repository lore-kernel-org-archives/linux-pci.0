Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35300 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964901AbcIVVAc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 17:00:32 -0400
Received: by mail-pa0-f51.google.com with SMTP id oz2so32700711pac.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 14:00:32 -0700 (PDT)
From: Rajat Jain <rajatja@google.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Cc: Rajat Jain <rajatja@google.com>
Subject: [PATCH] rockchip: Increase the Max Credit update interval.
Date: Thu, 22 Sep 2016 14:00:27 -0700
Message-Id: <1474578027-64292-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This increases the likelihood of link state to automatically go to L1
and save some power.

The default credit update interval of 7.5 us results in the rootport
sending UpdateFC packets too often, thus reulting in the link never
going to L1, and always staying in L0/L0s. The value 24 us was chosen
after some experiments and peeking over the PCIe bus to see that we do
enter L1 substate when there is not enough traffic on the PCIe bus.

The register value gets lost on a Link speed/width change, and the
ideal fix should reprogram this on that event (refer "Link Bandwidth
Management Interrupt Enable" & "Link Autonomous Bandwidth Interrupt Enable"
in link control reg?). But the rockchip platforms doesn't support hotplug
and I've verified that the retraining doesn't work as well, so this
should be OK.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/host/pcie-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c3593e6..e537413 100644
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
@@ -523,6 +528,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 			  PCIE_CORE_PL_CONF_LANE_MASK);
 	dev_dbg(dev, "current link width is x%d\n", status);
 
+	/* Update credit update interval */
+	status = rockchip_pcie_read(rockchip, PCIE_CORE_TXCREDIT_CFG1);
+	status &= ~PCIE_CORE_TXCREDIT_CFG1_MUI_MASK;
+	status |= PCIE_CORE_TXCREDIT_CFG1_MUI_ENCODE(24000);	/* ns */
+	rockchip_pcie_write(rockchip, status, PCIE_CORE_TXCREDIT_CFG1);
+
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
 			    PCIE_RC_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
-- 
2.8.0.rc3.226.g39d4020

