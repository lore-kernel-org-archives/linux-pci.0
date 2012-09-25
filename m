Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35425 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab2IYI0g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:36 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/29] PCI: Add dummy bus_type for pci_host_bridge
Date: Tue, 25 Sep 2012 01:26:07 -0700
Message-Id: <1348561590-28067-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-driver.c |   11 ++++++++++-
 drivers/pci/probe.c      |    1 +
 include/linux/pci.h      |    1 +
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9e1d295..93aff7f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1268,11 +1268,20 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 };
 
+struct bus_type pci_host_bridge_bus_type = {
+	.name           = "pci_host_bridge",
+};
+
+static int __init pci_host_bridge_driver_init(void)
+{
+	return bus_register(&pci_host_bridge_bus_type);
+}
+postcore_initcall(pci_host_bridge_driver_init);
+
 static int __init pci_driver_init(void)
 {
 	return bus_register(&pci_bus_type);
 }
-
 postcore_initcall(pci_driver_init);
 
 EXPORT_SYMBOL_GPL(pci_add_dynid);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 87d1cb0..30b1624 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1660,6 +1660,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		goto err_out;
 
 	bridge->dev.parent = parent;
+	bridge->dev.bus = &pci_host_bridge_bus_type;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
 	error = device_register(&bridge->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index be1de01..cc8b558 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -668,6 +668,7 @@ enum pcie_bus_config_types {
 
 extern enum pcie_bus_config_types pcie_bus_config;
 
+extern struct bus_type pci_host_bridge_bus_type;
 extern struct bus_type pci_bus_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
-- 
1.7.7

