Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:38919 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2IYI04 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:56 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 29/29] PCI: kill pci_root_buses
Date: Tue, 25 Sep 2012 01:26:30 -0700
Message-Id: <1348561590-28067-30-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    8 --------
 include/linux/pci.h |    3 ---
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 30b1624..0095554 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -23,10 +23,6 @@ struct resource busn_resource = {
 	.flags	= IORESOURCE_BUS,
 };
 
-/* Ugh.  Need to stop exporting this to modules. */
-LIST_HEAD(pci_root_buses);
-EXPORT_SYMBOL(pci_root_buses);
-
 static LIST_HEAD(pci_domain_busn_res_list);
 
 struct pci_domain_busn_res {
@@ -1712,10 +1708,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	return b;
 
 class_dev_reg_err:
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c7ca6e9..a1b835f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -673,9 +673,6 @@ extern enum pcie_bus_config_types pcie_bus_config;
 extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
-/* Do NOT directly access these two variables, unless you are arch specific pci
- * code, or pci core code. */
-extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 /* Some device drivers need know if pci is initiated */
 extern int no_pci_devices(void);
 
-- 
1.7.7

