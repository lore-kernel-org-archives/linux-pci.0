Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35951 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcKYK5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:32 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 03/10] PCI: Make host bridge interface publicly available
Date: Fri, 25 Nov 2016 11:57:11 +0100
Message-Id: <20161125105718.3866-3-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Allow PCI host bridge drivers to use the new host bridge interfaces to
register their host bridge.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/probe.c | 6 ++++--
 include/linux/pci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 912b22ed96dd..eeb48d3ce80c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -521,7 +521,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
+struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 {
 	struct pci_host_bridge *bridge;
 
@@ -533,6 +533,7 @@ static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 
 	return bridge;
 }
+EXPORT_SYMBOL(pci_alloc_host_bridge);
 
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
@@ -717,7 +718,7 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
-static int pci_register_host_bridge(struct pci_host_bridge *bridge)
+int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
 	struct resource_entry *window, *n;
@@ -832,6 +833,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	kfree(bus);
 	return err;
 }
+EXPORT_SYMBOL(pci_register_host_bridge);
 
 static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e9ba95cbfd62..e2d1a124216a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -449,6 +449,8 @@ static inline struct pci_host_bridge *pci_host_bridge_from_priv(void *priv)
 	return container_of(priv, struct pci_host_bridge, private);
 }
 
+struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
+int pci_register_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
2.10.2

