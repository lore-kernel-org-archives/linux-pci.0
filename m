Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:43812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753202AbeFTPSi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 11:18:38 -0400
Message-ID: <287c7b8c3ea7a4b17ea5b25772815374e39f9f82.camel@perches.com>
Subject: Re: pci: pci_printk use
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Date: Wed, 20 Jun 2018 08:18:34 -0700
In-Reply-To: <20180620132852.GA108993@bhelgaas-glaptop.roam.corp.google.com>
References: <9bd45007ddfe2c32b6ee5097e427aabdc267ce53.camel@perches.com>
         <20180620132852.GA108993@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-06-20 at 08:28 -0500, Bjorn Helgaas wrote:
> On Tue, Jun 19, 2018 at 09:33:18PM -0700, Joe Perches wrote:
> > All the pci_printk uses are at KERN_DEBUG which is always
> > emitted into the kernel logging whenever the console log
> > level is high enough.
> > 
> > Are any of these appropriate for conversion to pci_dbg
> > to allow these only to be emitted via dynamic_debug or
> > if necessary via a #define DEBUG during compilation?
> 
> I think pci_printk(KERN_DEBUG) is a little ugly to read.

As do I which is why I bring it up.

> My
> preference would be to remove them (and pci_dbg() uses) completely or
> convert them to pci_info().  Most of these are boot-time or low
> frequency messages, so I doubt the loglevel differentiation of
> DEBUG/INFO is really necessary.

Perhaps so.

Does anyone have objections to a patch that removes
the #define pci_printk and does:
$ git ls-files -- 'drivers/pci/*.[ch]' \
  xargs sed -i 's/pci_printk(KERN_DEBUG, /pci_info(/'
with some alignment neatening?

Only issue I see is ctrl_dbg in the hotplug code
being emitted at KERN_INFO but it is only output
when a guard flag is set.  Maybe those should use
the normal pci_dbg instead of the shpchp_debug
guard.
---
 drivers/pci/bus.c            |  3 +--
 drivers/pci/hotplug/shpchp.h |  3 +--
 drivers/pci/pci.c            | 28 ++++++++++++++--------------
 drivers/pci/pcie/aer.c       |  5 ++---
 drivers/pci/pcie/err.c       | 18 +++++++++---------
 drivers/pci/probe.c          | 18 +++++++++---------
 drivers/pci/setup-bus.c      | 26 +++++++++++++-------------
 include/linux/pci.h          |  3 ---
 8 files changed, 49 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 35b7fc87eac5..82322c5bcc80 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -288,8 +288,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 		res->end = end;
 		res->flags &= ~IORESOURCE_UNSET;
 		orig_res.flags &= ~IORESOURCE_UNSET;
-		pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
-				 &orig_res, res);
+		pci_info(dev, "%pR clipped to %pR\n", &orig_res, res);
 
 		return true;
 	}
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 516e4835019c..64a74c364529 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -48,8 +48,7 @@ do {									\
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (shpchp_debug)					\
-			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
-					format, ## arg);		\
+			pci_info(ctrl->pci_dev, format, ## arg);	\
 	} while (0)
 #define ctrl_err(ctrl, format, arg...)					\
 	pci_err(ctrl->pci_dev, format, ## arg)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba712e4e..6a5390fa312f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2481,14 +2481,14 @@ void pci_pm_init(struct pci_dev *dev)
 			dev->d2_support = true;
 
 		if (dev->d1_support || dev->d2_support)
-			pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
-				   dev->d1_support ? " D1" : "",
-				   dev->d2_support ? " D2" : "");
+			pci_info(dev, "supports%s%s\n",
+				 dev->d1_support ? " D1" : "",
+				 dev->d2_support ? " D2" : "");
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
 	if (pmc) {
-		pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
+		pci_info(dev, "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
 			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
@@ -2652,17 +2652,17 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	res->flags = flags;
 
 	if (bei <= PCI_EA_BEI_BAR5)
-		pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei, res, prop);
+		pci_info(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+			 bei, res, prop);
 	else if (bei == PCI_EA_BEI_ROM)
-		pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   res, prop);
+		pci_info(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
+			 res, prop);
 	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
-		pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
+		pci_info(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+			 bei - PCI_EA_BEI_VF_BAR0, res, prop);
 	else
-		pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
-			   bei, res, prop);
+		pci_info(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
+			 bei, res, prop);
 
 out:
 	return offset + ent_size;
@@ -3772,8 +3772,8 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
-		   pci_cache_line_size << 2);
+	pci_info(dev, "cache line size of %d is not supported\n",
+		 pci_cache_line_size << 2);
 
 	return -EINVAL;
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..ed0c313bf09c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -772,8 +772,7 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
-			   e_info->id);
+		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
 		return false;
 	}
 	return true;
@@ -1314,7 +1313,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	pci_reset_bridge_secondary_bus(dev);
-	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..b0df9bf66b2e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -72,9 +72,9 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 			 * of a driver for this device is unaware of
 			 * its hw state.
 			 */
-			pci_printk(KERN_DEBUG, dev, "device has %s\n",
-				   dev->driver ?
-				   "no AER-aware driver" : "no driver");
+			pci_info(dev, "device has %s\n",
+				 dev->driver ?
+				 "no AER-aware driver" : "no driver");
 		}
 
 		/*
@@ -176,7 +176,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	pci_reset_bridge_secondary_bus(dev);
-	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
+	pci_info(dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
@@ -202,14 +202,14 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 	} else if (udev->has_secondary_link) {
 		status = default_reset_link(udev);
 	} else {
-		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
-			pci_name(udev));
+		pci_info(dev, "no link-reset support at upstream device %s\n",
+			 pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED) {
-		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
-			pci_name(udev));
+		pci_info(dev, "link reset at upstream device %s failed\n",
+			 pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -234,7 +234,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 {
 	struct aer_broadcast_data result_data;
 
-	pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
+	pci_info(dev, "broadcast %s message\n", error_mesg);
 	result_data.state = state;
 	if (cb == report_error_detected)
 		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..828cb8f89066 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -318,7 +318,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
+		pci_info(dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -385,7 +385,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -407,7 +407,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -460,7 +460,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
+		pci_info(dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -490,9 +490,9 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			if (res && res->flags) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
-				pci_printk(KERN_DEBUG, dev,
-					   "  bridge window %pR (subtractive decode)\n",
-					   res);
+				pci_info(dev,
+					 "  bridge window %pR (subtractive decode)\n",
+					 res);
 			}
 		}
 	}
@@ -1595,8 +1595,8 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
-		   dev->vendor, dev->device, dev->hdr_type, dev->class);
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class);
 
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824e83b4..308f8d10e4a7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -255,10 +255,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				pci_printk(KERN_DEBUG, add_res->dev,
-					   "failed to add %llx res[%d]=%pR\n",
-					   (unsigned long long)add_size,
-					   idx, res);
+				pci_info(add_res->dev,
+					 "failed to add %llx res[%d]=%pR\n",
+					 (unsigned long long)add_size,
+					 idx, res);
 		}
 out:
 		list_del(&add_res->list);
@@ -951,9 +951,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
-			   b_res, &bus->busn_res,
-			   (unsigned long long)size1-size0);
+		pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
+			 b_res, &bus->busn_res,
+			 (unsigned long long)size1 - size0);
 	}
 }
 
@@ -1098,10 +1098,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
-		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
-			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
-			   (unsigned long long) add_align);
+		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
+			 b_res, &bus->busn_res,
+			 (unsigned long long)size1 - size0,
+			 (unsigned long long)add_align);
 	}
 	return 0;
 }
@@ -1566,8 +1566,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
-					PCI_BRIDGE_RESOURCES + idx, r);
+		pci_info(dev, "resource %d %pR released\n",
+			 PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
 		r->start = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..e93a55336ecc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2298,9 +2298,6 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 /* Provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
-#define pci_printk(level, pdev, fmt, arg...) \
-	dev_printk(level, &(pdev)->dev, fmt, ##arg)
-
 #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
 #define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
 #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
