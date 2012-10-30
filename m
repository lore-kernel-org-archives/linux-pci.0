Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 8/8] PCI, ACPI: remove acpi_root_driver in reserse order
Date: Tue, 30 Oct 2012 10:42:45 -0700
Message-Id: <1351618965-16761-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
References: <20121030040237.GA10472@google.com>
 <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

aka stop acpi root driver in this sequence: acpiphp, iommu, ioapic.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/acpi/pci_root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a27cbb57..012f40d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -672,7 +672,7 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 	pci_stop_root_bus(root->bus);
 
 	mutex_lock(&acpi_pci_root_lock);
-	list_for_each_entry(driver, &acpi_pci_drivers, node)
+	list_for_each_entry_reverse(driver, &acpi_pci_drivers, node)
 		if (driver->remove)
 			driver->remove(root);
 	mutex_unlock(&acpi_pci_root_lock);
-- 
1.7.7

