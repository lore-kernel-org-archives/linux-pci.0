Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60623 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab1KRSO3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 13:14:29 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E589820C76
	for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2011 13:14:28 -0500 (EST)
Date: Fri, 18 Nov 2011 10:12:49 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <balbi@ti.com>
Subject: [PATCH] PCI: Add helper macro for pci_register_driver boilerplate
Message-ID: <20111118181249.GA29495@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Greg Kroah-Hartman <gregkh@suse.de>

This patch introduces the module_pci_driver macro which is a convenience
macro for PCI driver modules similar to module_platform_driver. It is
intended to be used by drivers which init/exit section does nothing but
register/unregister the PCI driver. By using this macro it is possible
to eliminate a few lines of boilerplate code per PCI driver.

Based on work done by Lars-Peter Clausen <lars@metafoo.de> for other
busses (i2c and spi).

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

Jesse, I've added the same type of macros for i2c, spi, and usb to my
driver-core tree, and converted a number of drivers to these new macros.
If you give me the ack, I can add this patch to my tree as well.

I'll follow up this patch with an example showing how it works.

Comments?

 include/linux/pci.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -941,6 +941,19 @@ int __must_check __pci_register_driver(struct pci_driver *, struct module *,
 	__pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
 
 void pci_unregister_driver(struct pci_driver *dev);
+
+/**
+ * module_pci_driver() - Helper macro for registering a PCI driver
+ * @__pci_driver: pci_driver struct
+ *
+ * Helper macro for PCI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_pci_driver(__pci_driver) \
+	module_driver(__pci_driver, pci_register_driver, \
+		       pci_unregister_driver)
+
 void pci_remove_behind_bridge(struct pci_dev *dev);
 struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
 int pci_add_dynid(struct pci_driver *drv,
