Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v4 1/5] PCI/AER: factor out error reporting from AER
Date: Tue, 16 Jan 2018 15:28:39 +0530
Message-Id: <1516096723-8013-2-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
References: <1516096723-8013-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch factors out error reporting callbacks, which are currently
tightly coupled with AER.
DPC should be able to register callbacks and attmept recovery when DPC
trigger event occurs.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 223e4c3..d669497 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -6,7 +6,7 @@
 # Build PCI Express ASPM if needed
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 
-pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o pcie-err.o
 pcieportdrv-$(CONFIG_ACPI)	+= portdrv_acpi.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 5449e5c..bc9db53 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -76,36 +76,6 @@ struct aer_rpc {
 					 */
 };
 
-struct aer_broadcast_data {
-	enum pci_channel_state state;
-	enum pci_ers_result result;
-};
-
-static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
-		enum pci_ers_result new)
-{
-	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
-		return PCI_ERS_RESULT_NO_AER_DRIVER;
-
-	if (new == PCI_ERS_RESULT_NONE)
-		return orig;
-
-	switch (orig) {
-	case PCI_ERS_RESULT_CAN_RECOVER:
-	case PCI_ERS_RESULT_RECOVERED:
-		orig = new;
-		break;
-	case PCI_ERS_RESULT_DISCONNECT:
-		if (new == PCI_ERS_RESULT_NEED_RESET)
-			orig = PCI_ERS_RESULT_NEED_RESET;
-		break;
-	default:
-		break;
-	}
-
-	return orig;
-}
-
 extern struct bus_type pcie_port_bus_type;
 void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 7448052..4fda843 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -234,189 +234,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-static int report_error_detected(struct pci_dev *dev, void *data)
-{
-	pci_ers_result_t vote;
-	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-	result_data = (struct aer_broadcast_data *) data;
-
-	device_lock(&dev->dev);
-	dev->error_state = result_data->state;
-
-	if (!dev->driver ||
-		!dev->driver->err_handler ||
-		!dev->driver->err_handler->error_detected) {
-		if (result_data->state == pci_channel_io_frozen &&
-			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
-			/*
-			 * In case of fatal recovery, if one of down-
-			 * stream device has no driver. We might be
-			 * unable to recover because a later insmod
-			 * of a driver for this device is unaware of
-			 * its hw state.
-			 */
-			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
-				   dev->driver ?
-				   "no AER-aware driver" : "no driver");
-		}
-
-		/*
-		 * If there's any device in the subtree that does not
-		 * have an error_detected callback, returning
-		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
-		 * the subsequent mmio_enabled/slot_reset/resume
-		 * callbacks of "any" device in the subtree. All the
-		 * devices in the subtree are left in the error state
-		 * without recovery.
-		 */
-
-		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
-			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
-		else
-			vote = PCI_ERS_RESULT_NONE;
-	} else {
-		err_handler = dev->driver->err_handler;
-		vote = err_handler->error_detected(dev, result_data->state);
-	}
-
-	result_data->result = merge_result(result_data->result, vote);
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static int report_mmio_enabled(struct pci_dev *dev, void *data)
-{
-	pci_ers_result_t vote;
-	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-	result_data = (struct aer_broadcast_data *) data;
-
-	device_lock(&dev->dev);
-	if (!dev->driver ||
-		!dev->driver->err_handler ||
-		!dev->driver->err_handler->mmio_enabled)
-		goto out;
-
-	err_handler = dev->driver->err_handler;
-	vote = err_handler->mmio_enabled(dev);
-	result_data->result = merge_result(result_data->result, vote);
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static int report_slot_reset(struct pci_dev *dev, void *data)
-{
-	pci_ers_result_t vote;
-	const struct pci_error_handlers *err_handler;
-	struct aer_broadcast_data *result_data;
-	result_data = (struct aer_broadcast_data *) data;
-
-	device_lock(&dev->dev);
-	if (!dev->driver ||
-		!dev->driver->err_handler ||
-		!dev->driver->err_handler->slot_reset)
-		goto out;
-
-	err_handler = dev->driver->err_handler;
-	vote = err_handler->slot_reset(dev);
-	result_data->result = merge_result(result_data->result, vote);
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-static int report_resume(struct pci_dev *dev, void *data)
-{
-	const struct pci_error_handlers *err_handler;
-
-	device_lock(&dev->dev);
-	dev->error_state = pci_channel_io_normal;
-
-	if (!dev->driver ||
-		!dev->driver->err_handler ||
-		!dev->driver->err_handler->resume)
-		goto out;
-
-	err_handler = dev->driver->err_handler;
-	err_handler->resume(dev);
-out:
-	device_unlock(&dev->dev);
-	return 0;
-}
-
-/**
- * broadcast_error_message - handle message broadcast to downstream drivers
- * @dev: pointer to from where in a hierarchy message is broadcasted down
- * @state: error state
- * @error_mesg: message to print
- * @cb: callback to be broadcasted
- *
- * Invoked during error recovery process. Once being invoked, the content
- * of error severity will be broadcasted to all downstream drivers in a
- * hierarchy in question.
- */
-static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
-	enum pci_channel_state state,
-	char *error_mesg,
-	int (*cb)(struct pci_dev *, void *))
-{
-	struct aer_broadcast_data result_data;
-
-	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", error_mesg);
-	result_data.state = state;
-	if (cb == report_error_detected)
-		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
-	else
-		result_data.result = PCI_ERS_RESULT_RECOVERED;
-
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		/*
-		 * If the error is reported by a bridge, we think this error
-		 * is related to the downstream link of the bridge, so we
-		 * do error recovery on all subordinates of the bridge instead
-		 * of the bridge and clear the error status of the bridge.
-		 */
-		if (cb == report_error_detected)
-			dev->error_state = state;
-		pci_walk_bus(dev->subordinate, cb, &result_data);
-		if (cb == report_resume) {
-			pci_cleanup_aer_uncorrect_error_status(dev);
-			dev->error_state = pci_channel_io_normal;
-		}
-	} else {
-		/*
-		 * If the error is reported by an end point, we think this
-		 * error is related to the upstream link of the end point.
-		 */
-		if (state == pci_channel_io_normal)
-			/*
-			 * the error is non fatal so the bus is ok, just invoke
-			 * the callback for the function that logged the error.
-			 */
-			cb(dev, &result_data);
-		else
-			pci_walk_bus(dev->bus, cb, &result_data);
-	}
-
-	return result_data.result;
-}
-
-/**
- * default_reset_link - default reset function
- * @dev: pointer to pci_dev data structure
- *
- * Invoked when performing link reset on a Downstream Port or a
- * Root Port with no aer driver.
- */
-static pci_ers_result_t default_reset_link(struct pci_dev *dev)
-{
-	pci_reset_bridge_secondary_bus(dev);
-	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
 static int find_aer_service_iter(struct device *device, void *data)
 {
 	struct pcie_port_service_driver *service_driver, **drv;
@@ -434,7 +251,7 @@ static int find_aer_service_iter(struct device *device, void *data)
 	return 0;
 }
 
-static struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev)
+struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev *dev)
 {
 	struct pcie_port_service_driver *drv = NULL;
 
@@ -442,108 +259,7 @@ static struct pcie_port_service_driver *find_aer_service(struct pci_dev *dev)
 
 	return drv;
 }
-
-static pci_ers_result_t reset_link(struct pci_dev *dev)
-{
-	struct pci_dev *udev;
-	pci_ers_result_t status;
-	struct pcie_port_service_driver *driver;
-
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		/* Reset this port for all subordinates */
-		udev = dev;
-	} else {
-		/* Reset the upstream component (likely downstream port) */
-		udev = dev->bus->self;
-	}
-
-	/* Use the aer driver of the component firstly */
-	driver = find_aer_service(udev);
-
-	if (driver && driver->reset_link) {
-		status = driver->reset_link(udev);
-	} else if (udev->has_secondary_link) {
-		status = default_reset_link(udev);
-	} else {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"no link-reset support at upstream device %s\n",
-			pci_name(udev));
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	if (status != PCI_ERS_RESULT_RECOVERED) {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"link reset at upstream device %s failed\n",
-			pci_name(udev));
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	return status;
-}
-
-/**
- * do_recovery - handle nonfatal/fatal error recovery process
- * @dev: pointer to a pci_dev data structure of agent detecting an error
- * @severity: error severity type
- *
- * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
- * error detected message to all downstream drivers within a hierarchy in
- * question and return the returned code.
- */
-static void do_recovery(struct pci_dev *dev, int severity)
-{
-	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
-	enum pci_channel_state state;
-
-	if (severity == AER_FATAL)
-		state = pci_channel_io_frozen;
-	else
-		state = pci_channel_io_normal;
-
-	status = broadcast_error_message(dev,
-			state,
-			"error_detected",
-			report_error_detected);
-
-	if (severity == AER_FATAL) {
-		result = reset_link(dev);
-		if (result != PCI_ERS_RESULT_RECOVERED)
-			goto failed;
-	}
-
-	if (status == PCI_ERS_RESULT_CAN_RECOVER)
-		status = broadcast_error_message(dev,
-				state,
-				"mmio_enabled",
-				report_mmio_enabled);
-
-	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
-		status = broadcast_error_message(dev,
-				state,
-				"slot_reset",
-				report_slot_reset);
-	}
-
-	if (status != PCI_ERS_RESULT_RECOVERED)
-		goto failed;
-
-	broadcast_error_message(dev,
-				state,
-				"resume",
-				report_resume);
-
-	dev_info(&dev->dev, "AER: Device recovery successful\n");
-	return;
-
-failed:
-	/* TODO: Should kernel panic here? */
-	dev_info(&dev->dev, "AER: Device recovery failed\n");
-}
+EXPORT_SYMBOL(pci_find_aer_service);
 
 /**
  * handle_error_source - handle logging error into an event log
diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
new file mode 100644
index 0000000..76e66bb
--- /dev/null
+++ b/drivers/pci/pcie/pcie-err.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file implements the error recovery as a core part of PCIe error reporting.
+ * When a PCIe error is delivered, an error message will be collected and printed
+ * to console, then, an error recovery procedure will be executed by following
+ * the PCI error recovery rules.
+ *
+ * Copyright (C) 2006 Intel Corp.
+ *	Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *	Zhang Yanmin (yanmin.zhang@intel.com)
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/aer.h>
+#include <linux/pcieport_if.h>
+#include "portdrv.h"
+
+struct aer_broadcast_data {
+	enum pci_channel_state state;
+	enum pci_ers_result result;
+};
+
+pci_ers_result_t merge_result(enum pci_ers_result orig,
+				  enum pci_ers_result new)
+{
+	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
+		return PCI_ERS_RESULT_NO_AER_DRIVER;
+
+	if (new == PCI_ERS_RESULT_NONE)
+		return orig;
+
+	switch (orig) {
+	case PCI_ERS_RESULT_CAN_RECOVER:
+	case PCI_ERS_RESULT_RECOVERED:
+		orig = new;
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		if (new == PCI_ERS_RESULT_NEED_RESET)
+			orig = PCI_ERS_RESULT_NEED_RESET;
+		break;
+	default:
+		break;
+	}
+
+	return orig;
+}
+
+int report_mmio_enabled(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	const struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+
+	result_data = (struct aer_broadcast_data *) data;
+
+	device_lock(&dev->dev);
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->mmio_enabled)
+		goto out;
+
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->mmio_enabled(dev);
+	result_data->result = merge_result(result_data->result, vote);
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+int report_slot_reset(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	const struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+
+	result_data = (struct aer_broadcast_data *) data;
+
+	device_lock(&dev->dev);
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->slot_reset)
+		goto out;
+
+	err_handler = dev->driver->err_handler;
+	vote = err_handler->slot_reset(dev);
+	result_data->result = merge_result(result_data->result, vote);
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+int report_resume(struct pci_dev *dev, void *data)
+{
+	const struct pci_error_handlers *err_handler;
+
+	device_lock(&dev->dev);
+	dev->error_state = pci_channel_io_normal;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->resume)
+		goto out;
+
+	err_handler = dev->driver->err_handler;
+	err_handler->resume(dev);
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+int report_error_detected(struct pci_dev *dev, void *data)
+{
+	pci_ers_result_t vote;
+	const struct pci_error_handlers *err_handler;
+	struct aer_broadcast_data *result_data;
+
+	result_data = (struct aer_broadcast_data *) data;
+
+	device_lock(&dev->dev);
+	dev->error_state = result_data->state;
+
+	if (!dev->driver ||
+		!dev->driver->err_handler ||
+		!dev->driver->err_handler->error_detected) {
+		if (result_data->state == pci_channel_io_frozen &&
+			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+			/*
+			 * In case of fatal recovery, if one of down-
+			 * stream device has no driver. We might be
+			 * unable to recover because a later insmod
+			 * of a driver for this device is unaware of
+			 * its hw state.
+			 */
+			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
+				   dev->driver ?
+				   "no error-aware driver" : "no driver");
+		}
+
+		/*
+		 * If there's any device in the subtree that does not
+		 * have an error_detected callback, returning
+		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
+		 * the subsequent mmio_enabled/slot_reset/resume
+		 * callbacks of "any" device in the subtree. All the
+		 * devices in the subtree are left in the error state
+		 * without recovery.
+		 */
+
+		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
+		else
+			vote = PCI_ERS_RESULT_NONE;
+	} else {
+		err_handler = dev->driver->err_handler;
+		vote = err_handler->error_detected(dev, result_data->state);
+	}
+
+	result_data->result = merge_result(result_data->result, vote);
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+/**
+ * default_reset_link - default reset function
+ * @dev: pointer to pci_dev data structure
+ *
+ * Invoked when performing link reset on a Downstream Port or a
+ * Root Port with no aer driver.
+ */
+static pci_ers_result_t default_reset_link(struct pci_dev *dev)
+{
+	pci_reset_bridge_secondary_bus(dev);
+	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+pci_ers_result_t reset_link(struct pci_dev *dev)
+{
+	struct pci_dev *udev;
+	pci_ers_result_t status;
+	struct pcie_port_service_driver *driver = NULL;
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* Reset this port for all subordinates */
+		udev = dev;
+	} else {
+		/* Reset the upstream component (likely downstream port) */
+		udev = dev->bus->self;
+	}
+
+#if IS_ENABLED(CONFIG_PCIEAER)
+	/* Use the aer driver of the component firstly */
+	driver = pci_find_aer_service(udev);
+#endif
+
+	if (driver && driver->reset_link) {
+		status = driver->reset_link(udev);
+	} else if (udev->has_secondary_link) {
+		status = default_reset_link(udev);
+	} else {
+		dev_printk(KERN_DEBUG, &dev->dev,
+			"no link-reset support at upstream device %s\n",
+			pci_name(udev));
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	if (status != PCI_ERS_RESULT_RECOVERED) {
+		dev_printk(KERN_DEBUG, &dev->dev,
+			"link reset at upstream device %s failed\n",
+			pci_name(udev));
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return status;
+}
+
+/**
+ * broadcast_error_message - handle message broadcast to downstream drivers
+ * @dev: pointer to from where in a hierarchy message is broadcasted down
+ * @state: error state
+ * @error_mesg: message to print
+ * @cb: callback to be broadcasted
+ *
+ * Invoked during error recovery process. Once being invoked, the content
+ * of error severity will be broadcasted to all downstream drivers in a
+ * hierarchy in question.
+ */
+pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
+	enum pci_channel_state state,
+	char *error_mesg,
+	int (*cb)(struct pci_dev *, void *))
+{
+	struct aer_broadcast_data result_data;
+
+	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", error_mesg);
+	result_data.state = state;
+	if (cb == report_error_detected)
+		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
+	else
+		result_data.result = PCI_ERS_RESULT_RECOVERED;
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/*
+		 * If the error is reported by a bridge, we think this error
+		 * is related to the downstream link of the bridge, so we
+		 * do error recovery on all subordinates of the bridge instead
+		 * of the bridge and clear the error status of the bridge.
+		 */
+		if (cb == report_error_detected)
+			dev->error_state = state;
+		pci_walk_bus(dev->subordinate, cb, &result_data);
+		if (cb == report_resume) {
+			pci_cleanup_aer_uncorrect_error_status(dev);
+			dev->error_state = pci_channel_io_normal;
+		}
+	} else {
+		/*
+		 * If the error is reported by an end point, we think this
+		 * error is related to the upstream link of the end point.
+		 */
+		pci_walk_bus(dev->bus, cb, &result_data);
+	}
+
+	return result_data.result;
+}
+
+/**
+ * do_recovery - handle nonfatal/fatal error recovery process
+ * @dev: pointer to a pci_dev data structure of agent detecting an error
+ * @severity: error severity type
+ *
+ * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
+ * error detected message to all downstream drivers within a hierarchy in
+ * question and return the returned code.
+ */
+void do_recovery(struct pci_dev *dev, int severity)
+{
+	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
+	enum pci_channel_state state;
+
+	if (severity == AER_FATAL)
+		state = pci_channel_io_frozen;
+	else
+		state = pci_channel_io_normal;
+
+	status = broadcast_error_message(dev,
+			state,
+			"error_detected",
+			report_error_detected);
+
+	if (severity == AER_FATAL) {
+		result = reset_link(dev);
+		if (result != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+	}
+
+	if (status == PCI_ERS_RESULT_CAN_RECOVER)
+		status = broadcast_error_message(dev,
+				state,
+				"mmio_enabled",
+				report_mmio_enabled);
+
+	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		/*
+		 * TODO: Should call platform-specific
+		 * functions to reset slot before calling
+		 * drivers' slot_reset callbacks?
+		 */
+		status = broadcast_error_message(dev,
+				state,
+				"slot_reset",
+				report_slot_reset);
+	}
+
+	if (status != PCI_ERS_RESULT_RECOVERED)
+		goto failed;
+
+	broadcast_error_message(dev,
+				state,
+				"resume",
+				report_resume);
+
+	dev_info(&dev->dev, "Device recovery successful\n");
+	return;
+
+failed:
+	/* TODO: Should kernel panic here? */
+	dev_info(&dev->dev, "Device recovery failed\n");
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index a854bc5..4f1992d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -79,4 +79,5 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask)
 static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 #endif /* !CONFIG_ACPI */
 
+struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev *dev);
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8f87bbe..cd4f086 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,9 +11,9 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define AER_NONFATAL			0
-#define AER_FATAL			1
-#define AER_CORRECTABLE			2
+#define AER_NONFATAL		0
+#define AER_FATAL		1
+#define AER_CORRECTABLE		2
 
 struct pci_dev;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c92..46fd243 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1998,6 +1998,8 @@ static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int res
 void pci_hp_remove_module_link(struct pci_slot *pci_slot);
 #endif
 
+void do_recovery(struct pci_dev *dev, int severity);
+
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
