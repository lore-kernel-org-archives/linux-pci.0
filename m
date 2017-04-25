Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PCI: add functionality for resizing resources v3
Date: Tue, 25 Apr 2017 15:19:52 +0200
Message-Id: <1493126394-1239-3-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

This allows device drivers to request resizing their BARs.

The function only tries to reprogram the windows of the bridge directly above
the requesting device and only the BAR of the same type (usually mem, 64bit,
prefetchable). This is done to make sure not to disturb other drivers by
changing the BARs of their devices.

If reprogramming the bridge BAR fails the old status is restored and -ENOSPC
returned to the calling device driver.

v2: rebase on changes in rbar support
v3: style cleanups, fail if memory decoding is enabled or resources
    still allocated, resize all unused bridge BARs,
    drop calling pci_reenable_device

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/setup-bus.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-res.c |  60 ++++++++++++++++++++++++++++
 include/linux/pci.h     |   3 ++
 3 files changed, 165 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f30ca75..39351cf 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1923,6 +1923,108 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
+{
+	const unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
+		IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
+
+	struct pci_dev_resource *dev_res;
+	LIST_HEAD(saved);
+	LIST_HEAD(added);
+	LIST_HEAD(failed);
+	unsigned i;
+	int ret = 0;
+
+	/* Walk to the root BUS, releasing bridge BARs when possible */
+	while (1) {
+		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
+		     i++) {
+			struct resource *res = &bridge->resource[i];
+
+			if ((res->flags & type_mask) != (type & type_mask))
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
+			if (res->parent)
+				release_resource(res);
+			res->start = 0;
+			res->end = 0;
+			dev_info(&bridge->dev, "BAR %d: released %pR\n",
+				 i, res);
+			break;
+		}
+		if (i == PCI_BRIDGE_RESOURCE_END)
+			break;
+
+		if (!bridge->bus || !bridge->bus->self)
+			break;
+
+		bridge = bridge->bus->self;
+	}
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
+	free_list(&failed);
+	return ret;
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
index 9526e34..0d40adb 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -363,6 +363,66 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	return 0;
 }
 
+void pci_release_resource(struct pci_dev *dev, int resno)
+{
+	struct resource *res = dev->resource + resno;
+
+	release_resource(res);
+	res->end = resource_size(res) - 1;
+	res->start = 0;
+	res->flags |= IORESOURCE_UNSET;
+	dev_info(&dev->dev, "BAR %d: released %pR\n", resno, res);
+}
+EXPORT_SYMBOL(pci_release_resource);
+
+int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+{
+	struct resource *res = dev->resource + resno;
+	u64 bytes = 1ULL << (size + 20);
+	u16 cmd;
+	u32 sizes;
+	int old, ret = 0;
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
+	/* Make sure the resource isn't assigned before making it larger. */
+	pci_release_resource(dev, resno);
+
+	ret = pci_rbar_set_size(dev, resno, size);
+	if (ret)
+		goto error_reassign;
+
+	res->end = res->start + bytes - 1;
+
+	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
+	if (ret)
+		goto error_resize;
+
+	return 0;
+
+error_resize:
+	pci_rbar_set_size(dev, resno, old);
+	res->end = res->start + (1ULL << (old + 20)) - 1;
+
+error_reassign:
+	pci_assign_unassigned_bus_resources(dev->bus);
+	return ret;
+}
+EXPORT_SYMBOL(pci_resize_resource);
+
 int pci_enable_resources(struct pci_dev *dev, int mask)
 {
 	u16 cmd, old_cmd;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a38772a..f0a630a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1055,6 +1055,8 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
+void pci_release_resource(struct pci_dev *dev, int resno);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
@@ -1135,6 +1137,7 @@ void pci_assign_unassigned_resources(void);
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
+int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-- 
2.7.4
