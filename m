Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans De Goede <hdegoede@redhat.com>
Subject: [PATCH 3/6] ACPI / PM: Change log level of wakeup-related message
Date: Thu, 08 Jun 2017 02:03:33 +0200
Message-ID: <9422539.lDExOtEzqW@aspire.rjw.lan>
In-Reply-To: <8918199.uo13RZ8hZk@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Change the log level of the "System wakeup enabled/disabled by ACPI"
message in acpi_pm_device_sleep_wake() to "debug" to reduce to log
noise level.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -756,8 +756,8 @@ int acpi_pm_device_sleep_wake(struct dev
 
 	error = acpi_device_wakeup(adev, acpi_target_system_state(), enable);
 	if (!error)
-		dev_info(dev, "System wakeup %s by ACPI\n",
-				enable ? "enabled" : "disabled");
+		dev_dbg(dev, "System wakeup %s by ACPI\n",
+			enable ? "enabled" : "disabled");
 
 	return error;
 }

