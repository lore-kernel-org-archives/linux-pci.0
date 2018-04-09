Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41630 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDIWCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:08 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex_Gagniuc@Dellteam.com, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/4] PCI/AER: Lock pci topology when scanning errors
Date: Mon,  9 Apr 2018 16:04:44 -0600
Message-Id: <20180409220444.6632-5-keith.busch@intel.com>
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The side effects of surprise removal may trigger AER handling. The AER
handling walks the pci topology and may access a pci_dev that is being
freed by the hotplug handler.

This patch fixes that use-after-free by locking the PCI topology in
the AER handler so it isn't racing with the pciehp removal.

Since the AER handler now runs under a global PCI lock, the rpc specific
mutex is no longer necessary.

Reported-by: Alex Gagniuc <Alex_Gagniuc@Dellteam.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.c      | 1 -
 drivers/pci/pcie/aer/aerdrv.h      | 5 -----
 drivers/pci/pcie/aer/aerdrv_core.c | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 0b2eb88c422b..b88e5e2f3700 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -237,7 +237,6 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	rpc->rpd = pci_dev_get(dev->port);
 	kref_init(&rpc->ref);
 	INIT_WORK(&rpc->dpc_handler, aer_isr);
-	mutex_init(&rpc->rpc_mutex);
 
 	/* Use PCIe bus function to store rpc into PCIe device */
 	set_service_data(dev, rpc);
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index f886521e2c7b..b90fc5d4cda2 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -70,11 +70,6 @@ struct aer_rpc {
 					 * Lock access to Error Status/ID Regs
 					 * and error producer/consumer index
 					 */
-	struct mutex rpc_mutex;		/*
-					 * only one thread could do
-					 * recovery on the same
-					 * root port hierarchy
-					 */
 };
 
 struct aer_broadcast_data {
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index e4059d7fa7fa..de210b7439eb 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -796,10 +796,10 @@ void aer_isr(struct work_struct *work)
 	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
 	struct aer_err_source uninitialized_var(e_src);
 
-	mutex_lock(&rpc->rpc_mutex);
+	pci_lock_rescan_remove();
 	while (get_e_source(rpc, &e_src))
 		aer_isr_one_error(rpc, &e_src);
-	mutex_unlock(&rpc->rpc_mutex);
+	pci_unlock_rescan_remove();
 
 	aer_release(rpc);
 }
-- 
2.14.3
