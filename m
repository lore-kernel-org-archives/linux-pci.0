Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:41508 "EHLO
        10.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeA3U5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 15:57:53 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9C77F9A669
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2018 21:57:51 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 02/11] PCI: OF: Add generic function to parse and allocate PCI resources
Date: Tue, 30 Jan 2018 21:56:50 +0100
Message-Id: <ff9faac9cbe41c6c96dd6dabaa581d446ab782b6.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch moves the gen_pci_parse_request_of_pci_ranges() function from
drivers/pci/host/pci-host-common.c into drivers/pci/of.c to easily share
common source code between PCI host drivers.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/host/pci-host-common.c | 49 ++----------------------------------
 drivers/pci/of.c                   | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                |  9 +++++++
 3 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 44a47d4f0b8f..efd904d93562 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -24,50 +24,6 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-static int gen_pci_parse_request_of_pci_ranges(struct device *dev,
-		       struct list_head *resources, struct resource **bus_range)
-{
-	int err, res_valid = 0;
-	struct device_node *np = dev->of_node;
-	resource_size_t iobase;
-	struct resource_entry *win, *tmp;
-
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, resources);
-	if (err)
-		return err;
-
-	resource_list_for_each_entry_safe(win, tmp, resources) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = pci_remap_iospace(res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		case IORESOURCE_BUS:
-			*bus_range = res;
-			break;
-		}
-	}
-
-	if (res_valid)
-		return 0;
-
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	return -EINVAL;
-}
-
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
@@ -82,9 +38,9 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	struct pci_config_window *cfg;
 
 	/* Parse our PCI ranges and request their resources */
-	err = gen_pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
+	err = pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
 	if (err)
-		goto err_out;
+		return ERR_PTR(err);
 
 	err = of_address_to_resource(dev->of_node, 0, &cfgres);
 	if (err) {
@@ -135,7 +91,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
-	INIT_LIST_HEAD(&resources);
 	cfg = gen_pci_init(dev, &resources, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e112da11630e..54e210501b73 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -88,3 +88,54 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 	return NULL;
 #endif
 }
+
+int pci_parse_request_of_pci_ranges(struct device *dev,
+				    struct list_head *resources,
+				    struct resource **bus_range)
+{
+	int err, res_valid = 0;
+	struct device_node *np = dev->of_node;
+	resource_size_t iobase;
+	struct resource_entry *win, *tmp;
+
+	INIT_LIST_HEAD(resources);
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
+	if (err)
+		return err;
+
+	err = devm_request_pci_bus_resources(dev, resources);
+	if (err)
+		goto out_release_res;
+
+	resource_list_for_each_entry_safe(win, tmp, resources) {
+		struct resource *res = win->res;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+			err = pci_remap_iospace(res, iobase);
+			if (err) {
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
+					 err, res);
+				resource_list_destroy_entry(win);
+			}
+			break;
+		case IORESOURCE_MEM:
+			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+			break;
+		case IORESOURCE_BUS:
+			if (bus_range)
+				*bus_range = res;
+			break;
+		}
+	}
+
+	if (res_valid)
+		return 0;
+
+	dev_err(dev, "non-prefetchable memory resource required\n");
+	err = -EINVAL;
+
+ out_release_res:
+	pci_free_resource_list(resources);
+	return err;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c9250c8b..c7a701abbf17 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2182,6 +2182,9 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
+int pci_parse_request_of_pci_ranges(struct device *dev,
+				    struct list_head *resources,
+				    struct resource **bus_range);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -2206,6 +2209,12 @@ static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
+static inline int pci_parse_request_of_pci_ranges(struct device *dev,
+						  struct list_head *resources,
+						  struct resource **bus_range)
+{
+	return -EINVAL;
+}
 #endif  /* CONFIG_OF */
 
 #ifdef CONFIG_ACPI
-- 
2.11.0
