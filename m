Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42141 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcDHAQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:16:53 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v11 03/60] PCI: Add pci_find_bus_resource()
Date: Thu,  7 Apr 2016 17:15:16 -0700
Message-Id: <1460074573-7481-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pci_find_bus_resource() to return bus resource for input resource.

In some case, we may only have bus instead of dev.
It is same as pci_find_parent_resource, but take bus as input.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c   | 27 ++++++++++++++++-----------
 include/linux/pci.h |  2 ++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327..313dea5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -414,18 +414,9 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
-/**
- * pci_find_parent_resource - return resource region of parent bus of given region
- * @dev: PCI device structure contains resources to be searched
- * @res: child resource record for which parent is sought
- *
- *  For given resource region of given device, return the resource
- *  region of parent bus the given region is contained in.
- */
-struct resource *pci_find_parent_resource(const struct pci_dev *dev,
-					  struct resource *res)
+struct resource *pci_find_bus_resource(const struct pci_bus *bus,
+					struct resource *res)
 {
-	const struct pci_bus *bus = dev->bus;
 	struct resource *r;
 	int i;
 
@@ -455,6 +446,20 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 	}
 	return NULL;
 }
+
+/**
+ * pci_find_parent_resource - return resource region of parent bus of given region
+ * @dev: PCI device structure contains resources to be searched
+ * @res: child resource record for which parent is sought
+ *
+ *  For given resource region of given device, return the resource
+ *  region of parent bus the given region is contained in.
+ */
+struct resource *pci_find_parent_resource(const struct pci_dev *dev,
+					  struct resource *res)
+{
+	return pci_find_bus_resource(dev->bus, res);
+}
 EXPORT_SYMBOL(pci_find_parent_resource);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b813..795b4c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -807,6 +807,8 @@ void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region);
+struct resource *pci_find_bus_resource(const struct pci_bus *bus,
+					struct resource *res);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-- 
1.8.4.5

