Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 9/9] PCI/portdrv: Rename portdrv_pci.c to portdrv.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:12:56 -0500
Message-ID: <152848877659.14051.10282676719082835906.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Rename portdrv_pci.c to portdrv.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Makefile      |    6 
 drivers/pci/pcie/portdrv.c     |  822 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_pci.c |  822 ----------------------------------------
 3 files changed, 824 insertions(+), 826 deletions(-)
 create mode 100644 drivers/pci/pcie/portdrv.c
 delete mode 100644 drivers/pci/pcie/portdrv_pci.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index aad431790b1d..a283f9ac195d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -2,10 +2,8 @@
 #
 # Makefile for PCI Express features and port driver
 
-pcieportdrv-y			:= portdrv_pci.o err.o
-
-obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
-
+obj-$(CONFIG_PCIEPORTBUS)	+= portdrv.o
+obj-$(CONFIG_PCIEPORTBUS)	+= err.o
 obj-$(CONFIG_PCIEASPM)		+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer/
 obj-$(CONFIG_PCIE_PME)		+= pme.o
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
new file mode 100644
index 000000000000..4fc86d0eef9d
--- /dev/null
+++ b/drivers/pci/pcie/portdrv.c
@@ -0,0 +1,822 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Purpose:	PCI Express Port Bus Driver
+ * Author:	Tom Nguyen <tom.l.nguyen@intel.com>
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/init.h>
+#include <linux/aer.h>
+#include <linux/dmi.h>
+
+#include "../pci.h"
+#include "portdrv.h"
+
+/* If this switch is set, PCIe port native services should not be enabled. */
+bool pcie_ports_disabled;
+
+/*
+ * If the user specified "pcie_ports=native", use the PCIe services regardless
+ * of whether the platform has given us permission.  On ACPI systems, this
+ * means we ignore _OSC.
+ */
+bool pcie_ports_native;
+
+static int __init pcie_port_setup(char *str)
+{
+	if (!strncmp(str, "compat", 6))
+		pcie_ports_disabled = true;
+	else if (!strncmp(str, "native", 6))
+		pcie_ports_native = true;
+
+	return 1;
+}
+__setup("pcie_ports=", pcie_port_setup);
+
+/* global data */
+
+struct portdrv_service_data {
+	struct pcie_port_service_driver *drv;
+	struct device *dev;
+	u32 service;
+};
+
+static int find_service_iter(struct device *device, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+	struct portdrv_service_data *pdrvs;
+	u32 service;
+
+	pdrvs = (struct portdrv_service_data *) data;
+	service = pdrvs->service;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		service_driver = to_service_driver(device->driver);
+		if (service_driver->service == service) {
+			pdrvs->drv = service_driver;
+			pdrvs->dev = device;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pcie_port_find_service - find the service driver
+ * @dev: PCI Express port the service is associated with
+ * @service: Service to find
+ *
+ * Find PCI Express port service driver associated with given service
+ */
+struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
+							u32 service)
+{
+	struct pcie_port_service_driver *drv;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.drv = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	drv = pdrvs.drv;
+	return drv;
+}
+
+/**
+ * pcie_port_find_device - find the struct device
+ * @dev: PCI Express port the service is associated with
+ * @service: For the service to find
+ *
+ * Find the struct device associated with given service on a pci_dev
+ */
+struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)
+{
+	struct device *device;
+	struct portdrv_service_data pdrvs;
+
+	pdrvs.dev = NULL;
+	pdrvs.service = service;
+	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
+
+	device = pdrvs.dev;
+	return device;
+}
+
+/**
+ * pcie_port_probe_service - probe driver for given PCI Express port service
+ * @dev: PCI Express port service device to probe against
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * whenever match is found between the driver and a port service device.
+ */
+static int pcie_port_probe_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+	int status;
+
+	if (!dev || !dev->driver)
+		return -ENODEV;
+
+	driver = to_service_driver(dev->driver);
+	if (!driver || !driver->probe)
+		return -ENODEV;
+
+	pciedev = to_pcie_device(dev);
+	status = driver->probe(pciedev);
+	if (status)
+		return status;
+
+	get_device(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_remove_service - detach driver from given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_unregister() is called for the port service device associated
+ * with the driver.
+ */
+static int pcie_port_remove_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+	driver = to_service_driver(dev->driver);
+	if (driver && driver->remove) {
+		driver->remove(pciedev);
+		put_device(dev);
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_shutdown_service - shut down given PCI Express port service
+ * @dev: PCI Express port service device to handle
+ *
+ * If PCI Express port service driver is registered with
+ * pcie_port_service_register(), this function will be called by the driver core
+ * when device_shutdown() is called for the port service device associated
+ * with the driver.
+ */
+static void pcie_port_shutdown_service(struct device *dev) {}
+
+/**
+ * pcie_port_service_register - register PCI Express port service driver
+ * @new: PCI Express port service driver to register
+ */
+int pcie_port_service_register(struct pcie_port_service_driver *new)
+{
+	if (pcie_ports_disabled)
+		return -ENODEV;
+
+	new->driver.name = new->name;
+	new->driver.bus = &pcie_port_bus_type;
+	new->driver.probe = pcie_port_probe_service;
+	new->driver.remove = pcie_port_remove_service;
+	new->driver.shutdown = pcie_port_shutdown_service;
+
+	return driver_register(&new->driver);
+}
+EXPORT_SYMBOL(pcie_port_service_register);
+
+/**
+ * pcie_port_service_unregister - unregister PCI Express port service driver
+ * @drv: PCI Express port service driver to unregister
+ */
+void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(pcie_port_service_unregister);
+
+static int pcie_portdrv_restore_config(struct pci_dev *dev)
+{
+	int retval;
+
+	retval = pci_enable_device(dev);
+	if (retval)
+		return retval;
+	pci_set_master(dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int suspend_iter(struct device *dev, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+
+	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->suspend)
+			service_driver->suspend(to_pcie_device(dev));
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_device_suspend - suspend port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ */
+static int pcie_port_device_suspend(struct device *dev)
+{
+	return device_for_each_child(dev, NULL, suspend_iter);
+}
+
+static int resume_iter(struct device *dev, void *data)
+{
+	struct pcie_port_service_driver *service_driver;
+
+	if ((dev->bus == &pcie_port_bus_type) &&
+	    (dev->driver)) {
+		service_driver = to_service_driver(dev->driver);
+		if (service_driver->resume)
+			service_driver->resume(to_pcie_device(dev));
+	}
+	return 0;
+}
+
+/**
+ * pcie_port_device_resume - resume port services associated with a PCIe port
+ * @dev: PCI Express port to handle
+ */
+static int pcie_port_device_resume(struct device *dev)
+{
+	return device_for_each_child(dev, NULL, resume_iter);
+}
+
+static int pcie_port_runtime_suspend(struct device *dev)
+{
+	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+}
+
+static int pcie_port_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int pcie_port_runtime_idle(struct device *dev)
+{
+	/*
+	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
+	 * should be good to go to D3.  Everything else, including moving
+	 * the port to D3, is handled by the PCI core.
+	 */
+	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
+}
+
+static const struct dev_pm_ops pcie_portdrv_pm_ops = {
+	.suspend	= pcie_port_device_suspend,
+	.resume		= pcie_port_device_resume,
+	.freeze		= pcie_port_device_suspend,
+	.thaw		= pcie_port_device_resume,
+	.poweroff	= pcie_port_device_suspend,
+	.restore	= pcie_port_device_resume,
+	.runtime_suspend = pcie_port_runtime_suspend,
+	.runtime_resume	= pcie_port_runtime_resume,
+	.runtime_idle	= pcie_port_runtime_idle,
+};
+
+#define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
+
+#else /* !PM */
+
+#define PCIE_PORTDRV_PM_OPS	NULL
+#endif /* !PM */
+
+/**
+ * release_pcie_device - free PCI Express port service device structure
+ * @dev: Port service device to release
+ *
+ * Invoked automatically when device is being removed in response to
+ * device_unregister(dev).  Release all resources being claimed.
+ */
+static void release_pcie_device(struct device *dev)
+{
+	kfree(to_pcie_device(dev));
+}
+
+/*
+ * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
+ * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
+ * required to accommodate the largest Message Number.
+ */
+static int pcie_message_numbers(struct pci_dev *dev, int mask,
+				u32 *pme, u32 *aer, u32 *dpc)
+{
+	u32 nvec = 0, pos;
+	u16 reg16;
+
+	/*
+	 * The Interrupt Message Number indicates which vector is used, i.e.,
+	 * the MSI-X table entry or the MSI offset between the base Message
+	 * Data and the generated interrupt message.  See PCIe r3.1, sec
+	 * 7.8.2, 7.10.10, 7.31.2.
+	 */
+
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
+		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
+		nvec = *pme + 1;
+	}
+
+#ifdef CONFIG_PCIEAER
+	if (mask & PCIE_PORT_SERVICE_AER) {
+		u32 reg32;
+
+		pos = dev->aer_cap;
+		if (pos) {
+			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
+					      &reg32);
+			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
+			nvec = max(nvec, *aer + 1);
+		}
+	}
+#endif
+
+	if (mask & PCIE_PORT_SERVICE_DPC) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+		if (pos) {
+			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
+					     &reg16);
+			*dpc = reg16 & PCI_EXP_DPC_IRQ;
+			nvec = max(nvec, *dpc + 1);
+		}
+	}
+
+	return nvec;
+}
+
+/*
+ * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
+ * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
+ * supports a maximum of 32 vectors per function.
+ */
+#define PCIE_PORT_MAX_MSI_ENTRIES	32
+
+/**
+ * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
+ * for given port
+ * @dev: PCI Express port to handle
+ * @irqs: Array of interrupt vectors to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: 0 on success, error code on failure
+ */
+static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
+{
+	int nr_entries, nvec;
+	u32 pme = 0, aer = 0, dpc = 0;
+
+	/* Allocate the maximum possible number of MSI/MSI-X vectors */
+	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
+			PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nr_entries < 0)
+		return nr_entries;
+
+	/* See how many and which Interrupt Message Numbers we actually use */
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	if (nvec > nr_entries) {
+		pci_free_irq_vectors(dev);
+		return -EIO;
+	}
+
+	/*
+	 * If we allocated more than we need, free them and reallocate fewer.
+	 *
+	 * Reallocating may change the specific vectors we get, so
+	 * pci_irq_vector() must be done *after* the reallocation.
+	 *
+	 * If we're using MSI, hardware is *allowed* to change the Interrupt
+	 * Message Numbers when we free and reallocate the vectors, but we
+	 * assume it won't because we allocate enough vectors for the
+	 * biggest Message Number we found.
+	 */
+	if (nvec != nr_entries) {
+		pci_free_irq_vectors(dev);
+
+		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
+				PCI_IRQ_MSIX | PCI_IRQ_MSI);
+		if (nr_entries < 0)
+			return nr_entries;
+	}
+
+	/* PME and hotplug share an MSI/MSI-X vector */
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
+	}
+
+	if (mask & PCIE_PORT_SERVICE_AER)
+		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
+
+	if (mask & PCIE_PORT_SERVICE_DPC)
+		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
+
+	return 0;
+}
+
+/**
+ * pcie_init_service_irqs - initialize irqs for PCI Express port services
+ * @dev: PCI Express port to handle
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of port capabilities returned by get_port_device_capability()
+ *
+ * Return value: Interrupt mode associated with the port
+ */
+static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
+{
+	int ret, i;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = -1;
+
+	/*
+	 * If we support PME but can't use MSI/MSI-X for it, we have to
+	 * fall back to INTx or other interrupts, e.g., a system shared
+	 * interrupt.
+	 */
+	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
+		goto legacy_irq;
+
+	/* Try to use MSI-X or MSI if supported */
+	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
+		return 0;
+
+legacy_irq:
+	/* fall back to legacy IRQ */
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
+	if (ret < 0)
+		return -ENODEV;
+
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = pci_irq_vector(dev, 0);
+
+	return 0;
+}
+
+/**
+ * get_port_device_capability - discover capabilities of a PCI Express port
+ * @dev: PCI Express port to examine
+ *
+ * The capabilities are read from the port's PCI Express configuration registers
+ * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
+ * 7.9 - 7.11.
+ *
+ * Return value: Bitmask of discovered port capabilities
+ */
+static int get_port_device_capability(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int services = 0;
+
+	if (dev->is_hotplug_bridge &&
+	    (pcie_ports_native || host->native_pcie_hotplug)) {
+		services |= PCIE_PORT_SERVICE_HP;
+
+		/*
+		 * Disable hot-plug interrupts in case they have been enabled
+		 * by the BIOS and the hot-plug service driver is not loaded.
+		 */
+		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+	}
+
+#ifdef CONFIG_PCIEAER
+	if (dev->aer_cap && pci_aer_available() &&
+	    (pcie_ports_native || host->native_aer)) {
+		services |= PCIE_PORT_SERVICE_AER;
+
+		/*
+		 * Disable AER on this port in case it's been enabled by the
+		 * BIOS (the AER service driver will enable it when necessary).
+		 */
+		pci_disable_pcie_error_reporting(dev);
+	}
+#endif
+
+	/*
+	 * Root ports are capable of generating PME too.  Root Complex
+	 * Event Collectors can also generate PMEs, but we don't handle
+	 * those yet.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    (pcie_ports_native || host->native_pme)) {
+		services |= PCIE_PORT_SERVICE_PME;
+
+		/*
+		 * Disable PME interrupt on this port in case it's been enabled
+		 * by the BIOS (the PME service driver will enable it when
+		 * necessary).
+		 */
+		pcie_pme_interrupt_enable(dev, false);
+	}
+
+	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
+	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
+		services |= PCIE_PORT_SERVICE_DPC;
+
+	return services;
+}
+
+#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
+
+/**
+ * pcie_device_init - allocate and initialize PCI Express port service device
+ * @pdev: PCI Express port to associate the service device with
+ * @service: Type of service to associate with the service device
+ * @irq: Interrupt vector to associate with the service device
+ */
+static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
+{
+	int retval;
+	struct pcie_device *pcie;
+	struct device *device;
+
+	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+	pcie->port = pdev;
+	pcie->irq = irq;
+	pcie->service = service;
+
+	/* Initialize generic device interface */
+	device = &pcie->device;
+	device->bus = &pcie_port_bus_type;
+	device->release = release_pcie_device;	/* callback to free pcie dev */
+	dev_set_name(device, "%s:pcie%03x",
+		     pci_name(pdev),
+		     get_descriptor_id(pci_pcie_type(pdev), service));
+	device->parent = &pdev->dev;
+	device_enable_async_suspend(device);
+
+	retval = device_register(device);
+	if (retval) {
+		put_device(device);
+		return retval;
+	}
+
+	pm_runtime_no_callbacks(device);
+
+	return 0;
+}
+
+/**
+ * pcie_port_device_register - register PCI Express port
+ * @dev: PCI Express port to register
+ *
+ * Allocate the port extension structure and register services associated with
+ * the port.
+ */
+int pcie_port_device_register(struct pci_dev *dev)
+{
+	int status, capabilities, i, nr_service;
+	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
+
+	/* Enable PCI Express port device */
+	status = pci_enable_device(dev);
+	if (status)
+		return status;
+
+	/* Get and check PCI Express port services */
+	capabilities = get_port_device_capability(dev);
+	if (!capabilities)
+		return 0;
+
+	pci_set_master(dev);
+	/*
+	 * Initialize service irqs. Don't use service devices that
+	 * require interrupts if there is no way to generate them.
+	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
+	 * that can be used in the absence of irqs.  Allow them to determine
+	 * if that is to be used.
+	 */
+	status = pcie_init_service_irqs(dev, irqs, capabilities);
+	if (status) {
+		capabilities &= PCIE_PORT_SERVICE_HP;
+		if (!capabilities)
+			goto error_disable;
+	}
+
+	/* Allocate child services if any */
+	status = -ENODEV;
+	nr_service = 0;
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		int service = 1 << i;
+		if (!(capabilities & service))
+			continue;
+		if (!pcie_device_init(dev, service, irqs[i]))
+			nr_service++;
+	}
+	if (!nr_service)
+		goto error_cleanup_irqs;
+
+	return 0;
+
+error_cleanup_irqs:
+	pci_free_irq_vectors(dev);
+error_disable:
+	pci_disable_device(dev);
+	return status;
+}
+
+/*
+ * pcie_portdrv_probe - Probe PCI-Express port devices
+ * @dev: PCI-Express port device being probed
+ *
+ * If detected invokes the pcie_port_device_register() method for
+ * this port device.
+ */
+static int pcie_portdrv_probe(struct pci_dev *dev,
+			      const struct pci_device_id *id)
+{
+	int status;
+
+	if (!pci_is_pcie(dev) ||
+	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
+	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
+		return -ENODEV;
+
+	status = pcie_port_device_register(dev);
+	if (status)
+		return status;
+
+	pci_save_state(dev);
+
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
+					   DPM_FLAG_LEAVE_SUSPENDED);
+
+	if (pci_bridge_d3_possible(dev)) {
+		/*
+		 * Keep the port resumed 100ms to make sure things like
+		 * config space accesses from userspace (lspci) will not
+		 * cause the port to repeatedly suspend and resume.
+		 */
+		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
+		pm_runtime_use_autosuspend(&dev->dev);
+		pm_runtime_mark_last_busy(&dev->dev);
+		pm_runtime_put_autosuspend(&dev->dev);
+		pm_runtime_allow(&dev->dev);
+	}
+
+	return 0;
+}
+
+static int remove_iter(struct device *dev, void *data)
+{
+	if (dev->bus == &pcie_port_bus_type)
+		device_unregister(dev);
+	return 0;
+}
+
+/**
+ * pcie_port_device_remove - unregister PCI Express port service devices
+ * @dev: PCI Express port the service devices to unregister are associated with
+ *
+ * Remove PCI Express port service devices associated with given port and
+ * disable MSI-X or MSI for the port.
+ */
+static void pcie_port_device_remove(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, remove_iter);
+	pci_free_irq_vectors(dev);
+	pci_disable_device(dev);
+}
+
+static void pcie_portdrv_remove(struct pci_dev *dev)
+{
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev);
+}
+
+static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
+					enum pci_channel_state error)
+{
+	/* Root Port has no impact. Always recovers. */
+	return PCI_ERS_RESULT_CAN_RECOVER;
+}
+
+static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
+{
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
+{
+	/* If fatal, restore cfg space for possible link reset at upstream */
+	if (dev->error_state == pci_channel_io_frozen) {
+		dev->state_saved = true;
+		pci_restore_state(dev);
+		pcie_portdrv_restore_config(dev);
+		pci_enable_pcie_error_reporting(dev);
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static int err_resume_iter(struct device *device, void *data)
+{
+	struct pcie_device *pcie_device;
+	struct pcie_port_service_driver *driver;
+
+	if (device->bus == &pcie_port_bus_type && device->driver) {
+		driver = to_service_driver(device->driver);
+		if (driver && driver->error_resume) {
+			pcie_device = to_pcie_device(device);
+
+			/* Forward error message to service drivers */
+			driver->error_resume(pcie_device->port);
+		}
+	}
+
+	return 0;
+}
+
+static void pcie_portdrv_err_resume(struct pci_dev *dev)
+{
+	device_for_each_child(&dev->dev, NULL, err_resume_iter);
+}
+
+static const struct pci_device_id port_pci_ids[] = { {
+	/* handle any PCI-Express port */
+	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
+	},
+	{ }
+};
+
+static const struct pci_error_handlers pcie_portdrv_err_handler = {
+	.error_detected = pcie_portdrv_error_detected,
+	.mmio_enabled = pcie_portdrv_mmio_enabled,
+	.slot_reset = pcie_portdrv_slot_reset,
+	.resume = pcie_portdrv_err_resume,
+};
+
+static struct pci_driver pcie_portdriver = {
+	.name		= "pcieport",
+	.id_table	= port_pci_ids,
+
+	.probe		= pcie_portdrv_probe,
+	.remove		= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_remove,
+
+	.err_handler	= &pcie_portdrv_err_handler,
+
+	.driver.pm	= PCIE_PORTDRV_PM_OPS,
+};
+
+static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
+{
+	pr_notice("%s detected: will not use MSI for PCIe PME signaling\n",
+		  d->ident);
+	pcie_pme_disable_msi();
+	return 0;
+}
+
+static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
+	/*
+	 * Boxes that should not use MSI for PCIe PME signaling.
+	 */
+	{
+	 .callback = dmi_pcie_pme_disable_msi,
+	 .ident = "MSI Wind U-100",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR,
+				"MICRO-STAR INTERNATIONAL CO., LTD"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
+		     },
+	 },
+	 { }
+};
+
+static int __init pcie_portdrv_init(void)
+{
+	if (pcie_ports_disabled)
+		return -EACCES;
+
+	dmi_check_system(pcie_portdrv_dmi_table);
+
+	return pci_register_driver(&pcie_portdriver);
+}
+device_initcall(pcie_portdrv_init);
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
deleted file mode 100644
index 4fc86d0eef9d..000000000000
--- a/drivers/pci/pcie/portdrv_pci.c
+++ /dev/null
@@ -1,822 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Purpose:	PCI Express Port Bus Driver
- * Author:	Tom Nguyen <tom.l.nguyen@intel.com>
- *
- * Copyright (C) 2004 Intel
- * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
- */
-
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/init.h>
-#include <linux/aer.h>
-#include <linux/dmi.h>
-
-#include "../pci.h"
-#include "portdrv.h"
-
-/* If this switch is set, PCIe port native services should not be enabled. */
-bool pcie_ports_disabled;
-
-/*
- * If the user specified "pcie_ports=native", use the PCIe services regardless
- * of whether the platform has given us permission.  On ACPI systems, this
- * means we ignore _OSC.
- */
-bool pcie_ports_native;
-
-static int __init pcie_port_setup(char *str)
-{
-	if (!strncmp(str, "compat", 6))
-		pcie_ports_disabled = true;
-	else if (!strncmp(str, "native", 6))
-		pcie_ports_native = true;
-
-	return 1;
-}
-__setup("pcie_ports=", pcie_port_setup);
-
-/* global data */
-
-struct portdrv_service_data {
-	struct pcie_port_service_driver *drv;
-	struct device *dev;
-	u32 service;
-};
-
-static int find_service_iter(struct device *device, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-	struct portdrv_service_data *pdrvs;
-	u32 service;
-
-	pdrvs = (struct portdrv_service_data *) data;
-	service = pdrvs->service;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		service_driver = to_service_driver(device->driver);
-		if (service_driver->service == service) {
-			pdrvs->drv = service_driver;
-			pdrvs->dev = device;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service is associated with
- * @service: Service to find
- *
- * Find PCI Express port service driver associated with given service
- */
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service)
-{
-	struct pcie_port_service_driver *drv;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.drv = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	drv = pdrvs.drv;
-	return drv;
-}
-
-/**
- * pcie_port_find_device - find the struct device
- * @dev: PCI Express port the service is associated with
- * @service: For the service to find
- *
- * Find the struct device associated with given service on a pci_dev
- */
-struct device *pcie_port_find_device(struct pci_dev *dev, u32 service)
-{
-	struct device *device;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.dev = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	device = pdrvs.dev;
-	return device;
-}
-
-/**
- * pcie_port_probe_service - probe driver for given PCI Express port service
- * @dev: PCI Express port service device to probe against
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * whenever match is found between the driver and a port service device.
- */
-static int pcie_port_probe_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-	int status;
-
-	if (!dev || !dev->driver)
-		return -ENODEV;
-
-	driver = to_service_driver(dev->driver);
-	if (!driver || !driver->probe)
-		return -ENODEV;
-
-	pciedev = to_pcie_device(dev);
-	status = driver->probe(pciedev);
-	if (status)
-		return status;
-
-	get_device(dev);
-	return 0;
-}
-
-/**
- * pcie_port_remove_service - detach driver from given PCI Express port service
- * @dev: PCI Express port service device to handle
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * when device_unregister() is called for the port service device associated
- * with the driver.
- */
-static int pcie_port_remove_service(struct device *dev)
-{
-	struct pcie_device *pciedev;
-	struct pcie_port_service_driver *driver;
-
-	if (!dev || !dev->driver)
-		return 0;
-
-	pciedev = to_pcie_device(dev);
-	driver = to_service_driver(dev->driver);
-	if (driver && driver->remove) {
-		driver->remove(pciedev);
-		put_device(dev);
-	}
-	return 0;
-}
-
-/**
- * pcie_port_shutdown_service - shut down given PCI Express port service
- * @dev: PCI Express port service device to handle
- *
- * If PCI Express port service driver is registered with
- * pcie_port_service_register(), this function will be called by the driver core
- * when device_shutdown() is called for the port service device associated
- * with the driver.
- */
-static void pcie_port_shutdown_service(struct device *dev) {}
-
-/**
- * pcie_port_service_register - register PCI Express port service driver
- * @new: PCI Express port service driver to register
- */
-int pcie_port_service_register(struct pcie_port_service_driver *new)
-{
-	if (pcie_ports_disabled)
-		return -ENODEV;
-
-	new->driver.name = new->name;
-	new->driver.bus = &pcie_port_bus_type;
-	new->driver.probe = pcie_port_probe_service;
-	new->driver.remove = pcie_port_remove_service;
-	new->driver.shutdown = pcie_port_shutdown_service;
-
-	return driver_register(&new->driver);
-}
-EXPORT_SYMBOL(pcie_port_service_register);
-
-/**
- * pcie_port_service_unregister - unregister PCI Express port service driver
- * @drv: PCI Express port service driver to unregister
- */
-void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-EXPORT_SYMBOL(pcie_port_service_unregister);
-
-static int pcie_portdrv_restore_config(struct pci_dev *dev)
-{
-	int retval;
-
-	retval = pci_enable_device(dev);
-	if (retval)
-		return retval;
-	pci_set_master(dev);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int suspend_iter(struct device *dev, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-
-	if ((dev->bus == &pcie_port_bus_type) && dev->driver) {
-		service_driver = to_service_driver(dev->driver);
-		if (service_driver->suspend)
-			service_driver->suspend(to_pcie_device(dev));
-	}
-	return 0;
-}
-
-/**
- * pcie_port_device_suspend - suspend port services associated with a PCIe port
- * @dev: PCI Express port to handle
- */
-static int pcie_port_device_suspend(struct device *dev)
-{
-	return device_for_each_child(dev, NULL, suspend_iter);
-}
-
-static int resume_iter(struct device *dev, void *data)
-{
-	struct pcie_port_service_driver *service_driver;
-
-	if ((dev->bus == &pcie_port_bus_type) &&
-	    (dev->driver)) {
-		service_driver = to_service_driver(dev->driver);
-		if (service_driver->resume)
-			service_driver->resume(to_pcie_device(dev));
-	}
-	return 0;
-}
-
-/**
- * pcie_port_device_resume - resume port services associated with a PCIe port
- * @dev: PCI Express port to handle
- */
-static int pcie_port_device_resume(struct device *dev)
-{
-	return device_for_each_child(dev, NULL, resume_iter);
-}
-
-static int pcie_port_runtime_suspend(struct device *dev)
-{
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
-}
-
-static int pcie_port_runtime_resume(struct device *dev)
-{
-	return 0;
-}
-
-static int pcie_port_runtime_idle(struct device *dev)
-{
-	/*
-	 * Assume the PCI core has set bridge_d3 whenever it thinks the port
-	 * should be good to go to D3.  Everything else, including moving
-	 * the port to D3, is handled by the PCI core.
-	 */
-	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
-}
-
-static const struct dev_pm_ops pcie_portdrv_pm_ops = {
-	.suspend	= pcie_port_device_suspend,
-	.resume		= pcie_port_device_resume,
-	.freeze		= pcie_port_device_suspend,
-	.thaw		= pcie_port_device_resume,
-	.poweroff	= pcie_port_device_suspend,
-	.restore	= pcie_port_device_resume,
-	.runtime_suspend = pcie_port_runtime_suspend,
-	.runtime_resume	= pcie_port_runtime_resume,
-	.runtime_idle	= pcie_port_runtime_idle,
-};
-
-#define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
-
-#else /* !PM */
-
-#define PCIE_PORTDRV_PM_OPS	NULL
-#endif /* !PM */
-
-/**
- * release_pcie_device - free PCI Express port service device structure
- * @dev: Port service device to release
- *
- * Invoked automatically when device is being removed in response to
- * device_unregister(dev).  Release all resources being claimed.
- */
-static void release_pcie_device(struct device *dev)
-{
-	kfree(to_pcie_device(dev));
-}
-
-/*
- * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
- * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
- * required to accommodate the largest Message Number.
- */
-static int pcie_message_numbers(struct pci_dev *dev, int mask,
-				u32 *pme, u32 *aer, u32 *dpc)
-{
-	u32 nvec = 0, pos;
-	u16 reg16;
-
-	/*
-	 * The Interrupt Message Number indicates which vector is used, i.e.,
-	 * the MSI-X table entry or the MSI offset between the base Message
-	 * Data and the generated interrupt message.  See PCIe r3.1, sec
-	 * 7.8.2, 7.10.10, 7.31.2.
-	 */
-
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
-		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
-		nvec = *pme + 1;
-	}
-
-#ifdef CONFIG_PCIEAER
-	if (mask & PCIE_PORT_SERVICE_AER) {
-		u32 reg32;
-
-		pos = dev->aer_cap;
-		if (pos) {
-			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
-					      &reg32);
-			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
-			nvec = max(nvec, *aer + 1);
-		}
-	}
-#endif
-
-	if (mask & PCIE_PORT_SERVICE_DPC) {
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
-		if (pos) {
-			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
-					     &reg16);
-			*dpc = reg16 & PCI_EXP_DPC_IRQ;
-			nvec = max(nvec, *dpc + 1);
-		}
-	}
-
-	return nvec;
-}
-
-/*
- * The PCIe Capability Interrupt Message Number (PCIe r3.1, sec 7.8.2) must
- * be one of the first 32 MSI-X entries.  Per PCI r3.0, sec 6.8.3.1, MSI
- * supports a maximum of 32 vectors per function.
- */
-#define PCIE_PORT_MAX_MSI_ENTRIES	32
-
-/**
- * pcie_port_enable_irq_vec - try to set up MSI-X or MSI as interrupt mode
- * for given port
- * @dev: PCI Express port to handle
- * @irqs: Array of interrupt vectors to populate
- * @mask: Bitmask of port capabilities returned by get_port_device_capability()
- *
- * Return value: 0 on success, error code on failure
- */
-static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
-{
-	int nr_entries, nvec;
-	u32 pme = 0, aer = 0, dpc = 0;
-
-	/* Allocate the maximum possible number of MSI/MSI-X vectors */
-	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
-			PCI_IRQ_MSIX | PCI_IRQ_MSI);
-	if (nr_entries < 0)
-		return nr_entries;
-
-	/* See how many and which Interrupt Message Numbers we actually use */
-	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
-	if (nvec > nr_entries) {
-		pci_free_irq_vectors(dev);
-		return -EIO;
-	}
-
-	/*
-	 * If we allocated more than we need, free them and reallocate fewer.
-	 *
-	 * Reallocating may change the specific vectors we get, so
-	 * pci_irq_vector() must be done *after* the reallocation.
-	 *
-	 * If we're using MSI, hardware is *allowed* to change the Interrupt
-	 * Message Numbers when we free and reallocate the vectors, but we
-	 * assume it won't because we allocate enough vectors for the
-	 * biggest Message Number we found.
-	 */
-	if (nvec != nr_entries) {
-		pci_free_irq_vectors(dev);
-
-		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI);
-		if (nr_entries < 0)
-			return nr_entries;
-	}
-
-	/* PME and hotplug share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
-	}
-
-	if (mask & PCIE_PORT_SERVICE_AER)
-		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pci_irq_vector(dev, aer);
-
-	if (mask & PCIE_PORT_SERVICE_DPC)
-		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
-
-	return 0;
-}
-
-/**
- * pcie_init_service_irqs - initialize irqs for PCI Express port services
- * @dev: PCI Express port to handle
- * @irqs: Array of irqs to populate
- * @mask: Bitmask of port capabilities returned by get_port_device_capability()
- *
- * Return value: Interrupt mode associated with the port
- */
-static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
-{
-	int ret, i;
-
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = -1;
-
-	/*
-	 * If we support PME but can't use MSI/MSI-X for it, we have to
-	 * fall back to INTx or other interrupts, e.g., a system shared
-	 * interrupt.
-	 */
-	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
-		goto legacy_irq;
-
-	/* Try to use MSI-X or MSI if supported */
-	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
-		return 0;
-
-legacy_irq:
-	/* fall back to legacy IRQ */
-	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
-	if (ret < 0)
-		return -ENODEV;
-
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = pci_irq_vector(dev, 0);
-
-	return 0;
-}
-
-/**
- * get_port_device_capability - discover capabilities of a PCI Express port
- * @dev: PCI Express port to examine
- *
- * The capabilities are read from the port's PCI Express configuration registers
- * as described in PCI Express Base Specification 1.0a sections 7.8.2, 7.8.9 and
- * 7.9 - 7.11.
- *
- * Return value: Bitmask of discovered port capabilities
- */
-static int get_port_device_capability(struct pci_dev *dev)
-{
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	int services = 0;
-
-	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
-		services |= PCIE_PORT_SERVICE_HP;
-
-		/*
-		 * Disable hot-plug interrupts in case they have been enabled
-		 * by the BIOS and the hot-plug service driver is not loaded.
-		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
-	}
-
-#ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
-		services |= PCIE_PORT_SERVICE_AER;
-
-		/*
-		 * Disable AER on this port in case it's been enabled by the
-		 * BIOS (the AER service driver will enable it when necessary).
-		 */
-		pci_disable_pcie_error_reporting(dev);
-	}
-#endif
-
-	/*
-	 * Root ports are capable of generating PME too.  Root Complex
-	 * Event Collectors can also generate PMEs, but we don't handle
-	 * those yet.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (pcie_ports_native || host->native_pme)) {
-		services |= PCIE_PORT_SERVICE_PME;
-
-		/*
-		 * Disable PME interrupt on this port in case it's been enabled
-		 * by the BIOS (the PME service driver will enable it when
-		 * necessary).
-		 */
-		pcie_pme_interrupt_enable(dev, false);
-	}
-
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
-		services |= PCIE_PORT_SERVICE_DPC;
-
-	return services;
-}
-
-#define get_descriptor_id(type, service) (((type - 4) << 8) | service)
-
-/**
- * pcie_device_init - allocate and initialize PCI Express port service device
- * @pdev: PCI Express port to associate the service device with
- * @service: Type of service to associate with the service device
- * @irq: Interrupt vector to associate with the service device
- */
-static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
-{
-	int retval;
-	struct pcie_device *pcie;
-	struct device *device;
-
-	pcie = kzalloc(sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
-	pcie->port = pdev;
-	pcie->irq = irq;
-	pcie->service = service;
-
-	/* Initialize generic device interface */
-	device = &pcie->device;
-	device->bus = &pcie_port_bus_type;
-	device->release = release_pcie_device;	/* callback to free pcie dev */
-	dev_set_name(device, "%s:pcie%03x",
-		     pci_name(pdev),
-		     get_descriptor_id(pci_pcie_type(pdev), service));
-	device->parent = &pdev->dev;
-	device_enable_async_suspend(device);
-
-	retval = device_register(device);
-	if (retval) {
-		put_device(device);
-		return retval;
-	}
-
-	pm_runtime_no_callbacks(device);
-
-	return 0;
-}
-
-/**
- * pcie_port_device_register - register PCI Express port
- * @dev: PCI Express port to register
- *
- * Allocate the port extension structure and register services associated with
- * the port.
- */
-int pcie_port_device_register(struct pci_dev *dev)
-{
-	int status, capabilities, i, nr_service;
-	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
-
-	/* Enable PCI Express port device */
-	status = pci_enable_device(dev);
-	if (status)
-		return status;
-
-	/* Get and check PCI Express port services */
-	capabilities = get_port_device_capability(dev);
-	if (!capabilities)
-		return 0;
-
-	pci_set_master(dev);
-	/*
-	 * Initialize service irqs. Don't use service devices that
-	 * require interrupts if there is no way to generate them.
-	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
-	 * that can be used in the absence of irqs.  Allow them to determine
-	 * if that is to be used.
-	 */
-	status = pcie_init_service_irqs(dev, irqs, capabilities);
-	if (status) {
-		capabilities &= PCIE_PORT_SERVICE_HP;
-		if (!capabilities)
-			goto error_disable;
-	}
-
-	/* Allocate child services if any */
-	status = -ENODEV;
-	nr_service = 0;
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
-		int service = 1 << i;
-		if (!(capabilities & service))
-			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
-	}
-	if (!nr_service)
-		goto error_cleanup_irqs;
-
-	return 0;
-
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
-}
-
-/*
- * pcie_portdrv_probe - Probe PCI-Express port devices
- * @dev: PCI-Express port device being probed
- *
- * If detected invokes the pcie_port_device_register() method for
- * this port device.
- */
-static int pcie_portdrv_probe(struct pci_dev *dev,
-			      const struct pci_device_id *id)
-{
-	int status;
-
-	if (!pci_is_pcie(dev) ||
-	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
-	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
-		return -ENODEV;
-
-	status = pcie_port_device_register(dev);
-	if (status)
-		return status;
-
-	pci_save_state(dev);
-
-	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
-					   DPM_FLAG_LEAVE_SUSPENDED);
-
-	if (pci_bridge_d3_possible(dev)) {
-		/*
-		 * Keep the port resumed 100ms to make sure things like
-		 * config space accesses from userspace (lspci) will not
-		 * cause the port to repeatedly suspend and resume.
-		 */
-		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
-		pm_runtime_use_autosuspend(&dev->dev);
-		pm_runtime_mark_last_busy(&dev->dev);
-		pm_runtime_put_autosuspend(&dev->dev);
-		pm_runtime_allow(&dev->dev);
-	}
-
-	return 0;
-}
-
-static int remove_iter(struct device *dev, void *data)
-{
-	if (dev->bus == &pcie_port_bus_type)
-		device_unregister(dev);
-	return 0;
-}
-
-/**
- * pcie_port_device_remove - unregister PCI Express port service devices
- * @dev: PCI Express port the service devices to unregister are associated with
- *
- * Remove PCI Express port service devices associated with given port and
- * disable MSI-X or MSI for the port.
- */
-static void pcie_port_device_remove(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, remove_iter);
-	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
-}
-
-static void pcie_portdrv_remove(struct pci_dev *dev)
-{
-	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
-	}
-
-	pcie_port_device_remove(dev);
-}
-
-static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
-					enum pci_channel_state error)
-{
-	/* Root Port has no impact. Always recovers. */
-	return PCI_ERS_RESULT_CAN_RECOVER;
-}
-
-static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
-{
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
-{
-	/* If fatal, restore cfg space for possible link reset at upstream */
-	if (dev->error_state == pci_channel_io_frozen) {
-		dev->state_saved = true;
-		pci_restore_state(dev);
-		pcie_portdrv_restore_config(dev);
-		pci_enable_pcie_error_reporting(dev);
-	}
-
-	return PCI_ERS_RESULT_RECOVERED;
-}
-
-static int err_resume_iter(struct device *device, void *data)
-{
-	struct pcie_device *pcie_device;
-	struct pcie_port_service_driver *driver;
-
-	if (device->bus == &pcie_port_bus_type && device->driver) {
-		driver = to_service_driver(device->driver);
-		if (driver && driver->error_resume) {
-			pcie_device = to_pcie_device(device);
-
-			/* Forward error message to service drivers */
-			driver->error_resume(pcie_device->port);
-		}
-	}
-
-	return 0;
-}
-
-static void pcie_portdrv_err_resume(struct pci_dev *dev)
-{
-	device_for_each_child(&dev->dev, NULL, err_resume_iter);
-}
-
-static const struct pci_device_id port_pci_ids[] = { {
-	/* handle any PCI-Express port */
-	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
-	},
-	{ }
-};
-
-static const struct pci_error_handlers pcie_portdrv_err_handler = {
-	.error_detected = pcie_portdrv_error_detected,
-	.mmio_enabled = pcie_portdrv_mmio_enabled,
-	.slot_reset = pcie_portdrv_slot_reset,
-	.resume = pcie_portdrv_err_resume,
-};
-
-static struct pci_driver pcie_portdriver = {
-	.name		= "pcieport",
-	.id_table	= port_pci_ids,
-
-	.probe		= pcie_portdrv_probe,
-	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
-
-	.err_handler	= &pcie_portdrv_err_handler,
-
-	.driver.pm	= PCIE_PORTDRV_PM_OPS,
-};
-
-static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
-{
-	pr_notice("%s detected: will not use MSI for PCIe PME signaling\n",
-		  d->ident);
-	pcie_pme_disable_msi();
-	return 0;
-}
-
-static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
-	/*
-	 * Boxes that should not use MSI for PCIe PME signaling.
-	 */
-	{
-	 .callback = dmi_pcie_pme_disable_msi,
-	 .ident = "MSI Wind U-100",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR,
-				"MICRO-STAR INTERNATIONAL CO., LTD"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "U-100"),
-		     },
-	 },
-	 { }
-};
-
-static int __init pcie_portdrv_init(void)
-{
-	if (pcie_ports_disabled)
-		return -EACCES;
-
-	dmi_check_system(pcie_portdrv_dmi_table);
-
-	return pci_register_driver(&pcie_portdriver);
-}
-device_initcall(pcie_portdrv_init);
