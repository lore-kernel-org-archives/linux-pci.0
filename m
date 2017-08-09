Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lv Zheng <lv.zheng@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/3] ACPI / scan: Enable GPEs before scanning the namespace
Date: Thu, 10 Aug 2017 00:34:23 +0200
Message-ID: <6344941.kJ2o2XerZ0@aspire.rjw.lan>
In-Reply-To: <12346760.yAFCnkEgf6@aspire.rjw.lan>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some systems the platform firmware expects GPEs to be enabled
before the enumeration of devices and if that expectation is not
met, the systems in question may not boot in some situations.

For this reason, change the initialization ordering of the ACPI
subsystem to make it enable GPEs before scanning the namespace
for the first time in order to enumerate devices.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2139,6 +2139,10 @@ int __init acpi_scan_init(void)
 			acpi_get_spcr_uart_addr();
 	}
 
+	acpi_gpe_apply_masked_gpes();
+	acpi_update_all_gpes();
+	acpi_ec_ecdt_start();
+
 	mutex_lock(&acpi_scan_lock);
 	/*
 	 * Enumerate devices in the ACPI namespace.
@@ -2163,10 +2167,6 @@ int __init acpi_scan_init(void)
 		}
 	}
 
-	acpi_gpe_apply_masked_gpes();
-	acpi_update_all_gpes();
-	acpi_ec_ecdt_start();
-
 	acpi_scan_initialized = true;
 
  out:


