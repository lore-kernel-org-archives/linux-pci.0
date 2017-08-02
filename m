Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:31809 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751187AbdHBHOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2017 03:14:04 -0400
From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: [PATCH] PCI: rcar-pcie: Fix memory leak when no PCIe card is inserted
Date: Wed,  2 Aug 2017 16:13:20 +0900
Message-Id: <20170802071320.28674-1-harunobu.kurokawa.dn@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When no PCIe card is inserted, there is a memory leak as
pci_free_resource_list is not called before returning.

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ac80fbb..9b06de6 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1190,14 +1190,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free_bridge:
-	pci_free_host_bridge(bridge);
-
 err_pm_put:
 	pm_runtime_put(dev);
 
 err_pm_disable:
 	pm_runtime_disable(dev);
+
+err_free_bridge:
+	pci_free_host_bridge(bridge);
+	pci_free_resource_list(&pcie->resources);
 	return err;
 }
 
-- 
2.9.2
