Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:55413 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbbD1HII (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 03:08:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: [PATCH Part1 v11 4/5] PCI: xgene: Use pci_scan_root_bus() instead of pci_create_root_bus()
Date: Tue, 28 Apr 2015 15:01:38 +0800
Message-ID: <1430204499-19571-5-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
Now pci_scan_root_bus() == pci_create_root_bus() +
pci_scan_child_bus() if busn resource is supplied.
Xgene added the busn resource to resources list
in of_pci_get_host_bridge_resources(). So it should be safe
to use pci_scan_root_bus() instead.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index ee082c0..87e3962 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -499,12 +499,11 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
+	bus = pci_scan_root_bus(&pdev->dev, 0,
 					&xgene_pcie_ops, port, &res);
 	if (!bus)
 		return -ENOMEM;
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
-- 
1.7.1

