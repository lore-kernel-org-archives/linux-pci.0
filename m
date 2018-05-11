Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=T3Dv=H6=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>,
	Dave Fugate <david.fugate@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC PATCH 4/4] PCI/VMD: Add new VMD device id to driver device id table
Date: Thu, 10 May 2018 18:49:03 -0600
Message-Id: <20180511004903.19892-5-jonathan.derrick@intel.com>
In-Reply-To: <20180511004903.19892-1-jonathan.derrick@intel.com>
References: <20180511004903.19892-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Allow new VMD hardware to bind to VMD driver.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/vmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index fdfc286a1c9e..add940eedc56 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -831,6 +831,7 @@ static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x201d),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x28c0),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.14.3
