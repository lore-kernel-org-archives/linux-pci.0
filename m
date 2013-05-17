Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:60035 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab3EQJ5z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 05:57:55 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	<jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v2 7/7] PCI/IA64: introduce probe_pci_root_info() to manage  _CRS resource
Date: Fri, 17 May 2013 17:55:50 +0800
Message-ID: <1368784550-18332-8-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1368784550-18332-1-git-send-email-wangyijing@huawei.com>
References: <1368784550-18332-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, initialize _CRS resource code in IA64 make pci_acpi_scan_root()
some lengthiness. Introduce probe_pci_root_info() to manage it like in X86,

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/ia64/pci/pci.c |   91 +++++++++++++++++++++++++++-----------------------
 1 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 2857a83..8076225 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -365,6 +365,48 @@ static void release_pci_root_info(struct pci_host_bridge *bridge)
 	__release_pci_root_info(info);
 }
 
+static void
+probe_pci_root_info(struct pci_root_info *info, struct acpi_device *device,
+		int busnum, int domain)
+{
+	char *name;
+
+	name = kmalloc(16, GFP_KERNEL);
+	if (!name)
+		return;
+
+	sprintf(name, "PCI Bus %04x:%02x", domain, busnum);
+	info->bridge = device;
+	info->name = name;
+
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_window,
+			&info->res_num);
+	if (info->res_num) {
+		info->res =
+			kzalloc_node(sizeof(*info->res) * info->res_num,
+				     GFP_KERNEL, info->controller->node);
+		if (!info->res) {
+			kfree(name);
+			return;
+		}
+
+		info->res_offset =
+			kzalloc_node(sizeof(*info->res_offset) * info->res_num,
+					GFP_KERNEL, info->controller->node);
+		if (!info->res_offset) {
+			kfree(name);
+			kfree(info->res);
+			info->res = NULL;
+			return;
+		}
+
+		info->res_num = 0;
+		acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+			add_window, info);
+	} else
+		kfree(name);
+}
+
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
 	struct acpi_device *device = root->device;
@@ -374,12 +416,11 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct pci_root_info *info = NULL;
 	int busnum = root->secondary.start;
 	struct pci_bus *pbus;
-	char *name;
 	int pxm;
 
 	controller = alloc_pci_controller(domain);
 	if (!controller)
-		goto out1;
+		return NULL;
 
 	controller->acpi_handle = device->handle;
 
@@ -392,41 +433,18 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		printk(KERN_WARNING "pci_bus %04x:%02x: "
-				"ignored (out of memory)\n", root->segment, busnum);
-		goto out2;
+				"ignored (out of memory)\n", domain, busnum);
+		kfree(controller);
+		return NULL;
 	}
 	
+	info->controller = controller;
 	INIT_LIST_HEAD(&info->io_resources);
 	INIT_LIST_HEAD(&info->resources);
+	probe_pci_root_info(info, device, busnum, domain);
+
 	/* insert busn resource at first */
 	pci_add_resource(&info->resources, &root->secondary);
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_window,
-			&info->res_num);
-	if (info->res_num) {
-		info->res =
-			kzalloc_node(sizeof(*info->res) * info->res_num,
-				     GFP_KERNEL, controller->node);
-		if (!info->res)
-			goto out3;
-		
-		info->res_offset = 
-			kzalloc_node(sizeof(*info->res_offset) * info->res_num, 
-					GFP_KERNEL, controller->node);
-		if (!info->res_offset)
-			goto out4;
-
-		name = kmalloc(16, GFP_KERNEL);
-		if (!name)
-			goto out5;
-
-		sprintf(name, "PCI Bus %04x:%02x", domain, bus);
-		info->bridge = device;
-		info->controller = controller;
-		info->name = name;
-		info->res_num = 0;
-		acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-			add_window, info);
-	}
 	/*
 	 * See arch/x86/pci/acpi.c.
 	 * The desired pci bus might already be scanned in a quirk. We
@@ -445,17 +463,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 			release_pci_root_info, info);
 	pci_scan_child_bus(pbus);
 	return pbus;
-
-out5:
-	kfree(info->res_offset);
-out4:
-	kfree(info->res);
-out3:
-	kfree(info);
-out2:
-	kfree(controller);
-out1:
-	return NULL;
 }
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-- 
1.7.1


