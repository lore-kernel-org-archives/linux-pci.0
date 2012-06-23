Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:16747 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2FWHmI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:08 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/5] PCI, acpiphp: remove not used res_lock
Date: Sat, 23 Jun 2012 00:42:01 -0700
Message-Id: <1340437325-29282-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/acpiphp.h      |    2 --
 drivers/pci/hotplug/acpiphp_glue.c |    3 ---
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 7722108..6b58ed0 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -89,8 +89,6 @@ struct acpiphp_bridge {
 
 	/* PCI-to-PCI bridge device */
 	struct pci_dev *pci_dev;
-
-	spinlock_t res_lock;
 };
 
 
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 395c67d..ad6fd66 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -396,8 +396,6 @@ static void add_host_bridge(acpi_handle *handle)
 
 	bridge->pci_bus = root->bus;
 
-	spin_lock_init(&bridge->res_lock);
-
 	init_bridge_misc(bridge);
 }
 
@@ -430,7 +428,6 @@ static void add_p2p_bridge(acpi_handle *handle)
 	 * (which we access during module unload).
 	 */
 	get_device(&bridge->pci_bus->dev);
-	spin_lock_init(&bridge->res_lock);
 
 	init_bridge_misc(bridge);
 	return;
-- 
1.7.7

