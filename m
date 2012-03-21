Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Liu Jiang <jiang.liu@huawei.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, chenkeping@huawei.com
Subject: [PATCH 1/3] ACPI,PCI: Use normal list for struct acpi_pci_driver
Date: Thu, 22 Mar 2012 00:22:35 +0800
Message-Id: <1332346957-10070-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
References: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liu Jiang <jiang.liu@huawei.com>

Use normal list for struct acpi_pci_driver to simplify code.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/acpi/pci_root.c |   16 +++-------------
 include/linux/acpi.h    |    2 +-
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b38e347..c2d2b7b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -72,8 +72,8 @@ static struct acpi_driver acpi_pci_root_driver = {
 };
 
 static LIST_HEAD(acpi_pci_roots);
+static LIST_HEAD(acpi_pci_drivers);
 
-static struct acpi_pci_driver *sub_driver;
 static DEFINE_MUTEX(osc_lock);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
@@ -81,10 +81,7 @@ int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 	int n = 0;
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr)
-		pptr = &(*pptr)->next;
-	*pptr = driver;
+	list_add_tail(&driver->node, &acpi_pci_drivers);
 
 	if (!driver->add)
 		return 0;
@@ -103,14 +100,7 @@ void acpi_pci_unregister_driver(struct acpi_pci_driver *driver)
 {
 	struct acpi_pci_root *root;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr) {
-		if (*pptr == driver)
-			break;
-		pptr = &(*pptr)->next;
-	}
-	BUG_ON(!*pptr);
-	*pptr = (*pptr)->next;
+	list_del(&driver->node);
 
 	if (!driver->remove)
 		return;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3f96866..efcc6c4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -138,7 +138,7 @@ void acpi_penalize_isa_irq(int irq, int active);
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head node;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };
-- 
1.7.5.4

