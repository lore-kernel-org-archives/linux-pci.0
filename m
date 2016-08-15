Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34903 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbcHOPgz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2016 11:36:55 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: Allow driver-specific data in host bridge
Date: Mon, 15 Aug 2016 17:36:45 +0200
Message-Id: <20160815153647.1075-2-thierry.reding@gmail.com>
In-Reply-To: <20160815153647.1075-1-thierry.reding@gmail.com>
References: <20160815153647.1075-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Provide a way to allocate driver-specific data along with a PCI host
bridge structure. The bridge's ->private field points to this data.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/probe.c | 9 ++++++---
 include/linux/pci.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 93583b389058..ecf543014da3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,16 +521,19 @@ static void pci_release_host_bridge_dev(struct device *dev)
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
 
 	INIT_LIST_HEAD(&bridge->windows);
 
+	if (priv)
+		bridge->private = &bridge[1];
+
 	return bridge;
 }
 
@@ -2249,7 +2252,7 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	int error;
 	struct pci_host_bridge *bridge;
 
-	bridge = pci_alloc_host_bridge();
+	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
 		return NULL;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ccf298fad9e7..3aa7240800c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -421,6 +421,7 @@ struct pci_host_bridge {
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
+	void *private;
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
-- 
2.9.0

