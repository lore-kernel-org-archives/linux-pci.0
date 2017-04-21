Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37761 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035221AbdDUFFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2017 01:05:40 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/13] PCI: Add pci_find_bus_resource()
Date: Thu, 20 Apr 2017 22:04:49 -0700
Message-Id: <20170421050500.13957-3-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-1-yinghai@kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
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
index 4ffa152..deb828f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -437,18 +437,9 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
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
 
@@ -478,6 +469,20 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
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
index 88185ff..817786b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -836,6 +836,8 @@ void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region);
+struct resource *pci_find_bus_resource(const struct pci_bus *bus,
+					struct resource *res);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-- 
2.9.3
