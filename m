Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49594 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab3A1Bya (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 20:54:30 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 22/22] PCI: Kill pci_root_buses
Date: Sun, 27 Jan 2013 17:54:10 -0800
Message-Id: <1359338050-22735-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359338050-22735-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359338050-22735-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No user now, remove it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/probe.c |    8 --------
 include/linux/pci.h |    3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04ecf0d..8420b9d 100644
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
@@ -1746,10 +1742,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		dev_info(&b->dev, "root bus resource %pR%s\n", res, bus_addr);
 	}
 
-	down_write(&pci_bus_sem);
-	list_add_tail(&b->node, &pci_root_buses);
-	up_write(&pci_bus_sem);
-
 	return b;
 
 class_dev_reg_err:
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bb07db2..b42721b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -674,9 +674,6 @@ extern enum pcie_bus_config_types pcie_bus_config;
 extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
-/* Do NOT directly access these two variables, unless you are arch specific pci
- * code, or pci core code. */
-extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 /* Some device drivers need know if pci is initiated */
 extern int no_pci_devices(void);
 
-- 
1.7.10.4

