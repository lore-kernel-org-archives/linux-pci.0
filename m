Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:36225 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdF2BZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2017 21:25:40 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] PCI: rockchip: use local variable dev consistently
Date: Thu, 29 Jun 2017 09:22:49 +0800
Message-Id: <1498699369-65515-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
References: <1498699288-63944-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have "struct device *dev" in rockchip_pcie_probe but
still fetch it from pdev and rockchip->dev somewhere.
This patch tries to improve and no functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c545213..eb0a170 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1482,15 +1482,14 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto err_free_res;
 
-	rockchip->msg_region = devm_ioremap(rockchip->dev,
-					    rockchip->msg_bus_addr, SZ_1M);
+	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
 	if (!rockchip->msg_region) {
 		err = -ENOMEM;
 		goto err_free_res;
 	}
 
 	list_splice_init(&res, &bridge->windows);
-	bridge->dev.parent = &pdev->dev;
+	bridge->dev.parent = dev;
 	bridge->sysdata = rockchip;
 	bridge->busnr = 0;
 	bridge->ops = &rockchip_pcie_ops;
-- 
1.9.1
