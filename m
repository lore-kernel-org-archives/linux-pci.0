Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:22036 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab2JBGdN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:13 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 10/10] PCI, ACPI: use bus_type notifier for acpi_pci_bind_notify
Date: Mon,  1 Oct 2012 23:33:08 -0700
Message-Id: <1349159588-15029-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should not put  pci specific code in generic acpi glue code, especially
after we have bus_type for pci_host_bridge in addition to pci_dev.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/glue.c         |    4 ----
 drivers/acpi/pci_bind.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pci_root.c     |   39 +++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |    2 ++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index fe72b3e..3273178 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -164,8 +164,6 @@ static int acpi_bind_one(struct device *dev, acpi_handle handle)
 	if (ACPI_FAILURE(status))
 		acpi_dev = NULL;
 
-	acpi_pci_bind_notify(acpi_dev, dev, true);
-
 	if (acpi_dev) {
 		int ret;
 
@@ -197,8 +195,6 @@ static int acpi_unbind_one(struct device *dev)
 		} else
 			acpi_dev = NULL;
 
-		acpi_pci_bind_notify(acpi_dev, dev, false);
-
 		acpi_detach_data(dev->archdata.acpi_handle,
 				 acpi_glue_data_handler);
 		dev->archdata.acpi_handle = NULL;
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index b59a5df..f938b2e 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -114,3 +114,43 @@ void acpi_pci_bind_notify(struct acpi_device *acpi_dev, struct device *dev,
 			acpi_pci_unbind(acpi_dev, dev);
 	}
 }
+
+static int pci_dev_hp_notifier(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct device *dev = data;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	struct acpi_device *acpi_dev;
+
+	if (!handle)
+		return NOTIFY_OK;
+
+	if (acpi_bus_get_device(handle, &acpi_dev))
+		return NOTIFY_OK;
+
+	if (!acpi_dev)
+		return NOTIFY_OK;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		acpi_pci_bind_notify(acpi_dev, dev, true);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		acpi_pci_bind_notify(acpi_dev, dev, false);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pci_dev_hp_nb = {
+	.notifier_call = &pci_dev_hp_notifier,
+};
+
+static int __init pci_dev_hp_init(void)
+{
+	return bus_register_notifier(&pci_bus_type,
+					 &pci_dev_hp_nb);
+}
+
+arch_initcall(pci_dev_hp_init);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 725ec10..d2c194b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -659,3 +659,42 @@ static int __init acpi_pci_root_init(void)
 }
 
 subsys_initcall(acpi_pci_root_init);
+
+static int pci_host_bridge_hp_notifier(struct notifier_block *nb,
+				 unsigned long event, void *data)
+{
+	struct device *dev = data;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	struct acpi_pci_root *root;
+	struct acpi_device *acpi_dev;
+
+	if (!handle)
+		return NOTIFY_OK;
+
+	root = acpi_pci_find_root(handle);
+	acpi_dev = root->device;
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		acpi_pci_bind_notify(acpi_dev, dev, true);
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		acpi_pci_bind_notify(acpi_dev, dev, true);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pci_host_bridge_hp_nb = {
+	.notifier_call = &pci_host_bridge_hp_notifier,
+};
+
+static int __init pci_host_bridge_hp_init(void)
+{
+	return bus_register_notifier(&pci_host_bridge_bus_type,
+					 &pci_host_bridge_hp_nb);
+}
+
+arch_initcall(pci_host_bridge_hp_init);
+
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index fb1c0d5..c258500 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -100,6 +100,8 @@ void acpi_pci_irq_del_prt(struct pci_bus *bus);
 struct pci_bus;
 
 struct pci_dev *acpi_get_pci_dev(acpi_handle);
+void acpi_pci_bind_notify(struct acpi_device *acpi_dev, struct device *dev,
+			  bool bind);
 
 /* Arch-defined function to add a bus to the system */
 
-- 
1.7.7

