Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32142 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcD2IwJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Apr 2016 04:52:09 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 3/4] ACPI / hotplug / PCI: Runtime resume bridge before rescan
Date: Fri, 29 Apr 2016 11:51:58 +0300
Message-Id: <1461919919-120102-4-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a PCI bridge (or PCIe port) that is runtime suspended gets an ACPI
hotplug event, such as BUS_CHECK we need to make sure it is resumed before
devices below the bridge are re-scanned. Otherwise the devices behind the
port are not accessible and will be treated as hot-unplugged.

To fix this, resume PCI bridges from runtime suspend while rescanning.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index fa49f9143b80..d64ce8aa99b3 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -756,8 +756,10 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 
 	acpi_lock_hp_context();
 	bridge = context->bridge;
-	if (bridge)
+	if (bridge) {
 		get_bridge(bridge);
+		pm_runtime_get_sync(&bridge->pci_dev->dev);
+	}
 
 	acpi_unlock_hp_context();
 
@@ -797,8 +799,10 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 	}
 
 	pci_unlock_rescan_remove();
-	if (bridge)
+	if (bridge) {
+		pm_runtime_put(&bridge->pci_dev->dev);
 		put_bridge(bridge);
+	}
 }
 
 static int acpiphp_hotplug_notify(struct acpi_device *adev, u32 type)
-- 
2.8.0.rc3

