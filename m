Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] PCI: rockchip: make 'return 0' more obvious in probe()
Date: Wed,  8 Mar 2017 15:37:47 -0800
Message-Id: <20170308233748.54706-2-briannorris@chromium.org>
In-Reply-To: <20170308233748.54706-1-briannorris@chromium.org>
References: <20170308233748.54706-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no way to get here with 'err != 0'. Just return 0 to be more
obvious and prevent future changes from accidentally erroring out here
without going through the right error paths.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/pci/host/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index d785f64ec03b..5d7b27b1e941 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1398,7 +1398,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-	return err;
+	return 0;
 
 err_free_res:
 	pci_free_resource_list(&res);
-- 
2.12.0.246.ga2ecc84866-goog
