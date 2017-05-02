Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:35379 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdEBHc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 May 2017 03:32:58 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] PCI: rockchip: control vpcie0v9 for system PM
Date: Tue,  2 May 2017 15:31:23 +0800
Message-Id: <1493710283-164065-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

vpcie0v9 is used for PHY, so we could disable it as
we don't need PHY to work then in S3 if folks assign it
DT. But we should note that there is a side effect that
we could not support beacon wakeup if we disable vpcie0v9
for aggressive power-saving.

Cc: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0e020b6..c8ca796 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1251,6 +1251,9 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 	clk_disable_unprepare(rockchip->aclk_pcie);
 
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
+
 	return ret;
 }
 
@@ -1259,6 +1262,14 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
 
+	if (!IS_ERR(rockchip->vpcie0v9)) {
+		err = regulator_enable(rockchip->vpcie0v9);
+		if (err) {
+			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
+			return err;
+		}
+	}
+
 	clk_prepare_enable(rockchip->clk_pcie_pm);
 	clk_prepare_enable(rockchip->hclk_pcie);
 	clk_prepare_enable(rockchip->aclk_perf_pcie);
-- 
1.9.1
