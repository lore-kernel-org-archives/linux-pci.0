Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:58843 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbdEDCZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2017 22:25:55 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] PCI: rockchip: rename rockchip_cfg_atu to rockchip_pcie_cfg_atu
Date: Thu,  4 May 2017 10:24:48 +0800
Message-Id: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename it in order to keep the name consistent with other
functions' in pcie-rockchip.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c8ca796..ac08b4c 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1156,7 +1156,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
 	return 0;
 }
 
-static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
+static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
 	int offset;
@@ -1279,7 +1279,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 	if (err)
 		return err;
 
-	err = rockchip_cfg_atu(rockchip);
+	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		return err;
 
@@ -1396,7 +1396,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = rockchip_cfg_atu(rockchip);
+	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
 		goto err_free_res;
 
-- 
1.9.1
