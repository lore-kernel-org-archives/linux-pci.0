Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33688 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaETP3u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 May 2014 11:29:50 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pci: convert dev_printk(KERN_DEBUG...) to dev_dbg(...)
Date: Tue, 20 May 2014 18:29:33 +0300
Message-Id: <1400599773-8252-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch does the conversion of all entries of dev_printk() calls to more
shorter form.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/access.c               |  6 ++----
 drivers/pci/hotplug/pciehp.h       |  3 +--
 drivers/pci/hotplug/shpchp.h       |  3 +--
 drivers/pci/pci.c                  | 14 ++++++-------
 drivers/pci/pcie/aer/aerdrv.c      |  6 +++---
 drivers/pci/pcie/aer/aerdrv_core.c | 24 +++++++++------------
 drivers/pci/pcie/portdrv_core.c    |  5 ++---
 drivers/pci/probe.c                | 36 +++++++++++++++----------------
 drivers/pci/setup-bus.c            | 43 ++++++++++++++++++--------------------
 9 files changed, 63 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 7f8b78c..32c3a09 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -235,10 +235,8 @@ static int pci_vpd_pci22_wait(struct pci_dev *dev)
 		}
 
 		if (time_after(jiffies, timeout)) {
-			dev_printk(KERN_DEBUG, &dev->dev,
-				   "vpd r/w failed.  This is likely a firmware "
-				   "bug on this device.  Contact the card "
-				   "vendor for a firmware update.");
+			dev_dbg(&dev->dev,
+				"vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update.");
 			return -ETIMEDOUT;
 		}
 		if (fatal_signal_pending(current))
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8e9012d..e3e7d8b 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -59,8 +59,7 @@ do {									\
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (pciehp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
-					format, ## arg);		\
+			dev_dbg(&ctrl->pcie->device, format, ## arg);	\
 	} while (0)
 #define ctrl_err(ctrl, format, arg...)					\
 	dev_err(&ctrl->pcie->device, format, ## arg)
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 6152909..7cc7b23 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -62,8 +62,7 @@ do {									\
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (shpchp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pci_dev->dev,	\
-					format, ## arg);		\
+			dev_dbg(&ctrl->pci_dev->dev, format, ## arg);	\
 	} while (0)
 #define ctrl_err(ctrl, format, arg...)					\
 	dev_err(&ctrl->pci_dev->dev, format, ## arg)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b1ebe8b..2fc8ad6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1028,8 +1028,9 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
 		return;
 
 	for (;;) {
-		dev_dbg(&pdev->dev, "restoring config space at offset "
-			"%#x (was %#x, writing %#x)\n", offset, val, saved_val);
+		dev_dbg(&pdev->dev,
+			"restoring config space at offset %#x (was %#x, writing %#x)\n",
+			offset, val, saved_val);
 		pci_write_config_dword(pdev, offset, saved_val);
 		if (retry-- <= 0)
 			return;
@@ -2051,15 +2052,14 @@ void pci_pm_init(struct pci_dev *dev)
 			dev->d2_support = true;
 
 		if (dev->d1_support || dev->d2_support)
-			dev_printk(KERN_DEBUG, &dev->dev, "supports%s%s\n",
+			dev_dbg(&dev->dev, "supports%s%s\n",
 				   dev->d1_support ? " D1" : "",
 				   dev->d2_support ? " D2" : "");
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
 	if (pmc) {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			 "PME# supported from%s%s%s%s%s\n",
+		dev_dbg(&dev->dev, "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
 			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
@@ -2779,8 +2779,8 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	dev_printk(KERN_DEBUG, &dev->dev, "cache line size of %d is not "
-		   "supported\n", pci_cache_line_size << 2);
+	dev_dbg(&dev->dev, "cache line size of %d is not supported\n",
+		pci_cache_line_size << 2);
 
 	return -EINVAL;
 }
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 0bf82a2..dbf3fd2 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -314,7 +314,7 @@ static int aer_probe(struct pcie_device *dev)
 	/* Alloc rpc data structure */
 	rpc = aer_alloc_rpc(dev);
 	if (!rpc) {
-		dev_printk(KERN_DEBUG, device, "alloc rpc failed\n");
+		dev_dbg(device, "alloc rpc failed\n");
 		aer_remove(dev);
 		return -ENOMEM;
 	}
@@ -322,7 +322,7 @@ static int aer_probe(struct pcie_device *dev)
 	/* Request IRQ ISR */
 	status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_printk(KERN_DEBUG, device, "request IRQ failed\n");
+		dev_dbg(device, "request IRQ failed\n");
 		aer_remove(dev);
 		return status;
 	}
@@ -353,7 +353,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	pci_reset_bridge_secondary_bus(dev);
-	dev_printk(KERN_DEBUG, &dev->dev, "Root Port link has been reset\n");
+	dev_dbg(&dev->dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index b2c8881..b5792aa 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -196,9 +196,8 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		dev_printk(KERN_DEBUG, &parent->dev,
-				"can't find device of ID%04x\n",
-				e_info->id);
+		dev_dbg(&parent->dev, "can't find device of ID%04x\n",
+			e_info->id);
 		return false;
 	}
 	return true;
@@ -226,9 +225,8 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 			 * of a driver for this device is unaware of
 			 * its hw state.
 			 */
-			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
-				   dev->driver ?
-				   "no AER-aware driver" : "no driver");
+			dev_dbg(&dev->dev, "device has %s\n", dev->driver ?
+					   "no AER-aware driver" : "no driver");
 		}
 
 		/*
@@ -334,7 +332,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 {
 	struct aer_broadcast_data result_data;
 
-	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", error_mesg);
+	dev_dbg(&dev->dev, "broadcast %s message\n", error_mesg);
 	result_data.state = state;
 	if (cb == report_error_detected)
 		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
@@ -376,7 +374,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	pci_reset_bridge_secondary_bus(dev);
-	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
+	dev_dbg(&dev->dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
@@ -429,15 +427,14 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 		pci_pcie_type(udev) == PCI_EXP_TYPE_ROOT_PORT) {
 		status = default_reset_link(udev);
 	} else {
-		dev_printk(KERN_DEBUG, &dev->dev,
+		dev_dbg(&dev->dev,
 			"no link-reset support at upstream device %s\n",
 			pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED) {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"link reset at upstream device %s failed\n",
+		dev_dbg(&dev->dev, "link reset at upstream device %s failed\n",
 			pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
@@ -694,7 +691,7 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 	/* struct aer_err_info might be big, so we allocate it with slab */
 	e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
 	if (!e_info) {
-		dev_printk(KERN_DEBUG, &p_device->port->dev,
+		dev_dbg(&p_device->port->dev,
 			"Can't allocate mem when processing AER errors\n");
 		return;
 	}
@@ -798,8 +795,7 @@ void aer_isr(struct work_struct *work)
 int aer_init(struct pcie_device *dev)
 {
 	if (forceload) {
-		dev_printk(KERN_DEBUG, &dev->device,
-			   "aerdrv forceload requested.\n");
+		dev_dbg(&dev->device, "aerdrv forceload requested.\n");
 		pcie_aer_force_firmware_first(dev->port, 0);
 	}
 	return 0;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2f0ce66..fe1c382 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -504,7 +504,7 @@ static int pcie_port_probe_service(struct device *dev)
 	if (status)
 		return status;
 
-	dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n", driver->name);
+	dev_dbg(dev, "service driver %s loaded\n", driver->name);
 	get_device(dev);
 	return 0;
 }
@@ -529,8 +529,7 @@ static int pcie_port_remove_service(struct device *dev)
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
 	if (driver && driver->remove) {
-		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
-			driver->name);
+		dev_dbg(dev, "unloading service driver %s\n", driver->name);
 		driver->remove(pciedev);
 		put_device(dev);
 	}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 490031f..560af95 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -305,7 +305,7 @@ out:
 	if (bar_too_big)
 		dev_err(&dev->dev, "reg 0x%x: can't handle 64-bit BAR\n", pos);
 	if (res->flags && !bar_disabled)
-		dev_printk(KERN_DEBUG, &dev->dev, "reg 0x%x: %pR\n", pos, res);
+		dev_dbg(&dev->dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -366,7 +366,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		dev_dbg(&dev->dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -388,7 +388,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		dev_dbg(&dev->dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -438,7 +438,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		dev_dbg(&dev->dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -468,9 +468,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			if (res) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
-				dev_printk(KERN_DEBUG, &dev->dev,
-					   "  bridge window %pR (subtractive decode)\n",
-					   res);
+				dev_dbg(&dev->dev,
+					"  bridge window %pR (subtractive decode)\n",
+					res);
 			}
 		}
 	}
@@ -1084,8 +1084,8 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	dev_printk(KERN_DEBUG, &dev->dev, "[%04x:%04x] type %02x class %#08x\n",
-		   dev->vendor, dev->device, dev->hdr_type, dev->class);
+	dev_dbg(&dev->dev, "[%04x:%04x] type %02x class %#08x\n",
+		dev->vendor, dev->device, dev->hdr_type, dev->class);
 
 	/* need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
@@ -1829,10 +1829,10 @@ int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 	conflict = request_resource_conflict(parent_res, res);
 
 	if (conflict)
-		dev_printk(KERN_DEBUG, &b->dev,
-			   "busn_res: can not insert %pR under %s%pR (conflicts with %s %pR)\n",
-			    res, pci_is_root_bus(b) ? "domain " : "",
-			    parent_res, conflict->name, conflict);
+		dev_dbg(&b->dev,
+			"busn_res: can not insert %pR under %s%pR (conflicts with %s %pR)\n",
+			res, pci_is_root_bus(b) ? "domain " : "",
+			parent_res, conflict->name, conflict);
 
 	return conflict == NULL;
 }
@@ -1849,9 +1849,8 @@ int pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
 
 	size = bus_max - res->start + 1;
 	ret = adjust_resource(res, res->start, size);
-	dev_printk(KERN_DEBUG, &b->dev,
-			"busn_res: %pR end %s updated to %02x\n",
-			&old_res, ret ? "can not be" : "is", bus_max);
+	dev_dbg(&b->dev, "busn_res: %pR end %s updated to %02x\n",
+		&old_res, ret ? "can not be" : "is", bus_max);
 
 	if (!ret && !res->parent)
 		pci_bus_insert_busn_res(b, res->start, res->end);
@@ -1868,9 +1867,8 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 		return;
 
 	ret = release_resource(res);
-	dev_printk(KERN_DEBUG, &b->dev,
-			"busn_res: %pR %s released\n",
-			res, ret ? "can not be" : "is");
+	dev_dbg(&b->dev, "busn_res: %pR %s released\n", res,
+		ret ? "can not be" : "is");
 }
 
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d219d44..33fc026 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -108,10 +108,10 @@ static resource_size_t get_res_add_size(struct list_head *head,
 		if (dev_res->res == res) {
 			int idx = res - &dev_res->dev->resource[0];
 
-			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
-				 "res[%d]=%pR get_res_add_size add_size %llx\n",
-				 idx, dev_res->res,
-				 (unsigned long long)dev_res->add_size);
+			dev_dbg(&dev_res->dev->dev,
+				"res[%d]=%pR get_res_add_size add_size %llx\n",
+				idx, dev_res->res,
+				(unsigned long long)dev_res->add_size);
 
 			return dev_res->add_size;
 		}
@@ -250,10 +250,9 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				dev_printk(KERN_DEBUG, &add_res->dev->dev,
-					   "failed to add %llx res[%d]=%pR\n",
-					   (unsigned long long)add_size,
-					   idx, res);
+				dev_dbg(&add_res->dev->dev,
+					"failed to add %llx res[%d]=%pR\n",
+					(unsigned long long)add_size, idx, res);
 		}
 out:
 		list_del(&add_res->list);
@@ -872,10 +871,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
-		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
-				 "%pR to %pR add_size %llx\n", b_res,
-				 &bus->busn_res,
-				 (unsigned long long)size1-size0);
+		dev_dbg(&bus->self->dev,
+			"bridge window %pR to %pR add_size %llx\n", b_res,
+			&bus->busn_res, (unsigned long long)size1 - size0);
 	}
 }
 
@@ -1004,9 +1002,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->flags |= IORESOURCE_STARTALIGN | mem64_mask;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
-		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
-				 "%pR to %pR add_size %llx\n", b_res,
-				 &bus->busn_res, (unsigned long long)size1-size0);
+		dev_dbg(&bus->self->dev,
+			"bridge window %pR to %pR add_size %llx\n", b_res,
+			&bus->busn_res, (unsigned long long)size1 - size0);
 	}
 	return 1;
 }
@@ -1277,8 +1275,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		 */
 		release_child_resources(r);
 		if (!release_resource(r)) {
-			dev_printk(KERN_DEBUG, &dev->dev,
-				 "resource %d %pR released\n", idx, r);
+			dev_dbg(&dev->dev, "resource %d %pR released\n",
+				idx, r);
 			/* keep the old size */
 			r->end = resource_size(r) - 1;
 			r->start = 0;
@@ -1344,7 +1342,7 @@ static void pci_bus_dump_res(struct pci_bus *bus)
 		if (!res || !res->end || !res->flags)
                         continue;
 
-		dev_printk(KERN_DEBUG, &bus->dev, "resource %d %pR\n", i, res);
+		dev_dbg(&bus->dev, "resource %d %pR\n", i, res);
         }
 }
 
@@ -1480,9 +1478,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 		int max_depth = pci_bus_get_depth(bus);
 
 		pci_try_num = max_depth + 1;
-		dev_printk(KERN_DEBUG, &bus->dev,
-			   "max bus depth: %d pci_try_num: %d\n",
-			   max_depth, pci_try_num);
+		dev_dbg(&bus->dev, "max bus depth: %d pci_try_num: %d\n",
+			max_depth, pci_try_num);
 	}
 
 again:
@@ -1516,8 +1513,8 @@ again:
 		goto dump;
 	}
 
-	dev_printk(KERN_DEBUG, &bus->dev,
-		   "No. %d try to assign unassigned res\n", tried_times + 1);
+	dev_dbg(&bus->dev, "No. %d try to assign unassigned res\n",
+		tried_times + 1);
 
 	/* third times and later will not check if it is leaf */
 	if ((tried_times + 1) > 2)
-- 
2.0.0.rc2

