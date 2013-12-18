Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lv Zheng <lv.zheng@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>,
	<linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>, sfi-devel@simplefirmware.org,
	linux-pci@vger.kernel.org
Subject: [RFC PATCH 14/15] ACPI/SFI: Fix wrong <acpi/acpi.h> inclusion in SFI/ACPI wrapper - table definitions.
Date: Wed, 18 Dec 2013 17:07:14 +0800
Message-Id: <fc95924e41ed67b381217ec8c0b9eeee46164360.1387336613.git.lv.zheng@intel.com>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes <acpi/acpi.h> inclusions from <linux/sfi_acpi.h> as
<linux/acpi.h> has already included it for CONFIG_ACPI=n builds.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>
Cc: sfi-devel@simplefirmware.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/linux/sfi_acpi.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/sfi_acpi.h b/include/linux/sfi_acpi.h
index 4723bbf..a6e555c 100644
--- a/include/linux/sfi_acpi.h
+++ b/include/linux/sfi_acpi.h
@@ -63,8 +63,6 @@
 #include <linux/sfi.h>
 
 #ifdef CONFIG_SFI
-#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
-
 extern int sfi_acpi_table_parse(char *signature, char *oem_id,
 				char *oem_table_id,
 				int (*handler)(struct acpi_table_header *));
@@ -78,7 +76,6 @@ static inline int __init acpi_sfi_table_parse(char *signature,
 	return sfi_acpi_table_parse(signature, NULL, NULL, handler);
 }
 #else /* !CONFIG_SFI */
-
 static inline int sfi_acpi_table_parse(char *signature, char *oem_id,
 				char *oem_table_id,
 				int (*handler)(struct acpi_table_header *))
-- 
1.7.10.4

