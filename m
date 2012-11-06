Return-Path: <linux-pci-owner@vger.kernel.org>
From: Mike Yoknis <mike.yoknis@hp.com>
To: bhelgaas@google.com
Cc: Linux-pci@vger.kernel.org, mike.yoknis@hp.com
Subject: [PATCH v3] x86/pci: Allow x86 platforms to use translation offsets
Date: Tue,  6 Nov 2012 15:42:04 -0600
Message-Id: <1352238124-32162-1-git-send-email-mike.yoknis@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch v3 changes: applies cleanly to 3.7.0-rc3

The memory range descriptors in the _CRS control method contain an address
translation offset for host bridges.  This value is used to translate addresses
across the bridge.  The support to use _TRA values is present for other
architectures but not for X86 platforms.

For existing X86 platforms the _TRA value is zero.
Non-zero _TRA values are expected on future X86 platforms.
This change will register that value with the resource.

Signed-off-by: Mike Yoknis <mike.yoknis@hp.com>
---
 arch/x86/pci/acpi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 192397c..9cecffc 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -12,6 +12,7 @@ struct pci_root_info {
 	char name[16];
 	unsigned int res_num;
 	struct resource *res;
+	resource_size_t *res_offset;
 	struct pci_sysdata sd;
 #ifdef	CONFIG_PCI_MMCONFIG
 	bool mcfg_added;
@@ -305,6 +306,7 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
 	res->flags = flags;
 	res->start = start;
 	res->end = end;
+	info->res_offset[info->res_num] = addr.translation_offset;
 
 	if (!pci_use_crs) {
 		dev_printk(KERN_DEBUG, &info->bridge->dev,
@@ -374,7 +376,8 @@ static void add_resources(struct pci_root_info *info,
 				 "ignoring host bridge window %pR (conflicts with %s %pR)\n",
 				 res, conflict->name, conflict);
 		else
-			pci_add_resource(resources, res);
+			pci_add_resource_offset(resources, res,
+					info->res_offset[i]);
 	}
 }
 
@@ -382,6 +385,8 @@ static void free_pci_root_info_res(struct pci_root_info *info)
 {
 	kfree(info->res);
 	info->res = NULL;
+	kfree(info->res_offset);
+	info->res_offset = NULL;
 	info->res_num = 0;
 }
 
@@ -432,10 +437,20 @@ probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
 		return;
 
 	size = sizeof(*info->res) * info->res_num;
-	info->res_num = 0;
 	info->res = kzalloc(size, GFP_KERNEL);
-	if (!info->res)
+	if (!info->res) {
+		info->res_num = 0;
+		return;
+	}
+
+	size = sizeof(*info->res_offset) * info->res_num;
+	info->res_num = 0;
+	info->res_offset = kzalloc(size, GFP_KERNEL);
+	if (!info->res_offset) {
+		kfree(info->res);
+		info->res = NULL;
 		return;
+	}
 
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, setup_resource,
 				info);
-- 
1.7.11.3

