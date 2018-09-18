Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeISFd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:33:59 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 11/12] PCI/AER: Use managed resource allocations
Date: Tue, 18 Sep 2018 17:58:47 -0600
Message-Id: <20180918235848.26694-12-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This uses the managed device resource allocations for the service data
so that the aer driver doesn't need to manage it, further simplifying
this driver.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1878d9d7760b..7ecad011458d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,11 +1366,7 @@ static void aer_remove(struct pcie_device *dev)
 {
 	struct aer_rpc *rpc = get_service_data(dev);
 
-	if (rpc) {
-		aer_disable_rootport(rpc);
-		kfree(rpc);
-		set_service_data(dev, NULL);
-	}
+	aer_disable_rootport(rpc);
 }
 
 /**
@@ -1383,10 +1379,9 @@ static int aer_probe(struct pcie_device *dev)
 {
 	int status;
 	struct aer_rpc *rpc;
-	struct device *device = &dev->port->device;
+	struct device *device = &dev->device;
 
-	/* Alloc rpc data structure */
-	rpc = kzalloc(sizeof(struct aer_rpc), GFP_KERNEL);
+	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
 		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
 		return -ENOMEM;
@@ -1394,13 +1389,11 @@ static int aer_probe(struct pcie_device *dev)
 	rpc->rpd = dev->port;
 	set_service_data(dev, rpc);
 
-	/* Request IRQ ISR */
-	status = request_threaded_irq(dev->irq, aer_irq, aer_isr,
-				      IRQF_SHARED, "aerdrv", dev);
+	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
+					   IRQF_SHARED, "aerdrv", dev);
 	if (status) {
 		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
 			   dev->irq);
-		aer_remove(dev);
 		return status;
 	}
 
-- 
2.14.4
