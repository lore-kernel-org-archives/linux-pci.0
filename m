Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:53056 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933144AbbD1Jf4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 05:35:56 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<dja@axtens.net>, Arnd Bergmann <arnd@arndb.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH Part2 v11 1/2] xen/PCI: Don't use deprecated function pci_scan_bus_parented()
Date: Tue, 28 Apr 2015 17:32:33 +0800
Message-ID: <1430213554-9107-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

Use pci_scan_root_bus() instead of deprecated function
pci_scan_bus_parented().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: xen-devel@lists.xenproject.org
---
 drivers/pci/xen-pcifront.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7cfd2db..240f388 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -446,9 +446,15 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 				 unsigned int domain, unsigned int bus)
 {
 	struct pci_bus *b;
+	LIST_HEAD(resources);
 	struct pcifront_sd *sd = NULL;
 	struct pci_bus_entry *bus_entry = NULL;
 	int err = 0;
+	static struct resource busn_res = {
+		.start = 0,
+		.end = 255,
+		.flags = IORESOURCE_BUS,
+	};
 
 #ifndef CONFIG_PCI_DOMAINS
 	if (domain != 0) {
@@ -470,17 +476,21 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 		err = -ENOMEM;
 		goto err_out;
 	}
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
 	pcifront_init_sd(sd, domain, bus, pdev);
 
 	pci_lock_rescan_remove();
 
-	b = pci_scan_bus_parented(&pdev->xdev->dev, bus,
-				  &pcifront_bus_ops, sd);
+	b = pci_scan_root_bus(&pdev->xdev->dev, bus,
+				  &pcifront_bus_ops, sd, &resources);
 	if (!b) {
 		dev_err(&pdev->xdev->dev,
 			"Error creating PCI Frontend Bus!\n");
 		err = -ENOMEM;
 		pci_unlock_rescan_remove();
+		pci_free_resource_list(&resources);
 		goto err_out;
 	}
 
@@ -488,7 +498,7 @@ static int pcifront_scan_root(struct pcifront_device *pdev,
 
 	list_add(&bus_entry->list, &pdev->root_buses);
 
-	/* pci_scan_bus_parented skips devices which do not have a have
+	/* pci_scan_root_bus skips devices which do not have a
 	* devfn==0. The pcifront_scan_bus enumerates all devfn. */
 	err = pcifront_scan_bus(pdev, domain, bus, b);
 
-- 
1.7.1

