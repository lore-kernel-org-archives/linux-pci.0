Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E0CC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCB8206DF
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553537763;
	bh=WgBDl/a3N4iSVFGezbcfH9J9n/sTJlA/8Ke2dxwOZZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KCmVQCp2rm6wc2EY4y+MsAmlcUXMJ1CiOPN+3Ebe6VdZseek7bYl0HOlmYOLLJKmq
	 pdLR/+Fn7d0PUkmHUYi1sGbM9vM17/esdNthk7YmJhGGCcY66XnOfkBWr6NMTmB609
	 +wct4OXETWH3S23QHKyScJYfLZyvYIURrxsfODIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfCYSQC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYSQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 14:16:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12B73206DF;
        Mon, 25 Mar 2019 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553537759;
        bh=WgBDl/a3N4iSVFGezbcfH9J9n/sTJlA/8Ke2dxwOZZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4Gn4UPmCnvzSGame98Lmq0nT1YUfmuLEvjoE3ZPia/v3jZEQoYBYoDXL/Ewo5kle
         4CXkDMnT6vL7oGx8EtKcMHNQmN+WprTM1ReYbdLiubBYs3mz4zwJf2dwBhsma+BETl
         8Jk7D2F1aIyxkDlJMONVEwcstIye1JsrTAzG2DzA=
From:   helgaas@kernel.org
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] PCI: Fix comment typos
Date:   Mon, 25 Mar 2019 13:14:23 -0500
Message-Id: <20190325181425.247227-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325181425.247227-1-helgaas@kernel.org>
References: <20190325181425.247227-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix spelling errors and format function comments consistently.  Changes
whitespace and comments only; no functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-keystone.c |   2 +-
 drivers/pci/controller/pci-host-generic.c |   2 +-
 drivers/pci/controller/pcie-iproc-msi.c   |   2 +-
 drivers/pci/pci.c                         | 328 +++++++++++-----------
 4 files changed, 173 insertions(+), 161 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 14f2b0b4ed5e..9b4112095658 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -661,7 +661,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 			(legacy ? "legacy" : "MSI"), temp);
 
 	/*
-	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
+	 * support up to max_host_irqs. In DT from index 0 to 3 (legacy) or 0 to
 	 * 7 (MSI)
 	 */
 	for (temp = 0; temp < max_host_irqs; temp++) {
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index dea3ec7592a2..75a2fb930d4b 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Simple, generic PCI host controller driver targetting firmware-initialised
+ * Simple, generic PCI host controller driver targeting firmware-initialised
  * systems and virtual machines (e.g. the PCI emulation provided by kvmtool).
  *
  * Copyright (C) 2014 ARM Limited
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index cb3401a931f8..0a3f61be5625 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -367,7 +367,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
 
 		/*
 		 * Now go read the tail pointer again to see if there are new
-		 * oustanding events that came in during the above window.
+		 * outstanding events that came in during the above window.
 		 */
 	} while (true);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f599a..530eec3191e7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -197,8 +197,8 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 
 /**
  * pci_dev_str_match_path - test if a path string matches a device
- * @dev:    the PCI device to test
- * @path:   string to match the device against
+ * @dev: the PCI device to test
+ * @path: string to match the device against
  * @endptr: pointer to the string after the match
  *
  * Test if a string (typically from a kernel parameter) formatted as a
@@ -280,8 +280,8 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
 
 /**
  * pci_dev_str_match - test if a string matches a device
- * @dev:    the PCI device to test
- * @p:      string to match the device against
+ * @dev: the PCI device to test
+ * @p: string to match the device against
  * @endptr: pointer to the string after the match
  *
  * Test if a string (typically from a kernel parameter) matches a specified
@@ -341,7 +341,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
-		 *  (optionally, may include a path of devfns following it)
+		 * (optionally, may include a path of devfns following it)
 		 */
 		ret = pci_dev_str_match_path(dev, p, &p);
 		if (ret < 0)
@@ -425,7 +425,7 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
  * Tell if a device supports a given PCI capability.
  * Returns the address of the requested capability structure within the
  * device's PCI configuration space or 0 in case the device does not
- * support it.  Possible values for @cap:
+ * support it.  Possible values for @cap include:
  *
  *  %PCI_CAP_ID_PM           Power Management
  *  %PCI_CAP_ID_AGP          Accelerated Graphics Port
@@ -450,11 +450,11 @@ EXPORT_SYMBOL(pci_find_capability);
 
 /**
  * pci_bus_find_capability - query for devices' capabilities
- * @bus:   the PCI bus to query
+ * @bus: the PCI bus to query
  * @devfn: PCI device to query
- * @cap:   capability code
+ * @cap: capability code
  *
- * Like pci_find_capability() but works for pci devices that do not have a
+ * Like pci_find_capability() but works for PCI devices that do not have a
  * pci_dev structure set up yet.
  *
  * Returns the address of the requested capability structure within the
@@ -535,7 +535,7 @@ EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
  *
  * Returns the address of the requested extended capability structure
  * within the device's PCI configuration space or 0 if the device does
- * not support it.  Possible values for @cap:
+ * not support it.  Possible values for @cap include:
  *
  *  %PCI_EXT_CAP_ID_ERR		Advanced Error Reporting
  *  %PCI_EXT_CAP_ID_VC		Virtual Channel
@@ -618,12 +618,13 @@ int pci_find_ht_capability(struct pci_dev *dev, int ht_cap)
 EXPORT_SYMBOL_GPL(pci_find_ht_capability);
 
 /**
- * pci_find_parent_resource - return resource region of parent bus of given region
+ * pci_find_parent_resource - return resource region of parent bus of given
+ *			      region
  * @dev: PCI device structure contains resources to be searched
  * @res: child resource record for which parent is sought
  *
- *  For given resource region of given device, return the resource
- *  region of parent bus the given region is contained in.
+ * For given resource region of given device, return the resource region of
+ * parent bus the given region is contained in.
  */
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res)
@@ -800,7 +801,7 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
- *                           given PCI device
+ *			     given PCI device
  * @dev: PCI device to handle.
  * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
  *
@@ -826,7 +827,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state < PCI_D0 || state > PCI_D3hot)
 		return -EINVAL;
 
-	/* Validate current state:
+	/*
+	 * Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper
 	 * to sleep if we're already in a low power state
 	 */
@@ -837,14 +839,15 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EINVAL;
 	}
 
-	/* check if this device supports the desired state */
+	/* Check if this device supports the desired state */
 	if ((state == PCI_D1 && !dev->d1_support)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 
-	/* If we're (effectively) in D3, force entire word to 0.
+	/*
+	 * If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
@@ -867,11 +870,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		break;
 	}
 
-	/* enter specified state */
+	/* Enter specified state */
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
 
-	/* Mandatory power management transition delays */
-	/* see PCI PM 1.1 5.6.1 table 18 */
+	/*
+	 * Mandatory power management transition delays; see PCI PM 1.1
+	 * 5.6.1 table 18
+	 */
 	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
@@ -1085,16 +1090,18 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	int error;
 
-	/* bound the state we're entering */
+	/* Bound the state we're entering */
 	if (state > PCI_D3cold)
 		state = PCI_D3cold;
 	else if (state < PCI_D0)
 		state = PCI_D0;
 	else if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
+
 		/*
-		 * If the device or the parent bridge do not support PCI PM,
-		 * ignore the request if we're doing anything other than putting
-		 * it into D0 (which would only happen on boot).
+		 * If the device or the parent bridge do not support PCI
+		 * PM, ignore the request if we're doing anything other
+		 * than putting it into D0 (which would only happen on
+		 * boot).
 		 */
 		return 0;
 
@@ -1104,8 +1111,10 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	__pci_start_power_transition(dev, state);
 
-	/* This device is quirked not to be put into D3, so
-	   don't put it in D3 */
+	/*
+	 * This device is quirked not to be put into D3, so don't put it in
+	 * D3
+	 */
 	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
 		return 0;
 
@@ -1127,12 +1136,11 @@ EXPORT_SYMBOL(pci_set_power_state);
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: target sleep state for the whole system. This is the value
- *	that is passed to suspend() function.
+ *	   that is passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
  * message.
  */
-
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
 	pci_power_t ret;
@@ -1310,8 +1318,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 }
 
 /**
- * pci_save_state - save the PCI configuration space of a device before suspending
- * @dev: - PCI device that we're dealing with
+ * pci_save_state - save the PCI configuration space of a device before
+ *		    suspending
+ * @dev: PCI device that we're dealing with
  */
 int pci_save_state(struct pci_dev *dev)
 {
@@ -1422,7 +1431,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 
 /**
  * pci_restore_state - Restore the saved state of a PCI device
- * @dev: - PCI device that we're dealing with
+ * @dev: PCI device that we're dealing with
  */
 void pci_restore_state(struct pci_dev *dev)
 {
@@ -1599,8 +1608,8 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
  * pci_reenable_device - Resume abandoned device
  * @dev: PCI device to be resumed
  *
- *  Note this function is a backend of pci_default_resume and is not supposed
- *  to be called by normal code, write proper resume handler and use it instead.
+ * NOTE: This function is a backend of pci_default_resume() and is not supposed
+ * to be called by normal code, write proper resume handler and use it instead.
  */
 int pci_reenable_device(struct pci_dev *dev)
 {
@@ -1675,9 +1684,9 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
  * pci_enable_device_io - Initialize a device for use with IO space
  * @dev: PCI device to be initialized
  *
- *  Initialize device before it's used by a driver. Ask low-level code
- *  to enable I/O resources. Wake up the device if it was suspended.
- *  Beware, this function can fail.
+ * Initialize device before it's used by a driver. Ask low-level code
+ * to enable I/O resources. Wake up the device if it was suspended.
+ * Beware, this function can fail.
  */
 int pci_enable_device_io(struct pci_dev *dev)
 {
@@ -1689,9 +1698,9 @@ EXPORT_SYMBOL(pci_enable_device_io);
  * pci_enable_device_mem - Initialize a device for use with Memory space
  * @dev: PCI device to be initialized
  *
- *  Initialize device before it's used by a driver. Ask low-level code
- *  to enable Memory resources. Wake up the device if it was suspended.
- *  Beware, this function can fail.
+ * Initialize device before it's used by a driver. Ask low-level code
+ * to enable Memory resources. Wake up the device if it was suspended.
+ * Beware, this function can fail.
  */
 int pci_enable_device_mem(struct pci_dev *dev)
 {
@@ -1703,12 +1712,12 @@ EXPORT_SYMBOL(pci_enable_device_mem);
  * pci_enable_device - Initialize device before it's used by a driver.
  * @dev: PCI device to be initialized
  *
- *  Initialize device before it's used by a driver. Ask low-level code
- *  to enable I/O and memory. Wake up the device if it was suspended.
- *  Beware, this function can fail.
+ * Initialize device before it's used by a driver. Ask low-level code
+ * to enable I/O and memory. Wake up the device if it was suspended.
+ * Beware, this function can fail.
  *
- *  Note we don't actually enable the device many times if we call
- *  this function repeatedly (we just increment the count).
+ * Note we don't actually enable the device many times if we call
+ * this function repeatedly (we just increment the count).
  */
 int pci_enable_device(struct pci_dev *dev)
 {
@@ -1717,8 +1726,8 @@ int pci_enable_device(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_enable_device);
 
 /*
- * Managed PCI resources.  This manages device on/off, intx/msi/msix
- * on/off and BAR regions.  pci_dev itself records msi/msix status, so
+ * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
+ * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
  * there's no need to track it separately.  pci_devres is initialized
  * when a device is enabled using managed PCI device enable interface.
  */
@@ -1836,7 +1845,8 @@ int __weak pcibios_add_device(struct pci_dev *dev)
 }
 
 /**
- * pcibios_release_device - provide arch specific hooks when releasing device dev
+ * pcibios_release_device - provide arch specific hooks when releasing
+ *			    device dev
  * @dev: the PCI device being released
  *
  * Permits the platform to provide architecture specific functionality when
@@ -1927,8 +1937,7 @@ EXPORT_SYMBOL(pci_disable_device);
  * @dev: the PCIe device reset
  * @state: Reset state to enter into
  *
- *
- * Sets the PCIe reset state for the device. This is the default
+ * Set the PCIe reset state for the device. This is the default
  * implementation. Architecture implementations can override this.
  */
 int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
@@ -1942,7 +1951,6 @@ int __weak pcibios_set_pcie_reset_state(struct pci_dev *dev,
  * @dev: the PCIe device reset
  * @state: Reset state to enter into
  *
- *
  * Sets the PCI reset state for the device.
  */
 int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
@@ -2339,7 +2347,8 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 }
 
 /**
- * pci_prepare_to_sleep - prepare PCI device for system-wide transition into a sleep state
+ * pci_prepare_to_sleep - prepare PCI device for system-wide transition
+ *			  into a sleep state
  * @dev: Device to handle.
  *
  * Choose the power state appropriate for the device depending on whether
@@ -2367,7 +2376,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_prepare_to_sleep);
 
 /**
- * pci_back_from_sleep - turn PCI device on during system-wide transition into working state
+ * pci_back_from_sleep - turn PCI device on during system-wide transition
+ *			 into working state
  * @dev: Device to handle.
  *
  * Disable device's system wake-up capability and put it into D0.
@@ -3005,7 +3015,7 @@ static void pci_add_saved_cap(struct pci_dev *pci_dev,
 
 /**
  * _pci_add_cap_save_buffer - allocate buffer for saving given
- *                            capability registers
+ *			      capability registers
  * @dev: the PCI device
  * @cap: the capability to allocate the buffer for
  * @extended: Standard or Extended capability ID
@@ -3186,7 +3196,7 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 }
 
 /**
- * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
+ * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
  * @dev: the PCI device
  */
 static void pci_std_enable_acs(struct pci_dev *dev)
@@ -3609,13 +3619,14 @@ u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp)
 EXPORT_SYMBOL_GPL(pci_common_swizzle);
 
 /**
- *	pci_release_region - Release a PCI bar
- *	@pdev: PCI device whose resources were previously reserved by pci_request_region
- *	@bar: BAR to release
+ * pci_release_region - Release a PCI bar
+ * @pdev: PCI device whose resources were previously reserved by
+ *	  pci_request_region()
+ * @bar: BAR to release
  *
- *	Releases the PCI I/O and memory resources previously reserved by a
- *	successful call to pci_request_region.  Call this function only
- *	after all use of the PCI regions has ceased.
+ * Releases the PCI I/O and memory resources previously reserved by a
+ * successful call to pci_request_region().  Call this function only
+ * after all use of the PCI regions has ceased.
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
@@ -3637,23 +3648,23 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL(pci_release_region);
 
 /**
- *	__pci_request_region - Reserved PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource.
- *	@exclusive: whether the region access is exclusive or not
+ * __pci_request_region - Reserved PCI I/O and memory resource
+ * @pdev: PCI device whose resources are to be reserved
+ * @bar: BAR to be reserved
+ * @res_name: Name to be associated with resource.
+ * @exclusive: whether the region access is exclusive or not
  *
- *	Mark the PCI region associated with PCI device @pdev BR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
+ * Mark the PCI region associated with PCI device @pdev BAR @bar as
+ * being reserved by owner @res_name.  Do not access any
+ * address inside the PCI regions unless this call returns
+ * successfully.
  *
- *	If @exclusive is set, then the region is marked so that userspace
- *	is explicitly not allowed to map the resource via /dev/mem or
- *	sysfs MMIO access.
+ * If @exclusive is set, then the region is marked so that userspace
+ * is explicitly not allowed to map the resource via /dev/mem or
+ * sysfs MMIO access.
  *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
+ * Returns 0 on success, or %EBUSY on error.  A warning
+ * message is also printed on failure.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
@@ -3687,18 +3698,18 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 }
 
 /**
- *	pci_request_region - Reserve PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource
+ * pci_request_region - Reserve PCI I/O and memory resource
+ * @pdev: PCI device whose resources are to be reserved
+ * @bar: BAR to be reserved
+ * @res_name: Name to be associated with resource
  *
- *	Mark the PCI region associated with PCI device @pdev BAR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
+ * Mark the PCI region associated with PCI device @pdev BAR @bar as
+ * being reserved by owner @res_name.  Do not access any
+ * address inside the PCI regions unless this call returns
+ * successfully.
  *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
+ * Returns 0 on success, or %EBUSY on error.  A warning
+ * message is also printed on failure.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -3707,22 +3718,22 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 EXPORT_SYMBOL(pci_request_region);
 
 /**
- *	pci_request_region_exclusive - Reserved PCI I/O and memory resource
- *	@pdev: PCI device whose resources are to be reserved
- *	@bar: BAR to be reserved
- *	@res_name: Name to be associated with resource.
+ * pci_request_region_exclusive - Reserved PCI I/O and memory resource
+ * @pdev: PCI device whose resources are to be reserved
+ * @bar: BAR to be reserved
+ * @res_name: Name to be associated with resource.
  *
- *	Mark the PCI region associated with PCI device @pdev BR @bar as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
+ * Mark the PCI region associated with PCI device @pdev BAR @bar as
+ * being reserved by owner @res_name.  Do not access any
+ * address inside the PCI regions unless this call returns
+ * successfully.
  *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
+ * Returns 0 on success, or %EBUSY on error.  A warning
+ * message is also printed on failure.
  *
- *	The key difference that _exclusive makes it that userspace is
- *	explicitly not allowed to map the resource via /dev/mem or
- *	sysfs.
+ * The key difference that _exclusive makes it that userspace is
+ * explicitly not allowed to map the resource via /dev/mem or
+ * sysfs.
  */
 int pci_request_region_exclusive(struct pci_dev *pdev, int bar,
 				 const char *res_name)
@@ -3791,12 +3802,13 @@ int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
 
 /**
- *	pci_release_regions - Release reserved PCI I/O and memory resources
- *	@pdev: PCI device whose resources were previously reserved by pci_request_regions
+ * pci_release_regions - Release reserved PCI I/O and memory resources
+ * @pdev: PCI device whose resources were previously reserved by
+ *	  pci_request_regions()
  *
- *	Releases all PCI I/O and memory resources previously reserved by a
- *	successful call to pci_request_regions.  Call this function only
- *	after all use of the PCI regions has ceased.
+ * Releases all PCI I/O and memory resources previously reserved by a
+ * successful call to pci_request_regions().  Call this function only
+ * after all use of the PCI regions has ceased.
  */
 
 void pci_release_regions(struct pci_dev *pdev)
@@ -3806,17 +3818,17 @@ void pci_release_regions(struct pci_dev *pdev)
 EXPORT_SYMBOL(pci_release_regions);
 
 /**
- *	pci_request_regions - Reserved PCI I/O and memory resources
- *	@pdev: PCI device whose resources are to be reserved
- *	@res_name: Name to be associated with resource.
+ * pci_request_regions - Reserve PCI I/O and memory resources
+ * @pdev: PCI device whose resources are to be reserved
+ * @res_name: Name to be associated with resource.
  *
- *	Mark all PCI regions associated with PCI device @pdev as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
+ * Mark all PCI regions associated with PCI device @pdev as
+ * being reserved by owner @res_name.  Do not access any
+ * address inside the PCI regions unless this call returns
+ * successfully.
  *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
+ * Returns 0 on success, or %EBUSY on error.  A warning
+ * message is also printed on failure.
  */
 int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
@@ -3825,20 +3837,19 @@ int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 EXPORT_SYMBOL(pci_request_regions);
 
 /**
- *	pci_request_regions_exclusive - Reserved PCI I/O and memory resources
- *	@pdev: PCI device whose resources are to be reserved
- *	@res_name: Name to be associated with resource.
+ * pci_request_regions_exclusive - Reserve PCI I/O and memory resources
+ * @pdev: PCI device whose resources are to be reserved
+ * @res_name: Name to be associated with resource.
  *
- *	Mark all PCI regions associated with PCI device @pdev as
- *	being reserved by owner @res_name.  Do not access any
- *	address inside the PCI regions unless this call returns
- *	successfully.
+ * Mark all PCI regions associated with PCI device @pdev as being reserved
+ * by owner @res_name.  Do not access any address inside the PCI regions
+ * unless this call returns successfully.
  *
- *	pci_request_regions_exclusive() will mark the region so that
- *	/dev/mem and the sysfs MMIO access will not be allowed.
+ * pci_request_regions_exclusive() will mark the region so that /dev/mem
+ * and the sysfs MMIO access will not be allowed.
  *
- *	Returns 0 on success, or %EBUSY on error.  A warning
- *	message is also printed on failure.
+ * Returns 0 on success, or %EBUSY on error.  A warning message is also
+ * printed on failure.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -3849,7 +3860,7 @@ EXPORT_SYMBOL(pci_request_regions_exclusive);
 
 /*
  * Record the PCI IO range (expressed as CPU physical address + size).
- * Return a negative value if an error has occured, zero otherwise
+ * Return a negative value if an error has occurred, zero otherwise
  */
 int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 			resource_size_t	size)
@@ -3905,14 +3916,14 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
 }
 
 /**
- *	pci_remap_iospace - Remap the memory mapped I/O space
- *	@res: Resource describing the I/O space
- *	@phys_addr: physical address of range to be mapped
+ * pci_remap_iospace - Remap the memory mapped I/O space
+ * @res: Resource describing the I/O space
+ * @phys_addr: physical address of range to be mapped
  *
- *	Remap the memory mapped I/O space described by the @res
- *	and the CPU physical address @phys_addr into virtual address space.
- *	Only architectures that have memory mapped IO functions defined
- *	(and the PCI_IOBASE value defined) should call this function.
+ * Remap the memory mapped I/O space described by the @res and the CPU
+ * physical address @phys_addr into virtual address space.  Only
+ * architectures that have memory mapped IO functions defined (and the
+ * PCI_IOBASE value defined) should call this function.
  */
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
@@ -3928,8 +3939,10 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
 				  pgprot_device(PAGE_KERNEL));
 #else
-	/* this architecture does not have memory mapped I/O space,
-	   so this function should never be called */
+	/*
+	 * This architecture does not have memory mapped I/O space,
+	 * so this function should never be called
+	 */
 	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
 	return -ENODEV;
 #endif
@@ -3937,12 +3950,12 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 EXPORT_SYMBOL(pci_remap_iospace);
 
 /**
- *	pci_unmap_iospace - Unmap the memory mapped I/O space
- *	@res: resource to be unmapped
+ * pci_unmap_iospace - Unmap the memory mapped I/O space
+ * @res: resource to be unmapped
  *
- *	Unmap the CPU virtual address @res from virtual address space.
- *	Only architectures that have memory mapped IO functions defined
- *	(and the PCI_IOBASE value defined) should call this function.
+ * Unmap the CPU virtual address @res from virtual address space.  Only
+ * architectures that have memory mapped IO functions defined (and the
+ * PCI_IOBASE value defined) should call this function.
  */
 void pci_unmap_iospace(struct resource *res)
 {
@@ -4288,7 +4301,7 @@ EXPORT_SYMBOL(pci_clear_mwi);
  * @pdev: the PCI device to operate on
  * @enable: boolean: whether to enable or disable PCI INTx
  *
- * Enables/disables PCI INTx for device dev
+ * Enables/disables PCI INTx for device @pdev
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
@@ -4364,9 +4377,8 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
  * pci_check_and_mask_intx - mask INTx on pending interrupt
  * @dev: the PCI device to operate on
  *
- * Check if the device dev has its INTx line asserted, mask it and
- * return true in that case. False is returned if no interrupt was
- * pending.
+ * Check if the device dev has its INTx line asserted, mask it and return
+ * true in that case. False is returned if no interrupt was pending.
  */
 bool pci_check_and_mask_intx(struct pci_dev *dev)
 {
@@ -4378,9 +4390,9 @@ EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
  * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
  * @dev: the PCI device to operate on
  *
- * Check if the device dev has its INTx line asserted, unmask it if not
- * and return true. False is returned and the mask remains active if
- * there was still an interrupt pending.
+ * Check if the device dev has its INTx line asserted, unmask it if not and
+ * return true. False is returned and the mask remains active if there was
+ * still an interrupt pending.
  */
 bool pci_check_and_unmask_intx(struct pci_dev *dev)
 {
@@ -4389,7 +4401,7 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
 /**
- * pci_wait_for_pending_transaction - waits for pending transaction
+ * pci_wait_for_pending_transaction - wait for pending transaction
  * @dev: the PCI device to operate on
  *
  * Return 0 if transaction is pending 1 otherwise.
@@ -4447,7 +4459,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 /**
  * pcie_has_flr - check if a device supports function level resets
- * @dev:	device to check
+ * @dev: device to check
  *
  * Returns true if the device advertises support for PCIe function level
  * resets.
@@ -4466,7 +4478,7 @@ EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
- * @dev:	device to reset
+ * @dev: device to reset
  *
  * Initiate a function level reset on @dev.  The caller should ensure the
  * device supports FLR before calling this function, e.g. by using the
@@ -4810,6 +4822,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  *
  * The device function is presumed to be unused and the caller is holding
  * the device mutex lock when this function is called.
+ *
  * Resetting the device will make the contents of PCI configuration space
  * random, so any caller of this must be prepared to reinitialise the
  * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
@@ -5373,8 +5386,8 @@ EXPORT_SYMBOL_GPL(pci_reset_bus);
  * pcix_get_max_mmrbc - get PCI-X maximum designed memory read byte count
  * @dev: PCI device to query
  *
- * Returns mmrbc: maximum designed memory read count in bytes
- *    or appropriate error value.
+ * Returns mmrbc: maximum designed memory read count in bytes or
+ * appropriate error value.
  */
 int pcix_get_max_mmrbc(struct pci_dev *dev)
 {
@@ -5396,8 +5409,8 @@ EXPORT_SYMBOL(pcix_get_max_mmrbc);
  * pcix_get_mmrbc - get PCI-X maximum memory read byte count
  * @dev: PCI device to query
  *
- * Returns mmrbc: maximum memory read count in bytes
- *    or appropriate error value.
+ * Returns mmrbc: maximum memory read count in bytes or appropriate error
+ * value.
  */
 int pcix_get_mmrbc(struct pci_dev *dev)
 {
@@ -5421,7 +5434,7 @@ EXPORT_SYMBOL(pcix_get_mmrbc);
  * @mmrbc: maximum memory read count in bytes
  *    valid values are 512, 1024, 2048, 4096
  *
- * If possible sets maximum memory read byte count, some bridges have erratas
+ * If possible sets maximum memory read byte count, some bridges have errata
  * that prevent this.
  */
 int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
@@ -5466,8 +5479,7 @@ EXPORT_SYMBOL(pcix_set_mmrbc);
  * pcie_get_readrq - get PCI Express read request size
  * @dev: PCI device to query
  *
- * Returns maximum memory read request in bytes
- *    or appropriate error value.
+ * Returns maximum memory read request in bytes or appropriate error value.
  */
 int pcie_get_readrq(struct pci_dev *dev)
 {
@@ -5495,10 +5507,9 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 		return -EINVAL;
 
 	/*
-	 * If using the "performance" PCIe config, we clamp the
-	 * read rq size to the max packet size to prevent the
-	 * host bridge generating requests larger than we can
-	 * cope with
+	 * If using the "performance" PCIe config, we clamp the read rq
+	 * size to the max packet size to keep the host bridge from
+	 * generating requests larger than we can cope with.
 	 */
 	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
 		int mps = pcie_get_mps(dev);
@@ -6144,6 +6155,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 
 	if (parent)
 		domain = of_get_pci_domain_nr(parent->of_node);
+
 	/*
 	 * Check DT domain and use_dt_domains values.
 	 *
-- 
2.21.0.392.gf8f6787159e-goog

