Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:42125 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521Ab3FCNSs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 09:18:48 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so5646574pbc.25
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2013 06:18:47 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI, ACPI: use dev_printk() to keep messages consistent
Date: Mon,  3 Jun 2013 21:16:31 +0800
Message-Id: <1370265391-18236-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo5mtYxWkVn+DTT4Sswp0RkWBM=prhtViMJ+KoLpOMY1hw@mail.gmail.com>-s>
References: <CAErSpo5mtYxWkVn+DTT4Sswp0RkWBM=prhtViMJ+KoLpOMY1hw@mail.gmail.com>-s>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As pointed out by Bjorn that acpi_handle_printk() generates messages
like "ACPI: \_SB_.PCI0: xxxxx" and dev_printk() generates messages
like "acpi PNP0A08:00: xxxx", so use dev_printk() to keep messages
consistent when possible.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
Hi Bjorn,
	Could you please help to fold this patch onto "PCI/ACPI: Use
acpi_handle_print() and pr_xxx() to print messages" of branch
"pci/jiang-remove-global-list"?
Thanks!
Gerry
---
 drivers/acpi/pci_root.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 73a934d..4a8f5b4 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -388,7 +388,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
 				       &segment);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		acpi_handle_err(handle, "can't evaluate _SEG\n");
+		dev_err(&device->dev,  "can't evaluate _SEG\n");
 		result = -ENODEV;
 		goto end;
 	}
@@ -404,8 +404,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		 * can do is assume [_BBN-0xFF] or [0-0xFF].
 		 */
 		root->secondary.end = 0xFF;
-		acpi_handle_warn(handle,
-				 FW_BUG "no secondary bus range in _CRS\n");
+		dev_warn(&device->dev,
+			 FW_BUG "no secondary bus range in _CRS\n");
 		status = acpi_evaluate_integer(handle, METHOD_NAME__BBN,
 					       NULL, &bus);
 		if (ACPI_SUCCESS(status))
@@ -413,7 +413,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		else if (status == AE_NOT_FOUND)
 			root->secondary.start = 0;
 		else {
-			acpi_handle_err(handle, "can't evaluate _BBN\n");
+			dev_err(&device->dev, "can't evaluate _BBN\n");
 			result = -ENODEV;
 			goto end;
 		}
@@ -451,9 +451,9 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	 */
 	root->bus = pci_acpi_scan_root(root);
 	if (!root->bus) {
-		acpi_handle_err(handle,
-			    "Bus %04x:%02x not present in PCI namespace\n",
-			    root->segment, (unsigned int)root->secondary.start);
+		dev_err(&device->dev,
+			"Bus %04x:%02x not present in PCI namespace\n",
+			root->segment, (unsigned int)root->secondary.start);
 		result = -ENODEV;
 		goto end;
 	}
@@ -511,8 +511,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 				"ACPI _OSC request failed (%s), "
 				"returned control mask: 0x%02x\n",
 				acpi_format_exception(status), flags);
-			acpi_handle_info(handle,
-					 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
+			dev_info(&device->dev,
+				 "ACPI _OSC control for PCIe not granted, disabling ASPM\n");
 			pcie_no_aspm();
 		}
 	} else {
-- 
1.8.1.2

