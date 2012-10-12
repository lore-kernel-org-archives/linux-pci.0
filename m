Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tang Chen <tangchen@cn.fujitsu.com>
To: yinghai@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	izumi.taku@jp.fujitsu.com, jiang.liu@huawei.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/3] Check exit status of acpi_install_notify_handler() in find_root_bridges().
Date: Fri, 12 Oct 2012 18:31:30 +0800
Message-Id: <1350037890-5899-4-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1350037890-5899-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1350037890-5899-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_install_notify_handler() could fail. So check the exit status
and give a better debug info.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/pci_root_hp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
index 05a88ae..1985749 100644
--- a/drivers/acpi/pci_root_hp.c
+++ b/drivers/acpi/pci_root_hp.c
@@ -246,6 +246,7 @@ static void handle_hotplug_event_root(acpi_handle handle, u32 type,
 static acpi_status __init
 find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
+	acpi_status status;
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
@@ -258,9 +259,14 @@ find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 
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

