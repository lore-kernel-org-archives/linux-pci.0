Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=CtTX=IF=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/5] PCI: Add Intel VMD devices to pci ids
Date: Fri, 18 May 2018 13:27:58 -0600
Message-Id: <20180518192802.20371-2-jonathan.derrick@intel.com>
In-Reply-To: <20180518192802.20371-1-jonathan.derrick@intel.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Add the Intel VMD device ids to the pci id database and update the VMD
driver.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c  | 2 +-
 include/linux/pci_ids.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 930a8fa08bd6..b10d2bce2993 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -778,7 +778,7 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x201d),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9cd0a41e72dd..206d6b9ef434 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2676,6 +2676,7 @@
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_XHCI	0x1e31
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN	0x1e40
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX	0x1e5f
+#define PCI_DEVICE_ID_INTEL_VMD_201D	0x201d
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
@@ -2780,6 +2781,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
 #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
+#define PCI_DEVICE_ID_INTEL_VMD_28C0	0x28c0
 #define PCI_DEVICE_ID_INTEL_ICH9_0	0x2910
 #define PCI_DEVICE_ID_INTEL_ICH9_1	0x2917
 #define PCI_DEVICE_ID_INTEL_ICH9_2	0x2912
-- 
2.14.3
