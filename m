Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=alSj=BR=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH v9 3/5] PCI: add functionality for resizing resources v7
Date: Wed, 18 Oct 2017 15:58:19 +0200
Message-Id: <20171018135821.3248-4-deathsimple@vodafone.de>
In-Reply-To: <20171018135821.3248-1-deathsimple@vodafone.de>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

This allows device drivers to request resizing their BARs.

The function only tries to reprogram the windows of the bridge directly above
the requesting device and only the BAR of the same type (usually mem, 64bit,
prefetchable). This is done to make sure not to disturb other drivers by
changing the BARs of their devices.

Drivers should use the following sequence to resize their BARs:
1. Disable memory decoding of your device using the PCI cfg dword.
2. Use pci_release_resource() to release all BARs which can move during the
   resize. Including the one you want to resize.
3. Call pci_resize_resource() for each BAR you want to resize.
4. Call pci_assign_unassigned_bus_resources() to reassign new locations
   for all BARs which are not resized, but could move.
5. If everything worked as expected enable memory decoding in your device again
   using the PCI cfg dword.

v2: rebase on changes in rbar support
v3: style cleanups, fail if memory decoding is enabled or resources
    still allocated, resize all unused bridge BARs,
    drop calling pci_reenable_device
v4: print resources before releasing them, style cleanups,
    use pci_rbar_size_to_bytes, use PCI_RES_TYPE_MASK
v5: use next pointer to simplify loop
v6: move reassigning resources on error to driver side
v7: Document in the commit message how to use the new function.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/setup-bus.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-res.c | 58 +++++++++++++++++++++++++++++
 include/linux/pci.h     |  3 ++
 3 files changed, 159 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 37450d9e1132..03af25b3eec4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1908,6 +1908,104 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
+{
+	struct pci_dev_resource *dev_res;
+	struct pci_dev *next;
+	LIST_HEAD(saved);
+	LIST_HEAD(added);
+	LIST_HEAD(failed);
+	unsigned int i;
+	int ret;
+
+	/* Walk to the root hub, releasing bridge BARs when possible */
+	next = bridge;
+	do {
+		bridge = next;
+		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
+		     i++) {
+			struct resource *res = &bridge->resource[i];
+
+			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
+				continue;
+
+			/* Ignore BARs which are still in use */
+			if (res->child)
+				continue;
+
+			ret = add_to_list(&saved, bridge, res, 0, 0);
+			if (ret)
+				goto cleanup;
+
+			dev_info(&bridge->dev, "BAR %d: releasing %pR\n",
+				 i, res);
+
+			if (res->parent)
+				release_resource(res);
+			res->start = 0;
+			res->end = 0;
+			break;
+		}
+		if (i == PCI_BRIDGE_RESOURCE_END)
+			break;
+
+		next = bridge->bus ? bridge->bus->self : NULL;
+	} while (next);
+
+	if (list_empty(&saved))
+		return -ENOENT;
+
+	__pci_bus_size_bridges(bridge->subordinate, &added);
+	__pci_bridge_assign_resources(bridge, &added, &failed);
+	BUG_ON(!list_empty(&added));
+
+	if (!list_empty(&failed)) {
+		ret = -ENOSPC;
+		goto cleanup;
+	}
+
+	list_for_each_entry(dev_res, &saved, list) {
+		/* Skip the bridge we just assigned resources for. */
+		if (bridge == dev_res->dev)
+			continue;
+
+		bridge = dev_res->dev;
+		pci_setup_bridge(bridge->subordinate);
+	}
+
+	free_list(&saved);
+	return 0;
+
+cleanup:
+	/* restore size and flags */
+	list_for_each_entry(dev_res, &failed, list) {
+		struct resource *res = dev_res->res;
+
+		res->start = dev_res->start;
+		res->end = dev_res->end;
+		res->flags = dev_res->flags;
+	}
+	free_list(&failed);
+
+	/* Revert to the old configuration */
+	list_for_each_entry(dev_res, &saved, list) {
+		struct resource *res = dev_res->res;
+
+		bridge = dev_res->dev;
+		i = res - bridge->resource;
+
+		res->start = dev_res->start;
+		res->end = dev_res->end;
+		res->flags = dev_res->flags;
+
+		pci_claim_resource(bridge, i);
+		pci_setup_bridge(bridge->subordinate);
+	}
+	free_list(&saved);
+
+	return ret;
+}
+
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 85774b7a316a..1d558e18270d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -383,6 +383,64 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	return 0;
 }
 
+void pci_release_resource(struct pci_dev *dev, int resno)
+{
+	struct resource *res = dev->resource + resno;
+
+	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
+	release_resource(res);
+	res->end = resource_size(res) - 1;
+	res->start = 0;
+	res->flags |= IORESOURCE_UNSET;
+}
+EXPORT_SYMBOL(pci_release_resource);
+
+int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+{
+	struct resource *res = dev->resource + resno;
+	int old, ret;
+	u32 sizes;
+	u16 cmd;
+
+	/* Make sure the resource isn't assigned before resizing it. */
+	if (!(res->flags & IORESOURCE_UNSET))
+		return -EBUSY;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		return -EBUSY;
+
+	sizes = pci_rbar_get_possible_sizes(dev, resno);
+	if (!sizes)
+		return -ENOTSUPP;
+
+	if (!(sizes & BIT(size)))
+		return -EINVAL;
+
+	old = pci_rbar_get_current_size(dev, resno);
+	if (old < 0)
+		return old;
+
+	ret = pci_rbar_set_size(dev, resno, size);
+	if (ret)
+		return ret;
+
+	res->end = res->start + pci_rbar_size_to_bytes(size) - 1;
+
+	/* Check if the new config works by trying to assign everything. */
+	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
+	if (ret)
+		goto error_resize;
+
+	return 0;
+
+error_resize:
+	pci_rbar_set_size(dev, resno, old);
+	res->end = res->start + pci_rbar_size_to_bytes(old) - 1;
+	return ret;
+}
+EXPORT_SYMBOL(pci_resize_resource);
+
 int pci_enable_resources(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a75c13673852..c21949a6ea65 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1081,6 +1081,8 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
+void pci_release_resource(struct pci_dev *dev, int resno);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
@@ -1159,6 +1161,7 @@ void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
+int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-- 
2.11.0
