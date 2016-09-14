Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/AER: Move the error info struct into the root port container
Date: Wed, 14 Sep 2016 10:38:55 -0600
Message-Id: <1473871135-29088-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

AER injecting tests with many devices and nosourceid are resulting in
soft lockups, mostly due to the config reads (which have been helped
by recent aer capability position caching patches), but also due to a
superfluous kmalloc/kfree pair executed for each p_device.

When a device emits an error notification, it's not unreasonable to
assume that it may emit another error notification soon. Instead of
kmallocing and kfreeing the aer_err_info struct for each p_device during
an aer_isr pass, move the struct into the aer root port container and
kill the allocation.

The current code suggests the aer_err_info struct could be huge, but is
actually only about 70 bytes. Whereas the aer_rpc root port container is
over 900 bytes. Because of the already large size of the root port
container, moving the struct into it should not adversely impact access
to the root port container.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.h      |  1 +
 drivers/pci/pcie/aer/aerdrv_core.c | 13 ++-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index f15ca8d..d51e4a5 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -60,6 +60,7 @@ struct aer_rpc {
 	struct pcie_device *rpd;	/* Root Port device */
 	struct work_struct dpc_handler;
 	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
+	struct aer_err_info e_info;
 	unsigned short prod_idx;	/* Error Producer Index */
 	unsigned short cons_idx;	/* Error Consumer Index */
 	int isr;
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 8262527..9fd18a0 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -711,15 +711,8 @@ static inline void aer_process_err_devices(struct pcie_device *p_device,
 static void aer_isr_one_error(struct pcie_device *p_device,
 		struct aer_err_source *e_src)
 {
-	struct aer_err_info *e_info;
-
-	/* struct aer_err_info might be big, so we allocate it with slab */
-	e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
-	if (!e_info) {
-		dev_printk(KERN_DEBUG, &p_device->port->dev,
-			"Can't allocate mem when processing AER errors\n");
-		return;
-	}
+	struct aer_rpc *rpc = get_service_data(p_device);
+	struct aer_err_info *e_info = &rpc->e_info;
 
 	/*
 	 * There is a possibility that both correctable error and
@@ -758,8 +751,6 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		if (find_source_device(p_device->port, e_info))
 			aer_process_err_devices(p_device, e_info);
 	}
-
-	kfree(e_info);
 }
 
 /**
-- 
1.8.3.1
