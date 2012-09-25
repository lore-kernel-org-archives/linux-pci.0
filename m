Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 07/29] PCI, ACPI: add acpi_bus_type for host bridge
Date: Tue, 25 Sep 2012 01:26:08 -0700
Message-Id: <1348561590-28067-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of abusing of acp_bus_type for pci device and checking device
name tricks

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/glue.c    |    4 ++--
 drivers/pci/pci-acpi.c |   13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 243ee85..3079634 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -210,8 +210,8 @@ static int acpi_platform_notify(struct device *dev)
 	acpi_handle handle;
 	int ret = -EINVAL;
 
-	if (!dev->bus || !dev->parent) {
-		/* bridge devices genernally haven't bus or parent */
+	if (!dev->bus) {
+		/* bridge devices genernally haven't bus */
 		ret = acpi_find_bridge_device(dev, &handle);
 		goto end;
 	}
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c5792d6..a167f6d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -360,7 +360,8 @@ static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
 	return 0;
 }
 
-static int acpi_pci_find_root_bridge(struct device *dev, acpi_handle *handle)
+static int acpi_pci_host_bridge_find_device(struct device *dev,
+						acpi_handle *handle)
 {
 	int num;
 	unsigned int seg, bus;
@@ -378,10 +379,14 @@ static int acpi_pci_find_root_bridge(struct device *dev, acpi_handle *handle)
 	return 0;
 }
 
+static struct acpi_bus_type acpi_pci_host_bridge_bus = {
+	.bus = &pci_host_bridge_bus_type,
+	.find_device = acpi_pci_host_bridge_find_device,
+};
+
 static struct acpi_bus_type acpi_pci_bus = {
 	.bus = &pci_bus_type,
 	.find_device = acpi_pci_find_device,
-	.find_bridge = acpi_pci_find_root_bridge,
 };
 
 static int __init acpi_pci_init(void)
@@ -398,6 +403,10 @@ static int __init acpi_pci_init(void)
 		pcie_no_aspm();
 	}
 
+	ret = register_acpi_bus_type(&acpi_pci_host_bridge_bus);
+	if (ret)
+		return 0;
+
 	ret = register_acpi_bus_type(&acpi_pci_bus);
 	if (ret)
 		return 0;
-- 
1.7.7

