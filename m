Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCH 03/12] PCI/AER: Reuse existing service device lookup
Date: Tue, 18 Sep 2018 17:58:39 -0600
Message-Id: <20180918235848.26694-4-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The port services driver already provides a method to find the pcie_device
for a service. This patch exports the function and uses it from the
aer_inject module and removes the duplicate functionality.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer_inject.c   | 25 ++++---------------------
 drivers/pci/pcie/portdrv_core.c |  1 +
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 6f8b96499f44..7d641a543194 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -201,32 +201,13 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 	return -1;
 }
 
-static int find_aer_device_iter(struct device *device, void *data)
-{
-	struct pcie_device **result = data;
-	struct pcie_device *pcie_dev;
-
-	if (device->bus == &pcie_port_bus_type) {
-		pcie_dev = to_pcie_device(device);
-		if (pcie_dev->service & PCIE_PORT_SERVICE_AER) {
-			*result = pcie_dev;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-static int find_aer_device(struct pci_dev *dev, struct pcie_device **result)
-{
-	return device_for_each_child(&dev->dev, result, find_aer_device_iter);
-}
-
 static int aer_inject(struct aer_error_inj *einj)
 {
 	struct aer_error *err, *rperr;
 	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
 	struct pci_dev *dev, *rpdev;
 	struct pcie_device *edev;
+	struct device *device;
 	unsigned long flags;
 	unsigned int devfn = PCI_DEVFN(einj->dev, einj->fn);
 	int pos_cap_err, rp_pos_cap_err;
@@ -355,7 +336,9 @@ static int aer_inject(struct aer_error_inj *einj)
 				       uncor_mask_orig);
 	}
 
-	if (find_aer_device(rpdev, &edev)) {
+	device = pcie_port_find_device(rpdev, PCIE_PORT_SERVICE_AER);
+	if (device) {
+		edev = to_pcie_device(device);
 		if (!get_service_data(edev)) {
 			dev_warn(&edev->device,
 				 "aer_inject: AER service is not initialized\n");
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 7c37d815229e..5508285a0bff 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -466,6 +466,7 @@ struct device *pcie_port_find_device(struct pci_dev *dev,
 	device = pdrvs.dev;
 	return device;
 }
+EXPORT_SYMBOL_GPL(pcie_port_find_device);
 
 /**
  * pcie_port_device_remove - unregister PCI Express port service devices
-- 
2.14.4
