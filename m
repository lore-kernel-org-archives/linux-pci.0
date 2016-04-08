Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42790 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134AbcDHATK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 20:19:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v11 20/60] PCI: Separate realloc list checking after allocation
Date: Thu,  7 Apr 2016 17:15:33 -0700
Message-Id: <1460074573-7481-21-git-send-email-yinghai@kernel.org>
In-Reply-To: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We check the realloc list, as list must be empty after allocation.

Separate the realloc list checking to another function.

Add checking that is missed in acpiphp driver.

-v2: change from BUG_ON to WARN_ON according to Rafael.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp_glue.c |  1 +
 drivers/pci/pci.h                  |  1 +
 drivers/pci/setup-bus.c            | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index fa49f91..c35983a 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_slot *slot)
 		}
 	}
 	__pci_bus_assign_resources(bus, &add_list, NULL);
+	pci_bus_check_realloc(&add_list);
 
 	acpiphp_sanitize_bus(bus);
 	pcie_bus_configure_settings(bus);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0ac4229..0bb8eee 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -238,6 +238,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus,
 void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
+void pci_bus_check_realloc(struct list_head *realloc_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6385cf7..7d58f3f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -279,6 +279,12 @@ out:
 	}
 }
 
+void pci_bus_check_realloc(struct list_head *realloc_head)
+{
+	if (WARN_ON(!list_empty(realloc_head)))
+		free_list(realloc_head);
+}
+
 /**
  * assign_requested_resources_sorted() - satisfy resource requests
  *
@@ -1776,7 +1782,7 @@ again:
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
 	if (add_list)
-		BUG_ON(!list_empty(add_list));
+		pci_bus_check_realloc(add_list);
 	tried_times++;
 
 	/* any device complain? */
@@ -1851,7 +1857,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 again:
 	__pci_bus_size_bridges(parent, &add_list);
 	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-	BUG_ON(!list_empty(&add_list));
+	pci_bus_check_realloc(&add_list);
 	tried_times++;
 
 	if (list_empty(&fail_head))
@@ -1910,6 +1916,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 							 &add_list);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
-	BUG_ON(!list_empty(&add_list));
+	pci_bus_check_realloc(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
-- 
1.8.4.5

