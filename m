Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50504 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033679AbeCASC0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 13:02:26 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] firmware: dmi_scan: Introduce the dmi_get_bios_year() helper
Date: Thu,  1 Mar 2018 20:02:17 +0200
Message-Id: <20180301180220.11333-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pattern to only extract the year portion of date is used in
several places and more users may come.

By using this helper they may create slightly cleaner code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/dmi_scan.c | 11 +++++++++++
 include/linux/dmi.h         |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 6ce299926196..616ec17cc802 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -1015,6 +1015,17 @@ bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 }
 EXPORT_SYMBOL(dmi_get_date);
 
+int dmi_get_bios_year(void)
+{
+	bool exists;
+	int year;
+
+	exists = dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+
+	return exists ? year : -ENODATA;
+}
+EXPORT_SYMBOL(dmi_get_bios_year);
+
 /**
  *	dmi_walk - Walk the DMI table and get called back for every record
  *	@decode: Callback function
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 46e151172d95..6a86d8db16d9 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -106,6 +106,7 @@ extern void dmi_scan_machine(void);
 extern void dmi_memdev_walk(void);
 extern void dmi_set_dump_stack_arch_desc(void);
 extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
+extern int dmi_get_bios_year(void);
 extern int dmi_name_in_vendors(const char *str);
 extern int dmi_name_in_serial(const char *str);
 extern int dmi_available;
@@ -133,6 +134,7 @@ static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 		*dayp = 0;
 	return false;
 }
+static inline int dmi_get_bios_year(void) { return -ENXIO; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 static inline int dmi_name_in_serial(const char *s) { return 0; }
 #define dmi_available 0
-- 
2.16.1
