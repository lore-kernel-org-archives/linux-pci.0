Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59234 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752758Ab2AXTfO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2012 14:35:14 -0500
Date: Tue, 24 Jan 2012 14:35:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	<linux-pci@vger.kernel.org>, <linux-pcmcia@lists.infradead.org>,
	USB list <linux-usb@vger.kernel.org>
Subject: [PATCH resend] Clean up new_id and remove_id sysfs attribute routines
Message-ID: <Pine.LNX.4.44L0.1201241433200.1200-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch (as1514) cleans up some places where new_id and remove_id
sysfs attributes are created and deleted.  Handling both attributes in
a single routine rather than a pair of routines makes the code
smaller.  It also prevents certain kinds of errors, like one we
currently have in the USB subsystem: The removeid attribute is often
created even when newid isn't (because the driver's no_dynamid_id flag
is set).

In the case of the PCMCIA subsystem, the newid attribute is created
but never explicitly deleted.  The patch adds a deletion routine.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Dominik Brodowski <linux@dominikbrodowski.net>

---

With a real Subject: line this time, sorry about the earlier one.


 drivers/pci/pci-driver.c  |   50 ++++++++++++-------------------------
 drivers/pcmcia/ds.c       |    6 ++++
 drivers/usb/core/driver.c |   61 +++++++++++++++-------------------------------
 3 files changed, 43 insertions(+), 74 deletions(-)

Index: usb-3.3/drivers/pci/pci-driver.c
===================================================================
--- usb-3.3.orig/drivers/pci/pci-driver.c
+++ usb-3.3/drivers/pci/pci-driver.c
@@ -188,43 +188,34 @@ store_remove_id(struct device_driver *dr
 static DRIVER_ATTR(remove_id, S_IWUSR, NULL, store_remove_id);
 
 static int
-pci_create_newid_file(struct pci_driver *drv)
+pci_create_newid_files(struct pci_driver *drv)
 {
 	int error = 0;
-	if (drv->probe != NULL)
-		error = driver_create_file(&drv->driver, &driver_attr_new_id);
-	return error;
-}
-
-static void pci_remove_newid_file(struct pci_driver *drv)
-{
-	driver_remove_file(&drv->driver, &driver_attr_new_id);
-}
 
-static int
-pci_create_removeid_file(struct pci_driver *drv)
-{
-	int error = 0;
-	if (drv->probe != NULL)
-		error = driver_create_file(&drv->driver,&driver_attr_remove_id);
+	if (drv->probe != NULL) {
+		error = driver_create_file(&drv->driver, &driver_attr_new_id);
+		if (error == 0) {
+			error = driver_create_file(&drv->driver,
+					&driver_attr_remove_id);
+			if (error)
+				driver_remove_file(&drv->driver,
+						&driver_attr_new_id);
+		}
+	}
 	return error;
 }
 
-static void pci_remove_removeid_file(struct pci_driver *drv)
+static void pci_remove_newid_files(struct pci_driver *drv)
 {
 	driver_remove_file(&drv->driver, &driver_attr_remove_id);
+	driver_remove_file(&drv->driver, &driver_attr_new_id);
 }
 #else /* !CONFIG_HOTPLUG */
-static inline int pci_create_newid_file(struct pci_driver *drv)
+static inline int pci_create_newid_files(struct pci_driver *drv)
 {
 	return 0;
 }
-static inline void pci_remove_newid_file(struct pci_driver *drv) {}
-static inline int pci_create_removeid_file(struct pci_driver *drv)
-{
-	return 0;
-}
-static inline void pci_remove_removeid_file(struct pci_driver *drv) {}
+static inline void pci_remove_newid_files(struct pci_driver *drv) {}
 #endif
 
 /**
@@ -1136,18 +1127,12 @@ int __pci_register_driver(struct pci_dri
 	if (error)
 		goto out;
 
-	error = pci_create_newid_file(drv);
+	error = pci_create_newid_files(drv);
 	if (error)
 		goto out_newid;
-
-	error = pci_create_removeid_file(drv);
-	if (error)
-		goto out_removeid;
 out:
 	return error;
 
-out_removeid:
-	pci_remove_newid_file(drv);
 out_newid:
 	driver_unregister(&drv->driver);
 	goto out;
@@ -1166,8 +1151,7 @@ out_newid:
 void
 pci_unregister_driver(struct pci_driver *drv)
 {
-	pci_remove_removeid_file(drv);
-	pci_remove_newid_file(drv);
+	pci_remove_newid_files(drv);
 	driver_unregister(&drv->driver);
 	pci_free_dynids(drv);
 }
Index: usb-3.3/drivers/pcmcia/ds.c
===================================================================
--- usb-3.3.orig/drivers/pcmcia/ds.c
+++ usb-3.3/drivers/pcmcia/ds.c
@@ -157,6 +157,11 @@ pcmcia_create_newid_file(struct pcmcia_d
 	return error;
 }
 
+static void
+pcmcia_remove_newid_file(struct pcmcia_driver *drv)
+{
+	driver_remove_file(&drv->drv, &driver_attr_new_id);
+}
 
 /**
  * pcmcia_register_driver - register a PCMCIA driver with the bus core
@@ -201,6 +206,7 @@ EXPORT_SYMBOL(pcmcia_register_driver);
 void pcmcia_unregister_driver(struct pcmcia_driver *driver)
 {
 	pr_debug("unregistering driver %s\n", driver->name);
+	pcmcia_remove_newid_file(driver);
 	driver_unregister(&driver->drv);
 	pcmcia_free_dynids(driver);
 }
Index: usb-3.3/drivers/usb/core/driver.c
===================================================================
--- usb-3.3.orig/drivers/usb/core/driver.c
+++ usb-3.3/drivers/usb/core/driver.c
@@ -129,43 +129,39 @@ store_remove_id(struct device_driver *dr
 }
 static DRIVER_ATTR(remove_id, S_IWUSR, NULL, store_remove_id);
 
-static int usb_create_newid_file(struct usb_driver *usb_drv)
+static int usb_create_newid_files(struct usb_driver *usb_drv)
 {
 	int error = 0;
 
 	if (usb_drv->no_dynamic_id)
 		goto exit;
 
-	if (usb_drv->probe != NULL)
+	if (usb_drv->probe != NULL) {
 		error = driver_create_file(&usb_drv->drvwrap.driver,
 					   &driver_attr_new_id);
+		if (error == 0) {
+			error = driver_create_file(&usb_drv->drvwrap.driver,
+					&driver_attr_remove_id);
+			if (error)
+				driver_remove_file(&usb_drv->drvwrap.driver,
+						&driver_attr_new_id);
+		}
+	}
 exit:
 	return error;
 }
 
-static void usb_remove_newid_file(struct usb_driver *usb_drv)
+static void usb_remove_newid_files(struct usb_driver *usb_drv)
 {
 	if (usb_drv->no_dynamic_id)
 		return;
 
-	if (usb_drv->probe != NULL)
+	if (usb_drv->probe != NULL) {
 		driver_remove_file(&usb_drv->drvwrap.driver,
-				   &driver_attr_new_id);
-}
-
-static int
-usb_create_removeid_file(struct usb_driver *drv)
-{
-	int error = 0;
-	if (drv->probe != NULL)
-		error = driver_create_file(&drv->drvwrap.driver,
 				&driver_attr_remove_id);
-	return error;
-}
-
-static void usb_remove_removeid_file(struct usb_driver *drv)
-{
-	driver_remove_file(&drv->drvwrap.driver, &driver_attr_remove_id);
+		driver_remove_file(&usb_drv->drvwrap.driver,
+				   &driver_attr_new_id);
+	}
 }
 
 static void usb_free_dynids(struct usb_driver *usb_drv)
@@ -180,22 +176,12 @@ static void usb_free_dynids(struct usb_d
 	spin_unlock(&usb_drv->dynids.lock);
 }
 #else
-static inline int usb_create_newid_file(struct usb_driver *usb_drv)
-{
-	return 0;
-}
-
-static void usb_remove_newid_file(struct usb_driver *usb_drv)
-{
-}
-
-static int
-usb_create_removeid_file(struct usb_driver *drv)
+static inline int usb_create_newid_files(struct usb_driver *usb_drv)
 {
 	return 0;
 }
 
-static void usb_remove_removeid_file(struct usb_driver *drv)
+static void usb_remove_newid_files(struct usb_driver *usb_drv)
 {
 }
 
@@ -872,22 +858,16 @@ int usb_register_driver(struct usb_drive
 
 	usbfs_update_special();
 
-	retval = usb_create_newid_file(new_driver);
+	retval = usb_create_newid_files(new_driver);
 	if (retval)
 		goto out_newid;
 
-	retval = usb_create_removeid_file(new_driver);
-	if (retval)
-		goto out_removeid;
-
 	pr_info("%s: registered new interface driver %s\n",
 			usbcore_name, new_driver->name);
 
 out:
 	return retval;
 
-out_removeid:
-	usb_remove_newid_file(new_driver);
 out_newid:
 	driver_unregister(&new_driver->drvwrap.driver);
 
@@ -914,10 +894,9 @@ void usb_deregister(struct usb_driver *d
 	pr_info("%s: deregistering interface driver %s\n",
 			usbcore_name, driver->name);
 
-	usb_remove_removeid_file(driver);
-	usb_remove_newid_file(driver);
-	usb_free_dynids(driver);
+	usb_remove_newid_files(driver);
 	driver_unregister(&driver->drvwrap.driver);
+	usb_free_dynids(driver);
 
 	usbfs_update_special();
 }

