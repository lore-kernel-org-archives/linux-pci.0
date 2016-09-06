Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [RFCv2] pci/aer: kmalloc the aer_err_info struct once
Date: Tue,  6 Sep 2016 14:56:15 -0600
Message-Id: <1473195375-11037-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

AER injecting tests with many devices and nosourceid are resulting in
soft lockups, mostly due to the config reads, but there's also a
superfluous kmalloc/kfree pair executed for each p_device.

When a device emits an error, it's not unreasonable to assume that it
may emit another error soon. Instead of kmallocing and kfreeing the
aer_err_info struct for each p_device during an aer_isr pass, kmalloc it
once per root port and hold the reference through the life of the root
port. This may save a few cycles if there are many devices downstream of
the root port and no-source-id checking is enabled, which disables the
fast path and requires checking all devices for errors.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
V2: Same code, just fixed up the log message a bit

 drivers/pci/pcie/aer/aerdrv.c      |  1 +
 drivers/pci/pcie/aer/aerdrv.h      |  1 +
 drivers/pci/pcie/aer/aerdrv_core.c | 23 +++++++++++++++--------
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 49805a4..1fc6f51 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -282,6 +282,7 @@ static void aer_remove(struct pcie_device *dev)
 
 		flush_work(&rpc->dpc_handler);
 		aer_disable_rootport(rpc);
+		kfree(rpc->e_info);
 		kfree(rpc);
 		set_service_data(dev, NULL);
 	}
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 945c939..2c5a5b8 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -60,6 +60,7 @@ struct aer_rpc {
 	struct pcie_device *rpd;	/* Root Port device */
 	struct work_struct dpc_handler;
 	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
+	struct aer_err_info *e_info;
 	unsigned short prod_idx;	/* Error Producer Index */
 	unsigned short cons_idx;	/* Error Consumer Index */
 	int isr;
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 521e39c..e1b2e6c 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -715,14 +715,23 @@ static inline void aer_process_err_devices(struct pcie_device *p_device,
 static void aer_isr_one_error(struct pcie_device *p_device,
 		struct aer_err_source *e_src)
 {
-	struct aer_err_info *e_info;
+	struct aer_rpc *rpc = get_service_data(p_device);
+	struct aer_err_info *e_info = rpc->e_info;
 
-	/* struct aer_err_info might be big, so we allocate it with slab */
-	e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
+	/*
+	 * struct aer_err_info might be big, so we allocate it with slab.
+	 * It's not unreasonable to assume a faulting device might emit
+	 * another error, so try to only malloc once and keep the
+	 * reference through the root port's life.
+	 */
 	if (!e_info) {
-		dev_printk(KERN_DEBUG, &p_device->port->dev,
-			"Can't allocate mem when processing AER errors\n");
-		return;
+		e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
+		if (!e_info) {
+			dev_printk(KERN_DEBUG, &p_device->port->dev,
+				"Can't allocate mem when processing AER errors\n");
+			return;
+		}
+		rpc->e_info = e_info;
 	}
 
 	/*
@@ -762,8 +771,6 @@ static void aer_isr_one_error(struct pcie_device *p_device,
 		if (find_source_device(p_device->port, e_info))
 			aer_process_err_devices(p_device, e_info);
 	}
-
-	kfree(e_info);
 }
 
 /**
-- 
1.8.3.1
