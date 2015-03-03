Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757465AbbCCRw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Mar 2015 12:52:56 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v8 4/7] PCI: Add helper functions pci_get[put]_host_bridge_device()
Date: Tue, 3 Mar 2015 12:52:11 -0500
Message-ID: <1425405134-24707-5-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
References: <1425405134-24707-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add helper functions to get/put the root bus's host bridge device.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host-bridge.c |   14 ++++++++++++++
 include/linux/pci.h       |    3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 39b2dbe..3e5bbf9 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -23,6 +23,20 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 	return to_pci_host_bridge(root_bus->bridge);
 }
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev)
+{
+	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
+	struct device *bridge = root_bus->bridge;
+
+	kobject_get(&bridge->kobj);
+	return bridge;
+}
+
+void  pci_put_host_bridge_device(struct device *dev)
+{
+	kobject_put(&dev->kobj);
+}
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..a379513 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -510,6 +510,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+struct device *pci_get_host_bridge_device(struct pci_dev *dev);
+void pci_put_host_bridge_device(struct device *dev);
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
1.7.9.5

