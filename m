Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
Date: Thu, 22 Feb 2018 14:59:20 +0200
Message-Id: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's used in several places and more users may come.
By using this helper they may create a slightly cleaner code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 46e151172d95..241c27008c70 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -147,4 +147,11 @@ static inline const struct dmi_system_id *
 
 #endif
 
+static inline int dmi_get_bios_year(void)
+{
+	int year;
+	dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL);
+	return year;
+}
+
 #endif	/* __DMI_H__ */
-- 
2.16.1

