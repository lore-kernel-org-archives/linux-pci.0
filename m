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
Subject: [PATCH 5/5] PCI/VMD: Add an additional VMD device id to driver device id table
Date: Fri, 18 May 2018 13:28:02 -0600
Message-Id: <20180518192802.20371-6-jonathan.derrick@intel.com>
In-Reply-To: <20180518192802.20371-1-jonathan.derrick@intel.com>
References: <20180518192802.20371-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Allow VMD devices with PCI id 8086:28c0 to bind to VMD driver.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 34fa6cf0b0ee..942b64fc7f1f 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -847,6 +847,9 @@ static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.14.3
