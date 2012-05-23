Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 23 May 2012 11:50:23 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 6/9] PCI, ACPI: provide MCFG address for PCI host bridges
In-reply-to: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	linux-pci@vger.kernel.org
Message-id: <1337745026-1180-7-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

This patch provide MCFG address for PCI host bridges, which will
be used to support host bridge hotplug. It gets MCFG address
by evaluating _CBA method if available, or by scanning the ACPI
MCFG table.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/acpi/pci_root.c  |   12 ++++++++++++
 drivers/pci/pci-acpi.c   |   34 ++++++++++++++++++++++++++++++++++
 include/acpi/acnames.h   |    1 +
 include/acpi/acpi_bus.h  |    3 +++
 include/linux/pci-acpi.h |    5 +++++
 5 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7aff631..fc716cf 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -458,6 +458,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
+	int end_bus = -1;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -505,6 +506,17 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
+	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(device->handle,
+		root->segment, (uint8_t)root->secondary.start, &end_bus);
+
+	/*
+	 * End bus number for MCFG may be less than root's subordinary
+	 * bus number with buggy BIOS implementation.
+	 */
+	if (end_bus < 0 || end_bus > root->secondary.end)
+		end_bus = root->secondary.end;
+	root->mcfg_end_bus = (uint8_t)end_bus;
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0f150f2..9af71d2 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -162,6 +162,40 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 	return remove_pm_notifier(dev, pci_acpi_wake_dev);
 }
 
+/* acpi_table_parse() is marked as __init, so cache MCFG info at boot time */
+int pci_acpi_mcfg_entries;
+struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
+
+phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle, uint16_t seg,
+					uint8_t start, int *endp)
+{
+	int i, end_bus = -1;
+	acpi_status status = AE_NOT_EXIST;
+	unsigned long long mcfg_addr = 0;
+	struct acpi_mcfg_allocation *cfg;
+
+	if (handle)
+		status = acpi_evaluate_integer(handle, METHOD_NAME__CBA,
+					       NULL, &mcfg_addr);
+	if (ACPI_FAILURE(status) && pci_acpi_mcfg_entries &&
+	    pci_acpi_mcfg_array) {
+		mcfg_addr = 0;
+		cfg = pci_acpi_mcfg_array;
+		for (i = 0; i < pci_acpi_mcfg_entries; i++, cfg++)
+			if (seg == cfg->pci_segment &&
+			    start >= cfg->start_bus_number &&
+			    start <= cfg->end_bus_number) {
+				end_bus = cfg->end_bus_number;
+				mcfg_addr = cfg->address;
+				break;
+			}
+	}
+	if (endp)
+		*endp = end_bus;
+
+	return (phys_addr_t)mcfg_addr;
+}
+
 /*
  * _SxD returns the D-state with the highest power
  * (lowest D-state number) supported in the S-state "x".
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index 38f5088..99bda75 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -62,6 +62,7 @@
 #define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__PRW        "_PRW"
 #define METHOD_NAME__SRS        "_SRS"
+#define METHOD_NAME__CBA	"_CBA"
 
 /* Method names - these methods must appear at the namespace root */
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..8bc5229 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -370,6 +370,9 @@ struct acpi_pci_root {
 
 	u32 osc_support_set;	/* _OSC state of support bits */
 	u32 osc_control_set;	/* _OSC state of control bits */
+	uint8_t mcfg_end_bus;	/* End bus for MCFG may differ from
+				 * root's subordinary bus. */
+	phys_addr_t mcfg_addr;
 };
 
 /* helper */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 4462350..0369149 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -11,12 +11,17 @@
 #include <linux/acpi.h>
 
 #ifdef CONFIG_ACPI
+extern int pci_acpi_mcfg_entries;
+extern struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
+
 extern acpi_status pci_acpi_add_bus_pm_notifier(struct acpi_device *dev,
 						 struct pci_bus *pci_bus);
 extern acpi_status pci_acpi_remove_bus_pm_notifier(struct acpi_device *dev);
 extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
 					     struct pci_dev *pci_dev);
 extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
+extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle,
+			uint16_t seg, uint8_t start, int *endp);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
-- 
1.7.1


