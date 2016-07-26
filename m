Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com
Cc: bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: [PATCH 3/4] x86/ioapic: Fix lost ioapic resource after hot-removal and hotadd
Date: Wed, 27 Jul 2016 00:13:16 +0800
Message-Id: <1469549597-19253-4-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
References: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

ioapic resource at 0xfecxxxxx gets lost from /proc/iomem after
hot-removing and then hot-adding the ioapic devices.

After system boot, in /proc/iomem:
fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec40000-fec403ff : IOAPIC 2
  fec80000-fec803ff : IOAPIC 3
  fecc0000-fecc03ff : IOAPIC 4

Then hot-remove IOAPIC 2 and hot-add it again:
fec00000-fecfffff : PNP0003:00
  fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec80000-fec803ff : IOAPIC 3
  fecc0000-fecc03ff : IOAPIC 4

The range at 0xfec40000 is lost from /proc/iomem. It is because
handle_ioapic_add() requests resource from either PCI config BAR or
acpi _CRS, not both. But Intel platforms map the IOxAPIC registers
at both the PCI config BAR (called MBAR) and the 0xfecX_YZ00 to
0xfecX_Y2FF range (called ABAR). Both of the ranges should be claimed
from /proc/iomem for exclusive use.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 drivers/acpi/ioapic.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index daf4a40..80b0b1a 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -97,7 +97,7 @@ static acpi_status handle_ioapic_add(acpi_handle handle, u32 lvl,
 	unsigned long long gsi_base;
 	struct acpi_pci_ioapic *ioapic;
 	struct pci_dev *dev = NULL;
-	struct resource *res = NULL;
+	struct resource *res = NULL, *pci_res, *crs_res;
 	char *type = NULL;
 
 	if (!acpi_is_ioapic(handle, &type))
@@ -137,23 +137,28 @@ static acpi_status handle_ioapic_add(acpi_handle handle, u32 lvl,
 		pci_set_master(dev);
 		if (pci_request_region(dev, 0, type))
 			goto exit_disable;
-		res = &dev->resource[0];
+		pci_res = &dev->resource[0];
 		ioapic->pdev = dev;
 	} else {
 		pci_dev_put(dev);
 		dev = NULL;
+	}
 
-		res = &ioapic->res;
-		acpi_walk_resources(handle, METHOD_NAME__CRS, setup_res, res);
-		if (res->flags == 0) {
-			acpi_handle_warn(handle, "failed to get resource\n");
-			goto exit_free;
-		} else if (request_resource(&iomem_resource, res)) {
-			acpi_handle_warn(handle, "failed to insert resource\n");
-			goto exit_free;
-		}
+	crs_res = &ioapic->res;
+	acpi_walk_resources(handle, METHOD_NAME__CRS, setup_res, crs_res);
+	if (crs_res->flags == 0) {
+		acpi_handle_warn(handle, "failed to get resource\n");
+		goto exit_release;
+	} else if (request_resource(&iomem_resource, crs_res)) {
+		acpi_handle_warn(handle, "failed to insert resource\n");
+		goto exit_release;
 	}
 
+	/* try pci resource first, then "_CRS" resource */
+	res = pci_res;
+	if (!res || !res->flags)
+		res = crs_res;
+
 	if (acpi_register_ioapic(handle, res->start, (u32)gsi_base)) {
 		acpi_handle_warn(handle, "failed to register IOAPIC\n");
 		goto exit_release;
@@ -174,14 +179,13 @@ done:
 exit_release:
 	if (dev)
 		pci_release_region(dev, 0);
-	else
-		release_resource(res);
+	if (ioapic->res.flags && ioapic->res.parent)
+		release_resource(&ioapic->res);
 exit_disable:
 	if (dev)
 		pci_disable_device(dev);
 exit_put:
 	pci_dev_put(dev);
-exit_free:
 	kfree(ioapic);
 exit:
 	mutex_unlock(&ioapic_list_lock);
@@ -218,9 +222,9 @@ int acpi_ioapic_remove(struct acpi_pci_root *root)
 			pci_release_region(ioapic->pdev, 0);
 			pci_disable_device(ioapic->pdev);
 			pci_dev_put(ioapic->pdev);
-		} else if (ioapic->res.flags && ioapic->res.parent) {
-			release_resource(&ioapic->res);
 		}
+		if (ioapic->res.flags && ioapic->res.parent)
+			release_resource(&ioapic->res);
 		list_del(&ioapic->list);
 		kfree(ioapic);
 	}
-- 
1.8.3.1
