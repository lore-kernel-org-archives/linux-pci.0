Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:21081 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751921AbdHDDdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 23:33:37 -0400
From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: [PATCH v2 1/2] PCI: rcar: Fix error exit path
Date: Fri,  4 Aug 2017 12:32:54 +0900
Message-Id: <20170804033255.27171-2-harunobu.kurokawa.dn@renesas.com>
In-Reply-To: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
References: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Commit 90634e854079 ("PCI: rcar: Convert PCI scan API to
pci_scan_root_bus_bridge()") converted PCI root bus scan API
to the new pci_scan_root_bus_bridge() API; in the process
some error paths were not updated correctly which may cause
memory leaks.

Fix the driver error exit path reinstating the previous correct
error exit behaviour.

Fixes: 90634e854079 ("PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index ac80fbb..6b73981 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -471,10 +471,8 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 		bridge->msi = &pcie->msi.chip;
 
 	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		kfree(bridge);
+	if (ret < 0)
 		return ret;
-	}
 
 	bus = bridge->bus;
 
@@ -1190,14 +1188,15 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
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
+
 	return err;
 }
 
-- 
2.9.2
