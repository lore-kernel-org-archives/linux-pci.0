Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] ACPI / sleep: Simplify code by using the new dmi_get_bios_year() helper
Date: Thu,  1 Mar 2018 20:02:19 +0200
Message-Id: <20180301180220.11333-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use new dmi_get_bios_year() helper instead of open-coding its
functionality.

No changes in functionality.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/sleep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index c53119740a3c..23d9e6b88504 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -376,12 +376,10 @@ void __init acpi_sleep_no_blacklist(void)
 
 static void __init acpi_sleep_dmi_check(void)
 {
-	int year;
-
 	if (ignore_blacklist)
 		return;
 
-	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2012)
+	if (dmi_get_bios_year() >= 2012)
 		acpi_nvs_nosave_s3();
 
 	dmi_check_system(acpisleep_dmi_table);
-- 
2.16.1

