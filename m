Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:47987 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab3DLUsR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:48:17 -0400
Received: by mail-ia0-f171.google.com with SMTP id f27so884160iae.16
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:48:16 -0700 (PDT)
Subject: [PATCH 5/6] PCI: Warn about failures instead of "must_check" functions
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:48:14 -0600
Message-ID: <20130412204814.5237.92891.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These places capture return values to avoid "must_check" warnings,
but we didn't *do* anything with the return values, which causes
"set but not used" warnings.  We might as well do something instead
of just trying to evade the "must_check" warnings.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c       |    3 +++
 drivers/pci/setup-bus.c |    2 ++
 drivers/pci/slot.c      |    7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index e54ddb5..91b3c55 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -204,6 +204,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 		if (dev->is_added)
 			continue;
 		retval = pci_bus_add_device(dev);
+		if (retval)
+			dev_err(&dev->dev, "Error adding device (%d)\n",
+				retval);
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 502a75e..16abaaa 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1545,6 +1545,8 @@ again:
 
 enable_all:
 	retval = pci_reenable_device(bridge);
+	if (retval)
+		dev_err(&bridge->dev, "Error reenabling bridge (%d)\n", retval);
 	pci_set_master(bridge);
 	pci_enable_bridges(parent);
 }
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index ac6412f..c1e9284 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -377,14 +377,17 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 	struct kobject *kobj = NULL;
-	int no_warn;
+	int ret;
 
 	if (!slot || !slot->ops)
 		return;
 	kobj = kset_find_obj(module_kset, slot->ops->mod_name);
 	if (!kobj)
 		return;
-	no_warn = sysfs_create_link(&pci_slot->kobj, kobj, "module");
+	ret = sysfs_create_link(&pci_slot->kobj, kobj, "module");
+	if (ret)
+		dev_err(&pci_slot->bus->dev, "Error creating sysfs link (%d)\n",
+			ret);
 	kobject_put(kobj);
 }
 EXPORT_SYMBOL_GPL(pci_hp_create_module_link);

