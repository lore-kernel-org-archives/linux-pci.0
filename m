Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeEPAJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 20:09:34 -0400
Date: Tue, 15 May 2018 19:09:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v16 0/9] Address error and recovery for AER and DPC
Message-ID: <20180516000932.GE11156@bhelgaas-glaptop.roam.corp.google.com>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 06:43:19AM -0400, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> The goal of the patch-set is:
> DPC should handle the error handling and recovery similar to AER, because 
> finally both are attempting recovery in some or the other way,
> and for that error handling and recovery framework has to be loosely
> coupled.
> 
> It achieves uniformity and transparency to the error handling agents such
> as AER, DPC, with respect to recovery and error handling.
> 
> So, this patch-set tries to unify lot of things between error agents and
> make them behave in a well defined way. (be it error (FATAL, NON_FATAL)
> handling or recovery).
> 
> The FATAL error handling is handled with remove/reset_link/re-enumerate
> sequence while the NON_FATAL follows the default path.
> Documentation/PCI/pci-error-recovery.txt talks more on that.
> 
> Changes since v15:
>     Bjorn's comments addressed
>     > minor comments fixed
>     > made FATAL sequence aligned to existing one, as far as clearing status are concerned.
>     > pcie_do_fatal_recovery and pcie_do_nonfatal_recovery functions made to modularize
>     > pcie_do_fatal_recovery now takes service as an argument

I made a few tweaks and pushed the result to pci/oza-v16.  The code diffs
are below (I also edited some of the changelogs).  If you post a v17,
please start from that branch so you keep the tweaks.

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6ace47099fc5..ffb956457b4a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1535,7 +1535,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index adfc55347535..764bf64a097d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4139,9 +4139,9 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return pci_dev_wait(dev, "PM D3->D0", PCIE_RESET_READY_POLL_MS);
 }
 /**
- * pcie_wait_for_link - Wait for link till it's active?/inactive?
+ * pcie_wait_for_link - Wait until link is active or inactive
  * @pdev: Bridge device
- * @active: waiting for active or inactive ?
+ * @active: waiting for active or inactive?
  *
  * Use this to wait till link becomes active or inactive.
  */
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 358b4324b9a2..6064041409d2 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -84,15 +84,14 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	 * DPC disables the Link automatically in hardware, so it has
 	 * already been reset by the time we get here.
 	 */
-
 	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
 	pciedev = to_pcie_device(devdpc);
 	dpc = get_service_data(pciedev);
 	cap = dpc->cap_pos;
 
 	/*
-	 * Waiting until the link is inactive, then clearing DPC
-	 * trigger status to allow the port to leave DPC.
+	 * Wait until the Link is inactive, then clear DPC Trigger Status
+	 * to allow the Port to leave DPC.
 	 */
 	dpc_wait_link_inactive(dpc);
 
@@ -119,7 +118,7 @@ static void dpc_work(struct work_struct *work)
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *pdev = dpc->dev->port;
 
-	/* From DPC point of view error is always FATAL. */
+	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
 }
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 29ff1488e516..d4d869f68acf 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2006 Intel Corp.
  *	Tom Long Nguyen (tom.l.nguyen@intel.com)
  *	Zhang Yanmin (yanmin.zhang@intel.com)
- *
  */
 
 #include <linux/pci.h>
@@ -95,9 +94,7 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 	} else {
 		err_handler = dev->driver->err_handler;
 		vote = err_handler->error_detected(dev, result_data->state);
-#if defined(CONFIG_PCIEAER)
 		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
-#endif
 	}
 
 	result_data->result = merge_result(result_data->result, vote);
@@ -163,9 +160,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 	err_handler = dev->driver->err_handler;
 	err_handler->resume(dev);
-#if defined(CONFIG_PCIEAER)
 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
-#endif
 out:
 	device_unlock(&dev->dev);
 	return 0;
@@ -189,7 +184,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	pci_ers_result_t status;
-	struct pcie_port_service_driver *driver;
+	struct pcie_port_service_driver *driver = NULL;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 		/* Reset this port for all subordinates */
@@ -283,16 +278,15 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  *
  * Invoked when an error is fatal. Once being invoked, removes the devices
- * benetah this AER agent, followed by reset link e.g. secondary bus reset
+ * beneath this AER agent, followed by reset link e.g. secondary bus reset
  * followed by re-enumeration of devices.
  */
-
 void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
 	struct pci_dev *pdev, *temp;
-	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
+	pci_ers_result_t result;
 	struct aer_broadcast_data result_data;
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
@@ -303,7 +297,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	parent = udev->subordinate;
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
-				 bus_list) {
+					 bus_list) {
 		pci_dev_get(pdev);
 		pci_dev_set_disconnected(pdev, NULL);
 		if (pci_has_subordinate(pdev))
@@ -329,12 +323,10 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	if (result == PCI_ERS_RESULT_RECOVERED) {
 		if (pcie_wait_for_link(udev, true))
 			pci_rescan_bus(udev->bus);
-		pci_info(dev, "Device recovery successful\n");
+		pci_info(dev, "Device recovery from fatal error successful\n");
 	} else {
-#if defined(CONFIG_PCIEAER)
 		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-#endif
-		pci_info(dev, "Device recovery failed\n");
+		pci_info(dev, "Device recovery from fatal error failed\n");
 	}
 
 	pci_unlock_rescan_remove();
@@ -390,9 +382,8 @@ void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 	return;
 
 failed:
-#if defined(CONFIG_PCIEAER)
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-#endif
+
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "AER: Device recovery failed\n");
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bc2c3375d363..a5b3b3ae6ab0 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -425,7 +425,7 @@ static int find_service_iter(struct device *device, void *data)
 }
 /**
  * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service devices associated with
+ * @dev: PCI Express port the service is associated with
  * @service: Service to find
  *
  * Find PCI Express port service driver associated with given service
@@ -446,10 +446,10 @@ struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 
 /**
  * pcie_port_find_device - find the struct device
- * @dev: PCI Express port the service devices associated with
+ * @dev: PCI Express port the service is associated with
  * @service: For the service to find
  *
- * Find PCI Express port service driver associated with given service
+ * Find the struct device associated with given service on a pci_dev
  */
 struct device *pcie_port_find_device(struct pci_dev *dev,
 				      u32 service)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 0c506fe9eff5..514bffa11dbb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -14,7 +14,7 @@
 #define AER_NONFATAL			0
 #define AER_FATAL			1
 #define AER_CORRECTABLE			2
-#define DPC_FATAL			4
+#define DPC_FATAL			3
 
 struct pci_dev;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..4f721f757363 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2284,7 +2284,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
