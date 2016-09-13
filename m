Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:41310 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755164AbcIMRMX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 13:12:23 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH] pci: endpoint: add EP core layer to enable EP controller and EP functions
Date: Tue, 13 Sep 2016 22:40:43 +0530
Message-ID: <1473786653-12759-2-git-send-email-kishon@ti.com>
In-Reply-To: <1473786653-12759-1-git-send-email-kishon@ti.com>
References: <1473786653-12759-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a new EP core layer in order to support endpoint functions
in linux kernel. This comprises of EPC library
(Endpoint Controller Library) and EPF library (Endpoint
Function Library). EPC library implements functions that is specific
to an endpoint controller and EPF library implements functions
that is specific to an endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/Makefile                    |    1 +
 drivers/pci/Kconfig                 |    1 +
 drivers/pci/endpoint/Kconfig        |   21 ++
 drivers/pci/endpoint/Makefile       |    5 +
 drivers/pci/endpoint/pci-epc-core.c |  389 +++++++++++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c |  338 ++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h     |   10 +
 include/linux/pci-epc.h             |  100 +++++++++
 include/linux/pci-epf.h             |  159 ++++++++++++++
 9 files changed, 1024 insertions(+)
 create mode 100644 drivers/pci/endpoint/Kconfig
 create mode 100644 drivers/pci/endpoint/Makefile
 create mode 100644 drivers/pci/endpoint/pci-epc-core.c
 create mode 100644 drivers/pci/endpoint/pci-epf-core.c
 create mode 100644 include/linux/pci-epc.h
 create mode 100644 include/linux/pci-epf.h

diff --git a/drivers/Makefile b/drivers/Makefile
index 53abb4a..8c070ad 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_GENERIC_PHY)	+= phy/
 obj-$(CONFIG_PINCTRL)		+= pinctrl/
 obj-$(CONFIG_GPIOLIB)		+= gpio/
 obj-y				+= pwm/
+obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 67f9916..5f116a6 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -133,3 +133,4 @@ config PCI_HYPERV
 
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/host/Kconfig"
+source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
new file mode 100644
index 0000000..a6d827c
--- /dev/null
+++ b/drivers/pci/endpoint/Kconfig
@@ -0,0 +1,21 @@
+#
+# PCI Endpoint Support
+#
+
+menu "PCI Endpoint"
+
+config PCI_ENDPOINT
+	tristate "PCI Endpoint Support"
+	help
+	   Enable this configuration option to support configurable PCI
+	   endpoint. This should be enabled if the platform has a PCI
+	   controller that can operate in endpoint mode.
+
+	   Enabling this option will build the endpoint library, which
+	   includes endpoint controller library and endpoint function
+	   library.
+
+	   If in doubt, say "N" to disable Endpoint support.
+
+endmenu
+
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
new file mode 100644
index 0000000..dbc5517
--- /dev/null
+++ b/drivers/pci/endpoint/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for PCI Endpoint Support
+#
+
+obj-$(CONFIG_PCI_ENDPOINT)		:= pci-epc-core.o pci-epf-core.o
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
new file mode 100644
index 0000000..003d2ee
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -0,0 +1,389 @@
+/**
+ * pci-epc-core.c - PCI Endpoint *Controller* (EPC) library
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+static struct class *pci_epc_class;
+
+static void devm_pci_epc_release(struct device *dev, void *res)
+{
+	struct pci_epc *epc = *(struct pci_epc **)res;
+
+	pci_epc_destroy(epc);
+}
+
+static int devm_pci_epc_match(struct device *dev, void *res, void *match_data)
+{
+	struct pci_epc **epc = res;
+
+	return *epc == match_data;
+}
+
+/**
+ * pci_epc_unbind_epf() - unbind the endpoint function and endpoint controller
+ * @epf: the endpoint function which has requested for unbinding
+ *
+ * Invoke to unbind the endpoint function and endpoint controller
+ */
+void pci_epc_unbind_epf(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	pci_epf_unbind(epf);
+	module_put(epc->ops->owner);
+	epf->epc = NULL;
+	epc->epf = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_epc_unbind_epf);
+
+/**
+ * pci_epc_bind_epf() - bind the endpoint function with an endpoint controller
+ * @epf: endpoint function which has to be bound to an endpoint controller
+ *
+ * Invoke to bind the endpoint function with an endpoint controller based on
+ * pci_epc_name.
+ */
+int pci_epc_bind_epf(struct pci_epf *epf)
+{
+	int ret = -EINVAL;
+	struct pci_epc *epc;
+	struct device *dev;
+	struct class_dev_iter iter;
+
+	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
+	while ((dev = class_dev_iter_next(&iter))) {
+		if (strcmp(epf->pci_epc_name, dev_name(dev)))
+			continue;
+
+		epc = to_pci_epc(dev);
+		if (epc->epf) {
+			ret = -EBUSY;
+			goto err;
+		}
+
+		if (!try_module_get(epc->ops->owner)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		epf->epc = epc;
+		epc->epf = epf;
+
+		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
+		epf->dev.dma_mask = epc->dev.dma_mask;
+
+		pci_epf_bind(epf);
+		class_dev_iter_exit(&iter);
+		return 0;
+	}
+
+err:
+	class_dev_iter_exit(&iter);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_bind_epf);
+
+/**
+ * pci_epc_stop() - stop the PCI link
+ * @epc: the link of the EPC device that has to be stopped
+ *
+ * Invoke to stop the PCI link
+ */
+void pci_epc_stop(struct pci_epc *epc)
+{
+	if (IS_ERR(epc) || !epc->ops->stop)
+		return;
+
+	spin_lock_irq(&epc->irq_lock);
+	epc->ops->stop(epc);
+	spin_unlock_irq(&epc->irq_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_stop);
+
+/**
+ * pci_epc_start() - start the PCI link
+ * @epc: the link of the EPC device that has to be started
+ *
+ * Invoke to start the PCI link
+ */
+int pci_epc_start(struct pci_epc *epc)
+{
+	int ret;
+
+	if (IS_ERR(epc))
+		return -EINVAL;
+
+	if (!epc->ops->start)
+		return 0;
+
+	spin_lock_irq(&epc->irq_lock);
+	ret = epc->ops->start(epc);
+	spin_unlock_irq(&epc->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_start);
+
+/**
+ * pci_epc_raise_irq() - interrupt the host system
+ * @epc: the EPC device which has to interrupt the host
+ * @type: specify the type of interrupt; legacy or MSI
+ *
+ * Invoke to raise an MSI or legacy interrupt
+ */
+int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type)
+{
+	int ret;
+
+	if (IS_ERR(epc))
+		return -EINVAL;
+
+	if (!epc->ops->raise_irq)
+		return 0;
+
+	spin_lock_irq(&epc->irq_lock);
+	ret = epc->ops->raise_irq(epc, type);
+	spin_unlock_irq(&epc->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
+
+/**
+ * pci_epc_clear_bar() - reset the BAR
+ * @epc: the EPC device for which the BAR has to be cleared
+ * @bar: the bar number that has to be reset
+ *
+ * Invoke to reset the BAR of the endpoint device.
+ */
+void pci_epc_clear_bar(struct pci_epc *epc, int bar)
+{
+	if (IS_ERR(epc))
+		return;
+
+	if (!epc->ops->clear_bar)
+		return;
+
+	spin_lock_irq(&epc->irq_lock);
+	epc->ops->clear_bar(epc, bar);
+	spin_unlock_irq(&epc->irq_lock);
+}
+EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
+
+/**
+ * pci_epc_set_bar() - configure BAR in order for host to assign PCI addr space
+ * @epc: the EPC device on which BAR has to be configured
+ * @bar: the bar number that has to be configured
+ * @size: the size of the addr space
+ * @flags: specify memory allocation/io allocation/32bit address/64 bit address
+ *
+ * Invoke to configure the BAR of the endpoint device.
+ */
+int pci_epc_set_bar(struct pci_epc *epc, enum pci_barno bar,
+		    dma_addr_t bar_phys, size_t size, int flags)
+{
+	int ret;
+
+	if (IS_ERR(epc))
+		return -EINVAL;
+
+	if (!epc->ops->set_bar)
+		return 0;
+
+	spin_lock_irq(&epc->irq_lock);
+	ret = epc->ops->set_bar(epc, bar, bar_phys, size, flags);
+	spin_unlock_irq(&epc->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_set_bar);
+
+/**
+ * pci_epc_write_header() - write standard configuration header
+ * @epc: the EPC device to which the configuration header should be written
+ * @header: standard configuration header fields
+ *
+ * Invoke to write the configuration header to the endpoint controller. Every
+ * endpoint controller will have a dedicated location to which the standard
+ * configuration header would be written. The callback function should write
+ * the header fields to this dedicated location.
+ */
+int pci_epc_write_header(struct pci_epc *epc, struct pci_epf_header *header)
+{
+	int ret;
+
+	if (IS_ERR(epc))
+		return -EINVAL;
+
+	if (!epc->ops->write_header)
+		return 0;
+
+	spin_lock_irq(&epc->irq_lock);
+	ret = epc->ops->write_header(epc, header);
+	spin_unlock_irq(&epc->irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_write_header);
+
+/**
+ * pci_epc_destroy() - destroy the EPC device
+ * @epc: the EPC device that has to be destroyed
+ *
+ * Invoke to destroy the PCI EPC device
+ */
+void pci_epc_destroy(struct pci_epc *epc)
+{
+	device_unregister(&epc->dev);
+	kfree(epc);
+}
+EXPORT_SYMBOL_GPL(pci_epc_destroy);
+
+/**
+ * devm_pci_epc_destroy() - destroy the EPC device
+ * @dev: device that wants to destroy the EPC
+ * @epc: the EPC device that has to be destroyed
+ *
+ * Invoke to destroy the devres associated with this
+ * pci_epc and destroy the EPC device.
+ */
+void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
+{
+	int r;
+
+	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+			   epc);
+	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
+}
+EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
+
+/**
+ * __pci_epc_create() - create a new endpoint controller (EPC) device
+ * @dev: device that is creating the new EPC
+ * @ops: function pointers for performing EPC operations
+ * @owner: the owner of the module that creates the EPC device
+ *
+ * Invoke to create a new EPC device and add it to pci_epc class.
+ */
+struct pci_epc *
+__pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
+		 struct module *owner)
+{
+	int ret;
+	struct pci_epc *epc;
+
+	if (WARN_ON(!dev)) {
+		ret = -EINVAL;
+		goto err_ret;
+	}
+
+	epc = kzalloc(sizeof(*epc), GFP_KERNEL);
+	if (!epc) {
+		ret = -ENOMEM;
+		goto err_ret;
+	}
+
+	spin_lock_init(&epc->irq_lock);
+
+	device_initialize(&epc->dev);
+	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
+	epc->dev.class = pci_epc_class;
+	epc->dev.dma_mask = dev->dma_mask;
+	epc->ops = ops;
+
+	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
+	if (ret)
+		goto put_dev;
+
+	ret = device_add(&epc->dev);
+	if (ret)
+		goto put_dev;
+
+	return epc;
+
+put_dev:
+	put_device(&epc->dev);
+	kfree(epc);
+
+err_ret:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(__pci_epc_create);
+
+/**
+ * __devm_pci_epc_create() - create a new endpoint controller (EPC) device
+ * @dev: device that is creating the new EPC
+ * @ops: function pointers for performing EPC operations
+ * @owner: the owner of the module that creates the EPC device
+ *
+ * Invoke to create a new EPC device and add it to pci_epc class.
+ * While at that, it also associates the device with the pci_epc using devres.
+ * On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed.
+ */
+struct pci_epc *
+__devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
+		      struct module *owner)
+{
+	struct pci_epc **ptr, *epc;
+
+	ptr = devres_alloc(devm_pci_epc_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	epc = __pci_epc_create(dev, ops, owner);
+	if (!IS_ERR(epc)) {
+		*ptr = epc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return epc;
+}
+EXPORT_SYMBOL_GPL(__devm_pci_epc_create);
+
+static int __init pci_epc_init(void)
+{
+	pci_epc_class = class_create(THIS_MODULE, "pci_epc");
+	if (IS_ERR(pci_epc_class)) {
+		pr_err("failed to create pci epc class --> %ld\n",
+		       PTR_ERR(pci_epc_class));
+		return PTR_ERR(pci_epc_class);
+	}
+
+	return 0;
+}
+module_init(pci_epc_init);
+
+static void __exit pci_epc_exit(void)
+{
+	class_destroy(pci_epc_class);
+}
+module_exit(pci_epc_exit);
+
+MODULE_DESCRIPTION("PCI EPC Library");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
new file mode 100644
index 0000000..2802267
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -0,0 +1,338 @@
+/**
+ * pci-epf-core.c - PCI Endpoint *Function* (EPF) library
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+static struct bus_type pci_epf_bus_type;
+static struct device_type pci_epf_type;
+
+/**
+ * pci_epf_linkup() - Notify the function driver that EPC device has
+ *		      established a connection with the Root Complex.
+ * @epf: the EPF device bound to the EPC device which has established
+ *	 the connection with the host
+ *
+ * Invoke to notify the function driver that EPC device has established
+ * a connection with the Root Complex.
+ */
+void pci_epf_linkup(struct pci_epf *epf)
+{
+	epf->driver->ops->linkup(epf);
+}
+EXPORT_SYMBOL_GPL(pci_epf_linkup);
+
+/**
+ * pci_epf_unbind() - Notify the function driver that the binding between the
+ *		      EPF device and EPC device has been lost
+ * @epf: the EPF device which has lost the binding with the EPC device
+ *
+ * Invoke to notify the function driver that the binding between the EPF device
+ * and EPC device has been lost.
+ */
+void pci_epf_unbind(struct pci_epf *epf)
+{
+	epf->driver->ops->unbind(epf);
+	module_put(epf->driver->owner);
+}
+EXPORT_SYMBOL_GPL(pci_epf_unbind);
+
+/**
+ * pci_epf_bind() - Notify the function driver that the EPF device has been
+ *		    bound to a EPC device
+ * @epf: the EPF device which has been bound to the EPC device
+ *
+ * Invoke to notify the function driver that it has been bound to a EPC device
+ */
+int pci_epf_bind(struct pci_epf *epf)
+{
+	if (!try_module_get(epf->driver->owner))
+		return -EAGAIN;
+
+	return epf->driver->ops->bind(epf);
+}
+EXPORT_SYMBOL_GPL(pci_epf_bind);
+
+/**
+ * pci_epf_free_space() - free the allocated PCI EPF register space
+ * @addr: the virtual address of the PCI EPF register space
+ * @bar: the bar number corresponding to the register space
+ *
+ * Invoke to free the allocated PCI EPF register space.
+ */
+void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
+{
+	struct device *dev = &epf->dev;
+
+	if (!addr)
+		return;
+
+	dma_free_coherent(dev, epf->bar[bar].size, addr,
+			  epf->bar[bar].phys_addr);
+
+	epf->bar[bar].phys_addr = 0;
+	epf->bar[bar].size = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_space);
+
+/**
+ * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
+ * @size: the size of the memory that has to be allocated
+ * @bar: the bar number corresponding to the allocated register space
+ *
+ * Invoke to allocate memory for the PCI EPF register space.
+ */
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
+{
+	void *space;
+	struct device *dev = &epf->dev;
+	dma_addr_t phys_addr;
+
+	if (size < 128)
+		size = 128;
+	size = roundup_pow_of_two(size);
+
+	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	if (!space) {
+		dev_err(dev, "failed to allocate mem space\n");
+		return NULL;
+	}
+
+	epf->bar[bar].phys_addr = phys_addr;
+	epf->bar[bar].size = size;
+
+	return space;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
+
+/**
+ * pci_epf_unregister_driver() - unregister the PCI EPF driver
+ * @driver: the PCI EPF driver that has to be unregistered
+ *
+ * Invoke to unregister the PCI EPF driver.
+ */
+void pci_epf_unregister_driver(struct pci_epf_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
+
+/**
+ * __pci_epf_register_driver() - register a new PCI EPF driver
+ * @driver: structure representing PCI EPF driver
+ * @owner: the owner of the module that registers the PCI EPF driver
+ *
+ * Invoke to register a new PCI EPF driver.
+ */
+int __pci_epf_register_driver(struct pci_epf_driver *driver,
+			      struct module *owner)
+{
+	int ret;
+
+	if (!driver->ops)
+		return -EINVAL;
+
+	if (!driver->ops->bind || !driver->ops->unbind || !driver->ops->linkup)
+		return -EINVAL;
+
+	driver->driver.bus = &pci_epf_bus_type;
+	driver->driver.owner = owner;
+
+	ret = driver_register(&driver->driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__pci_epf_register_driver);
+
+/**
+ * pci_epf_destroy() - destroy the created PCI EPF device
+ * @epf: the PCI EPF device that has to be destroyed.
+ *
+ * Invoke to destroy the PCI EPF device created by invoking pci_epf_create().
+ */
+void pci_epf_destroy(struct pci_epf *epf)
+{
+	device_unregister(&epf->dev);
+}
+EXPORT_SYMBOL_GPL(pci_epf_destroy);
+
+/**
+ * pci_epf_create() - create a new PCI EPF device
+ * @name: the name of the PCI EPF device. This name will be used to bind the
+ *	  the EPF device to a EPF driver
+ *
+ * Invoke to create a new PCI EPF device by providing the name of the function
+ * device.
+ */
+struct pci_epf *pci_epf_create(const char *name)
+{
+	int ret;
+	struct pci_epf *epf;
+	struct device *dev;
+	char *func_name;
+	char *buf;
+
+	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
+	if (!epf) {
+		ret = -ENOMEM;
+		goto err_ret;
+	}
+
+	buf = kstrdup(name, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_epf;
+	}
+
+	func_name = buf;
+	buf = strchrnul(buf, '.');
+	*buf = '\0';
+
+	epf->name = kstrdup(func_name, GFP_KERNEL);
+	if (!epf->name) {
+		ret = -ENOMEM;
+		goto free_epf;
+	}
+
+	dev = &epf->dev;
+	device_initialize(dev);
+	dev->bus = &pci_epf_bus_type;
+	dev->type = &pci_epf_type;
+
+	ret = dev_set_name(dev, "%s", name);
+	if (ret)
+		goto put_dev;
+
+	ret = device_add(dev);
+	if (ret)
+		goto put_dev;
+
+	kfree(func_name);
+	return epf;
+
+put_dev:
+	put_device(dev);
+	kfree(epf->name);
+	kfree(func_name);
+
+free_epf:
+	kfree(epf);
+
+err_ret:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pci_epf_create);
+
+static void pci_epf_dev_release(struct device *dev)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+
+	kfree(epf->name);
+	kfree(epf);
+}
+
+static struct device_type pci_epf_type = {
+	.release	= pci_epf_dev_release,
+};
+
+static const struct pci_epf_device_id *
+pci_epf_match_id(const struct pci_epf_device_id *id, const struct pci_epf *epf)
+{
+	while (id->name[0]) {
+		if (strcmp(epf->name, id->name) == 0)
+			return id;
+		id++;
+	}
+
+	return NULL;
+}
+
+static int pci_epf_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct pci_epf_driver *driver = to_pci_epf_driver(drv);
+
+	if (driver->id_table)
+		return pci_epf_match_id(driver->id_table, epf) != NULL;
+
+	return !strcmp(epf->name, drv->name);
+}
+
+static int pci_epf_device_probe(struct device *dev)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
+
+	if (!driver->probe)
+		return -ENODEV;
+
+	epf->driver = driver;
+
+	return driver->probe(epf);
+}
+
+static int pci_epf_device_remove(struct device *dev)
+{
+	int ret;
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
+
+	ret = driver->remove(epf);
+	epf->driver = NULL;
+
+	return ret;
+}
+
+static struct bus_type pci_epf_bus_type = {
+	.name		= "pci-epf",
+	.match		= pci_epf_device_match,
+	.probe		= pci_epf_device_probe,
+	.remove		= pci_epf_device_remove,
+};
+
+static int __init pci_epf_init(void)
+{
+	int ret;
+
+	ret = bus_register(&pci_epf_bus_type);
+	if (ret) {
+		pr_err("failed to register pci epf bus --> %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(pci_epf_init);
+
+static void __exit pci_epf_exit(void)
+{
+	bus_unregister(&pci_epf_bus_type);
+}
+module_exit(pci_epf_exit);
+
+MODULE_DESCRIPTION("PCI EPF Library");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..946cef1 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -427,6 +427,16 @@ struct i2c_device_id {
 	kernel_ulong_t driver_data;	/* Data private to the driver */
 };
 
+/* pci_epf */
+
+#define PCI_EPF_NAME_SIZE	20
+#define PCI_EPF_MODULE_PREFIX	"pci_epf:"
+
+struct pci_epf_device_id {
+	char name[PCI_EPF_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
 /* spi */
 
 #define SPI_NAME_SIZE	32
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
new file mode 100644
index 0000000..78e4178
--- /dev/null
+++ b/include/linux/pci-epc.h
@@ -0,0 +1,100 @@
+/**
+ * pci-epc.h - PCI Endpoint *Controller* (EPC) header file
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ */
+
+#ifndef __DRIVERS_PCI_EPC_H
+#define __DRIVERS_PCI_EPC_H
+
+#include <linux/pci-epf.h>
+
+struct pci_epc;
+
+enum pci_epc_irq_type {
+	PCI_EPC_IRQ_UNKNOWN,
+	PCI_EPC_IRQ_LEGACY,
+	PCI_EPC_IRQ_MSI,
+};
+
+/**
+ * struct pci_epc_ops - set of function pointers for performing EPC operations
+ * @write_header: ops to populate configuration space header
+ * @set_bar: ops to configure the BAR
+ * @clear_bar: ops to reset the BAR
+ * @alloc_addr_space: ops to allocate *in* PCI controller address space
+ * @free_addr_space: ops to free the allocated address space
+ * @raise_irq: ops to raise a legacy or MSI interrupt
+ * @start: ops to start the PCI link
+ * @stop: ops to stop the PCI link
+ * @owner: the module owner containing the ops
+ */
+struct pci_epc_ops {
+	int	(*write_header)(struct pci_epc *pci_epc,
+				struct pci_epf_header *hdr);
+	int	(*set_bar)(struct pci_epc *epc, enum pci_barno bar,
+			   dma_addr_t bar_phys, size_t size, int flags);
+	void	(*clear_bar)(struct pci_epc *epc, enum pci_barno bar);
+	void	*(*alloc_addr_space)(struct pci_epc *pci_epc, size_t size);
+	void	(*free_addr_space)(struct pci_epc *pci_epc);
+	int	(*raise_irq)(struct pci_epc *pci_epc,
+			     enum pci_epc_irq_type type);
+	int	(*start)(struct pci_epc *epc);
+	void	(*stop)(struct pci_epc *epc);
+	struct module *owner;
+};
+
+/**
+ * struct pci_epc - represents the PCI EPC device
+ * @dev: PCI EPC device
+ * @ops: function pointers for performing endpoint operations
+ * @mutex: mutex to protect pci_epc ops
+ */
+struct pci_epc {
+	struct device			dev;
+	/* support only single function PCI device for now */
+	struct pci_epf			*epf;
+	const struct pci_epc_ops	*ops;
+	spinlock_t			irq_lock;
+};
+
+#define to_pci_epc(device) container_of((device), struct pci_epc, dev)
+
+#define pci_epc_create(dev, ops)    \
+		__pci_epc_create((dev), (ops), THIS_MODULE)
+#define devm_pci_epc_create(dev, ops)    \
+		__devm_pci_epc_create((dev), (ops), THIS_MODULE)
+
+static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
+{
+	dev_set_drvdata(&epc->dev, data);
+}
+
+static inline void *epc_get_drvdata(struct pci_epc *epc)
+{
+	return dev_get_drvdata(&epc->dev);
+}
+
+struct pci_epc *
+__devm_pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
+		      struct module *owner);
+struct pci_epc *
+__pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
+		 struct module *owner);
+void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc);
+void pci_epc_destroy(struct pci_epc *epc);
+int pci_epc_write_header(struct pci_epc *epc, struct pci_epf_header *hdr);
+int pci_epc_set_bar(struct pci_epc *epc, enum pci_barno bar,
+		    dma_addr_t bar_phys, size_t size, int flags);
+void pci_epc_clear_bar(struct pci_epc *epc, int bar);
+int pci_epc_raise_irq(struct pci_epc *epc, enum pci_epc_irq_type type);
+int pci_epc_start(struct pci_epc *epc);
+void pci_epc_stop(struct pci_epc *epc);
+int pci_epc_bind_epf(struct pci_epf *epf);
+void pci_epc_unbind_epf(struct pci_epf *epf);
+#endif /* __DRIVERS_PCI_EPC_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
new file mode 100644
index 0000000..337e474
--- /dev/null
+++ b/include/linux/pci-epf.h
@@ -0,0 +1,159 @@
+/**
+ * pci-epf.h - PCI Endpoint *Function* (EPF) header file
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ */
+
+#ifndef __DRIVERS_PCI_EPF_H
+#define __DRIVERS_PCI_EPF_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+struct pci_epf;
+
+enum pci_interrupt_pin {
+	PCI_INTERRUPT_UNKNOWN,
+	PCI_INTERRUPT_INTA,
+	PCI_INTERRUPT_INTB,
+	PCI_INTERRUPT_INTC,
+	PCI_INTERRUPT_INTD,
+};
+
+enum pci_barno {
+	BAR_0,
+	BAR_1,
+	BAR_2,
+	BAR_3,
+	BAR_4,
+	BAR_5,
+};
+
+/**
+ * struct pci_epf_header - represents standard configuration header
+ * @vendorid: identifies device manufacturer
+ * @deviceid: identifies a particular device
+ * @revid: specifies a device specific revision identifier
+ * @progif_code: identifies a specific register-level programming interface
+ * @subclass_code: identifies more specifically the function of the device
+ * @baseclass_code: broadly classifies the type of function the device performs
+ * @cache_line_size: specifies the system cacheline size in units of DWORDs
+ * @subsys_vendor_id: vendor of the add-in card or subsystem
+ * @subsys_id: id specific to vendor
+ * @interrupt_pin: interrupt pin the device (or device function) uses
+ */
+struct pci_epf_header {
+	u16	vendorid;
+	u16	deviceid;
+	u8	revid;
+	u8	progif_code;
+	u8	subclass_code;
+	u8	baseclass_code;
+	u8	cache_line_size;
+	u16	subsys_vendor_id;
+	u16	subsys_id;
+	enum pci_interrupt_pin interrupt_pin;
+};
+
+/**
+ * struct pci_epf_ops - set of function pointers for performing EPF operations
+ * @bind: ops to perform when a EPC device has been bound to EPF device
+ * @unbind: ops to perform when a binding has been lost between a EPC device
+ *	    and EPF device
+ * @linkup: ops to perform when the EPC device has established a connection with
+ *	    a host system
+ */
+struct pci_epf_ops {
+	int	(*bind)(struct pci_epf *epf);
+	void	(*unbind)(struct pci_epf *epf);
+	void	(*linkup)(struct pci_epf *epf);
+};
+
+/**
+ * struct pci_epf_driver - represents the PCI EPF driver
+ * @probe: ops to perform when a new EPF device has been bound to the EPF driver
+ * @remove: ops to perform when the binding between the EPF device and EPF
+ *	    driver is broken
+ * @driver: PCI EPF driver
+ * @ops: set of function pointers for performing EPF operations
+ * @owner: the owner of the module that registers the PCI EPF driver
+ * @id_table: identifies EPF devices for probing
+ */
+struct pci_epf_driver {
+	int	(*probe)(struct pci_epf *epf);
+	int	(*remove)(struct pci_epf *epf);
+
+	struct device_driver	driver;
+	struct pci_epf_ops	*ops;
+	struct module		*owner;
+	const struct pci_epf_device_id	*id_table;
+};
+
+#define to_pci_epf_driver(drv) (container_of((drv), struct pci_epf_driver, \
+				driver))
+
+/**
+ * struct pci_epf_bar - represents the BAR of EPF device
+ * @phys_addr: physical address that should be mapped to the BAR
+ * @size: the size of the address space present in BAR
+ */
+struct pci_epf_bar {
+	dma_addr_t	phys_addr;
+	size_t		size;
+};
+
+/**
+ * struct pci_epf - represents the PCI EPF device
+ * @dev: the PCI EPF device
+ * @name: the name of the PCI EPF device
+ * @header: represents standard configuration header
+ * @bar: represents the BAR of EPF device
+ * @epc: the EPC device to which this EPF device is bound
+ * @driver: the EPF driver to which this EPF device is bound
+ * @pci_epc_name: the name of the EPC device to which this EPF device is bound
+ * @hw_devname: the name of the peripheral device associated with this EPF
+ *		device
+ */
+struct pci_epf {
+	struct device		dev;
+	const char		*name;
+	struct pci_epf_header	*header;
+	struct pci_epf_bar	bar[6];
+
+	struct pci_epc		*epc;
+	struct pci_epf_driver	*driver;
+	const char		*pci_epc_name;
+	const char		*hw_devname;
+};
+
+#define to_pci_epf(dev) container_of((dev), struct pci_epf, dev)
+
+#define pci_epf_register_driver(driver)    \
+		__pci_epf_register_driver((driver), THIS_MODULE)
+
+static inline void epf_set_drvdata(struct pci_epf *epf, void *data)
+{
+	dev_set_drvdata(&epf->dev, data);
+}
+
+static inline void *epf_get_drvdata(struct pci_epf *epf)
+{
+	return dev_get_drvdata(&epf->dev);
+}
+
+struct pci_epf *pci_epf_create(const char *name);
+void pci_epf_destroy(struct pci_epf *epf);
+int __pci_epf_register_driver(struct pci_epf_driver *driver,
+			      struct module *owner);
+void pci_epf_unregister_driver(struct pci_epf_driver *driver);
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar);
+void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
+int pci_epf_bind(struct pci_epf *epf);
+void pci_epf_unbind(struct pci_epf *epf);
+void pci_epf_linkup(struct pci_epf *epf);
+#endif /* __DRIVERS_PCI_EPF_H */
-- 
1.7.9.5

