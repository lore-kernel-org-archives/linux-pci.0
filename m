Return-Path: <linux-kernel-owner@vger.kernel.org>
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
        Hans De Goede <hdegoede@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 5/8] PM / sleep: Print timing information if debug is enabled
Date: Mon, 12 Jun 2017 22:51:55 +0200
Message-ID: <7222456.034JZvbkBs@aspire.rjw.lan>
In-Reply-To: <1615075.mBkoKApGGc@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan> <1615075.mBkoKApGGc@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Avoid printing the device suspend/resume timing information if
CONFIG_PM_DEBUG is not set to reduce the log noise level.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -417,6 +417,7 @@ static void pm_dev_err(struct device *de
 		dev_name(dev), pm_verb(state.event), info, error);
 }
 
+#ifdef CONFIG_PM_DEBUG
 static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
 {
 	ktime_t calltime;
@@ -433,6 +434,9 @@ static void dpm_show_time(ktime_t startt
 		info ?: "", info ? " " : "", pm_verb(state.event),
 		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
 }
+#else
+static inline void dpm_show_time(ktime_t starttime, pm_message_t state, char *info) {}
+#endif /* CONFIG_PM_DEBUG */
 
 static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 			    pm_message_t state, char *info)
