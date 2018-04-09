Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeDIWCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:07 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex_Gagniuc@Dellteam.com, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/4] PCI/AER: Replace struct pcie_device with pci_dev
Date: Mon,  9 Apr 2018 16:04:42 -0600
Message-Id: <20180409220444.6632-3-keith.busch@intel.com>
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The AER driver really only needed the pcie_device to get to the port
pci_dev, so this patch removes the unnecessary indirection.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.c      |  6 +++---
 drivers/pci/pcie/aer/aerdrv.h      |  2 +-
 drivers/pci/pcie/aer/aerdrv_core.c | 18 ++++++++----------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 779b3879b1b5..9ce8a824afbc 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -94,7 +94,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
  */
 static void aer_enable_rootport(struct aer_rpc *rpc)
 {
-	struct pci_dev *pdev = rpc->rpd->port;
+	struct pci_dev *pdev = rpc->rpd;
 	int aer_pos;
 	u16 reg16;
 	u32 reg32;
@@ -136,7 +136,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
  */
 static void aer_disable_rootport(struct aer_rpc *rpc)
 {
-	struct pci_dev *pdev = rpc->rpd->port;
+	struct pci_dev *pdev = rpc->rpd;
 	u32 reg32;
 	int pos;
 
@@ -232,7 +232,7 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	/* Initialize Root lock access, e_lock, to Root Error Status Reg */
 	spin_lock_init(&rpc->e_lock);
 
-	rpc->rpd = dev;
+	rpc->rpd = dev->port;
 	INIT_WORK(&rpc->dpc_handler, aer_isr);
 	mutex_init(&rpc->rpc_mutex);
 
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 08b4584f62fe..f34174feab55 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -58,7 +58,7 @@ struct aer_err_source {
 };
 
 struct aer_rpc {
-	struct pcie_device *rpd;	/* Root Port device */
+	struct pci_dev *rpd;		/* Root Port device */
 	struct work_struct dpc_handler;
 	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
 	struct aer_err_info e_info;
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a533ea25e52c..672374cfb16d 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -709,13 +709,13 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 /**
  * aer_isr_one_error - consume an error detected by root port
- * @p_device: pointer to error root port service device
+ * @rpc: pointer to the root port which holds an error
  * @e_src: pointer to an error source
  */
-static void aer_isr_one_error(struct pcie_device *p_device,
+static void aer_isr_one_error(struct aer_rpc *rpc,
 		struct aer_err_source *e_src)
 {
-	struct aer_rpc *rpc = get_service_data(p_device);
+	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info *e_info = &rpc->e_info;
 
 	/*
@@ -730,10 +730,9 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 			e_info->multi_error_valid = 1;
 		else
 			e_info->multi_error_valid = 0;
+		aer_print_port_info(pdev, e_info);
 
-		aer_print_port_info(p_device->port, e_info);
-
-		if (find_source_device(p_device->port, e_info))
+		if (find_source_device(pdev, e_info))
 			aer_process_err_devices(e_info);
 	}
 
@@ -750,9 +749,9 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		else
 			e_info->multi_error_valid = 0;
 
-		aer_print_port_info(p_device->port, e_info);
+		aer_print_port_info(pdev, e_info);
 
-		if (find_source_device(p_device->port, e_info))
+		if (find_source_device(pdev, e_info))
 			aer_process_err_devices(e_info);
 	}
 }
@@ -795,11 +794,10 @@ static int get_e_source(struct aer_rpc *rpc, struct aer_err_source *e_src)
 void aer_isr(struct work_struct *work)
 {
 	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
-	struct pcie_device *p_device = rpc->rpd;
 	struct aer_err_source uninitialized_var(e_src);
 
 	mutex_lock(&rpc->rpc_mutex);
 	while (get_e_source(rpc, &e_src))
-		aer_isr_one_error(p_device, &e_src);
+		aer_isr_one_error(rpc, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
 }
-- 
2.14.3
