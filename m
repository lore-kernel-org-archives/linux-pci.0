Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50137 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3L0V1q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2013 16:27:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so7843348pab.33
        for <linux-pci@vger.kernel.org>; Fri, 27 Dec 2013 13:27:45 -0800 (PST)
Date: Fri, 27 Dec 2013 13:27:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH pci-next 2/2] pci: remove dead code
Message-ID: <20131227132710.7190647c@nehalam.linuxnetplumber.net>
In-Reply-To: <20131227132530.5c02d9d8@nehalam.linuxnetplumber.net>
References: <20131227132530.5c02d9d8@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


My philosophy is unused code is dead code.
And dead code is subject to bit rot and is likely source of bugs.
Use it or lose it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

---
Patch against next branch of pci git

 Documentation/PCI/pci-iov-howto.txt |    4 
 drivers/pci/access.c                |   24 ---
 drivers/pci/ats.c                   |   81 ----------
 drivers/pci/iov.c                   |   39 ----
 drivers/pci/pci.c                   |  282 ------------------------------------
 drivers/pci/pcie/aspm.c             |   12 -
 drivers/pci/probe.c                 |    6 
 drivers/pci/slot.c                  |   26 ---
 include/linux/pci-ats.h             |   17 --
 include/linux/pci.h                 |    4 
 10 files changed, 495 deletions(-)

--- a/drivers/pci/pci.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/pci.c	2013-12-27 13:14:18.159776829 -0800
@@ -2169,242 +2169,6 @@ void pci_configure_ari(struct pci_dev *d
 	}
 }
 
-/**
- * pci_enable_ido - enable ID-based Ordering on a device
- * @dev: the PCI device
- * @type: which types of IDO to enable
- *
- * Enable ID-based ordering on @dev.  @type can contain the bits
- * %PCI_EXP_IDO_REQUEST and/or %PCI_EXP_IDO_COMPLETION to indicate
- * which types of transactions are allowed to be re-ordered.
- */
-void pci_enable_ido(struct pci_dev *dev, unsigned long type)
-{
-	u16 ctrl = 0;
-
-	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
-	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
-	if (ctrl)
-		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2, ctrl);
-}
-EXPORT_SYMBOL(pci_enable_ido);
-
-/**
- * pci_disable_ido - disable ID-based ordering on a device
- * @dev: the PCI device
- * @type: which types of IDO to disable
- */
-void pci_disable_ido(struct pci_dev *dev, unsigned long type)
-{
-	u16 ctrl = 0;
-
-	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
-	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
-	if (ctrl)
-		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, ctrl);
-}
-EXPORT_SYMBOL(pci_disable_ido);
-
-/**
- * pci_enable_obff - enable optimized buffer flush/fill
- * @dev: PCI device
- * @type: type of signaling to use
- *
- * Try to enable @type OBFF signaling on @dev.  It will try using WAKE#
- * signaling if possible, falling back to message signaling only if
- * WAKE# isn't supported.  @type should indicate whether the PCIe link
- * be brought out of L0s or L1 to send the message.  It should be either
- * %PCI_EXP_OBFF_SIGNAL_ALWAYS or %PCI_OBFF_SIGNAL_L0.
- *
- * If your device can benefit from receiving all messages, even at the
- * power cost of bringing the link back up from a low power state, use
- * %PCI_EXP_OBFF_SIGNAL_ALWAYS.  Otherwise, use %PCI_OBFF_SIGNAL_L0 (the
- * preferred type).
- *
- * RETURNS:
- * Zero on success, appropriate error number on failure.
- */
-int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type type)
-{
-	u32 cap;
-	u16 ctrl;
-	int ret;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_OBFF_MASK))
-		return -ENOTSUPP; /* no OBFF support at all */
-
-	/* Make sure the topology supports OBFF as well */
-	if (dev->bus->self) {
-		ret = pci_enable_obff(dev->bus->self, type);
-		if (ret)
-			return ret;
-	}
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctrl);
-	if (cap & PCI_EXP_DEVCAP2_OBFF_WAKE)
-		ctrl |= PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
-	else {
-		switch (type) {
-		case PCI_EXP_OBFF_SIGNAL_L0:
-			if (!(ctrl & PCI_EXP_DEVCTL2_OBFF_WAKE_EN))
-				ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGA_EN;
-			break;
-		case PCI_EXP_OBFF_SIGNAL_ALWAYS:
-			ctrl &= ~PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
-			ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGB_EN;
-			break;
-		default:
-			WARN(1, "bad OBFF signal type\n");
-			return -ENOTSUPP;
-		}
-	}
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, ctrl);
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_enable_obff);
-
-/**
- * pci_disable_obff - disable optimized buffer flush/fill
- * @dev: PCI device
- *
- * Disable OBFF on @dev.
- */
-void pci_disable_obff(struct pci_dev *dev)
-{
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
-				   PCI_EXP_DEVCTL2_OBFF_WAKE_EN);
-}
-EXPORT_SYMBOL(pci_disable_obff);
-
-/**
- * pci_ltr_supported - check whether a device supports LTR
- * @dev: PCI device
- *
- * RETURNS:
- * True if @dev supports latency tolerance reporting, false otherwise.
- */
-static bool pci_ltr_supported(struct pci_dev *dev)
-{
-	u32 cap;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-
-	return cap & PCI_EXP_DEVCAP2_LTR;
-}
-
-/**
- * pci_enable_ltr - enable latency tolerance reporting
- * @dev: PCI device
- *
- * Enable LTR on @dev if possible, which means enabling it first on
- * upstream ports.
- *
- * RETURNS:
- * Zero on success, errno on failure.
- */
-int pci_enable_ltr(struct pci_dev *dev)
-{
-	int ret;
-
-	/* Only primary function can enable/disable LTR */
-	if (PCI_FUNC(dev->devfn) != 0)
-		return -EINVAL;
-
-	if (!pci_ltr_supported(dev))
-		return -ENOTSUPP;
-
-	/* Enable upstream ports first */
-	if (dev->bus->self) {
-		ret = pci_enable_ltr(dev->bus->self);
-		if (ret)
-			return ret;
-	}
-
-	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
-					PCI_EXP_DEVCTL2_LTR_EN);
-}
-EXPORT_SYMBOL(pci_enable_ltr);
-
-/**
- * pci_disable_ltr - disable latency tolerance reporting
- * @dev: PCI device
- */
-void pci_disable_ltr(struct pci_dev *dev)
-{
-	/* Only primary function can enable/disable LTR */
-	if (PCI_FUNC(dev->devfn) != 0)
-		return;
-
-	if (!pci_ltr_supported(dev))
-		return;
-
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
-				   PCI_EXP_DEVCTL2_LTR_EN);
-}
-EXPORT_SYMBOL(pci_disable_ltr);
-
-static int __pci_ltr_scale(int *val)
-{
-	int scale = 0;
-
-	while (*val > 1023) {
-		*val = (*val + 31) / 32;
-		scale++;
-	}
-	return scale;
-}
-
-/**
- * pci_set_ltr - set LTR latency values
- * @dev: PCI device
- * @snoop_lat_ns: snoop latency in nanoseconds
- * @nosnoop_lat_ns: nosnoop latency in nanoseconds
- *
- * Figure out the scale and set the LTR values accordingly.
- */
-int pci_set_ltr(struct pci_dev *dev, int snoop_lat_ns, int nosnoop_lat_ns)
-{
-	int pos, ret, snoop_scale, nosnoop_scale;
-	u16 val;
-
-	if (!pci_ltr_supported(dev))
-		return -ENOTSUPP;
-
-	snoop_scale = __pci_ltr_scale(&snoop_lat_ns);
-	nosnoop_scale = __pci_ltr_scale(&nosnoop_lat_ns);
-
-	if (snoop_lat_ns > PCI_LTR_VALUE_MASK ||
-	    nosnoop_lat_ns > PCI_LTR_VALUE_MASK)
-		return -EINVAL;
-
-	if ((snoop_scale > (PCI_LTR_SCALE_MASK >> PCI_LTR_SCALE_SHIFT)) ||
-	    (nosnoop_scale > (PCI_LTR_SCALE_MASK >> PCI_LTR_SCALE_SHIFT)))
-		return -EINVAL;
-
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!pos)
-		return -ENOTSUPP;
-
-	val = (snoop_scale << PCI_LTR_SCALE_SHIFT) | snoop_lat_ns;
-	ret = pci_write_config_word(dev, pos + PCI_LTR_MAX_SNOOP_LAT, val);
-	if (ret != 4)
-		return -EIO;
-
-	val = (nosnoop_scale << PCI_LTR_SCALE_SHIFT) | nosnoop_lat_ns;
-	ret = pci_write_config_word(dev, pos + PCI_LTR_MAX_NOSNOOP_LAT, val);
-	if (ret != 4)
-		return -EIO;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_set_ltr);
-
 static int pci_acs_enable;
 
 /**
@@ -2738,28 +2502,6 @@ int pci_request_region(struct pci_dev *p
 }
 
 /**
- *	pci_request_region_exclusive - Reserved PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource.
- *
- *	Mark the PCI region associated with PCI device @pdev BR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
- *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
- *
- *	The key difference that _exclusive makes it that userspace is
- *	explicitly not allowed to map the resource via /dev/mem or
- *	sysfs.
- */
-int pci_request_region_exclusive(struct pci_dev *pdev, int bar, const char *res_name)
-{
-	return __pci_request_region(pdev, bar, res_name, IORESOURCE_EXCLUSIVE);
-}
-/**
  * pci_release_selected_regions - Release selected PCI I/O and memory resources
  * @pdev: PCI device whose resources were previously reserved
  * @bars: Bitmask of BARs to be released
@@ -2847,28 +2589,6 @@ int pci_request_regions(struct pci_dev *
 	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
 }
 
-/**
- *	pci_request_regions_exclusive - Reserved PCI I/O and memory resources
- *	@pdev: PCI device whose resources are to be reserved
- *	@res_name: Name to be associated with resource.
- *
- *	Mark all PCI regions associated with PCI device @pdev as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
- *
- *	pci_request_regions_exclusive() will mark the region so that
- *	/dev/mem and the sysfs MMIO access will not be allowed.
- *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
- */
-int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
-{
-	return pci_request_selected_regions_exclusive(pdev,
-					((1 << 6) - 1), res_name);
-}
-
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
@@ -4460,10 +4180,8 @@ EXPORT_SYMBOL(pci_find_capability);
 EXPORT_SYMBOL(pci_bus_find_capability);
 EXPORT_SYMBOL(pci_release_regions);
 EXPORT_SYMBOL(pci_request_regions);
-EXPORT_SYMBOL(pci_request_regions_exclusive);
 EXPORT_SYMBOL(pci_release_region);
 EXPORT_SYMBOL(pci_request_region);
-EXPORT_SYMBOL(pci_request_region_exclusive);
 EXPORT_SYMBOL(pci_release_selected_regions);
 EXPORT_SYMBOL(pci_request_selected_regions);
 EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
--- a/drivers/pci/access.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/access.c	2013-12-27 13:14:18.159776829 -0800
@@ -381,30 +381,6 @@ int pci_vpd_pci22_init(struct pci_dev *d
 }
 
 /**
- * pci_vpd_truncate - Set available Vital Product Data size
- * @dev:	pci device struct
- * @size:	available memory in bytes
- *
- * Adjust size of available VPD area.
- */
-int pci_vpd_truncate(struct pci_dev *dev, size_t size)
-{
-	if (!dev->vpd)
-		return -EINVAL;
-
-	/* limited by the access method */
-	if (size > dev->vpd->len)
-		return -EINVAL;
-
-	dev->vpd->len = size;
-	if (dev->vpd->attr)
-		dev->vpd->attr->size = size;
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_vpd_truncate);
-
-/**
  * pci_cfg_access_lock - Lock PCI config reads/writes
  * @dev:	pci device struct
  *
--- a/drivers/pci/ats.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/ats.c	2013-12-27 13:14:18.159776829 -0800
@@ -234,26 +234,6 @@ void pci_disable_pri(struct pci_dev *pde
 }
 EXPORT_SYMBOL_GPL(pci_disable_pri);
 
-/**
- * pci_pri_enabled - Checks if PRI capability is enabled
- * @pdev: PCI device structure
- *
- * Returns true if PRI is enabled on the device, false otherwise
- */
-bool pci_pri_enabled(struct pci_dev *pdev)
-{
-	u16 control;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return false;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
-
-	return (control & PCI_PRI_CTRL_ENABLE) ? true : false;
-}
-EXPORT_SYMBOL_GPL(pci_pri_enabled);
 
 /**
  * pci_reset_pri - Resets device's PRI state
@@ -282,67 +262,6 @@ int pci_reset_pri(struct pci_dev *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_pri);
-
-/**
- * pci_pri_stopped - Checks whether the PRI capability is stopped
- * @pdev: PCI device structure
- *
- * Returns true if the PRI capability on the device is disabled and the
- * device has no outstanding PRI requests, false otherwise. The device
- * indicates this via the STOPPED bit in the status register of the
- * capability.
- * The device internal state can be cleared by resetting the PRI state
- * with pci_reset_pri(). This can force the capability into the STOPPED
- * state.
- */
-bool pci_pri_stopped(struct pci_dev *pdev)
-{
-	u16 control, status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return true;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	if (control & PCI_PRI_CTRL_ENABLE)
-		return false;
-
-	return (status & PCI_PRI_STATUS_STOPPED) ? true : false;
-}
-EXPORT_SYMBOL_GPL(pci_pri_stopped);
-
-/**
- * pci_pri_status - Request PRI status of a device
- * @pdev: PCI device structure
- *
- * Returns negative value on failure, status on success. The status can
- * be checked against status-bits. Supported bits are currently:
- * PCI_PRI_STATUS_RF:      Response failure
- * PCI_PRI_STATUS_UPRGI:   Unexpected Page Request Group Index
- * PCI_PRI_STATUS_STOPPED: PRI has stopped
- */
-int pci_pri_status(struct pci_dev *pdev)
-{
-	u16 status, control;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return -EINVAL;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	/* Stopped bit is undefined when enable == 1, so clear it */
-	if (control & PCI_PRI_CTRL_ENABLE)
-		status &= ~PCI_PRI_STATUS_STOPPED;
-
-	return status;
-}
-EXPORT_SYMBOL_GPL(pci_pri_status);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
--- a/include/linux/pci-ats.h	2013-12-27 13:14:16.539801861 -0800
+++ b/include/linux/pci-ats.h	2013-12-27 13:14:18.159776829 -0800
@@ -56,10 +56,7 @@ static inline int pci_ats_enabled(struct
 
 int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
-bool pci_pri_enabled(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
-bool pci_pri_stopped(struct pci_dev *pdev);
-int pci_pri_status(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI_PRI */
 
@@ -72,25 +69,11 @@ static inline void pci_disable_pri(struc
 {
 }
 
-static inline bool pci_pri_enabled(struct pci_dev *pdev)
-{
-	return false;
-}
-
 static inline int pci_reset_pri(struct pci_dev *pdev)
 {
 	return -ENODEV;
 }
 
-static inline bool pci_pri_stopped(struct pci_dev *pdev)
-{
-	return true;
-}
-
-static inline int pci_pri_status(struct pci_dev *pdev)
-{
-	return -ENODEV;
-}
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
--- a/Documentation/PCI/pci-iov-howto.txt	2013-12-27 13:14:16.539801861 -0800
+++ b/Documentation/PCI/pci-iov-howto.txt	2013-12-27 13:14:18.159776829 -0800
@@ -68,10 +68,6 @@ To disable SR-IOV capability:
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
-To notify SR-IOV core of Virtual Function Migration:
-(a) In the driver:
-	irqreturn_t pci_sriov_migration(struct pci_dev *dev);
-
 3.2 Usage example
 
 Following piece of code illustrates the usage of the SR-IOV API.
--- a/drivers/pci/iov.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/iov.c	2013-12-27 13:14:18.159776829 -0800
@@ -169,26 +169,6 @@ static void virtfn_remove(struct pci_dev
 	pci_dev_put(dev);
 }
 
-static int sriov_migration(struct pci_dev *dev)
-{
-	u16 status;
-	struct pci_sriov *iov = dev->sriov;
-
-	if (!iov->num_VFs)
-		return 0;
-
-	if (!(iov->cap & PCI_SRIOV_CAP_VFM))
-		return 0;
-
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_STATUS, &status);
-	if (!(status & PCI_SRIOV_STATUS_VFM))
-		return 0;
-
-	schedule_work(&iov->mtask);
-
-	return 1;
-}
-
 static void sriov_migration_task(struct work_struct *work)
 {
 	int i;
@@ -687,25 +667,6 @@ void pci_disable_sriov(struct pci_dev *d
 EXPORT_SYMBOL_GPL(pci_disable_sriov);
 
 /**
- * pci_sriov_migration - notify SR-IOV core of Virtual Function Migration
- * @dev: the PCI device
- *
- * Returns IRQ_HANDLED if the IRQ is handled, or IRQ_NONE if not.
- *
- * Physical Function driver is responsible to register IRQ handler using
- * VF Migration Interrupt Message Number, and call this function when the
- * interrupt is generated by the hardware.
- */
-irqreturn_t pci_sriov_migration(struct pci_dev *dev)
-{
-	if (!dev->is_physfn)
-		return IRQ_NONE;
-
-	return sriov_migration(dev) ? IRQ_HANDLED : IRQ_NONE;
-}
-EXPORT_SYMBOL_GPL(pci_sriov_migration);
-
-/**
  * pci_num_vf - return number of VFs associated with a PF device_release_driver
  * @dev: the PCI device
  *
--- a/drivers/pci/pcie/aspm.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/pcie/aspm.c	2013-12-27 13:14:18.159776829 -0800
@@ -984,18 +984,6 @@ void pcie_no_aspm(void)
 	}
 }
 
-/**
- * pcie_aspm_enabled - is PCIe ASPM enabled?
- *
- * Returns true if ASPM has not been disabled by the command-line option
- * pcie_aspm=off.
- **/
-int pcie_aspm_enabled(void)
-{
-       return !aspm_disabled;
-}
-EXPORT_SYMBOL(pcie_aspm_enabled);
-
 bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
--- a/include/linux/pci.h	2013-12-27 13:14:16.539801861 -0800
+++ b/include/linux/pci.h	2013-12-27 13:14:18.159776829 -0800
@@ -376,7 +376,6 @@ static inline struct pci_dev *pci_physfn
 }
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
-struct pci_dev * __deprecated alloc_pci_dev(void);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
@@ -761,7 +760,6 @@ struct pci_slot *pci_create_slot(struct
 				 const char *name,
 				 struct hotplug_slot *hotplug);
 void pci_destroy_slot(struct pci_slot *slot);
-void pci_renumber_slot(struct pci_slot *slot, int slot_nr);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
@@ -1220,10 +1218,8 @@ extern bool pcie_ports_auto;
 #endif
 
 #ifndef CONFIG_PCIEASPM
-static inline int pcie_aspm_enabled(void) { return 0; }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 #else
-int pcie_aspm_enabled(void);
 bool pcie_aspm_support_enabled(void);
 #endif
 
--- a/drivers/pci/probe.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/probe.c	2013-12-27 13:14:18.159776829 -0800
@@ -1260,12 +1260,6 @@ struct pci_dev *pci_alloc_dev(struct pci
 }
 EXPORT_SYMBOL(pci_alloc_dev);
 
-struct pci_dev *alloc_pci_dev(void)
-{
-	return pci_alloc_dev(NULL);
-}
-EXPORT_SYMBOL(alloc_pci_dev);
-
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				 int crs_timeout)
 {
--- a/drivers/pci/slot.c	2013-12-27 13:14:16.539801861 -0800
+++ b/drivers/pci/slot.c	2013-12-27 13:14:18.159776829 -0800
@@ -320,32 +320,6 @@ err:
 EXPORT_SYMBOL_GPL(pci_create_slot);
 
 /**
- * pci_renumber_slot - update %struct pci_slot -> number
- * @slot: &struct pci_slot to update
- * @slot_nr: new number for slot
- *
- * The primary purpose of this interface is to allow callers who earlier
- * created a placeholder slot in pci_create_slot() by passing a -1 as
- * slot_nr, to update their %struct pci_slot with the correct @slot_nr.
- */
-void pci_renumber_slot(struct pci_slot *slot, int slot_nr)
-{
-	struct pci_slot *tmp;
-
-	down_write(&pci_bus_sem);
-
-	list_for_each_entry(tmp, &slot->bus->slots, list) {
-		WARN_ON(tmp->number == slot_nr);
-		goto out;
-	}
-
-	slot->number = slot_nr;
-out:
-	up_write(&pci_bus_sem);
-}
-EXPORT_SYMBOL_GPL(pci_renumber_slot);
-
-/**
  * pci_destroy_slot - decrement refcount for physical PCI slot
  * @slot: struct pci_slot to decrement
  *
