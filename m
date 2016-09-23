Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:58807 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbcIWCE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 22:04:56 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: rockchip: improve the deassert sequence of four reset pins
Date: Fri, 23 Sep 2016 10:05:59 +0800
Message-Id: <1474596360-23483-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per TRM, we need to deassert the four reset pins simultaneously.
Currently the reset framework doesn't support that so we did it
one by one. It seems no side effect found but it does impact the
state machine of controller, so sometimes the change speed bit is
not setted when sending training sequence from recover state.
After the silicon RTL review from Soc guys, we don't need to do
the sequence recommended by TRM, and could just move the deassert
of mgmt_sticky_rst to the first place.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c3593e6..5e51121 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -433,21 +433,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
-	err = reset_control_deassert(rockchip->core_rst);
+	/*
+	 * Please don't reorder the deassert sequence of the following
+	 * four reset pins.
+	 */
+	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(dev, "deassert core_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(rockchip->mgmt_rst);
+	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
-		dev_err(dev, "deassert mgmt_rst err %d\n", err);
+		dev_err(dev, "deassert core_rst err %d\n", err);
 		return err;
 	}
 
-	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
+	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_rst err %d\n", err);
 		return err;
 	}
 
-- 
2.3.7


