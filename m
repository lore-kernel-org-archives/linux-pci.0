Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3524 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbHRTTO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 15:19:14 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v5 07/13] PCI: Export pci_find_host_bridge()
Date: Tue, 18 Aug 2015 14:04:03 -0500
Message-ID: <1439924649-29698-8-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
References: <1439924649-29698-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return the struct pci_host_bridge corresponding to the given
struct pci_bus.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 drivers/pci/host-bridge.c | 19 ++-----------------
 include/linux/pci.h       |  7 +++++++
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 5f4a2e0..6c2c82a 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -8,25 +8,10 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
-{
-	while (bus->parent)
-		bus = bus->parent;
-
-	return bus;
-}
-
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
-{
-	struct pci_bus *root_bus = find_pci_root_bus(bus);
-
-	return to_pci_host_bridge(root_bus->bridge);
-}
-
 struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 {
-	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
-	struct device *bridge = root_bus->bridge;
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
+	struct device *bridge = &host_bridge->dev;
 
 	kobject_get(&bridge->kobj);
 	return bridge;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..d58063e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -512,6 +512,13 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+static inline struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
+{
+	while (bus->parent)
+		bus = bus->parent;
+	return to_pci_host_bridge(bus->bridge);
+}
+
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
-- 
2.5.0

