Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [Patch v7 6/7] x86/PCI/ACPI: Use common interface to support PCI host bridge
Date: Wed, 14 Oct 2015 14:29:41 +0800
Message-Id: <1444804182-6596-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use common interface to simplify ACPI PCI host bridge implementation.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
 arch/x86/pci/acpi.c |  294 +++++++++++++++------------------------------------
 1 file changed, 87 insertions(+), 207 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5bc018559cc4..3cd69832d7f4 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -4,16 +4,15 @@
 #include <linux/irq.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
+#include <linux/pci-acpi.h>
 #include <asm/numa.h>
 #include <asm/pci_x86.h>
 
 struct pci_root_info {
-	struct acpi_device *bridge;
-	char name[16];
+	struct acpi_pci_root_info common;
 	struct pci_sysdata sd;
 #ifdef	CONFIG_PCI_MMCONFIG
 	bool mcfg_added;
-	u16 segment;
 	u8 start_bus;
 	u8 end_bus;
 #endif
@@ -178,15 +177,18 @@ static int check_segment(u16 seg, struct device *dev, char *estr)
 	return 0;
 }
 
-static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
-			  u8 end, phys_addr_t addr)
+static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
-	int result;
-	struct device *dev = &info->bridge->dev;
+	int result, seg;
+	struct pci_root_info *info;
+	struct acpi_pci_root *root = ci->root;
+	struct device *dev = &ci->bridge->dev;
 
-	info->start_bus = start;
-	info->end_bus = end;
+	info = container_of(ci, struct pci_root_info, common);
+	info->start_bus = (u8)root->secondary.start;
+	info->end_bus = (u8)root->secondary.end;
 	info->mcfg_added = false;
+	seg = info->sd.domain;
 
 	/* return success if MMCFG is not in use */
 	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
@@ -195,7 +197,8 @@ static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
 	if (!(pci_probe & PCI_PROBE_MMCONF))
 		return check_segment(seg, dev, "MMCONFIG is disabled,");
 
-	result = pci_mmconfig_insert(dev, seg, start, end, addr);
+	result = pci_mmconfig_insert(dev, seg, info->start_bus, info->end_bus,
+				     root->mcfg_addr);
 	if (result == 0) {
 		/* enable MMCFG if it hasn't been enabled yet */
 		if (raw_pci_ext_ops == NULL)
@@ -208,134 +211,55 @@ static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
 	return 0;
 }
 
-static void teardown_mcfg_map(struct pci_root_info *info)
+static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
+	struct pci_root_info *info;
+
+	info = container_of(ci, struct pci_root_info, common);
 	if (info->mcfg_added) {
-		pci_mmconfig_delete(info->segment, info->start_bus,
-				    info->end_bus);
+		pci_mmconfig_delete(info->sd.domain,
+				    info->start_bus, info->end_bus);
 		info->mcfg_added = false;
 	}
 }
 #else
-static int setup_mcfg_map(struct pci_root_info *info,
-				    u16 seg, u8 start, u8 end,
-				    phys_addr_t addr)
+static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 {
 	return 0;
 }
-static void teardown_mcfg_map(struct pci_root_info *info)
+
+static void teardown_mcfg_map(struct acpi_pci_root_info *ci)
 {
 }
 #endif
 
-static void validate_resources(struct device *dev, struct list_head *crs_res,
-			       unsigned long type)
+static int pci_acpi_root_get_node(struct acpi_pci_root *root)
 {
-	LIST_HEAD(list);
-	struct resource *res1, *res2, *root = NULL;
-	struct resource_entry *tmp, *entry, *entry2;
-
-	BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) == 0);
-	root = (type & IORESOURCE_MEM) ? &iomem_resource : &ioport_resource;
-
-	list_splice_init(crs_res, &list);
-	resource_list_for_each_entry_safe(entry, tmp, &list) {
-		bool free = false;
-		resource_size_t end;
-
-		res1 = entry->res;
-		if (!(res1->flags & type))
-			goto next;
-
-		/* Exclude non-addressable range or non-addressable portion */
-		end = min(res1->end, root->end);
-		if (end <= res1->start) {
-			dev_info(dev, "host bridge window %pR (ignored, not CPU addressable)\n",
-				 res1);
-			free = true;
-			goto next;
-		} else if (res1->end != end) {
-			dev_info(dev, "host bridge window %pR ([%#llx-%#llx] ignored, not CPU addressable)\n",
-				 res1, (unsigned long long)end + 1,
-				 (unsigned long long)res1->end);
-			res1->end = end;
-		}
-
-		resource_list_for_each_entry(entry2, crs_res) {
-			res2 = entry2->res;
-			if (!(res2->flags & type))
-				continue;
-
-			/*
-			 * I don't like throwing away windows because then
-			 * our resources no longer match the ACPI _CRS, but
-			 * the kernel resource tree doesn't allow overlaps.
-			 */
-			if (resource_overlaps(res1, res2)) {
-				res2->start = min(res1->start, res2->start);
-				res2->end = max(res1->end, res2->end);
-				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n",
-					 res2, res1);
-				free = true;
-				goto next;
-			}
-		}
+	int busnum = root->secondary.start;
+	struct acpi_device *device = root->device;
+	int node = acpi_get_node(device->handle);
 
-next:
-		resource_list_del(entry);
-		if (free)
-			resource_list_free_entry(entry);
-		else
-			resource_list_add_tail(entry, crs_res);
+	if (node == NUMA_NO_NODE) {
+		node = x86_pci_root_bus_node(busnum);
+		if (node != 0 && node != NUMA_NO_NODE)
+			dev_info(&device->dev, FW_BUG "no _PXM; falling back to node %d from hardware (may be inconsistent with ACPI node numbers)\n",
+				node);
 	}
+	if (node != NUMA_NO_NODE && !node_online(node))
+		node = NUMA_NO_NODE;
+
+	return node;
 }
 
-static void add_resources(struct pci_root_info *info,
-			  struct list_head *resources,
-			  struct list_head *crs_res)
+static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
 {
-	struct resource_entry *entry, *tmp;
-	struct resource *res, *conflict, *root = NULL;
-
-	validate_resources(&info->bridge->dev, crs_res, IORESOURCE_MEM);
-	validate_resources(&info->bridge->dev, crs_res, IORESOURCE_IO);
-
-	resource_list_for_each_entry_safe(entry, tmp, crs_res) {
-		res = entry->res;
-		if (res->flags & IORESOURCE_MEM)
-			root = &iomem_resource;
-		else if (res->flags & IORESOURCE_IO)
-			root = &ioport_resource;
-		else
-			BUG_ON(res);
-
-		conflict = insert_resource_conflict(root, res);
-		if (conflict) {
-			dev_info(&info->bridge->dev,
-				 "ignoring host bridge window %pR (conflicts with %s %pR)\n",
-				 res, conflict->name, conflict);
-			resource_list_destroy_entry(entry);
-		}
-	}
-
-	list_splice_tail(crs_res, resources);
+	return setup_mcfg_map(ci);
 }
 
-static void release_pci_root_info(struct pci_host_bridge *bridge)
+static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
 {
-	struct resource *res;
-	struct resource_entry *entry;
-	struct pci_root_info *info = bridge->release_data;
-
-	resource_list_for_each_entry(entry, &bridge->windows) {
-		res = entry->res;
-		if (res->parent &&
-		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
-			release_resource(res);
-	}
-
-	teardown_mcfg_map(info);
-	kfree(info);
+	teardown_mcfg_map(ci);
+	kfree(container_of(ci, struct pci_root_info, common));
 }
 
 /*
@@ -358,47 +282,44 @@ static bool resource_is_pcicfg_ioport(struct resource *res)
 		res->start == 0xCF8 && res->end == 0xCFF;
 }
 
-static void probe_pci_root_info(struct pci_root_info *info,
-				struct acpi_device *device,
-				int busnum, int domain,
-				struct list_head *list)
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 {
-	int ret;
+	struct acpi_device *device = ci->bridge;
+	int busnum = ci->root->secondary.start;
 	struct resource_entry *entry, *tmp;
+	int status;
 
-	sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
-	info->bridge = device;
-	ret = acpi_dev_get_resources(device, list,
-				     acpi_dev_filter_resource_type_cb,
-				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
-	if (ret < 0)
-		dev_warn(&device->dev,
-			 "failed to parse _CRS method, error code %d\n", ret);
-	else if (ret == 0)
-		dev_dbg(&device->dev,
-			"no IO and memory resources present in _CRS\n");
-	else
-		resource_list_for_each_entry_safe(entry, tmp, list) {
-			if ((entry->res->flags & IORESOURCE_DISABLED) ||
-			    resource_is_pcicfg_ioport(entry->res))
+	status = acpi_pci_probe_root_resources(ci);
+	if (pci_use_crs) {
+		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
+			if (resource_is_pcicfg_ioport(entry->res))
 				resource_list_destroy_entry(entry);
-			else
-				entry->res->name = info->name;
-		}
+		return status;
+	}
+
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		dev_printk(KERN_DEBUG, &device->dev,
+			   "host bridge window %pR (ignored)\n", entry->res);
+		resource_list_destroy_entry(entry);
+	}
+	x86_pci_root_bus_resources(busnum, &ci->resources);
+
+	return 0;
 }
 
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.pci_ops = &pci_root_ops,
+	.init_info = pci_acpi_root_init_info,
+	.release_info = pci_acpi_root_release_info,
+	.prepare_resources = pci_acpi_root_prepare_resources,
+};
+
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	struct acpi_device *device = root->device;
-	struct pci_root_info *info;
 	int domain = root->segment;
 	int busnum = root->secondary.start;
-	struct resource_entry *res_entry;
-	LIST_HEAD(crs_res);
-	LIST_HEAD(resources);
+	int node = pci_acpi_root_get_node(root);
 	struct pci_bus *bus;
-	struct pci_sysdata *sd;
-	int node;
 
 	if (pci_ignore_seg)
 		root->segment = domain = 0;
@@ -410,71 +331,33 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	node = acpi_get_node(device->handle);
-	if (node == NUMA_NO_NODE) {
-		node = x86_pci_root_bus_node(busnum);
-		if (node != 0 && node != NUMA_NO_NODE)
-			dev_info(&device->dev, FW_BUG "no _PXM; falling back to node %d from hardware (may be inconsistent with ACPI node numbers)\n",
-				node);
-	}
-
-	if (node != NUMA_NO_NODE && !node_online(node))
-		node = NUMA_NO_NODE;
-
-	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
-	if (!info) {
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-		       "ignored (out of memory)\n", domain, busnum);
-		return NULL;
-	}
-
-	sd = &info->sd;
-	sd->domain = domain;
-	sd->node = node;
-	sd->companion = device;
-
 	bus = pci_find_bus(domain, busnum);
 	if (bus) {
 		/*
 		 * If the desired bus has been scanned already, replace
 		 * its bus->sysdata.
 		 */
-		memcpy(bus->sysdata, sd, sizeof(*sd));
-		kfree(info);
-	} else {
-		/* insert busn res at first */
-		pci_add_resource(&resources,  &root->secondary);
+		struct pci_sysdata sd = {
+			.domain = domain,
+			.node = node,
+			.companion = root->device
+		};
 
-		/*
-		 * _CRS with no apertures is normal, so only fall back to
-		 * defaults or native bridge info if we're ignoring _CRS.
-		 */
-		probe_pci_root_info(info, device, busnum, domain, &crs_res);
-		if (pci_use_crs) {
-			add_resources(info, &resources, &crs_res);
-		} else {
-			resource_list_for_each_entry(res_entry, &crs_res)
-				dev_printk(KERN_DEBUG, &device->dev,
-					   "host bridge window %pR (ignored)\n",
-					   res_entry->res);
-			resource_list_free(&crs_res);
-			x86_pci_root_bus_resources(busnum, &resources);
-		}
-
-		if (!setup_mcfg_map(info, domain, (u8)root->secondary.start,
-				    (u8)root->secondary.end, root->mcfg_addr))
-			bus = pci_create_root_bus(NULL, busnum, &pci_root_ops,
-						  sd, &resources);
-
-		if (bus) {
-			pci_scan_child_bus(bus);
-			pci_set_host_bridge_release(
-				to_pci_host_bridge(bus->bridge),
-				release_pci_root_info, info);
-		} else {
-			resource_list_free(&resources);
-			teardown_mcfg_map(info);
-			kfree(info);
+		memcpy(bus->sysdata, &sd, sizeof(sd));
+	} else {
+		struct pci_root_info *info;
+
+		info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+		if (!info)
+			dev_err(&root->device->dev,
+				"pci_bus %04x:%02x: ignored (out of memory)\n",
+				domain, busnum);
+		else {
+			info->sd.domain = domain;
+			info->sd.node = node;
+			info->sd.companion = root->device;
+			bus = acpi_pci_root_create(root, &acpi_pci_root_ops,
+						   &info->common, &info->sd);
 		}
 	}
 
@@ -487,9 +370,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 			pcie_bus_configure_settings(child);
 	}
 
-	if (bus && node != NUMA_NO_NODE)
-		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
-
 	return bus;
 }
 
-- 
1.7.10.4

