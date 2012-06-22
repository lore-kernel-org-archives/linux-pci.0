Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761253Ab2FVG6P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:58:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:58:15 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v10 12/13] ACPI: mark acpi_sfi_table_parse() as __init
Date: Fri, 22 Jun 2012 14:55:21 +0800
Message-Id: <1340348122-29021-13-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
References: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

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
 1 file changed, 2 insertions(+), 2 deletions(-)

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
1.7.9.5

