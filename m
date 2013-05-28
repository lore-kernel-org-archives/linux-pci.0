Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:44794 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab3E1IEe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 04:04:34 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Replace printks with appropriate pr_*()
Date: Tue, 28 May 2013 16:03:46 +0800
Message-ID: <1369728226-25936-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace deprecated printk(KERN_ERR...) with pr_err() in pci-acpi.c

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e4b1fb2..6c15d6a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -376,12 +376,12 @@ static int __init acpi_pci_init(void)
 	int ret;
 
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
-		printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
+		pr_info("ACPI FADT declares the system doesn't support MSI, so disable it\n");
 		pci_no_msi();
 	}
 
 	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
-		printk(KERN_INFO"ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
+		pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
 		pcie_no_aspm();
 	}
 
-- 
1.7.1


