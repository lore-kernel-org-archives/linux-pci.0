Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33157 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbdCTWtv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 18:49:51 -0400
Received: by mail-pg0-f42.google.com with SMTP id n190so84252132pga.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2017 15:49:50 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: rockchip: don't leak the PCI resource list
Date: Mon, 20 Mar 2017 15:49:36 -0700
Message-Id: <20170320224936.28605-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This list is local to the probe() function. We should free it up in both
the success case and the error case, but currently we're only freeing it
in the error case (see commit f1d722b607d6 ("PCI: rockchip: Fix
rockchip_pcie_probe() error path to free resource list")).

Caught by kmemleak, when doing repeated bind/unbind tests.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pci/host/pcie-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index bd6df7254de4..8087a0698d65 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1396,6 +1396,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_free_res;
 	}
 	rockchip->root_bus = bus;
+	pci_free_resource_list(&res);
 
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
-- 
2.12.0.367.g23dc2f6d3c-goog
