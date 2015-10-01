Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v6 08/53] PCI: Separate realloc list checking after allocation
Date: Wed, 30 Sep 2015 22:52:42 -0700
Message-Id: <1443678807-786-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1443678807-786-1-git-send-email-yinghai@kernel.org>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We check the realloc list, as list must be empty after allocation.

Separate the realloc list checking to another function.

Add checking that is missed in acpiphp driver.

-v2: change to WARN_ON addording to Rafael.

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
index ff53856..ce9fb21 100644
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
index c04c9f1..9dc42b6 100644
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
index fc77a71..8550408 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -280,6 +280,12 @@ out:
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
@@ -1686,7 +1692,7 @@ again:
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
 	if (add_list)
-		BUG_ON(!list_empty(add_list));
+		pci_bus_check_realloc(add_list);
 	tried_times++;
 
 	/* any device complain? */
@@ -1761,7 +1767,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 again:
 	__pci_bus_size_bridges(parent, &add_list);
 	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-	BUG_ON(!list_empty(&add_list));
+	pci_bus_check_realloc(&add_list);
 	tried_times++;
 
 	if (list_empty(&fail_head))
@@ -1820,6 +1826,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 							 &add_list);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
-	BUG_ON(!list_empty(&add_list));
+	pci_bus_check_realloc(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
-- 
1.8.4.5

