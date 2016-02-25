Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40576 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758966AbcBYCNb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 21:13:31 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v10 01/59] PCI: Add pci_find_root_bus_resource()
Date: Wed, 24 Feb 2016 18:11:52 -0800
Message-Id: <1456366370-28995-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pci_find_root_bus_resource() to return root bus resource
for input resource.

For sparc mem64 support, We need that host bridge window res:
  1. we need direct parent for request_resource_conflict() calling in
      pci_register_legacy_regions().
  2. check if return is NULL to decide if region is valid or not.

Convert old pci_find_parent_resource() to pci_find_bus_resource(),
and use it in pci_find_root_bus_resource() and new
pci_find_parent_resource().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c   | 36 +++++++++++++++++++++++++-----------
 include/linux/pci.h |  2 ++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..db4025f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -415,18 +415,9 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
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
+static struct resource *pci_find_bus_resource(const struct pci_bus *bus,
+					      struct resource *res)
 {
-	const struct pci_bus *bus = dev->bus;
 	struct resource *r;
 	int i;
 
@@ -456,8 +447,31 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
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
 
+struct resource *pci_find_root_bus_resource(struct pci_bus *bus,
+					    struct resource *res)
+{
+	while (bus->parent)
+		bus = bus->parent;
+
+	return pci_find_bus_resource(bus, res);
+}
+
 /**
  * pci_find_pcie_root_port - return PCIe Root Port
  * @dev: PCI device to query
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..dd603a668 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -792,6 +792,8 @@ void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region);
+struct resource *pci_find_root_bus_resource(struct pci_bus *bus,
+					    struct resource *res);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-- 
1.8.4.5

