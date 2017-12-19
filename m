Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:38271 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759542AbdLSBQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 20:16:27 -0500
Received: by mail-io0-f174.google.com with SMTP id 87so7670187ior.5
        for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2017 17:16:26 -0800 (PST)
From: Frederick Lawler <fred@fredlawl.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 2/2] PCI: Replace calls from dev_<level> to pci_<level>
Date: Mon, 18 Dec 2017 19:16:14 -0600
Message-Id: <1513646174-2269-3-git-send-email-fred@fredlawl.com>
In-Reply-To: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
References: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace calls from dev_<level> to pci_<level>

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/access.c       |   6 +-
 drivers/pci/bus.c          |   4 +-
 drivers/pci/iov.c          |  10 +--
 drivers/pci/irq.c          |   6 +-
 drivers/pci/msi.c          |   6 +-
 drivers/pci/pci-acpi.c     |   2 +-
 drivers/pci/pci-stub.c     |   2 +-
 drivers/pci/pci-sysfs.c    |  10 +--
 drivers/pci/pci.c          |  76 ++++++++---------
 drivers/pci/probe.c        |  74 ++++++++---------
 drivers/pci/quirks.c       | 198 ++++++++++++++++++++++-----------------------
 drivers/pci/rom.c          |   4 +-
 drivers/pci/setup-bus.c    |  44 +++++-----
 drivers/pci/setup-irq.c    |   4 +-
 drivers/pci/setup-res.c    |  38 ++++-----
 drivers/pci/vc.c           |  16 ++--
 drivers/pci/xen-pcifront.c |  16 ++--
 17 files changed, 258 insertions(+), 258 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 913d672..9675230 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -333,7 +333,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			    (tag == PCI_VPD_LTIN_RW_DATA)) {
 				if (pci_read_vpd(dev, off+1, 2,
 						 &header[1]) != 2) {
-					dev_warn(&dev->dev,
+					pci_warn(dev,
 						 "invalid large VPD tag %02x size at offset %zu",
 						 tag, off + 1);
 					return 0;
@@ -354,7 +354,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
 		    (tag != PCI_VPD_LTIN_RO_DATA) &&
 		    (tag != PCI_VPD_LTIN_RW_DATA)) {
-			dev_warn(&dev->dev,
+			pci_warn(dev,
 				 "invalid %s VPD tag %02x at offset %zu",
 				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
 				 tag, off);
@@ -402,7 +402,7 @@ static int pci_vpd_wait(struct pci_dev *dev)
 			max_sleep *= 2;
 	}
 
-	dev_warn(&dev->dev, "VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
+	pci_warn(dev, "VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
 	return -ETIMEDOUT;
 }
 
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf1..efe61c0 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -289,7 +289,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 		res->end = end;
 		res->flags &= ~IORESOURCE_UNSET;
 		orig_res.flags &= ~IORESOURCE_UNSET;
-		dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
+		pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
 				 &orig_res, res);
 
 		return true;
@@ -325,7 +325,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER) {
-		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
+		pci_warn(dev, "device attach failed (%d)\n", retval);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		return;
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 6bacb89..449a9db 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -259,19 +259,19 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			nres++;
 	}
 	if (nres != iov->nres) {
-		dev_err(&dev->dev, "not enough MMIO resources for SR-IOV\n");
+		pci_err(dev, "not enough MMIO resources for SR-IOV\n");
 		return -ENOMEM;
 	}
 
 	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
 	if (bus > dev->bus->busn_res.end) {
-		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
+		pci_err(dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
 			nr_virtfn, bus, &dev->bus->busn_res);
 		return -ENOMEM;
 	}
 
 	if (pci_enable_resources(dev, bars)) {
-		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
+		pci_err(dev, "SR-IOV: IOV BARS not allocated\n");
 		return -ENOMEM;
 	}
 
@@ -298,7 +298,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 	rc = pcibios_sriov_enable(dev, initial);
 	if (rc) {
-		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n", rc);
+		pci_err(dev, "failure %d from pcibios_sriov_enable()\n", rc);
 		goto err_pcibios;
 	}
 
@@ -432,7 +432,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		}
 		iov->barsz[i] = resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
-		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
+		pci_info(dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
 			 i, res, i, total);
 		i += bar64;
 		nres++;
diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
index 10929cd..6b2d1e6 100644
--- a/drivers/pci/irq.c
+++ b/drivers/pci/irq.c
@@ -16,11 +16,11 @@ static void pci_note_irq_problem(struct pci_dev *pdev, const char *reason)
 {
 	struct pci_dev *parent = to_pci_dev(pdev->dev.parent);
 
-	dev_err(&pdev->dev,
+	pci_err(pdev,
 		"Potentially misrouted IRQ (Bridge %s %04x:%04x)\n",
 		dev_name(&parent->dev), parent->vendor, parent->device);
-	dev_err(&pdev->dev, "%s\n", reason);
-	dev_err(&pdev->dev, "Please report to linux-kernel@vger.kernel.org\n");
+	pci_err(pdev, "%s\n", reason);
+	pci_err(pdev, "Please report to linux-kernel@vger.kernel.org\n");
 	WARN_ON(1);
 }
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e066071..25675ef 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -578,7 +578,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 	for_each_pci_msi_entry(entry, dev) {
 		if (!dev->no_64bit_msi || !entry->msg.address_hi)
 			continue;
-		dev_err(&dev->dev, "Device has broken 64-bit MSI but arch"
+		pci_err(dev, "Device has broken 64-bit MSI but arch"
 			" tried to assign one above 4G\n");
 		return -EIO;
 	}
@@ -962,7 +962,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 
 	/* Check whether driver already requested for MSI irq */
 	if (dev->msi_enabled) {
-		dev_info(&dev->dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
+		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
 	return msix_capability_init(dev, entries, nvec, affd);
@@ -1032,7 +1032,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	/* Check whether driver already requested MSI-X irqs */
 	if (dev->msix_enabled) {
-		dev_info(&dev->dev,
+		pci_info(dev,
 			 "can't enable MSI (MSI-X already enabled)\n");
 		return -EINVAL;
 	}
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4708eb9..189e6cc 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -542,7 +542,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	}
 
 	if (!error)
-		dev_dbg(&dev->dev, "power state changed by ACPI to %s\n",
+		pci_dbg(dev, "power state changed by ACPI to %s\n",
 			 acpi_power_state_string(state_conv[state]));
 
 	return error;
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 886fb35..e51789e 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -28,7 +28,7 @@ MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
 
 static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	dev_info(&dev->dev, "claimed by stub\n");
+	pci_info(dev, "claimed by stub\n");
 	return 0;
 }
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 06c7f0b..c7941a0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -348,7 +348,7 @@ static ssize_t numa_node_store(struct device *dev,
 		return -EINVAL;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-	dev_alert(&pdev->dev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
+	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
 		  node);
 
 	dev->numa_node = node;
@@ -411,7 +411,7 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 	 */
 	if (!subordinate) {
 		pdev->no_msi = !val;
-		dev_info(&pdev->dev, "MSI/MSI-X %s for future drivers\n",
+		pci_info(pdev, "MSI/MSI-X %s for future drivers\n",
 			 val ? "allowed" : "disallowed");
 		return count;
 	}
@@ -613,7 +613,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	/* is PF driver loaded w/callback */
 	if (!pdev->driver || !pdev->driver->sriov_configure) {
-		dev_info(&pdev->dev, "Driver doesn't support SRIOV configuration via sysfs\n");
+		pci_info(pdev, "Driver doesn't support SRIOV configuration via sysfs\n");
 		ret = -ENOENT;
 		goto exit;
 	}
@@ -626,7 +626,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	/* enable VFs */
 	if (pdev->sriov->num_VFs) {
-		dev_warn(&pdev->dev, "%d VFs already enabled. Disable before enabling %d VFs\n",
+		pci_warn(pdev, "%d VFs already enabled. Disable before enabling %d VFs\n",
 			 pdev->sriov->num_VFs, num_vfs);
 		ret = -EBUSY;
 		goto exit;
@@ -637,7 +637,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 
 	if (ret != num_vfs)
-		dev_warn(&pdev->dev, "%d VFs requested; only %d enabled\n",
+		pci_warn(pdev, "%d VFs requested; only %d enabled\n",
 			 num_vfs, ret);
 
 exit:
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c686..5616775 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -156,7 +156,7 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
 	 * Make sure the BAR is actually a memory resource, not an IO resource
 	 */
 	if (res->flags & IORESOURCE_UNSET || !(res->flags & IORESOURCE_MEM)) {
-		dev_warn(&pdev->dev, "can't ioremap BAR %d: %pR\n", bar, res);
+		pci_warn(pdev, "can't ioremap BAR %d: %pR\n", bar, res);
 		return NULL;
 	}
 	return ioremap_nocache(res->start, resource_size(res));
@@ -648,7 +648,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	 */
 	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
 	    && dev->current_state > state) {
-		dev_err(&dev->dev, "invalid power transition (from state %d to %d)\n",
+		pci_err(dev, "invalid power transition (from state %d to %d)\n",
 			dev->current_state, state);
 		return -EINVAL;
 	}
@@ -696,7 +696,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	if (dev->current_state != state && printk_ratelimit())
-		dev_info(&dev->dev, "Refused to change power state, currently in D%d\n",
+		pci_info(dev, "Refused to change power state, currently in D%d\n",
 			 dev->current_state);
 
 	/*
@@ -970,7 +970,7 @@ pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 	case PM_EVENT_HIBERNATE:
 		return PCI_D3hot;
 	default:
-		dev_info(&dev->dev, "unrecognized suspend event %d\n",
+		pci_info(dev, "unrecognized suspend event %d\n",
 			 state.event);
 		BUG();
 	}
@@ -1013,7 +1013,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state) {
-		dev_err(&dev->dev, "buffer not found in %s\n", __func__);
+		pci_err(dev, "buffer not found in %s\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -1061,7 +1061,7 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
 	if (!save_state) {
-		dev_err(&dev->dev, "buffer not found in %s\n", __func__);
+		pci_err(dev, "buffer not found in %s\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -1121,7 +1121,7 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
 		return;
 
 	for (;;) {
-		dev_dbg(&pdev->dev, "restoring config space at offset %#x (was %#x, writing %#x)\n",
+		pci_dbg(pdev, "restoring config space at offset %#x (was %#x, writing %#x)\n",
 			offset, val, saved_val);
 		pci_write_config_dword(pdev, offset, saved_val);
 		if (retry-- <= 0)
@@ -1358,7 +1358,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 
 	retval = pci_enable_device(dev);
 	if (retval)
-		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
+		pci_err(dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
 }
@@ -1863,7 +1863,7 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 			pme_dev = kmalloc(sizeof(struct pci_pme_device),
 					  GFP_KERNEL);
 			if (!pme_dev) {
-				dev_warn(&dev->dev, "can't enable PME#\n");
+				pci_warn(dev, "can't enable PME#\n");
 				return;
 			}
 			pme_dev->dev = dev;
@@ -1887,7 +1887,7 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
 		}
 	}
 
-	dev_dbg(&dev->dev, "PME# %s\n", enable ? "enabled" : "disabled");
+	pci_dbg(dev, "PME# %s\n", enable ? "enabled" : "disabled");
 }
 EXPORT_SYMBOL(pci_pme_active);
 
@@ -2424,7 +2424,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
-		dev_err(&dev->dev, "unsupported PM cap regs version (%u)\n",
+		pci_err(dev, "unsupported PM cap regs version (%u)\n",
 			pmc & PCI_PM_CAP_VER_MASK);
 		return;
 	}
@@ -2444,14 +2444,14 @@ void pci_pm_init(struct pci_dev *dev)
 			dev->d2_support = true;
 
 		if (dev->d1_support || dev->d2_support)
-			dev_printk(KERN_DEBUG, &dev->dev, "supports%s%s\n",
+			pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
 				   dev->d1_support ? " D1" : "",
 				   dev->d2_support ? " D2" : "");
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
 	if (pmc) {
-		dev_printk(KERN_DEBUG, &dev->dev,
+		pci_printk(KERN_DEBUG, dev,
 			 "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
@@ -2544,13 +2544,13 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 
 	res = pci_ea_get_resource(dev, bei, prop);
 	if (!res) {
-		dev_err(&dev->dev, "Unsupported EA entry BEI: %u\n", bei);
+		pci_err(dev, "Unsupported EA entry BEI: %u\n", bei);
 		goto out;
 	}
 
 	flags = pci_ea_flags(dev, prop);
 	if (!flags) {
-		dev_err(&dev->dev, "Unsupported EA properties: %#x\n", prop);
+		pci_err(dev, "Unsupported EA properties: %#x\n", prop);
 		goto out;
 	}
 
@@ -2600,12 +2600,12 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	}
 
 	if (end < start) {
-		dev_err(&dev->dev, "EA Entry crosses address boundary\n");
+		pci_err(dev, "EA Entry crosses address boundary\n");
 		goto out;
 	}
 
 	if (ent_size != ent_offset - offset) {
-		dev_err(&dev->dev,
+		pci_err(dev,
 			"EA Entry Size (%d) does not match length read (%d)\n",
 			ent_size, ent_offset - offset);
 		goto out;
@@ -2617,16 +2617,16 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	res->flags = flags;
 
 	if (bei <= PCI_EA_BEI_BAR5)
-		dev_printk(KERN_DEBUG, &dev->dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei, res, prop);
 	else if (bei == PCI_EA_BEI_ROM)
-		dev_printk(KERN_DEBUG, &dev->dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   res, prop);
 	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
-		dev_printk(KERN_DEBUG, &dev->dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
 	else
-		dev_printk(KERN_DEBUG, &dev->dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
+		pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
 			   bei, res, prop);
 
 out:
@@ -2723,12 +2723,12 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_EXP,
 					PCI_EXP_SAVE_REGS * sizeof(u16));
 	if (error)
-		dev_err(&dev->dev,
+		pci_err(dev,
 			"unable to preallocate PCI Express save buffer\n");
 
 	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_PCIX, sizeof(u16));
 	if (error)
-		dev_err(&dev->dev,
+		pci_err(dev,
 			"unable to preallocate PCI-X save buffer\n");
 
 	pci_allocate_vc_save_buffers(dev);
@@ -3198,7 +3198,7 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 	return 0;
 
 err_out:
-	dev_warn(&pdev->dev, "BAR %d: can't reserve %pR\n", bar,
+	pci_warn(pdev, "BAR %d: can't reserve %pR\n", bar,
 		 &pdev->resource[bar]);
 	return -EBUSY;
 }
@@ -3621,7 +3621,7 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 	else
 		cmd = old_cmd & ~PCI_COMMAND_MASTER;
 	if (cmd != old_cmd) {
-		dev_dbg(&dev->dev, "%s bus mastering\n",
+		pci_dbg(dev, "%s bus mastering\n",
 			enable ? "enabling" : "disabling");
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
@@ -3722,7 +3722,7 @@ int pci_set_cacheline_size(struct pci_dev *dev)
 	if (cacheline_size == pci_cache_line_size)
 		return 0;
 
-	dev_printk(KERN_DEBUG, &dev->dev, "cache line size of %d is not supported\n",
+	pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
 		   pci_cache_line_size << 2);
 
 	return -EINVAL;
@@ -3751,7 +3751,7 @@ int pci_set_mwi(struct pci_dev *dev)
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	if (!(cmd & PCI_COMMAND_INVALIDATE)) {
-		dev_dbg(&dev->dev, "enabling Mem-Wr-Inval\n");
+		pci_dbg(dev, "enabling Mem-Wr-Inval\n");
 		cmd |= PCI_COMMAND_INVALIDATE;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
@@ -3947,13 +3947,13 @@ static void pci_flr_wait(struct pci_dev *dev)
 	pci_read_config_dword(dev, PCI_COMMAND, &id);
 	while (id == ~0) {
 		if (delay > timeout) {
-			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
+			pci_warn(dev, "not ready %dms after FLR; giving up\n",
 				 100 + delay - 1);
 			return;
 		}
 
 		if (delay > 1000)
-			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
+			pci_info(dev, "not ready %dms after FLR; waiting\n",
 				 100 + delay - 1);
 
 		msleep(delay);
@@ -3962,7 +3962,7 @@ static void pci_flr_wait(struct pci_dev *dev)
 	}
 
 	if (delay > 1000)
-		dev_info(&dev->dev, "ready %dms after FLR\n", 100 + delay - 1);
+		pci_info(dev, "ready %dms after FLR\n", 100 + delay - 1);
 }
 
 /**
@@ -3994,7 +3994,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
 void pcie_flr(struct pci_dev *dev)
 {
 	if (!pci_wait_for_pending_transaction(dev))
-		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
+		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 	pci_flr_wait(dev);
@@ -4027,7 +4027,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 	 */
 	if (!pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
 				 PCI_AF_STATUS_TP << 8))
-		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
+		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 	pci_flr_wait(dev);
@@ -5150,12 +5150,12 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
 					      sizeof(long), GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
-		dev_warn(&dev->dev, "Unable to allocate DMA alias mask\n");
+		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
 	}
 
 	set_bit(devfn, dev->dma_alias_mask);
-	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
+	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
 		 PCI_SLOT(devfn), PCI_FUNC(devfn));
 }
 
@@ -5304,7 +5304,7 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 		return;
 
 	if (r->flags & IORESOURCE_PCI_FIXED) {
-		dev_info(&dev->dev, "BAR%d %pR: ignoring requested alignment %#llx\n",
+		pci_info(dev, "BAR%d %pR: ignoring requested alignment %#llx\n",
 			 bar, r, (unsigned long long)align);
 		return;
 	}
@@ -5341,7 +5341,7 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	 * devices and we use the second.
 	 */
 
-	dev_info(&dev->dev, "BAR%d %pR: requesting alignment to %#llx\n",
+	pci_info(dev, "BAR%d %pR: requesting alignment to %#llx\n",
 		 bar, r, (unsigned long long)align);
 
 	if (resize) {
@@ -5387,12 +5387,12 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
 	    (dev->class >> 8) == PCI_CLASS_BRIDGE_HOST) {
-		dev_warn(&dev->dev,
+		pci_warn(dev,
 			"Can't reassign resources to host bridge.\n");
 		return;
 	}
 
-	dev_info(&dev->dev,
+	pci_info(dev,
 		"Disabling memory decoding and releasing memory resources.\n");
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 14e0ea1..1e1122e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -253,7 +253,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 
 	sz64 = pci_size(l64, sz64, mask64);
 	if (!sz64) {
-		dev_info(&dev->dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
+		pci_info(dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
 			 pos);
 		goto fail;
 	}
@@ -264,7 +264,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 			res->start = 0;
 			res->end = 0;
-			dev_err(&dev->dev, "reg 0x%x: can't handle BAR larger than 4GB (size %#010llx)\n",
+			pci_err(dev, "reg 0x%x: can't handle BAR larger than 4GB (size %#010llx)\n",
 				pos, (unsigned long long)sz64);
 			goto out;
 		}
@@ -274,7 +274,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			res->flags |= IORESOURCE_UNSET;
 			res->start = 0;
 			res->end = sz64;
-			dev_info(&dev->dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
+			pci_info(dev, "reg 0x%x: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 pos, (unsigned long long)l64);
 			goto out;
 		}
@@ -301,7 +301,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		res->flags |= IORESOURCE_UNSET;
 		res->start = 0;
 		res->end = region.end - region.start;
-		dev_info(&dev->dev, "reg 0x%x: initial BAR value %#010llx invalid\n",
+		pci_info(dev, "reg 0x%x: initial BAR value %#010llx invalid\n",
 			 pos, (unsigned long long)region.start);
 	}
 
@@ -312,7 +312,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 	res->flags = 0;
 out:
 	if (res->flags)
-		dev_printk(KERN_DEBUG, &dev->dev, "reg 0x%x: %pR\n", pos, res);
+		pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
 
 	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
 }
@@ -375,7 +375,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + io_granularity - 1;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -397,7 +397,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -437,7 +437,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 	limit = (pci_bus_addr_t) limit64;
 
 	if (base != base64) {
-		dev_err(&dev->dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
+		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
 			(unsigned long long) base64);
 		return;
 	}
@@ -450,7 +450,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		region.start = base;
 		region.end = limit + 0xfffff;
 		pcibios_bus_to_resource(dev->bus, res, &region);
-		dev_printk(KERN_DEBUG, &dev->dev, "  bridge window %pR\n", res);
+		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
 	}
 }
 
@@ -463,7 +463,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
 		return;
 
-	dev_info(&dev->dev, "PCI bridge to %pR%s\n",
+	pci_info(dev, "PCI bridge to %pR%s\n",
 		 &child->busn_res,
 		 dev->transparent ? " (subtractive decode)" : "");
 
@@ -480,7 +480,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 			if (res && res->flags) {
 				pci_bus_add_resource(child, res,
 						     PCI_SUBTRACTIVE_DECODE);
-				dev_printk(KERN_DEBUG, &dev->dev,
+				pci_printk(KERN_DEBUG, dev,
 					   "  bridge window %pR (subtractive decode)\n",
 					   res);
 			}
@@ -1005,11 +1005,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	secondary = (buses >> 8) & 0xFF;
 	subordinate = (buses >> 16) & 0xFF;
 
-	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
+	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);
 
 	if (!primary && (primary != bus->number) && secondary && subordinate) {
-		dev_warn(&dev->dev, "Primary bus is hard wired to 0\n");
+		pci_warn(dev, "Primary bus is hard wired to 0\n");
 		primary = bus->number;
 	}
 
@@ -1017,7 +1017,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number ||
 	     secondary > subordinate)) {
-		dev_info(&dev->dev, "bridge configuration invalid ([bus %02x-%02x]), reconfiguring\n",
+		pci_info(dev, "bridge configuration invalid ([bus %02x-%02x]), reconfiguring\n",
 			 secondary, subordinate);
 		broken = 1;
 	}
@@ -1058,7 +1058,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 		cmax = pci_scan_child_bus(child);
 		if (cmax > subordinate)
-			dev_warn(&dev->dev, "bridge has subordinate %02x but max busn %02x\n",
+			pci_warn(dev, "bridge has subordinate %02x but max busn %02x\n",
 				 subordinate, cmax);
 		/* subordinate should equal child->busn_res.end */
 		if (subordinate > max)
@@ -1468,7 +1468,7 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	dev_printk(KERN_DEBUG, &dev->dev, "[%04x:%04x] type %02x class %#08x\n",
+	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
 		   dev->vendor, dev->device, dev->hdr_type, dev->class);
 
 	/* need to have dev->class ready */
@@ -1488,7 +1488,7 @@ int pci_setup_device(struct pci_dev *dev)
 	if (dev->non_compliant_bars) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			dev_info(&dev->dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
+			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
 			cmd &= ~PCI_COMMAND_IO;
 			cmd &= ~PCI_COMMAND_MEMORY;
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
@@ -1521,14 +1521,14 @@ int pci_setup_device(struct pci_dev *dev)
 				res = &dev->resource[0];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				dev_info(&dev->dev, "legacy IDE quirk: reg 0x10: %pR\n",
+				pci_info(dev, "legacy IDE quirk: reg 0x10: %pR\n",
 					 res);
 				region.start = 0x3F6;
 				region.end = 0x3F6;
 				res = &dev->resource[1];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				dev_info(&dev->dev, "legacy IDE quirk: reg 0x14: %pR\n",
+				pci_info(dev, "legacy IDE quirk: reg 0x14: %pR\n",
 					 res);
 			}
 			if ((progif & 4) == 0) {
@@ -1537,14 +1537,14 @@ int pci_setup_device(struct pci_dev *dev)
 				res = &dev->resource[2];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				dev_info(&dev->dev, "legacy IDE quirk: reg 0x18: %pR\n",
+				pci_info(dev, "legacy IDE quirk: reg 0x18: %pR\n",
 					 res);
 				region.start = 0x376;
 				region.end = 0x376;
 				res = &dev->resource[3];
 				res->flags = LEGACY_IO_RESOURCE;
 				pcibios_bus_to_resource(dev->bus, res, &region);
-				dev_info(&dev->dev, "legacy IDE quirk: reg 0x1c: %pR\n",
+				pci_info(dev, "legacy IDE quirk: reg 0x1c: %pR\n",
 					 res);
 			}
 		}
@@ -1577,12 +1577,12 @@ int pci_setup_device(struct pci_dev *dev)
 		break;
 
 	default:				    /* unknown header */
-		dev_err(&dev->dev, "unknown header type %02x, ignoring device\n",
+		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
 		return -EIO;
 
 	bad:
-		dev_err(&dev->dev, "ignoring class %#08x (doesn't match header type %02x)\n",
+		pci_err(dev, "ignoring class %#08x (doesn't match header type %02x)\n",
 			dev->class, dev->hdr_type);
 		dev->class = PCI_CLASS_NOT_DEFINED << 8;
 	}
@@ -1606,7 +1606,7 @@ static void pci_configure_mps(struct pci_dev *dev)
 		return;
 
 	if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
-		dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+		pci_warn(dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
 			 mps, pci_name(bridge), p_mps);
 		return;
 	}
@@ -1620,12 +1620,12 @@ static void pci_configure_mps(struct pci_dev *dev)
 
 	rc = pcie_set_mps(dev, p_mps);
 	if (rc) {
-		dev_warn(&dev->dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
 			 p_mps);
 		return;
 	}
 
-	dev_info(&dev->dev, "Max Payload Size set to %d (was %d, max %d)\n",
+	pci_info(dev, "Max Payload Size set to %d (was %d, max %d)\n",
 		 p_mps, mps, 128 << dev->pcie_mpss);
 }
 
@@ -1645,7 +1645,7 @@ static void program_hpp_type0(struct pci_dev *dev, struct hpp_type0 *hpp)
 		hpp = &pci_default_type0;
 
 	if (hpp->revision > 1) {
-		dev_warn(&dev->dev,
+		pci_warn(dev,
 			 "PCI settings rev %d not supported; using defaults\n",
 			 hpp->revision);
 		hpp = &pci_default_type0;
@@ -1684,7 +1684,7 @@ static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
 	if (!pos)
 		return;
 
-	dev_warn(&dev->dev, "PCI-X settings not supported\n");
+	pci_warn(dev, "PCI-X settings not supported\n");
 }
 
 static bool pcie_root_rcb_set(struct pci_dev *dev)
@@ -1714,7 +1714,7 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 		return;
 
 	if (hpp->revision > 1) {
-		dev_warn(&dev->dev, "PCIe settings rev %d not supported\n",
+		pci_warn(dev, "PCIe settings rev %d not supported\n",
 			 hpp->revision);
 		return;
 	}
@@ -1818,7 +1818,7 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	 */
 	if (host->no_ext_tags) {
 		if (ctl & PCI_EXP_DEVCTL_EXT_TAG) {
-			dev_info(&dev->dev, "disabling Extended Tags\n");
+			pci_info(dev, "disabling Extended Tags\n");
 			pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 						   PCI_EXP_DEVCTL_EXT_TAG);
 		}
@@ -1826,7 +1826,7 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	}
 
 	if (!(ctl & PCI_EXP_DEVCTL_EXT_TAG)) {
-		dev_info(&dev->dev, "enabling Extended Tags\n");
+		pci_info(dev, "enabling Extended Tags\n");
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
 					 PCI_EXP_DEVCTL_EXT_TAG);
 	}
@@ -1871,7 +1871,7 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 	if (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING) {
 		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					   PCI_EXP_DEVCTL_RELAX_EN);
-		dev_info(&dev->dev, "Disable Relaxed Ordering because the Root Port didn't support it\n");
+		pci_info(dev, "Disable Relaxed Ordering because the Root Port didn't support it\n");
 	}
 }
 
@@ -2334,7 +2334,7 @@ static void pcie_write_mps(struct pci_dev *dev, int mps)
 
 	rc = pcie_set_mps(dev, mps);
 	if (rc)
-		dev_err(&dev->dev, "Failed attempting to set the MPS\n");
+		pci_err(dev, "Failed attempting to set the MPS\n");
 }
 
 static void pcie_write_mrrs(struct pci_dev *dev)
@@ -2364,12 +2364,12 @@ static void pcie_write_mrrs(struct pci_dev *dev)
 		if (!rc)
 			break;
 
-		dev_warn(&dev->dev, "Failed attempting to set the MRRS\n");
+		pci_warn(dev, "Failed attempting to set the MRRS\n");
 		mrrs /= 2;
 	}
 
 	if (mrrs < 128)
-		dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
+		pci_err(dev, "MRRS was unable to be configured with a safe value.  If problems are experienced, try running with pci=pcie_bus_safe\n");
 }
 
 static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
@@ -2389,7 +2389,7 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
 	pcie_write_mps(dev, mps);
 	pcie_write_mrrs(dev);
 
-	dev_info(&dev->dev, "Max Payload Size set to %4d/%4d (was %4d), Max Read Rq %4d\n",
+	pci_info(dev, "Max Payload Size set to %4d/%4d (was %4d), Max Read Rq %4d\n",
 		 pcie_get_mps(dev), 128 << dev->pcie_mpss,
 		 orig_mps, pcie_get_readrq(dev));
 
@@ -2874,7 +2874,7 @@ int pci_hp_add_bridge(struct pci_dev *dev)
 			break;
 	}
 	if (busnr-- > end) {
-		dev_err(&dev->dev, "No bus number available for hot-added bridge\n");
+		pci_err(dev, "No bus number available for hot-added bridge\n");
 		return -1;
 	}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10684b1..82a5611 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -66,7 +66,7 @@ static void quirk_passive_release(struct pci_dev *dev)
 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, d))) {
 		pci_read_config_byte(d, 0x82, &dlc);
 		if (!(dlc & 1<<1)) {
-			dev_info(&d->dev, "PIIX3: Enabling Passive Release\n");
+			pci_info(d, "PIIX3: Enabling Passive Release\n");
 			dlc |= 1<<1;
 			pci_write_config_byte(d, 0x82, dlc);
 		}
@@ -86,7 +86,7 @@ static void quirk_isa_dma_hangs(struct pci_dev *dev)
 {
 	if (!isa_dma_bridge_buggy) {
 		isa_dma_bridge_buggy = 1;
-		dev_info(&dev->dev, "Activating ISA DMA hang workarounds\n");
+		pci_info(dev, "Activating ISA DMA hang workarounds\n");
 	}
 }
 	/*
@@ -115,7 +115,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 	pm1a = inw(pmbase);
 
 	if (pm1a & 0x10) {
-		dev_info(&dev->dev, FW_BUG "TigerPoint LPC.BM_STS cleared\n");
+		pci_info(dev, FW_BUG "TigerPoint LPC.BM_STS cleared\n");
 		outw(0x10, pmbase);
 	}
 }
@@ -127,7 +127,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LPC, quirk
 static void quirk_nopcipci(struct pci_dev *dev)
 {
 	if ((pci_pci_problems & PCIPCI_FAIL) == 0) {
-		dev_info(&dev->dev, "Disabling direct PCI/PCI transfers\n");
+		pci_info(dev, "Disabling direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_FAIL;
 	}
 }
@@ -140,7 +140,7 @@ static void quirk_nopciamd(struct pci_dev *dev)
 	pci_read_config_byte(dev, 0x08, &rev);
 	if (rev == 0x13) {
 		/* Erratum 24 */
-		dev_info(&dev->dev, "Chipset erratum: Disabling direct PCI/AGP transfers\n");
+		pci_info(dev, "Chipset erratum: Disabling direct PCI/AGP transfers\n");
 		pci_pci_problems |= PCIAGP_FAIL;
 	}
 }
@@ -152,7 +152,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopci
 static void quirk_triton(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_TRITON) == 0) {
-		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_TRITON;
 	}
 }
@@ -212,7 +212,7 @@ static void quirk_vialatency(struct pci_dev *dev)
 	busarb &= ~(1<<5);
 	busarb |= (1<<4);
 	pci_write_config_byte(dev, 0x76, busarb);
-	dev_info(&dev->dev, "Applying VIA southbridge workaround\n");
+	pci_info(dev, "Applying VIA southbridge workaround\n");
 exit:
 	pci_dev_put(p);
 }
@@ -230,7 +230,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,		quirk_viala
 static void quirk_viaetbf(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_VIAETBF) == 0) {
-		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_VIAETBF;
 	}
 }
@@ -239,7 +239,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_via
 static void quirk_vsfx(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_VSFX) == 0) {
-		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_VSFX;
 	}
 }
@@ -254,7 +254,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx)
 static void quirk_alimagik(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_ALIMAGIK) == 0) {
-		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_ALIMAGIK|PCIPCI_TRITON;
 	}
 }
@@ -268,7 +268,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M1651,		quirk_alimagi
 static void quirk_natoma(struct pci_dev *dev)
 {
 	if ((pci_pci_problems&PCIPCI_NATOMA) == 0) {
-		dev_info(&dev->dev, "Limiting direct PCI/PCI transfers\n");
+		pci_info(dev, "Limiting direct PCI/PCI transfers\n");
 		pci_pci_problems |= PCIPCI_NATOMA;
 	}
 }
@@ -313,7 +313,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 			r->end = PAGE_SIZE - 1;
 			r->start = 0;
 			r->flags |= IORESOURCE_UNSET;
-			dev_info(&dev->dev, "expanded BAR %d to page size: %pR\n",
+			pci_info(dev, "expanded BAR %d to page size: %pR\n",
 				 i, r);
 		}
 	}
@@ -360,7 +360,7 @@ static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
 	bus_region.end = region + size - 1;
 	pcibios_bus_to_resource(dev->bus, res, &bus_region);
 
-	dev_info(&dev->dev, FW_BUG "%s quirk: reg 0x%x: %pR\n",
+	pci_info(dev, FW_BUG "%s quirk: reg 0x%x: %pR\n",
 		 name, PCI_BASE_ADDRESS_0 + (pos << 2), res);
 }
 
@@ -381,7 +381,7 @@ static void quirk_cs5536_vsa(struct pci_dev *dev)
 		quirk_io(dev, 0,   8, name);	/* SMB */
 		quirk_io(dev, 1, 256, name);	/* GPIO */
 		quirk_io(dev, 2,  64, name);	/* MFGPT */
-		dev_info(&dev->dev, "%s bug detected (incorrect header); workaround applied\n",
+		pci_info(dev, "%s bug detected (incorrect header); workaround applied\n",
 			 name);
 	}
 }
@@ -409,7 +409,7 @@ static void quirk_io_region(struct pci_dev *dev, int port,
 	pcibios_bus_to_resource(dev->bus, res, &bus_region);
 
 	if (!pci_claim_resource(dev, nr))
-		dev_info(&dev->dev, "quirk: %pR claimed by %s\n", res, name);
+		pci_info(dev, "quirk: %pR claimed by %s\n", res, name);
 }
 
 /*
@@ -418,7 +418,7 @@ static void quirk_io_region(struct pci_dev *dev, int port,
  */
 static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
+	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
 	request_region(0x3b0, 0x0C, "RadeonIGP");
 	request_region(0x3d3, 0x01, "RadeonIGP");
@@ -441,7 +441,7 @@ static void quirk_amd_nl_class(struct pci_dev *pdev)
 
 	/* Use "USB Device (not host controller)" class */
 	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	dev_info(&pdev->dev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
@@ -488,7 +488,7 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
 	 * let's get enough confirmation reports first.
 	 */
 	base &= -size;
-	dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base,
+	pci_info(dev, "%s PIO at %04x-%04x\n", name, base,
 		 base + size - 1);
 }
 
@@ -514,7 +514,7 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
 	 * reserve it, but let's get enough confirmation reports first.
 	 */
 	base &= -size;
-	dev_info(&dev->dev, "%s MMIO at %04x-%04x\n", name, base,
+	pci_info(dev, "%s MMIO at %04x-%04x\n", name, base,
 		 base + size - 1);
 }
 
@@ -644,7 +644,7 @@ static void ich6_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const cha
 	base &= ~(size-1);
 
 	/* Just print it out for now. We should reserve it after more debugging */
-	dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
+	pci_info(dev, "%s PIO at %04x-%04x\n", name, base, base+size-1);
 }
 
 static void quirk_ich6_lpc(struct pci_dev *dev)
@@ -679,7 +679,7 @@ static void ich7_lpc_generic_decode(struct pci_dev *dev, unsigned reg, const cha
 	mask |= 3;
 
 	/* Just print it out for now. We should reserve it after more debugging */
-	dev_info(&dev->dev, "%s PIO at %04x (mask %04x)\n", name, base, mask);
+	pci_info(dev, "%s PIO at %04x (mask %04x)\n", name, base, mask);
 }
 
 /* ICH7-10 has the same common LPC generic IO decode registers */
@@ -758,7 +758,7 @@ static void quirk_xio2000a(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 command;
 
-	dev_warn(&dev->dev, "TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled\n");
+	pci_warn(dev, "TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled\n");
 	list_for_each_entry(pdev, &dev->subordinate->devices, bus_list) {
 		pci_read_config_word(pdev, PCI_COMMAND, &command);
 		if (command & PCI_COMMAND_FAST_BACK)
@@ -788,7 +788,7 @@ static void quirk_via_ioapic(struct pci_dev *dev)
 	else
 		tmp = 0x1f; /* all known bits (4-0) routed to external APIC */
 
-	dev_info(&dev->dev, "%sbling VIA external APIC routing\n",
+	pci_info(dev, "%sbling VIA external APIC routing\n",
 	       tmp == 0 ? "Disa" : "Ena");
 
 	/* Offset 0x58: External APIC IRQ output control */
@@ -810,7 +810,7 @@ static void quirk_via_vt8237_bypass_apic_deassert(struct pci_dev *dev)
 
 	pci_read_config_byte(dev, 0x5B, &misc_control2);
 	if (!(misc_control2 & BYPASS_APIC_DEASSERT)) {
-		dev_info(&dev->dev, "Bypassing VIA 8237 APIC De-Assert Message\n");
+		pci_info(dev, "Bypassing VIA 8237 APIC De-Assert Message\n");
 		pci_write_config_byte(dev, 0x5B, misc_control2|BYPASS_APIC_DEASSERT);
 	}
 }
@@ -829,8 +829,8 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,		quirk
 static void quirk_amd_ioapic(struct pci_dev *dev)
 {
 	if (dev->revision >= 0x02) {
-		dev_warn(&dev->dev, "I/O APIC: AMD Erratum #22 may be present. In the event of instability try\n");
-		dev_warn(&dev->dev, "        : booting with the \"noapic\" option\n");
+		pci_warn(dev, "I/O APIC: AMD Erratum #22 may be present. In the event of instability try\n");
+		pci_warn(dev, "        : booting with the \"noapic\" option\n");
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic);
@@ -854,7 +854,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xa018, quirk_cavium_sriov_rnm_lin
 static void quirk_amd_8131_mmrbc(struct pci_dev *dev)
 {
 	if (dev->subordinate && dev->revision <= 0x12) {
-		dev_info(&dev->dev, "AMD8131 rev %x detected; disabling PCI-X MMRBC\n",
+		pci_info(dev, "AMD8131 rev %x detected; disabling PCI-X MMRBC\n",
 			 dev->revision);
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MMRBC;
 	}
@@ -962,7 +962,7 @@ static void quirk_via_vlink(struct pci_dev *dev)
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		dev_info(&dev->dev, "VIA VLink IRQ fixup, from %d to %d\n",
+		pci_info(dev, "VIA VLink IRQ fixup, from %d to %d\n",
 			irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
@@ -1011,7 +1011,7 @@ static void quirk_amd_ordering(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x4C, &pcic);
 	if ((pcic & 6) != 6) {
 		pcic |= 6;
-		dev_warn(&dev->dev, "BIOS failed to enable PCI standards compliance; fixing this error\n");
+		pci_warn(dev, "BIOS failed to enable PCI standards compliance; fixing this error\n");
 		pci_write_config_dword(dev, 0x4C, pcic);
 		pci_read_config_dword(dev, 0x84, &pcic);
 		pcic |= (1 << 23);	/* Required in this mode */
@@ -1064,7 +1064,7 @@ static void quirk_mediagx_master(struct pci_dev *dev)
 	pci_read_config_byte(dev, 0x41, &reg);
 	if (reg & 2) {
 		reg &= ~2;
-		dev_info(&dev->dev, "Fixup for MediaGX/Geode Slave Disconnect Boundary (0x41=0x%02x)\n",
+		pci_info(dev, "Fixup for MediaGX/Geode Slave Disconnect Boundary (0x41=0x%02x)\n",
 			 reg);
 		pci_write_config_byte(dev, 0x41, reg);
 	}
@@ -1087,7 +1087,7 @@ static void quirk_disable_pxb(struct pci_dev *pdev)
 	if (config & (1<<6)) {
 		config &= ~(1<<6);
 		pci_write_config_word(pdev, 0x40, config);
-		dev_info(&pdev->dev, "C0 revision 450NX. Disabling PCI restreaming\n");
+		pci_info(pdev, "C0 revision 450NX. Disabling PCI restreaming\n");
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82454NX,	quirk_disable_pxb);
@@ -1107,7 +1107,7 @@ static void quirk_amd_ide_mode(struct pci_dev *pdev)
 		pci_write_config_byte(pdev, 0x40, tmp);
 
 		pdev->class = PCI_CLASS_STORAGE_SATA_AHCI;
-		dev_info(&pdev->dev, "set SATA to AHCI mode\n");
+		pci_info(pdev, "set SATA to AHCI mode\n");
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, quirk_amd_ide_mode);
@@ -1145,7 +1145,7 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
 	pci_read_config_byte(pdev, PCI_CLASS_PROG, &prog);
 
 	if (((prog & 1) && !(prog & 4)) || ((prog & 4) && !(prog & 1))) {
-		dev_info(&pdev->dev, "IDE mode mismatch; forcing legacy mode\n");
+		pci_info(pdev, "IDE mode mismatch; forcing legacy mode\n");
 		prog &= ~5;
 		pdev->class &= ~5;
 		pci_write_config_byte(pdev, PCI_CLASS_PROG, prog);
@@ -1356,10 +1356,10 @@ static void asus_hides_smbus_lpc(struct pci_dev *dev)
 		pci_write_config_word(dev, 0xF2, val & (~0x8));
 		pci_read_config_word(dev, 0xF2, &val);
 		if (val & 0x8)
-			dev_info(&dev->dev, "i801 SMBus device continues to play 'hide and seek'! 0x%x\n",
+			pci_info(dev, "i801 SMBus device continues to play 'hide and seek'! 0x%x\n",
 				 val);
 		else
-			dev_info(&dev->dev, "Enabled i801 SMBus device\n");
+			pci_info(dev, "Enabled i801 SMBus device\n");
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801AA_0,	asus_hides_smbus_lpc);
@@ -1411,7 +1411,7 @@ static void asus_hides_smbus_lpc_ich6_resume(struct pci_dev *dev)
 		return;
 	iounmap(asus_rcba_base);
 	asus_rcba_base = NULL;
-	dev_info(&dev->dev, "Enabled ICH6/i801 SMBus device\n");
+	pci_info(dev, "Enabled ICH6/i801 SMBus device\n");
 }
 
 static void asus_hides_smbus_lpc_ich6(struct pci_dev *dev)
@@ -1433,7 +1433,7 @@ static void quirk_sis_96x_smbus(struct pci_dev *dev)
 	u8 val = 0;
 	pci_read_config_byte(dev, 0x77, &val);
 	if (val & 0x10) {
-		dev_info(&dev->dev, "Enabling SiS 96x SMBus\n");
+		pci_info(dev, "Enabling SiS 96x SMBus\n");
 		pci_write_config_byte(dev, 0x77, val & ~0x10);
 	}
 }
@@ -1505,10 +1505,10 @@ static void asus_hides_ac97_lpc(struct pci_dev *dev)
 		pci_write_config_byte(dev, 0x50, val & (~0xc0));
 		pci_read_config_byte(dev, 0x50, &val);
 		if (val & 0xc0)
-			dev_info(&dev->dev, "Onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n",
+			pci_info(dev, "Onboard AC97/MC97 devices continue to play 'hide and seek'! 0x%x\n",
 				 val);
 		else
-			dev_info(&dev->dev, "Enabled onboard AC97/MC97 devices\n");
+			pci_info(dev, "Enabled onboard AC97/MC97 devices\n");
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc);
@@ -1599,7 +1599,7 @@ static void quirk_jmicron_async_suspend(struct pci_dev *dev)
 {
 	if (dev->multifunction) {
 		device_disable_async_suspend(&dev->dev);
-		dev_info(&dev->dev, "async suspend disabled to avoid multi-function power-on ordering issue\n");
+		pci_info(dev, "async suspend disabled to avoid multi-function power-on ordering issue\n");
 	}
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE, 8, quirk_jmicron_async_suspend);
@@ -1646,7 +1646,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
 static void quirk_pcie_pxh(struct pci_dev *dev)
 {
 	dev->no_msi = 1;
-	dev_warn(&dev->dev, "PXH quirk detected; SHPC device MSI disabled\n");
+	pci_warn(dev, "PXH quirk detected; SHPC device MSI disabled\n");
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_0,	quirk_pcie_pxh);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_1,	quirk_pcie_pxh);
@@ -1692,7 +1692,7 @@ static void quirk_radeon_pm(struct pci_dev *dev)
 	    dev->subsystem_device == 0x00e2) {
 		if (dev->d3_delay < 20) {
 			dev->d3_delay = 20;
-			dev_info(&dev->dev, "extending delay after power-on from D3 to %d msec\n",
+			pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
 				 dev->d3_delay);
 		}
 	}
@@ -1736,7 +1736,7 @@ static void quirk_reroute_to_boot_interrupts_intel(struct pci_dev *dev)
 		return;
 
 	dev->irq_reroute_variant = INTEL_IRQ_REROUTE_VARIANT;
-	dev_info(&dev->dev, "rerouting interrupts for [%04x:%04x]\n",
+	pci_info(dev, "rerouting interrupts for [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80333_0,	quirk_reroute_to_boot_interrupts_intel);
@@ -1779,7 +1779,7 @@ static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
 	pci_config_word |= INTEL_6300_DISABLE_BOOT_IRQ;
 	pci_write_config_word(dev, INTEL_6300_IOAPIC_ABAR, pci_config_word);
 
-	dev_info(&dev->dev, "disabled boot interrupts on device [%04x:%04x]\n",
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ESB_10,	quirk_disable_intel_boot_interrupt);
@@ -1812,7 +1812,7 @@ static void quirk_disable_broadcom_boot_interrupt(struct pci_dev *dev)
 
 	pci_write_config_dword(dev, BC_HT1000_FEATURE_REG, pci_config_dword);
 
-	dev_info(&dev->dev, "disabled boot interrupts on device [%04x:%04x]\n",
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,   PCI_DEVICE_ID_SERVERWORKS_HT1000SB,	quirk_disable_broadcom_boot_interrupt);
@@ -1845,7 +1845,7 @@ static void quirk_disable_amd_813x_boot_interrupt(struct pci_dev *dev)
 	pci_config_dword &= ~AMD_813X_NOIOAMODE;
 	pci_write_config_dword(dev, AMD_813X_MISC, pci_config_dword);
 
-	dev_info(&dev->dev, "disabled boot interrupts on device [%04x:%04x]\n",
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8131_BRIDGE,	quirk_disable_amd_813x_boot_interrupt);
@@ -1864,12 +1864,12 @@ static void quirk_disable_amd_8111_boot_interrupt(struct pci_dev *dev)
 
 	pci_read_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, &pci_config_word);
 	if (!pci_config_word) {
-		dev_info(&dev->dev, "boot interrupts on device [%04x:%04x] already disabled\n",
+		pci_info(dev, "boot interrupts on device [%04x:%04x] already disabled\n",
 			 dev->vendor, dev->device);
 		return;
 	}
 	pci_write_config_word(dev, AMD_8111_PCI_IRQ_ROUTING, 0);
-	dev_info(&dev->dev, "disabled boot interrupts on device [%04x:%04x]\n",
+	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,   PCI_DEVICE_ID_AMD_8111_SMBUS,	quirk_disable_amd_8111_boot_interrupt);
@@ -1913,7 +1913,7 @@ static void quirk_plx_pci9050(struct pci_dev *dev)
 		if (pci_resource_len(dev, bar) == 0x80 &&
 		    (pci_resource_start(dev, bar) & 0x80)) {
 			struct resource *r = &dev->resource[bar];
-			dev_info(&dev->dev, "Re-allocating PLX PCI 9050 BAR %u to length 256 to avoid bit 7 bug\n",
+			pci_info(dev, "Re-allocating PLX PCI 9050 BAR %u to length 256 to avoid bit 7 bug\n",
 				 bar);
 			r->flags |= IORESOURCE_UNSET;
 			r->start = 0;
@@ -1960,7 +1960,7 @@ static void quirk_netmos(struct pci_dev *dev)
 	case PCI_DEVICE_ID_NETMOS_9845:
 	case PCI_DEVICE_ID_NETMOS_9855:
 		if (num_parallel) {
-			dev_info(&dev->dev, "Netmos %04x (%u parallel, %u serial); changing class SERIAL to OTHER (use parport_serial)\n",
+			pci_info(dev, "Netmos %04x (%u parallel, %u serial); changing class SERIAL to OTHER (use parport_serial)\n",
 				dev->device, num_parallel, num_serial);
 			dev->class = (PCI_CLASS_COMMUNICATION_OTHER << 8) |
 			    (dev->class & 0xff);
@@ -2046,13 +2046,13 @@ static void quirk_e100_interrupt(struct pci_dev *dev)
 	/* Convert from PCI bus to resource space.  */
 	csr = ioremap(pci_resource_start(dev, 0), 8);
 	if (!csr) {
-		dev_warn(&dev->dev, "Can't map e100 registers\n");
+		pci_warn(dev, "Can't map e100 registers\n");
 		return;
 	}
 
 	cmd_hi = readb(csr + 3);
 	if (cmd_hi == 0) {
-		dev_warn(&dev->dev, "Firmware left e100 interrupts enabled; disabling\n");
+		pci_warn(dev, "Firmware left e100 interrupts enabled; disabling\n");
 		writeb(1, csr + 3);
 	}
 
@@ -2067,7 +2067,7 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
  */
 static void quirk_disable_aspm_l0s(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "Disabling L0s\n");
+	pci_info(dev, "Disabling L0s\n");
 	pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10a7, quirk_disable_aspm_l0s);
@@ -2097,7 +2097,7 @@ static void fixup_rev1_53c810(struct pci_dev *dev)
 		return;
 
 	dev->class = PCI_CLASS_STORAGE_SCSI << 8;
-	dev_info(&dev->dev, "NCR 53c810 rev 1 PCI class overridden (%#08x -> %#08x)\n",
+	pci_info(dev, "NCR 53c810 rev 1 PCI class overridden (%#08x -> %#08x)\n",
 		 class, dev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, fixup_rev1_53c810);
@@ -2110,7 +2110,7 @@ static void quirk_p64h2_1k_io(struct pci_dev *dev)
 	pci_read_config_word(dev, 0x40, &en1k);
 
 	if (en1k & 0x200) {
-		dev_info(&dev->dev, "Enable I/O Space to 1KB granularity\n");
+		pci_info(dev, "Enable I/O Space to 1KB granularity\n");
 		dev->io_window_1k = 1;
 	}
 }
@@ -2126,7 +2126,7 @@ static void quirk_nvidia_ck804_pcie_aer_ext_cap(struct pci_dev *dev)
 	if (pci_read_config_byte(dev, 0xf41, &b) == 0) {
 		if (!(b & 0x20)) {
 			pci_write_config_byte(dev, 0xf41, b | 0x20);
-			dev_info(&dev->dev, "Linking AER extended capability\n");
+			pci_info(dev, "Linking AER extended capability\n");
 		}
 	}
 }
@@ -2164,7 +2164,7 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 			/* Turn off PCI Bus Parking */
 			pci_write_config_byte(dev, 0x76, b ^ 0x40);
 
-			dev_info(&dev->dev, "Disabling VIA CX700 PCI parking\n");
+			pci_info(dev, "Disabling VIA CX700 PCI parking\n");
 		}
 	}
 
@@ -2179,7 +2179,7 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 			/* Disable "Read FIFO Timer" */
 			pci_write_config_byte(dev, 0x77, 0x0);
 
-			dev_info(&dev->dev, "Disabling VIA CX700 PCI caching\n");
+			pci_info(dev, "Disabling VIA CX700 PCI caching\n");
 		}
 	}
 }
@@ -2196,7 +2196,7 @@ static void quirk_blacklist_vpd(struct pci_dev *dev)
 {
 	if (dev->vpd) {
 		dev->vpd->len = 0;
-		dev_warn(&dev->dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
+		pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
 	}
 }
 
@@ -2312,7 +2312,7 @@ static void quirk_unhide_mch_dev6(struct pci_dev *dev)
 	u8 reg;
 
 	if (pci_read_config_byte(dev, 0xF4, &reg) == 0 && !(reg & 0x02)) {
-		dev_info(&dev->dev, "Enabling MCH 'Overflow' Device\n");
+		pci_info(dev, "Enabling MCH 'Overflow' Device\n");
 		pci_write_config_byte(dev, 0xF4, reg | 0x02);
 	}
 }
@@ -2351,7 +2351,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8624, quirk_tile_plx_gen1);
 static void quirk_disable_all_msi(struct pci_dev *dev)
 {
 	pci_no_msi();
-	dev_warn(&dev->dev, "MSI quirk detected; MSI disabled\n");
+	pci_warn(dev, "MSI quirk detected; MSI disabled\n");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS400_200, quirk_disable_all_msi);
@@ -2366,7 +2366,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
 static void quirk_disable_msi(struct pci_dev *dev)
 {
 	if (dev->subordinate) {
-		dev_warn(&dev->dev, "MSI quirk detected; subordinate MSI disabled\n");
+		pci_warn(dev, "MSI quirk detected; subordinate MSI disabled\n");
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 	}
 }
@@ -2406,7 +2406,7 @@ static int msi_ht_cap_enabled(struct pci_dev *dev)
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
 					 &flags) == 0) {
-			dev_info(&dev->dev, "Found %s HT MSI Mapping\n",
+			pci_info(dev, "Found %s HT MSI Mapping\n",
 				flags & HT_MSI_FLAGS_ENABLE ?
 				"enabled" : "disabled");
 			return (flags & HT_MSI_FLAGS_ENABLE) != 0;
@@ -2422,7 +2422,7 @@ static int msi_ht_cap_enabled(struct pci_dev *dev)
 static void quirk_msi_ht_cap(struct pci_dev *dev)
 {
 	if (dev->subordinate && !msi_ht_cap_enabled(dev)) {
-		dev_warn(&dev->dev, "MSI quirk detected; subordinate MSI disabled\n");
+		pci_warn(dev, "MSI quirk detected; subordinate MSI disabled\n");
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 	}
 }
@@ -2446,7 +2446,7 @@ static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
 	if (!pdev)
 		return;
 	if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
-		dev_warn(&dev->dev, "MSI quirk detected; subordinate MSI disabled\n");
+		pci_warn(dev, "MSI quirk detected; subordinate MSI disabled\n");
 		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
 	}
 	pci_dev_put(pdev);
@@ -2465,7 +2465,7 @@ static void ht_enable_msi_mapping(struct pci_dev *dev)
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
 					 &flags) == 0) {
-			dev_info(&dev->dev, "Enabling HT MSI Mapping\n");
+			pci_info(dev, "Enabling HT MSI Mapping\n");
 
 			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
 					      flags | HT_MSI_FLAGS_ENABLE);
@@ -2492,7 +2492,7 @@ static void nvenet_msi_disable(struct pci_dev *dev)
 	if (board_name &&
 	    (strstr(board_name, "P5N32-SLI PREMIUM") ||
 	     strstr(board_name, "P5N32-E SLI"))) {
-		dev_info(&dev->dev, "Disabling msi for MCP55 NIC on P5N32-SLI\n");
+		pci_info(dev, "Disabling msi for MCP55 NIC on P5N32-SLI\n");
 		dev->no_msi = 1;
 	}
 }
@@ -2669,7 +2669,7 @@ static void ht_disable_msi_mapping(struct pci_dev *dev)
 
 		if (pci_read_config_byte(dev, pos + HT_MSI_FLAGS,
 					 &flags) == 0) {
-			dev_info(&dev->dev, "Disabling HT MSI Mapping\n");
+			pci_info(dev, "Disabling HT MSI Mapping\n");
 
 			pci_write_config_byte(dev, pos + HT_MSI_FLAGS,
 					      flags & ~HT_MSI_FLAGS_ENABLE);
@@ -2701,7 +2701,7 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 	 */
 	host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
 	if (host_bridge == NULL) {
-		dev_warn(&dev->dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
+		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
 		return;
 	}
 
@@ -2770,7 +2770,7 @@ static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
 {
 	/* AR816X/AR817X/E210X MSI is fixed at HW level from revision 0x18 */
 	if (dev->revision < 0x18) {
-		dev_info(&dev->dev, "set MSI_INTX_DISABLE_BUG flag\n");
+		pci_info(dev, "set MSI_INTX_DISABLE_BUG flag\n");
 		dev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
 	}
 }
@@ -2899,8 +2899,8 @@ static void ricoh_mmc_fixup_rl5c476(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x8E, write_enable);
 	pci_write_config_byte(dev, 0x8D, write_target);
 
-	dev_notice(&dev->dev, "proprietary Ricoh MMC controller disabled (via cardbus function)\n");
-	dev_notice(&dev->dev, "MMC cards are now supported by standard SDHCI controller\n");
+	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via cardbus function)\n");
+	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_RL5C476, ricoh_mmc_fixup_rl5c476);
@@ -2935,7 +2935,7 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 		pci_write_config_byte(dev, 0xe1, 0x32);
 		pci_write_config_byte(dev, 0xfc, 0x00);
 
-		dev_notice(&dev->dev, "MMC controller base frequency changed to 50Mhz.\n");
+		pci_notice(dev, "MMC controller base frequency changed to 50Mhz.\n");
 	}
 
 	pci_read_config_byte(dev, 0xCB, &disable);
@@ -2948,8 +2948,8 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0xCB, disable | 0x02);
 	pci_write_config_byte(dev, 0xCA, write_enable);
 
-	dev_notice(&dev->dev, "proprietary Ricoh MMC controller disabled (via firewire function)\n");
-	dev_notice(&dev->dev, "MMC cards are now supported by standard SDHCI controller\n");
+	pci_notice(dev, "proprietary Ricoh MMC controller disabled (via firewire function)\n");
+	pci_notice(dev, "MMC cards are now supported by standard SDHCI controller\n");
 
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
@@ -2990,7 +2990,7 @@ static void fixup_ti816x_class(struct pci_dev *dev)
 
 	/* TI 816x devices do not have class code set when in PCIe boot mode */
 	dev->class = PCI_CLASS_MULTIMEDIA_VIDEO << 8;
-	dev_info(&dev->dev, "PCI class overridden (%#08x -> %#08x)\n",
+	pci_info(dev, "PCI class overridden (%#08x -> %#08x)\n",
 		 class, dev->class);
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_TI, 0xb800,
@@ -3032,7 +3032,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 	 */
 	err = pci_read_config_word(dev, 0x48, &rcc);
 	if (err) {
-		dev_err(&dev->dev, "Error attempting to read the read completion coalescing register\n");
+		pci_err(dev, "Error attempting to read the read completion coalescing register\n");
 		return;
 	}
 
@@ -3043,7 +3043,7 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
 
 	err = pci_write_config_word(dev, 0x48, rcc);
 	if (err) {
-		dev_err(&dev->dev, "Error attempting to write the read completion coalescing register\n");
+		pci_err(dev, "Error attempting to write the read completion coalescing register\n");
 		return;
 	}
 
@@ -3108,7 +3108,7 @@ static ktime_t fixup_debug_start(struct pci_dev *dev,
 {
 	ktime_t calltime = 0;
 
-	dev_dbg(&dev->dev, "calling %pF\n", fn);
+	pci_dbg(dev, "calling %pF\n", fn);
 	if (initcall_debug) {
 		pr_debug("calling  %pF @ %i for %s\n",
 			 fn, task_pid_nr(current), dev_name(&dev->dev));
@@ -3150,13 +3150,13 @@ static void disable_igfx_irq(struct pci_dev *dev)
 {
 	void __iomem *regs = pci_iomap(dev, 0, 0);
 	if (regs == NULL) {
-		dev_warn(&dev->dev, "igfx quirk: Can't iomap PCI device\n");
+		pci_warn(dev, "igfx quirk: Can't iomap PCI device\n");
 		return;
 	}
 
 	/* Check if any interrupt line is still enabled */
 	if (readl(regs + I915_DEIER_REG) != 0) {
-		dev_warn(&dev->dev, "BIOS left Intel GPU interrupts enabled; disabling\n");
+		pci_warn(dev, "BIOS left Intel GPU interrupts enabled; disabling\n");
 
 		writel(0, regs + I915_DEIER_REG);
 	}
@@ -3317,13 +3317,13 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 
 	/* For ConnectX-4 and ConnectX-4LX, need to check FW support */
 	if (pci_enable_device_mem(pdev)) {
-		dev_warn(&pdev->dev, "Can't enable device memory\n");
+		pci_warn(pdev, "Can't enable device memory\n");
 		return;
 	}
 
 	fw_ver = ioremap(pci_resource_start(pdev, 0), 4);
 	if (!fw_ver) {
-		dev_warn(&pdev->dev, "Can't map ConnectX-4 initialization segment\n");
+		pci_warn(pdev, "Can't map ConnectX-4 initialization segment\n");
 		goto out;
 	}
 
@@ -3335,7 +3335,7 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
 	fw_subminor = fw_sub_min & 0xffff;
 	if (fw_minor > CONNECTX_4_CURR_MAX_MINOR ||
 	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR) {
-		dev_warn(&pdev->dev, "ConnectX-4: FW %u.%u.%u doesn't support INTx masking, disabling. Please upgrade FW to %d.14.1100 and up for INTx support\n",
+		pci_warn(pdev, "ConnectX-4: FW %u.%u.%u doesn't support INTx masking, disabling. Please upgrade FW to %d.14.1100 and up for INTx support\n",
 			 fw_major, fw_minor, fw_subminor, pdev->device ==
 			 PCI_DEVICE_ID_MELLANOX_CONNECTX4 ? 12 : 14);
 		pdev->broken_intx_masking = 1;
@@ -3473,7 +3473,7 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
 	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
 	    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
 		return;
-	dev_info(&dev->dev, "quirk: cutting power to thunderbolt controller...\n");
+	pci_info(dev, "quirk: cutting power to thunderbolt controller...\n");
 
 	/* magic sequence */
 	acpi_execute_simple_method(SXIO, NULL, 1);
@@ -3524,7 +3524,7 @@ static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
 			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
 		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
 		goto out;
-	dev_info(&dev->dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
+	pci_info(dev, "quirk: waiting for thunderbolt to reestablish PCI tunnels...\n");
 	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
 out:
 	pci_dev_put(nhi);
@@ -3740,7 +3740,7 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 			goto reset_complete;
 		msleep(10);
 	} while (time_before(jiffies, timeout));
-	dev_warn(&dev->dev, "timeout during reset\n");
+	pci_warn(dev, "timeout during reset\n");
 
 reset_complete:
 	iowrite32(0x00000002, mmio_base + NSDE_PWR_STATE);
@@ -4012,7 +4012,7 @@ static void quirk_tw686x_class(struct pci_dev *pdev)
 
 	/* Use "Multimedia controller" class */
 	pdev->class = (PCI_CLASS_MULTIMEDIA_OTHER << 8) | 0x01;
-	dev_info(&pdev->dev, "TW686x PCI class overridden (%#08x -> %#08x)\n",
+	pci_info(pdev, "TW686x PCI class overridden (%#08x -> %#08x)\n",
 		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 8,
@@ -4032,7 +4032,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
 static void quirk_relaxedordering_disable(struct pci_dev *dev)
 {
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_RELAXED_ORDERING;
-	dev_info(&dev->dev, "Disable Relaxed Ordering Attributes to avoid PCIe Completion erratum\n");
+	pci_info(dev, "Disable Relaxed Ordering Attributes to avoid PCIe Completion erratum\n");
 }
 
 /*
@@ -4141,11 +4141,11 @@ static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
 	struct pci_dev *root_port = pci_find_pcie_root_port(pdev);
 
 	if (!root_port) {
-		dev_warn(&pdev->dev, "PCIe Completion erratum may cause device errors\n");
+		pci_warn(pdev, "PCIe Completion erratum may cause device errors\n");
 		return;
 	}
 
-	dev_info(&root_port->dev, "Disabling No Snoop/Relaxed Ordering Attributes to avoid PCIe Completion erratum in %s\n",
+	pci_info(root_port, "Disabling No Snoop/Relaxed Ordering Attributes to avoid PCIe Completion erratum in %s\n",
 		 dev_name(&pdev->dev));
 	pcie_capability_clear_and_set_word(root_port, PCI_EXP_DEVCTL,
 					   PCI_EXP_DEVCTL_RELAX_EN |
@@ -4339,7 +4339,7 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
 	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
 	int ret = acs_flags & ~flags ? 0 : 1;
 
-	dev_info(&dev->dev, "Using QCOM ACS Quirk (%d)\n", ret);
+	pci_info(dev, "Using QCOM ACS Quirk (%d)\n", ret);
 
 	return ret;
 }
@@ -4591,7 +4591,7 @@ static int pci_quirk_enable_intel_lpc_acs(struct pci_dev *dev)
 	if (bspr != (INTEL_BSPR_REG_BPNPD | INTEL_BSPR_REG_BPPD)) {
 		updcr = readl(rcba_mem + INTEL_UPDCR_REG);
 		if (updcr & INTEL_UPDCR_REG_MASK) {
-			dev_info(&dev->dev, "Disabling UPDCR peer decodes\n");
+			pci_info(dev, "Disabling UPDCR peer decodes\n");
 			updcr &= ~INTEL_UPDCR_REG_MASK;
 			writel(updcr, rcba_mem + INTEL_UPDCR_REG);
 		}
@@ -4618,7 +4618,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	 */
 	pci_read_config_dword(dev, INTEL_MPC_REG, &mpc);
 	if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
-		dev_info(&dev->dev, "Enabling MPC IRBNCE\n");
+		pci_info(dev, "Enabling MPC IRBNCE\n");
 		mpc |= INTEL_MPC_REG_IRBNCE;
 		pci_write_config_word(dev, INTEL_MPC_REG, mpc);
 	}
@@ -4630,7 +4630,7 @@ static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 		return -ENOTTY;
 
 	if (pci_quirk_enable_intel_lpc_acs(dev)) {
-		dev_warn(&dev->dev, "Failed to enable Intel PCH ACS quirk\n");
+		pci_warn(dev, "Failed to enable Intel PCH ACS quirk\n");
 		return 0;
 	}
 
@@ -4638,7 +4638,7 @@ static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 
 	dev->dev_flags |= PCI_DEV_FLAGS_ACS_ENABLED_QUIRK;
 
-	dev_info(&dev->dev, "Intel PCH root port ACS workaround enabled\n");
+	pci_info(dev, "Intel PCH root port ACS workaround enabled\n");
 
 	return 0;
 }
@@ -4665,7 +4665,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
 
-	dev_info(&dev->dev, "Intel SPT PCH root port ACS workaround enabled\n");
+	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
 
 	return 0;
 }
@@ -4800,7 +4800,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 		return;
 
 	bridge->no_ext_tags = 1;
-	dev_info(&pdev->dev, "disabling Extended Tags (this device can't handle them)\n");
+	pci_info(pdev, "disabling Extended Tags (this device can't handle them)\n");
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
@@ -4815,7 +4815,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0144, quirk_no_ext_tags);
  */
 static void quirk_no_ats(struct pci_dev *pdev)
 {
-	dev_info(&pdev->dev, "disabling ATS (broken on this device)\n");
+	pci_info(pdev, "disabling ATS (broken on this device)\n");
 	pdev->ats_cap = 0;
 }
 
diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 1f5e6af..61f9e8a 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -92,14 +92,14 @@ size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
 		void __iomem *pds;
 		/* Standard PCI ROMs start out with these bytes 55 AA */
 		if (readw(image) != 0xAA55) {
-			dev_err(&pdev->dev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
+			pci_err(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
 				readw(image));
 			break;
 		}
 		/* get the PCI data structure and check its "PCIR" signature */
 		pds = image + readw(image + 24);
 		if (readl(pds) != 0x52494350) {
-			dev_err(&pdev->dev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
+			pci_err(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
 				readl(pds));
 			break;
 		}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b1ad466..a99524b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -152,7 +152,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 
 		r_align = pci_resource_alignment(dev, r);
 		if (!r_align) {
-			dev_warn(&dev->dev, "BAR %d: %pR has bogus alignment\n",
+			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
 				 i, r);
 			continue;
 		}
@@ -260,7 +260,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(add_res->dev, idx,
 						  add_size, align))
-				dev_printk(KERN_DEBUG, &add_res->dev->dev,
+				pci_printk(KERN_DEBUG, add_res->dev,
 					   "failed to add %llx res[%d]=%pR\n",
 					   (unsigned long long)add_size,
 					   idx, res);
@@ -519,7 +519,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 	struct resource *res;
 	struct pci_bus_region region;
 
-	dev_info(&bridge->dev, "CardBus bridge to %pR\n",
+	pci_info(bridge, "CardBus bridge to %pR\n",
 		 &bus->busn_res);
 
 	res = bus->resource[0];
@@ -529,7 +529,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 		 * The IO resource is allocated a range twice as large as it
 		 * would normally need.  This allows us to set both IO regs.
 		 */
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_IO_BASE_0,
 					region.start);
 		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_0,
@@ -539,7 +539,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 	res = bus->resource[1];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_IO) {
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
 					region.start);
 		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_1,
@@ -549,7 +549,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 	res = bus->resource[2];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_MEM) {
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
 					region.start);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_0,
@@ -559,7 +559,7 @@ void pci_setup_cardbus(struct pci_bus *bus)
 	res = bus->resource[3];
 	pcibios_resource_to_bus(bridge->bus, &region, res);
 	if (res->flags & IORESOURCE_MEM) {
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
 					region.start);
 		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
@@ -602,7 +602,7 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 		l = ((u16) io_limit_lo << 8) | io_base_lo;
 		/* Set up upper 16 bits of I/O base/limit. */
 		io_upper16 = (region.end & 0xffff0000) | (region.start >> 16);
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 	} else {
 		/* Clear upper 16 bits of I/O base/limit. */
 		io_upper16 = 0;
@@ -628,7 +628,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 	if (res->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 	} else {
 		l = 0x0000fff0;
 	}
@@ -657,7 +657,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 			bu = upper_32_bits(region.start);
 			lu = upper_32_bits(region.end);
 		}
-		dev_info(&bridge->dev, "  bridge window %pR\n", res);
+		pci_info(bridge, "  bridge window %pR\n", res);
 	} else {
 		l = 0x0000fff0;
 	}
@@ -672,7 +672,7 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 	struct pci_dev *bridge = bus->self;
 
-	dev_info(&bridge->dev, "PCI bridge to %pR\n",
+	pci_info(bridge, "PCI bridge to %pR\n",
 		 &bus->busn_res);
 
 	if (type & IORESOURCE_IO)
@@ -944,7 +944,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
+			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
 		b_res->flags = 0;
 		return;
@@ -956,7 +956,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0,
 			    min_align);
-		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx\n",
+		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long)size1-size0);
 	}
@@ -1061,7 +1061,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (order < 0)
 				order = 0;
 			if (order >= ARRAY_SIZE(aligns)) {
-				dev_warn(&dev->dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
+				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
 					 i, r, (unsigned long long) align);
 				r->flags = 0;
 				continue;
@@ -1093,7 +1093,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 				resource_size(b_res), add_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-			dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
+			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
 		b_res->flags = 0;
 		return 0;
@@ -1103,7 +1103,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
 		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
-		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx add_align %llx\n",
+		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) (size1 - size0),
 			   (unsigned long long) add_align);
@@ -1407,7 +1407,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 			break;
 
 		default:
-			dev_info(&dev->dev, "not setting up bridge for bus %04x:%02x\n",
+			pci_info(dev, "not setting up bridge for bus %04x:%02x\n",
 				 pci_domain_nr(b), b->number);
 			break;
 		}
@@ -1513,7 +1513,7 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 		break;
 
 	default:
-		dev_info(&bridge->dev, "not setting up bridge for bus %04x:%02x\n",
+		pci_info(bridge, "not setting up bridge for bus %04x:%02x\n",
 			 pci_domain_nr(b), b->number);
 		break;
 	}
@@ -1571,7 +1571,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
+		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
 					PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
 		r->end = resource_size(r) - 1;
@@ -1874,7 +1874,7 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 		return;
 
 	dev_res->add_size = available - resource_size(res);
-	dev_dbg(&bridge->dev, "bridge window %pR extended by %pa\n", res,
+	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
 		&dev_res->add_size);
 }
 
@@ -2085,7 +2085,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 enable_all:
 	retval = pci_reenable_device(bridge);
 	if (retval)
-		dev_err(&bridge->dev, "Error reenabling bridge (%d)\n", retval);
+		pci_err(bridge, "Error reenabling bridge (%d)\n", retval);
 	pci_set_master(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
@@ -2119,7 +2119,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 			if (ret)
 				goto cleanup;
 
-			dev_info(&bridge->dev, "BAR %d: releasing %pR\n",
+			pci_info(bridge, "BAR %d: releasing %pR\n",
 				 i, res);
 
 			if (res->parent)
diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 86106c4..774defe 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -25,7 +25,7 @@ void pci_assign_irq(struct pci_dev *dev)
 	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
 
 	if (!(hbrg->map_irq)) {
-		dev_dbg(&dev->dev, "runtime IRQ mapping not provided by arch\n");
+		pci_dbg(dev, "runtime IRQ mapping not provided by arch\n");
 		return;
 	}
 
@@ -55,7 +55,7 @@ void pci_assign_irq(struct pci_dev *dev)
 	}
 	dev->irq = irq;
 
-	dev_dbg(&dev->dev, "assign IRQ: got %d\n", dev->irq);
+	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index e815111..4d219af 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -103,7 +103,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 	pci_read_config_dword(dev, reg, &check);
 
 	if ((new ^ check) & mask) {
-		dev_err(&dev->dev, "BAR %d: error updating (%#08x != %#08x)\n",
+		pci_err(dev, "BAR %d: error updating (%#08x != %#08x)\n",
 			resno, new, check);
 	}
 
@@ -112,7 +112,7 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
-			dev_err(&dev->dev, "BAR %d: error updating (high %#08x != %#08x)\n",
+			pci_err(dev, "BAR %d: error updating (high %#08x != %#08x)\n",
 				resno, new, check);
 		}
 	}
@@ -137,7 +137,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 	struct resource *root, *conflict;
 
 	if (res->flags & IORESOURCE_UNSET) {
-		dev_info(&dev->dev, "can't claim BAR %d %pR: no address assigned\n",
+		pci_info(dev, "can't claim BAR %d %pR: no address assigned\n",
 			 resource, res);
 		return -EINVAL;
 	}
@@ -152,7 +152,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
-		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge window\n",
+		pci_info(dev, "can't claim BAR %d %pR: no compatible bridge window\n",
 			 resource, res);
 		res->flags |= IORESOURCE_UNSET;
 		return -EINVAL;
@@ -160,7 +160,7 @@ int pci_claim_resource(struct pci_dev *dev, int resource)
 
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
-		dev_info(&dev->dev, "can't claim BAR %d %pR: address conflict with %s %pR\n",
+		pci_info(dev, "can't claim BAR %d %pR: address conflict with %s %pR\n",
 			 resource, res, conflict->name, conflict);
 		res->flags |= IORESOURCE_UNSET;
 		return -EBUSY;
@@ -172,7 +172,7 @@ EXPORT_SYMBOL(pci_claim_resource);
 
 void pci_disable_bridge_window(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "disabling bridge mem windows\n");
+	pci_info(dev, "disabling bridge mem windows\n");
 
 	/* MMIO Base/Limit */
 	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
@@ -221,11 +221,11 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 			root = &iomem_resource;
 	}
 
-	dev_info(&dev->dev, "BAR %d: trying firmware assignment %pR\n",
+	pci_info(dev, "BAR %d: trying firmware assignment %pR\n",
 		 resno, res);
 	conflict = request_resource_conflict(root, res);
 	if (conflict) {
-		dev_info(&dev->dev, "BAR %d: %pR conflicts with %s %pR\n",
+		pci_info(dev, "BAR %d: %pR conflicts with %s %pR\n",
 			 resno, res, conflict->name, conflict);
 		res->start = start;
 		res->end = end;
@@ -324,7 +324,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	res->flags |= IORESOURCE_UNSET;
 	align = pci_resource_alignment(dev, res);
 	if (!align) {
-		dev_info(&dev->dev, "BAR %d: can't assign %pR (bogus alignment)\n",
+		pci_info(dev, "BAR %d: can't assign %pR (bogus alignment)\n",
 			 resno, res);
 		return -EINVAL;
 	}
@@ -338,19 +338,19 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	 * working, which is better than just leaving it disabled.
 	 */
 	if (ret < 0) {
-		dev_info(&dev->dev, "BAR %d: no space for %pR\n", resno, res);
+		pci_info(dev, "BAR %d: no space for %pR\n", resno, res);
 		ret = pci_revert_fw_address(res, dev, resno, size);
 	}
 
 	if (ret < 0) {
-		dev_info(&dev->dev, "BAR %d: failed to assign %pR\n", resno,
+		pci_info(dev, "BAR %d: failed to assign %pR\n", resno,
 			 res);
 		return ret;
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	dev_info(&dev->dev, "BAR %d: assigned %pR\n", resno, res);
+	pci_info(dev, "BAR %d: assigned %pR\n", resno, res);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 
@@ -372,7 +372,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	flags = res->flags;
 	res->flags |= IORESOURCE_UNSET;
 	if (!res->parent) {
-		dev_info(&dev->dev, "BAR %d: can't reassign an unassigned resource %pR\n",
+		pci_info(dev, "BAR %d: can't reassign an unassigned resource %pR\n",
 			 resno, res);
 		return -EINVAL;
 	}
@@ -382,14 +382,14 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
 	if (ret) {
 		res->flags = flags;
-		dev_info(&dev->dev, "BAR %d: %pR (failed to expand by %#llx)\n",
+		pci_info(dev, "BAR %d: %pR (failed to expand by %#llx)\n",
 			 resno, res, (unsigned long long) addsize);
 		return ret;
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	dev_info(&dev->dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
+	pci_info(dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
 		 resno, res, (unsigned long long) addsize);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
@@ -401,7 +401,7 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
 
-	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
+	pci_info(dev, "BAR %d: releasing %pR\n", resno, res);
 	release_resource(res);
 	res->end = resource_size(res) - 1;
 	res->start = 0;
@@ -477,13 +477,13 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 			continue;
 
 		if (r->flags & IORESOURCE_UNSET) {
-			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
+			pci_err(dev, "can't enable device: BAR %d %pR not assigned\n",
 				i, r);
 			return -EINVAL;
 		}
 
 		if (!r->parent) {
-			dev_err(&dev->dev, "can't enable device: BAR %d %pR not claimed\n",
+			pci_err(dev, "can't enable device: BAR %d %pR not claimed\n",
 				i, r);
 			return -EINVAL;
 		}
@@ -495,7 +495,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	}
 
 	if (cmd != old_cmd) {
-		dev_info(&dev->dev, "enabling device (%04x -> %04x)\n",
+		pci_info(dev, "enabling device (%04x -> %04x)\n",
 			 old_cmd, cmd);
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 1fa3a32..57c1213 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -57,7 +57,7 @@ static void pci_vc_load_arb_table(struct pci_dev *dev, int pos)
 				 PCI_VC_PORT_STATUS_TABLE))
 		return;
 
-	dev_err(&dev->dev, "VC arbitration table failed to load\n");
+	pci_err(dev, "VC arbitration table failed to load\n");
 }
 
 /**
@@ -85,7 +85,7 @@ static void pci_vc_load_port_arb_table(struct pci_dev *dev, int pos, int res)
 	if (pci_wait_for_pending(dev, status_pos, PCI_VC_RES_STATUS_TABLE))
 		return;
 
-	dev_err(&dev->dev, "VC%d port arbitration table failed to load\n", res);
+	pci_err(dev, "VC%d port arbitration table failed to load\n", res);
 }
 
 /**
@@ -161,11 +161,11 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 	pci_write_config_dword(dev, ctrl_pos, ctrl);
 
 	if (!pci_wait_for_pending(dev, status_pos, PCI_VC_RES_STATUS_NEGO))
-		dev_err(&dev->dev, "VC%d negotiation stuck pending\n", id);
+		pci_err(dev, "VC%d negotiation stuck pending\n", id);
 
 	if (link && !pci_wait_for_pending(link, status_pos2,
 					  PCI_VC_RES_STATUS_NEGO))
-		dev_err(&link->dev, "VC%d negotiation stuck pending\n", id);
+		pci_err(link, "VC%d negotiation stuck pending\n", id);
 }
 
 /**
@@ -195,7 +195,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 	/* Sanity check buffer size for save/restore */
 	if (buf && save_state->cap.size !=
 	    pci_vc_do_save_buffer(dev, pos, NULL, save)) {
-		dev_err(&dev->dev,
+		pci_err(dev,
 			"VC save buffer size does not match @0x%x\n", pos);
 		return -ENOMEM;
 	}
@@ -366,14 +366,14 @@ int pci_save_vc_state(struct pci_dev *dev)
 
 		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
 		if (!save_state) {
-			dev_err(&dev->dev, "%s buffer not found in %s\n",
+			pci_err(dev, "%s buffer not found in %s\n",
 				vc_caps[i].name, __func__);
 			return -ENOMEM;
 		}
 
 		ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
 		if (ret) {
-			dev_err(&dev->dev, "%s save unsuccessful %s\n",
+			pci_err(dev, "%s save unsuccessful %s\n",
 				vc_caps[i].name, __func__);
 			return ret;
 		}
@@ -426,7 +426,7 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev)
 
 		len = pci_vc_do_save_buffer(dev, pos, NULL, false);
 		if (pci_add_ext_cap_save_buffer(dev, vc_caps[i].id, len))
-			dev_err(&dev->dev,
+			pci_err(dev,
 				"unable to preallocate %s save buffer\n",
 				vc_caps[i].name);
 	}
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8fc2e95..acd485c 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -261,7 +261,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 	struct msi_desc *entry;
 
 	if (nvec > SH_INFO_MAX_VEC) {
-		dev_err(&dev->dev, "too much vector for pci frontend: %x."
+		pci_err(dev, "too much vector for pci frontend: %x."
 				   " Increase SH_INFO_MAX_VEC.\n", nvec);
 		return -EINVAL;
 	}
@@ -281,7 +281,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 			/* we get the result */
 			for (i = 0; i < nvec; i++) {
 				if (op.msix_entries[i].vector <= 0) {
-					dev_warn(&dev->dev, "MSI-X entry %d is invalid: %d!\n",
+					pci_warn(dev, "MSI-X entry %d is invalid: %d!\n",
 						i, op.msix_entries[i].vector);
 					err = -EINVAL;
 					vector[i] = -1;
@@ -295,7 +295,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
 			err = op.value;
 		}
 	} else {
-		dev_err(&dev->dev, "enable msix get err %x\n", err);
+		pci_err(dev, "enable msix get err %x\n", err);
 	}
 	return err;
 }
@@ -316,7 +316,7 @@ static void pci_frontend_disable_msix(struct pci_dev *dev)
 
 	/* What should do for error ? */
 	if (err)
-		dev_err(&dev->dev, "pci_disable_msix get err %x\n", err);
+		pci_err(dev, "pci_disable_msix get err %x\n", err);
 }
 
 static int pci_frontend_enable_msi(struct pci_dev *dev, int vector[])
@@ -335,13 +335,13 @@ static int pci_frontend_enable_msi(struct pci_dev *dev, int vector[])
 	if (likely(!err)) {
 		vector[0] = op.value;
 		if (op.value <= 0) {
-			dev_warn(&dev->dev, "MSI entry is invalid: %d!\n",
+			pci_warn(dev, "MSI entry is invalid: %d!\n",
 				op.value);
 			err = -EINVAL;
 			vector[0] = -1;
 		}
 	} else {
-		dev_err(&dev->dev, "pci frontend enable msi failed for dev "
+		pci_err(dev, "pci frontend enable msi failed for dev "
 				    "%x:%x\n", op.bus, op.devfn);
 		err = -EINVAL;
 	}
@@ -560,7 +560,7 @@ static void free_root_bus_devs(struct pci_bus *bus)
 	while (!list_empty(&bus->devices)) {
 		dev = container_of(bus->devices.next, struct pci_dev,
 				   bus_list);
-		dev_dbg(&dev->dev, "removing device\n");
+		pci_dbg(dev, "removing device\n");
 		pci_stop_and_remove_bus_device(dev);
 	}
 }
@@ -613,7 +613,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 
 	if (pdrv) {
 		if (pdrv->err_handler && pdrv->err_handler->error_detected) {
-			dev_dbg(&pcidev->dev,
+			pci_dbg(pcidev,
 				"trying to call AER service\n");
 			if (pcidev) {
 				flag = 1;
-- 
2.7.4
