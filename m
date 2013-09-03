Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54115 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761165Ab3ICWiT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2013 18:38:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so6636546pbb.33
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2013 15:38:18 -0700 (PDT)
Date: Tue, 3 Sep 2013 15:38:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Greg KH <gregkh@linux-foundation.org>
Cc: linux-pci@vger.kernel.org
Subject: [RFC] pci: crash on pci_unregister_driver after pci_register_driver
 fails
Message-ID: <20130903153815.13638272@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While debugging another problem with a PCI driver, I noticed that if
device probe routine returns an error, the kernel will crash when module
is unloaded. It looks like pci_register_driver() sets drv->bus to be PCI
then in the module unload.

module_unload
   my_device_exit_module
      pci_unregister_driver
         bus_remove_driver
           OOPS

One way to fix this would be to have pci_register_driver clear the bus
flag (it has no reference) if an error was detected.

--- a/drivers/pci/pci-driver.c	2013-07-08 10:54:52.968241742 -0700
+++ b/drivers/pci/pci-driver.c	2013-09-03 15:34:10.112477893 -0700
@@ -1120,6 +1120,8 @@ const struct dev_pm_ops pci_dev_pm_ops =
 int __pci_register_driver(struct pci_driver *drv, struct module *owner,
 			  const char *mod_name)
 {
+	int err;
+
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pci_bus_type;
@@ -1130,7 +1132,11 @@ int __pci_register_driver(struct pci_dri
 	INIT_LIST_HEAD(&drv->dynids.list);
 
 	/* register with core */
-	return driver_register(&drv->driver);
+	err = driver_register(&drv->driver);
+	if (err)
+		drv->driver.bus = NULL;
+
+	return err;
 }
 
 /**
