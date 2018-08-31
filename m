Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:59297 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbeHaVmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 17:42:46 -0400
Subject: [PATCH for-rc 2/2] IB/hfi1,PCI: Allow bus reset while probing
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
To: bhelgaas@google.com, jgg@ziepe.ca, dledford@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Fri, 31 Aug 2018 10:34:14 -0700
Message-ID: <20180831173411.21741.65388.stgit@scvm10.sc.intel.com>
In-Reply-To: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
References: <20180831173132.21741.25892.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Calling into the new API to reset the secondary bus results in a
deadlock. This occurs because the device/bus is already locked at
probe time. Reverting back to the old behavior while the API is
improved.

Fixes: c6a44ba950d1 ("PCI: Rename pci_try_reset_bus() to pci_reset_bus()")
Fixes: 409888e0966e ("IB/hfi1: Use pci_try_reset_bus() for initiating PCI Secondary Bus Reset")
Cc: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/pcie.c |   11 ++++-------
 drivers/pci/pci.c                 |    1 +
 include/linux/pci.h               |    3 +++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index eec8375..6c967dd 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -893,14 +893,11 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 		}
 
 	/*
-	 * A secondary bus reset (SBR) issues a hot reset to our device.
-	 * The following routine does a 1s wait after the reset is dropped
-	 * per PCI Trhfa (recovery time).  PCIe 3.0 section 6.6.1 -
-	 * Conventional Reset, paragraph 3, line 35 also says that a 1s
-	 * delay after a reset is required.  Per spec requirements,
-	 * the link is either working or not after that point.
+	 * This is an end around to do an SBR during probe time. A new API needs
+	 * to be implemented to have cleaner interface but this fixes the
+	 * current brokenness
 	 */
-	return pci_reset_bus(dev);
+	return pci_bridge_secondary_bus_reset(dev->bus->self);
 }
 
 /*
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 30b2603..1835f3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4547,6 +4547,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 
 	return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
 }
+EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
 static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8d..6925828 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1235,6 +1235,9 @@ void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
 int devm_request_pci_bus_resources(struct device *dev,
 				   struct list_head *resources);
 
+/* Temporary until new and working PCI SBR API in place */
+int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+
 #define pci_bus_for_each_resource(bus, res, i)				\
 	for (i = 0;							\
 	    (res = pci_bus_resource_n(bus, i)) || i < PCI_BRIDGE_RESOURCE_NUM; \
