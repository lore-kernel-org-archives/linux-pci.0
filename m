Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30788 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2FWHmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:09 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/5] PCI, acpiphp: Merge acpiphp_debug and debug
Date: Sat, 23 Jun 2012 00:42:03 -0700
Message-Id: <1340437325-29282-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Should not have two, just remove debug, and use module_param_named
instead.

Also change acpiphp_debug to bool.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/acpiphp.h      |    2 +-
 drivers/pci/hotplug/acpiphp_core.c |    7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 6b58ed0..a1afb5b 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -205,6 +205,6 @@ extern u8 acpiphp_get_latch_status (struct acpiphp_slot *slot);
 extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
 
 /* variables */
-extern int acpiphp_debug;
+extern bool acpiphp_debug;
 
 #endif /* _ACPIPHP_H */
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index aa41631..96316b7 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -47,8 +47,7 @@
 /* name size which is used for entries in pcihpfs */
 #define SLOT_NAME_SIZE  21              /* {_SUN} */
 
-static bool debug;
-int acpiphp_debug;
+bool acpiphp_debug;
 
 /* local variables */
 static int num_slots;
@@ -62,7 +61,7 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-module_param(debug, bool, 0644);
+module_param_named(debug, acpiphp_debug, bool, 0644);
 
 /* export the attention callback registration methods */
 EXPORT_SYMBOL_GPL(acpiphp_register_attention);
@@ -379,8 +378,6 @@ static int __init acpiphp_init(void)
 	if (acpi_pci_disabled)
 		return 0;
 
-	acpiphp_debug = debug;
-
 	/* read all the ACPI info from the system */
 	return init_acpi();
 }
-- 
1.7.7

