Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6213 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809AbcBXRHA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 12:07:00 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>, keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCHv2] VMD: Attach vmd resources to parent domain's resource tree
Date: Wed, 24 Feb 2016 10:06:37 -0700
Message-Id: <1456333597-10469-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch attaches the new VMD domain's resources to the VMD device's
resources. This allows /proc/iomem to display a more complete picture.

Before:
  c0000000-c1ffffff : 0000:5d:05.5
  c2000000-c3ffffff : 0000:5d:05.5
    c2010000-c2013fff : nvme
  c4000000-c40fffff : 0000:5d:05.5

After:
  c0000000-c1ffffff : 0000:5d:05.5
  c2000000-c3ffffff : 0000:5d:05.5
    c2000000-c3ffffff : VMD MEMBAR1
      c2000000-c22fffff : PCI Bus 10000:01
        c2000000-c200ffff : 10000:01:00.0
        c2010000-c2013fff : 10000:01:00.0
          c2010000-c2013fff : nvme
      c2300000-c24fffff : PCI Bus 10000:01
  c4000000-c40fffff : 0000:5d:05.5
    c4002000-c40fffff : VMD MEMBAR2

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
v1->v2: Dropped the CFGBAR resource from the tree
 arch/x86/pci/vmd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index d57e480..d0c4542 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -503,6 +503,18 @@ static struct pci_ops vmd_ops = {
 	.write		= vmd_pci_write,
 };
 
+static void vmd_attach_resources(struct vmd_dev *vmd)
+{
+	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
+	vmd->dev->resource[VMD_MEMBAR2].child = &vmd->resources[2];
+}
+
+static void vmd_detach_resources(struct vmd_dev *vmd)
+{
+	vmd->dev->resource[VMD_MEMBAR1].child = NULL;
+	vmd->dev->resource[VMD_MEMBAR2].child = NULL;
+}
+
 /*
  * VMD domains start at 0x1000 to not clash with ACPI _SEG domains.
  */
@@ -542,6 +554,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		.start = res->start,
 		.end   = res->end,
 		.flags = flags,
+		.parent = res,
 	};
 
 	res = &vmd->dev->resource[VMD_MEMBAR2];
@@ -554,6 +567,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		.start = res->start + 0x2000,
 		.end   = res->end,
 		.flags = flags,
+		.parent = res,
 	};
 
 	sd->domain = vmd_find_free_domain();
@@ -578,6 +592,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		return -ENODEV;
 	}
 
+	vmd_attach_resources(vmd);
 	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 	pci_rescan_bus(vmd->bus);
@@ -674,6 +689,7 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
+	vmd_detach_resources(vmd);
 	pci_set_drvdata(dev, NULL);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
-- 
1.8.3.1

