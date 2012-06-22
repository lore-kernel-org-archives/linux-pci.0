Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761331Ab2FVG5j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:57:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:57:38 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 07/13] PCI/ACPI: provide MCFG address for PCI host bridges
Date: Fri, 22 Jun 2012 14:55:16 +0800
Message-Id: <1340348122-29021-8-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

This patch provide MCFG address for PCI host bridges, which will
be used to support host bridge hotplug.  It gets MCFG address
by evaluating _CBA method if available.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c  |    2 ++
 drivers/pci/pci-acpi.c   |   14 ++++++++++++++
 include/acpi/acnames.h   |    1 +
 include/acpi/acpi_bus.h  |    1 +
 include/linux/pci-acpi.h |    1 +
 5 files changed, 19 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7aff631..ec54014 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -505,6 +505,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
+	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(device->handle);
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 61e2fef..87f4c50 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -162,6 +162,20 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 	return remove_pm_notifier(dev, pci_acpi_wake_dev);
 }
 
+phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
+{
+	acpi_status status = AE_NOT_EXIST;
+	unsigned long long mcfg_addr;
+
+	if (handle)
+		status = acpi_evaluate_integer(handle, METHOD_NAME__CBA,
+					       NULL, &mcfg_addr);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	return (phys_addr_t)mcfg_addr;
+}
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 38f5088..b177f97 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -62,6 +62,7 @@
 #define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__PRW        "_PRW"
 #define METHOD_NAME__SRS        "_SRS"
+#define METHOD_NAME__CBA        "_CBA"
 
 /* Method names - these methods must appear at the namespace root */
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 9e6e1c6..4579740 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -401,6 +401,7 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
+	phys_addr_t mcfg_addr;
 };
 
 /* helper */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 4462350..248fba2 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -17,6 +17,7 @@ extern acpi_status pci_acpi_remove_bus_pm_notifier(struct acpi_device *dev);
 extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 					     struct pci_dev *pci_dev);
 extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
+extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
-- 
1.7.9.5

