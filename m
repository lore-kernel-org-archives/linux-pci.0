Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:35723 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab3DLUrz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:47:55 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so472491iad.35
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:47:55 -0700 (PDT)
Subject: [PATCH 2/6] PCI: Remove unused variables
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:47:51 -0600
Message-ID: <20130412204751.5237.1749.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes "set but not used" warnings found via "make W=1".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |    2 --
 drivers/pci/pcie/portdrv_pci.c         |   17 +++++------------
 drivers/pci/setup-res.c                |    2 --
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 202f4a9..d9a528f 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -527,10 +527,8 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
 int __must_check pci_hp_change_slot_info(struct hotplug_slot *hotplug,
 					 struct hotplug_slot_info *info)
 {
-	struct pci_slot *slot;
 	if (!hotplug || !info)
 		return -ENODEV;
-	slot = hotplug->pci_slot;
 
 	memcpy(hotplug->info, info, sizeof(struct hotplug_slot_info));
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 08c243a..0efba05 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -272,11 +272,9 @@ static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 					enum pci_channel_state error)
 {
 	struct aer_broadcast_data data = {error, PCI_ERS_RESULT_CAN_RECOVER};
-	int ret;
-
-	/* can not fail */
-	ret = device_for_each_child(&dev->dev, &data, error_detected_iter);
 
+	/* get true return value from &data */
+	device_for_each_child(&dev->dev, &data, error_detected_iter);
 	return data.result;
 }
 
@@ -308,10 +306,9 @@ static int mmio_enabled_iter(struct device *device, void *data)
 static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int retval;
 
 	/* get true return value from &status */
-	retval = device_for_each_child(&dev->dev, &status, mmio_enabled_iter);
+	device_for_each_child(&dev->dev, &status, mmio_enabled_iter);
 	return status;
 }
 
@@ -343,7 +340,6 @@ static int slot_reset_iter(struct device *device, void *data)
 static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int retval;
 
 	/* If fatal, restore cfg space for possible link reset at upstream */
 	if (dev->error_state == pci_channel_io_frozen) {
@@ -354,8 +350,7 @@ static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
 	}
 
 	/* get true return value from &status */
-	retval = device_for_each_child(&dev->dev, &status, slot_reset_iter);
-
+	device_for_each_child(&dev->dev, &status, slot_reset_iter);
 	return status;
 }
 
@@ -381,9 +376,7 @@ static int resume_iter(struct device *device, void *data)
 
 static void pcie_portdrv_err_resume(struct pci_dev *dev)
 {
-	int retval;
-	/* nothing to do with error value, if it ever happens */
-	retval = device_for_each_child(&dev->dev, NULL, resume_iter);
+	device_for_each_child(&dev->dev, NULL, resume_iter);
 }
 
 /*
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 81b88bd..07f2edd 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -261,7 +261,6 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = dev->resource + resno;
 	resource_size_t align, size;
-	struct pci_bus *bus;
 	int ret;
 
 	align = pci_resource_alignment(dev, res);
@@ -271,7 +270,6 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 		return -EINVAL;
 	}
 
-	bus = dev->bus;
 	size = resource_size(res);
 	ret = _pci_assign_resource(dev, resno, size, align);
 

