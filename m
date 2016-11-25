Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35457 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcKYK50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:26 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 02/10] PCI: Allow driver-specific data in host bridge
Date: Fri, 25 Nov 2016 11:57:10 +0100
Message-Id: <20161125105718.3866-2-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Provide a way to allocate driver-specific data along with a PCI host
bridge structure. The bridge's ->private field points to this data.

Changes in v4:
- use zero-sized, cache-aligned structure field to store private data
- provide static inline functions to obtain private data and upcast from
  private data to struct pci_host_bridge

Signed-off-by: Thierry Reding <treding@nvidia.com>

---
 drivers/pci/probe.c |  6 +++---
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 99f503c3ab81..912b22ed96dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,11 +521,11 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(void)
+static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 {
 	struct pci_host_bridge *bridge;
 
-	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
+	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
 	if (!bridge)
 		return NULL;
 
@@ -2279,7 +2279,7 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	int error;
 	struct pci_host_bridge *bridge;
 
-	bridge = pci_alloc_host_bridge();
+	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return NULL;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ff16e44d8f84..e9ba95cbfd62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -434,10 +434,21 @@ struct pci_host_bridge {
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
+	unsigned long private[0] ____cacheline_aligned;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
 
+static inline void *pci_host_bridge_priv(struct pci_host_bridge *bridge)
+{
+	return (void *)bridge->private;
+}
+
+static inline struct pci_host_bridge *pci_host_bridge_from_priv(void *priv)
+{
+	return container_of(priv, struct pci_host_bridge, private);
+}
+
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
2.10.2

