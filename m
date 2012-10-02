Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:21994 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab2JBGdK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:10 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 07/10] PCI, ACPI: Remove not used acpi_pci_root_start()
Date: Mon,  1 Oct 2012 23:33:05 -0700
Message-Id: <1349159588-15029-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_add_bus_devices has been moved out.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e63a58d..8134f72 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -47,7 +47,6 @@ ACPI_MODULE_NAME("pci_root");
 #define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device);
 static int acpi_pci_root_remove(struct acpi_device *device, int type);
-static int acpi_pci_root_start(struct acpi_device *device);
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_EXT_PCI_CONFIG_SUPPORT \
 				| OSC_ACTIVE_STATE_PWR_SUPPORT \
@@ -67,7 +66,6 @@ static struct acpi_driver acpi_pci_root_driver = {
 	.ops = {
 		.add = acpi_pci_root_add,
 		.remove = acpi_pci_root_remove,
-		.start = acpi_pci_root_start,
 		},
 };
 
@@ -623,6 +621,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	if (system_state != SYSTEM_BOOTING)
 		pci_enable_bridges(root->bus);
 
+	pci_bus_add_devices(root->bus);
+
 	return 0;
 
 out_del_root:
@@ -634,16 +634,6 @@ end:
 	return result;
 }
 
-static int acpi_pci_root_start(struct acpi_device *device)
-{
-	struct acpi_pci_root *root = acpi_driver_data(device);
-
-
-	pci_bus_add_devices(root->bus);
-
-	return 0;
-}
-
 static int acpi_pci_root_remove(struct acpi_device *device, int type)
 {
 	acpi_status status;
-- 
1.7.7

