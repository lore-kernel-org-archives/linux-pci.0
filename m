Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>, Lukas Wunner <lukas@wunner.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] firmware: dmi_scan: Uninline dmi_get_bios_year() helper
Date: Tue, 20 Mar 2018 15:54:10 +0200
Message-Id: <20180320135410.11627-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Uninline dmi_get_bios_year() which, in particular, allows us
to optimize it in the future.

While doing this, convert the function to return an error code
when BIOS date is not present, parsable or CONFIG_DMI=n.

Additionally, during the move, add a bit of documentation.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/dmi_scan.c | 20 ++++++++++++++++++++
 include/linux/dmi.h         | 11 ++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index ae4f1b181c23..bfb6ce6abc83 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -1040,6 +1040,26 @@ bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 }
 EXPORT_SYMBOL(dmi_get_date);
 
+/**
+ *	dmi_get_bios_year - get a year out of DMI_BIOS_DATE field
+ *
+ *	Returns year on success, -ENXIO if DMI is not selected,
+ *	or a different negative error code if DMI field is not present
+ *	or not parsable.
+ */
+int dmi_get_bios_year(void)
+{
+	bool exists;
+	int year;
+
+	exists = dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+	if (!exists)
+		return -ENODATA;
+
+	return year ? year : -ERANGE;
+}
+EXPORT_SYMBOL(dmi_get_bios_year);
+
 /**
  *	dmi_walk - Walk the DMI table and get called back for every record
  *	@decode: Callback function
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index b5b8c26b04fb..c46fdb36700b 100644
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
@@ -134,6 +135,7 @@ static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp)
 		*dayp = 0;
 	return false;
 }
+static inline int dmi_get_bios_year(void) { return -ENXIO; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
 static inline int dmi_name_in_serial(const char *s) { return 0; }
 #define dmi_available 0
@@ -149,13 +151,4 @@ static inline const struct dmi_system_id *
 
 #endif
 
-static inline int dmi_get_bios_year(void)
-{
-	int year;
-
-	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
-
-	return year;
-}
-
 #endif	/* __DMI_H__ */
-- 
2.16.2

