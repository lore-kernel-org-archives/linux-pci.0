Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:55414 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbD1HII (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 03:08:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH Part1 v11 5/5] PCI: iproc: Use pci_scan_root_bus() instead of pci_create_root_bus()
Date: Tue, 28 Apr 2015 15:01:39 +0800
Message-ID: <1430204499-19571-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
Now pci_scan_root_bus() == pci_create_root_bus() +
pci_scan_child_bus() if busn resource is supplied.
iproc added the busn resource to resources list
in of_pci_get_host_bridge_resources(). So it should be safe
to use pci_scan_root_bus() instead.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 329e1b5..9622ebf 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -210,10 +210,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
 
 	pcie->sysdata.private_data = pcie;
 
-	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
+	bus = pci_scan_root_bus(pcie->dev, 0, &iproc_pcie_ops,
 				  &pcie->sysdata, pcie->resources);
 	if (!bus) {
-		dev_err(pcie->dev, "unable to create PCI root bus\n");
+		dev_err(pcie->dev, "unable to scan PCI root bus\n");
 		ret = -ENOMEM;
 		goto err_power_off_phy;
 	}
@@ -227,7 +227,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
 
 	iproc_pcie_enable(pcie);
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_bus_add_devices(bus);
-- 
1.7.1

