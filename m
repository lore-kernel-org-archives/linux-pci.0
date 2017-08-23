Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45707 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbdHWHEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:04:42 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 10/10] PCI: rockchip: umap io space if failing to probe
Date: Wed, 23 Aug 2017 15:03:39 +0800
Message-Id: <1503471819-74224-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Fix the missing to call pci_unmap_iospace if failing
to finish the probe.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index e752d3e..70d878b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1610,12 +1610,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_free_res;
+		goto err_unmap_iospace;
 
 	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
 	if (!rockchip->msg_region) {
 		err = -ENOMEM;
-		goto err_free_res;
+		goto err_unmap_iospace;
 	}
 
 	list_splice_init(&res, &bridge->windows);
@@ -1628,7 +1628,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = pci_scan_root_bus_bridge(bridge);
 	if (err < 0)
-		goto err_free_res;
+		goto err_unmap_iospace;
 
 	bus = bridge->bus;
 
@@ -1642,6 +1642,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	pci_bus_add_devices(bus);
 	return 0;
 
+err_unmap_iospace:
+	pci_unmap_iospace(rockchip->io);
 err_free_res:
 	pci_free_resource_list(&res);
 err_remove_irq_domain:
-- 
1.9.1
