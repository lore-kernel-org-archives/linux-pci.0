Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33882 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbbEUNxV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 09:53:21 -0400
Received: by pabru16 with SMTP id ru16so106186735pab.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2015 06:53:21 -0700 (PDT)
From: Hanjun Guo <hanjun.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] ACPI / PCI: remove stale list_head in struct acpi_prt_entry
Date: Thu, 21 May 2015 21:52:32 +0800
Message-Id: <1432216352-8016-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

list_head "list" in struct acpi_prt_entry was used to connect
_PRT entries for PCI irq, but after commit 181380b7 (PCI/ACPI:
Don't cache _PRT, and don't associate them with bus numbers),
the list head for _PRT entries was removed, but left "list" in
struct acpi_prt_entry which is useless and stale, remove it now.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Yinghai Lu <yinghai@kernel.org>
CC: Yijing Wang <wangyijing@huawei.com>
---
 drivers/acpi/pci_irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index b1def41..03e4b6c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -44,7 +44,6 @@
 ACPI_MODULE_NAME("pci_irq");
 
 struct acpi_prt_entry {
-	struct list_head	list;
 	struct acpi_pci_id	id;
 	u8			pin;
 	acpi_handle		link;
-- 
1.7.12.4

