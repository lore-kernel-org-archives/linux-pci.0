Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36923 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965533AbbJ0U4u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 16:56:50 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v8 02/61] PCI: Add pci_find_root_bus_resource()
Date: Tue, 27 Oct 2015 13:54:54 -0700
Message-Id: <1445979353-1728-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pci_find_root_bus_resource() to return root bus res
for resource.

For sparc mem64 support, We need that host bridge window res,
  1. we need direct parent for request_resource_conflict() calling in
      pci_register_legacy_regions().
  2. check if return is NULL to decide if region is valid or not.

Convert old pci_find_parent_resource() to pci_find_bus_resource(),
and reuse it in pci_find_root_bus_resource().
So we avoid changing pcibios_bus_to_resource().

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci.c   | 36 +++++++++++++++++++++++++-----------
 include/linux/pci.h |  2 ++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..613eef1 100644
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
+static struct resource *pci_find_bus_resource(const struct pci_bus *bus,
+					      struct resource *res)
 {
-	const struct pci_bus *bus = dev->bus;
 	struct resource *r;
 	int i;
 
@@ -455,8 +446,31 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
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
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..05f5eac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -783,6 +783,8 @@ void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
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

