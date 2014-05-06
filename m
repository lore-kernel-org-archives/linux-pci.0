Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch Part3 V2 21/21] pci, ACPI, iommu: enhance pci_root to support DMAR device hotplug
Date: Tue,  6 May 2014 15:05:32 +0800
Message-Id: <1399359932-28972-22-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1399359932-28972-1-git-send-email-jiang.liu@linux.intel.com>
References: <1399359932-28972-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Finally enhance pci_root driver to support DMAR device hotplug when
hot-plugging PCI host bridges.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/pci_root.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d388f13d48b4..99c2b9761c12 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/pci-aspm.h>
+#include <linux/dmar.h>
 #include <linux/acpi.h>
 #include <linux/slab.h>
 #include <acpi/apei.h>	/* for acpi_hest_init() */
@@ -511,6 +512,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	struct acpi_pci_root *root;
 	acpi_handle handle = device->handle;
 	int no_aspm = 0, clear_aspm = 0;
+	bool hotadd = system_state != SYSTEM_BOOTING;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -557,6 +559,11 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
+	if (hotadd && dmar_device_add(handle)) {
+		result = -ENXIO;
+		goto end;
+	}
+
 	pr_info(PREFIX "%s [%s] (domain %04x %pR)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
 	       root->segment, &root->secondary);
@@ -583,7 +590,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 			root->segment, (unsigned int)root->secondary.start);
 		device->driver_data = NULL;
 		result = -ENODEV;
-		goto end;
+		goto remove_dmar;
 	}
 
 	if (clear_aspm) {
@@ -597,7 +604,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(root->bus->bridge, true);
 
-	if (system_state != SYSTEM_BOOTING) {
+	if (hotadd) {
 		pcibios_resource_survey_bus(root->bus);
 		pci_assign_unassigned_root_bus_resources(root->bus);
 	}
@@ -607,6 +614,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	pci_unlock_rescan_remove();
 	return 1;
 
+remove_dmar:
+	if (hotadd)
+		dmar_device_remove(handle);
 end:
 	kfree(root);
 	return result;
@@ -625,6 +635,8 @@ static void acpi_pci_root_remove(struct acpi_device *device)
 
 	pci_remove_root_bus(root->bus);
 
+	dmar_device_remove(device->handle);
+
 	pci_unlock_rescan_remove();
 
 	kfree(root);
-- 
1.7.10.4

