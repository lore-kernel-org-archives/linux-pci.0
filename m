Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 04/12] PCI/AER: Abstract AER interrupt handling
Date: Tue, 18 Sep 2018 17:58:40 -0600
Message-Id: <20180918235848.26694-5-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aer_inject module was directly calling aer_irq. This required the
aer driver export its private irq handler for no other reason than to
support error injection. A driver should not have to expose its private
interfaces, so this patch uses the irq subsystem to route injection to
the aer driver, and makes the aer_irq handler a private interface.

This are additional benefits this provides.

First, directly calling the irq handler bypasses the IRQ subsytem so
the injection wasn't really synthesizing what happens if a shared AER
interrupt occurs.

The error injection had to provide the callback data directly, which
may be racing with a removal that is freeing that structure. The irq
subsystem can handle that race.

Finally, if we ever need to modify the aer interrupt handling, for
example, to use threaded IRQs for the benefits those provide, abstracting
the interface from the error injection will make that easier to modify.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c        | 3 +--
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 drivers/pci/pcie/portdrv.h    | 4 ----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6b59a23568f8..1318483a080c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1270,7 +1270,7 @@ static void aer_isr(struct work_struct *work)
  *
  * Invoked when Root Port detects AER messages.
  */
-irqreturn_t aer_irq(int irq, void *context)
+static irqreturn_t aer_irq(int irq, void *context)
 {
 	unsigned int status, id;
 	struct pcie_device *pdev = (struct pcie_device *)context;
@@ -1319,7 +1319,6 @@ irqreturn_t aer_irq(int irq, void *context)
 
 	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL_GPL(aer_irq);
 
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 7d641a543194..57821bb61c2a 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ftrace.h>
+#include <linux/irq.h>
 #include <linux/kallsyms.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
@@ -348,7 +349,9 @@ static int aer_inject(struct aer_error_inj *einj)
 		dev_info(&edev->device,
 			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
-		aer_irq(-1, edev);
+		local_irq_disable();
+		generic_handle_irq(edev->irq);
+		local_irq_enable();
 	} else {
 		pci_err(rpdev, "aer_inject: AER device not found\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..127b8b246437 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -123,10 +123,6 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
-#ifdef CONFIG_PCIEAER
-irqreturn_t aer_irq(int irq, void *context);
-#endif
-
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
-- 
2.14.4
