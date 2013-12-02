Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
In-reply-to: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Subject: [PATCH 38/39] PCI: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 03 Dec 2013 08:32:16 +0900
Message-id: <003b01ceefb6$bca43ed0$35ecbc70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred. Also, the definition of DEFINE_PCI_DEVICE_TABLE
macro is removed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 Documentation/PCI/pci.txt |    3 +--
 drivers/pci/ioapic.c      |    2 +-
 include/linux/pci.h       |   10 ----------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index 6f45856..2f14be7 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -123,8 +123,7 @@ initialization with a pointer to a structure describing the driver
 
 
 The ID table is an array of struct pci_device_id entries ending with an
-all-zero entry; use of the macro DEFINE_PCI_DEVICE_TABLE is the preferred
-method of declaring the table.  Each entry consists of:
+all-zero entry; Each entry consists of:
 
 	vendor,device	Vendor and device ID to match (or PCI_ANY_ID)
 
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 50ce680..d9d249a2 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -99,7 +99,7 @@ static void ioapic_remove(struct pci_dev *dev)
 }
 
 
-static DEFINE_PCI_DEVICE_TABLE(ioapic_devices) = {
+static const struct pci_device_id ioapic_devices[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOAPIC, ~0) },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SYSTEM_PIC_IOXAPIC, ~0) },
 	{ }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15..6c1f6af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -631,16 +631,6 @@ struct pci_driver {
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
- * DEFINE_PCI_DEVICE_TABLE - macro used to describe a pci device table
- * @_table: device table name
- *
- * This macro is used to create a struct pci_device_id array (a device table)
- * in a generic manner.
- */
-#define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[]
-
-/**
  * PCI_DEVICE - macro used to describe a specific pci device
  * @vend: the 16 bit PCI Vendor ID
  * @dev: the 16 bit PCI Device ID
-- 
1.7.10.4


