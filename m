Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: create builtin_pci_driver to avoid registration boilerplate
Date: Tue, 25 Aug 2015 20:25:37 -0400
Message-ID: <1440548737-7465-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
better support builtin boilerplate avoidance") we introduced the
builtin_driver macro.

Here we use that support and extend it to PCI driver registration,
so where a driver is clearly non-modular and builtin-only, we can
register it in a similar fashion.  And existing code that is clearly
non-modular can be updated with the simple mapping of

     module_pci_driver(...)  ---> builtin_pci_driver(...)

We've essentially cloned the former to make the latter, and taken
out the remove/module_exit parts since those never get used in a
non-modular build of the code.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/pci.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 88bee285b93d..8da2758e7d0e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1187,6 +1187,17 @@ void pci_unregister_driver(struct pci_driver *dev);
 	module_driver(__pci_driver, pci_register_driver, \
 		       pci_unregister_driver)
 
+/**
+ * builtin_pci_driver() - Helper macro for registering a PCI driver
+ * @__pci_driver: pci_driver struct
+ *
+ * Helper macro for PCI drivers which do not do anything special in their
+ * init code. This eliminates a lot of boilerplate. Each driver may only
+ * use this macro once, and calling it replaces device_initcall(...)
+ */
+#define builtin_pci_driver(__pci_driver) \
+	builtin_driver(__pci_driver, pci_register_driver)
+
 struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
 int pci_add_dynid(struct pci_driver *drv,
 		  unsigned int vendor, unsigned int device,
-- 
2.5.0

