Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:2484 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933542Ab2JLMfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Oct 2012 08:35:32 -0400
From: Tang Chen <tangchen@cn.fujitsu.com>
To: bhelgaas@google.com, lenb@kernel.org, yinghai@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/3 v2] Check exit status of acpi_install_notify_handler() in find_root_bridges().
Date: Fri, 12 Oct 2012 20:34:21 +0800
Message-Id: <1350045261-7344-4-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1350045261-7344-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1350045261-7344-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_install_notify_handler() could fail. So check the exit status
and give a better debug info.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/pci_root_hp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
index 1f60533..4c18573 100644
--- a/drivers/acpi/pci_root_hp.c
+++ b/drivers/acpi/pci_root_hp.c
@@ -242,6 +242,7 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
 static acpi_status __init
 find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
+	acpi_status status;
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
@@ -254,9 +255,14 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
-	acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
-				handle_hotplug_event_root, NULL);
-	printk(KERN_DEBUG "acpi root: %s notify handler installed\n", objname);
+	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					handle_hotplug_event_root, NULL);
+	if (ACPI_FAILURE(status))
+		printk(KERN_DEBUG "acpi root: %s notify handler not installed\n"
+				  "acpi root: exit status: %u\n",
+				  objname, (unsigned int)status);
+	else
+		printk(KERN_DEBUG "acpi root: %s notify handler installed\n", objname);
 
 	add_acpi_root_bridge(handle);
 
-- 
1.7.1

