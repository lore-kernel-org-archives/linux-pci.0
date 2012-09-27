Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:27396 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab2I0IM0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2012 04:12:26 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
Date: Thu, 27 Sep 2012 01:11:54 -0700
Message-Id: <1348733519-24684-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So could use assign_unassigned_bus_res pci root bus add

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c     |    1 +
 drivers/pci/setup-bus.c |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 65f62e3..59cf1ba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1905,6 +1905,7 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
 
 	max = pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 59e6c55..6d3591d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1566,6 +1566,4 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 	BUG_ON(!list_empty(&add_list));
-
-	pci_enable_bridges(bus);
 }
-- 
1.7.7

