Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:36262 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034081AbcIWCFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 22:05:00 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] PCI: rockchip: fix wrong transmitted FTS count
Date: Fri, 23 Sep 2016 10:06:00 +0800
Message-Id: <1474596360-23483-2-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1474596360-23483-1-git-send-email-shawn.lin@rock-chips.com>
References: <1474596360-23483-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the expected numbers of FTS aren't recevied by RC when
exiting from L0s, the LTSSM will fall into recover state.
So it will need to send TS for retraining which makes the
latency of exiting from L0s a little longer than expected.
This issue is caused by the wrong reset value of FTS count
on PLC1 register(offset 0x4). The expected value for Gen1/2
should be more than 240 and we may leave a little margin here.
Let's fix this before starting Gen1 traning which will makes
TS1 contains the correct FTS count.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 5e51121..6a7a9df 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -95,6 +95,10 @@
 #define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
 #define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
 #define   PCIE_CORE_PL_CONF_LANE_SHIFT		1
+#define PCIE_CORE_CTRL_PLC1		(PCIE_CORE_CTRL_MGMT_BASE + 0x004)
+#define   PCIE_CORE_CTRL_PLC1_FTS_MASK		GENMASK(23, 8)
+#define   PCIE_CORE_CTRL_PLC1_FTS_SHIFT	8
+#define   PCIE_CORE_CTRL_PLC1_FTS_CNT		0xffff
 #define PCIE_CORE_INT_STATUS		(PCIE_CORE_CTRL_MGMT_BASE + 0x20c)
 #define   PCIE_CORE_INT_PRFPE			BIT(0)
 #define   PCIE_CORE_INT_CRFPE			BIT(1)
@@ -470,6 +474,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2);
 
+	/* Fix the transmitted FTS count desired to exit from L0s. */
+	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL_PLC1);
+	status = (status & PCIE_CORE_CTRL_PLC1_FTS_MASK) |
+		 (PCIE_CORE_CTRL_PLC1_FTS_CNT << PCIE_CORE_CTRL_PLC1_FTS_SHIFT);
+	rockchip_pcie_write(rockchip, status, PCIE_CORE_CTRL_PLC1);
+
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
-- 
2.3.7


