Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45496 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbdHWHE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:04:26 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 08/10] PCI: rockchip: disable vpcie0v9 for resume_noirq error handling path
Date: Wed, 23 Aug 2017 15:03:17 +0800
Message-Id: <1503471797-74110-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Need to disable vpcie0v9 regulator if failing to finish
resume_noirq callback.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 42dcb3d..6dbd3fd 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1481,7 +1481,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 	err = rockchip_pcie_enable_clocks(rockchip);
 	if (err)
-		return err;
+		goto err_disable_0v9;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
@@ -1501,6 +1501,9 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	rockchip_pcie_deinit_phys(rockchip);
 err_pcie_resume:
 	rockchip_pcie_disable_clocks(rockchip);
+err_disable_0v9:
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
 	return err;
 }
 
-- 
1.9.1
