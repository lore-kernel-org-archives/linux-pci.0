Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/10] PCI: Add dev parameter to __of_pci_get_host_bridge_resources()
Date: Mon, 30 Apr 2018 07:48:38 +0200
Message-Id: <cfab525f3d0436f75187fbd65907ada909d7692f.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

When non-NULL, use the new dev parameter of
__of_pci_get_host_bridge_resources() to allocate the resource data
structures via devm_kzalloc. That allows to release them automatically
during device destruction.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 375de447a58e..bfa282b538d5 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -243,7 +243,7 @@ void of_pci_check_probe_only(void)
 EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
 
 #if defined(CONFIG_OF_ADDRESS)
-static int __of_pci_get_host_bridge_resources(
+static int __of_pci_get_host_bridge_resources(struct device *dev,
 			struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
@@ -259,7 +259,10 @@ static int __of_pci_get_host_bridge_resources(
 	if (io_base)
 		*io_base = (resource_size_t)OF_BAD_ADDR;
 
-	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
+	if (dev)
+		bus_range = devm_kzalloc(dev,sizeof(*bus_range), GFP_KERNEL);
+	else
+		bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
 	if (!bus_range)
 		return -ENOMEM;
 
@@ -303,7 +306,11 @@ static int __of_pci_get_host_bridge_resources(
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;
 
-		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+		if (dev)
+			res = devm_kzalloc(dev, sizeof(struct resource),
+					   GFP_KERNEL);
+		else
+			res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 		if (!res) {
 			err = -ENOMEM;
 			goto parse_failed;
@@ -365,7 +372,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev_node,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
-	return __of_pci_get_host_bridge_resources(dev_node, busno,
+	return __of_pci_get_host_bridge_resources(NULL, dev_node, busno,
 						  bus_max, resources, io_base);
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.13.6
