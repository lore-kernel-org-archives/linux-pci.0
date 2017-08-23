Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50840 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbdHWHEd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:04:33 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 09/10] PCI: rockchip: remove irq domain if failing to probe
Date: Wed, 23 Aug 2017 15:03:31 +0800
Message-Id: <1503471811-74167-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Fix the missing to call irq_domain_remove if failing
to finish the probe.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 6dbd3fd..e752d3e 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1572,7 +1572,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
 					       &res, &io_base);
 	if (err)
-		goto err_deinit_port;
+		goto err_remove_irq_domain;
 
 	err = devm_request_pci_bus_resources(dev, &res);
 	if (err)
@@ -1644,6 +1644,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 err_free_res:
 	pci_free_resource_list(&res);
+err_remove_irq_domain:
+	irq_domain_remove(rockchip->irq_domain);
 err_deinit_port:
 	rockchip_pcie_deinit_phys(rockchip);
 err_vpcie:
-- 
1.9.1
