Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933672AbcIFWUT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:20:19 -0400
Subject: [PATCH 2/2] PCI/AER: Remove aerdriver.forceload kernel parameter
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lance Ortiz <lance.ortiz@hpe.com>, Betty Dall <betty.dall@hpe.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        KeithBuschkeith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Huang Ying <ying.huang@intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hpe.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Date: Tue, 06 Sep 2016 17:20:04 -0500
Message-ID: <20160906222004.23655.39092.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per the PCI Firmware spec, r3.0, sec 4.5.1, on ACPI systems, the OS must
not use AER unless _OSC is present and _OSC grants AER control to the OS.
The aerdriver.forceload kernel parameter was a way to enable Linux AER
support on ACPI systems that lack _OSC or fail to grant control the the OS.

Enabling Linux AER support when the firmware doesn't want us to is a recipe
for problems, e.g., the firmware might be handling AER itself.

Remove the aerdriver.forceload kernel parameter and related supporting
code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pcieaer-howto.txt |   22 +++++++++-------------
 drivers/pci/pcie/aer/aerdrv.c       |    7 +------
 drivers/pci/pcie/aer/aerdrv.h       |    8 --------
 drivers/pci/pcie/aer/aerdrv_core.c  |   19 -------------------
 4 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.txt b/Documentation/PCI/pcieaer-howto.txt
index 4956df3..ea8cafb 100644
--- a/Documentation/PCI/pcieaer-howto.txt
+++ b/Documentation/PCI/pcieaer-howto.txt
@@ -49,21 +49,17 @@ depends on CONFIG_PCIEPORTBUS, so pls. set CONFIG_PCIEPORTBUS=y and
 CONFIG_PCIEAER = y.
 
 2.2 Load PCI Express AER Root Driver
-There is a case where a system has AER support in BIOS. Enabling the AER
-Root driver and having AER support in BIOS may result unpredictable
-behavior. To avoid this conflict, a successful load of the AER Root driver
-requires ACPI _OSC support in the BIOS to allow the AER Root driver to
-request for native control of AER. See the PCI FW 3.0 Specification for
-details regarding OSC usage. Currently, lots of firmwares don't provide
-_OSC support while they use PCI Express. To support such firmwares,
-forceload, a parameter of type bool, could enable AER to continue to
-be initiated although firmwares have no _OSC support. To enable the
-walkaround, pls. add aerdriver.forceload=y to kernel boot parameter line
-when booting kernel. Note that forceload=n by default.
+
+Some systems have AER support in firmware. Enabling Linux AER support at
+the same time the firmware handles AER may result in unpredictable
+behavior. Therefore, Linux does not handle AER events unless the firmware
+grants AER control to the OS via the ACPI _OSC method. See the PCI FW 3.0
+Specification for details regarding _OSC usage.
 
 2.3 AER error output
-When a PCI-E AER error is captured, an error message will be outputted to
-console. If it's a correctable error, it is outputted as a warning.
+
+When a PCIe AER error is captured, an error message will be output to
+console. If it's a correctable error, it is output as a warning.
 Otherwise, it is printed as an error. So users could choose different
 log level to filter out correctable error messages.
 
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0..08ce257 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -70,7 +70,7 @@ static int pcie_aer_disable;
 
 void pci_no_aer(void)
 {
-	pcie_aer_disable = 1;	/* has priority over 'forceload' */
+	pcie_aer_disable = 1;
 }
 
 bool pci_aer_available(void)
@@ -304,11 +304,6 @@ static int aer_probe(struct pcie_device *dev)
 	struct aer_rpc *rpc;
 	struct device *device = &dev->device;
 
-	/* Init */
-	status = aer_init(dev);
-	if (status)
-		return status;
-
 	/* Alloc rpc data structure */
 	rpc = aer_alloc_rpc(dev);
 	if (!rpc) {
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 945c939..f15ca8d 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -105,7 +105,6 @@ static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
 }
 
 extern struct bus_type pcie_port_bus_type;
-int aer_init(struct pcie_device *dev);
 void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
@@ -121,11 +120,4 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 	return 0;
 }
 #endif
-
-static inline void pcie_aer_force_firmware_first(struct pci_dev *pci_dev,
-						 int enable)
-{
-	pci_dev->__aer_firmware_first = !!enable;
-	pci_dev->__aer_firmware_first_valid = 1;
-}
 #endif /* _AERDRV_H_ */
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index f8a9b17..8262527 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -27,9 +27,6 @@
 #include <linux/kfifo.h>
 #include "aerdrv.h"
 
-static bool forceload;
-module_param(forceload, bool, 0);
-
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -811,19 +808,3 @@ void aer_isr(struct work_struct *work)
 		aer_isr_one_error(p_device, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
 }
-
-/**
- * aer_init - provide AER initialization
- * @dev: pointer to AER pcie device
- *
- * Invoked when AER service driver is loaded.
- */
-int aer_init(struct pcie_device *dev)
-{
-	if (forceload) {
-		dev_printk(KERN_DEBUG, &dev->device,
-			   "aerdrv forceload requested.\n");
-		pcie_aer_force_firmware_first(dev->port, 0);
-	}
-	return 0;
-}

