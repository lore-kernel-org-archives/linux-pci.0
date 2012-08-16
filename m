Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:11104 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab2HPMOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 08:14:25 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/3] PCI, acpiphp: Add module parameter "complete_add" used to determine whether to hot add all devices regardless of be assigned resources fail
Date: Thu, 16 Aug 2012 20:12:20 +0800
Message-ID: <1345119142-5896-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Default, when we hot add pci devices, if system allocate resources fail, this devices will be removed
again. Module parameter complete_add = 1 will forces to hot add all pci devices regardless of be assigned
resources fail.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/acpiphp.h      |    2 +-
 drivers/pci/hotplug/acpiphp_core.c |    4 +++-
 drivers/pci/hotplug/acpiphp_glue.c |    6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index a1afb5b..b228dad 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -206,5 +206,5 @@ extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
 
 /* variables */
 extern bool acpiphp_debug;
-
+extern bool acpiphp_complete_add;
 #endif /* _ACPIPHP_H */
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index 96316b7..6d31608 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -48,7 +48,7 @@
 #define SLOT_NAME_SIZE  21              /* {_SUN} */
 
 bool acpiphp_debug;
-
+bool acpiphp_complete_add;
 /* local variables */
 static int num_slots;
 static struct acpiphp_attention_info *attention_info;
@@ -61,7 +61,9 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+MODULE_PARM_DESC(complete_add, "Hot add all pci devices regardless of be assign resources fail");
 module_param_named(debug, acpiphp_debug, bool, 0644);
+module_param_named(complete_add, acpiphp_complete_add, bool, 0644);
 
 /* export the attention callback registration methods */
 EXPORT_SYMBOL_GPL(acpiphp_register_attention);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ad6fd66..a372ade 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -827,7 +827,8 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 		acpiphp_bus_add(func);
 
 	pci_bus_assign_resources(bus);
-	acpiphp_sanitize_bus(bus);
+	if (!acpiphp_complete_add)
+		acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
 	acpiphp_set_acpi_region(slot);
 	pci_enable_bridges(bus);
@@ -1115,7 +1116,8 @@ static int acpiphp_configure_bridge (acpi_handle handle)
 
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
-	acpiphp_sanitize_bus(bus);
+	if (!acpiphp_complete_add)
+		acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
 	pci_enable_bridges(bus);
 	return 0;
-- 
1.7.1


