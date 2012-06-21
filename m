Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:25324 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759223Ab2FUJwP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:52:15 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v9 11/11] ACPI: mark acpi_sfi_table_parse() as __init
Date: Thu, 21 Jun 2012 17:37:03 +0800
Message-ID: <1340271423-4352-12-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mark function acpi_sfi_table_parse() as __init to avoid warning messages:
WARNING: vmlinux.o(.text+0x4cd2d2): Section mismatch in reference from the
function acpi_sfi_table_parse.clone.0() to the function

Function acpi_sfi_table_parse() calls acpi_table_parse() and pci_parse_mcfg(),
which are both marked as __init. And currently acpi_sfi_table_parse() is used
by MMCONFIG to scan MCFG table at boot time only, so it's safe to mark
acpi_sfi_table_parse() as __init.

.init.text:pci_parse_mcfg()

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 include/linux/sfi_acpi.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
index c4a5a8c..631af63 100644
--- a/include/linux/sfi_acpi.h
+++ b/include/linux/sfi_acpi.h
@@ -66,7 +66,7 @@ extern int sfi_acpi_table_parse(char *signature, char *oem_id,
 				char *oem_table_id,
 				int (*handler)(struct acpi_table_header *));
 
-static inline int acpi_sfi_table_parse(char *signature,
+static inline int __init acpi_sfi_table_parse(char *signature,
 				int (*handler)(struct acpi_table_header *))
 {
 	if (!acpi_table_parse(signature, handler))
@@ -83,7 +83,7 @@ static inline int sfi_acpi_table_parse(char *signature, char *oem_id,
 	return -1;
 }
 
-static inline int acpi_sfi_table_parse(char *signature,
+static inline int __init acpi_sfi_table_parse(char *signature,
 				int (*handler)(struct acpi_table_header *))
 {
 	return acpi_table_parse(signature, handler);
-- 
1.7.1


