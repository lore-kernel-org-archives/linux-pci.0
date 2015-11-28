Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37364 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbbK1Ie1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 28 Nov 2015 03:34:27 -0500
From: Imre Deak <imre.deak@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v4] PCI / PM: tune down RPM suspend error message with EBUSY and EAGAIN retval
Date: Sat, 28 Nov 2015 10:34:24 +0200
Message-Id: <1448699664-4178-1-git-send-email-imre.deak@intel.com>
In-Reply-To: <1448648254-12639-1-git-send-email-imre.deak@intel.com>
References: <1448648254-12639-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The runtime PM core doesn't treat EBUSY and EAGAIN retvals from the driver
suspend hooks as errors, but they still show up as errors in dmesg. Tune
them down.

One problem caused by this was noticed by Daniel: the i915 driver
returns EAGAIN to signal a temporary failure to suspend and as a request
towards the RPM core for scheduling a suspend again. This is a normal
event, but the resulting error message flags a breakage during the
driver's automated testing which parses dmesg and picks up the error.

v2:
- fix compile breake when CONFIG_PM_SLEEP=n (0-day builder)
v3:
- instead of modifying the suspend_report_result() helper to disinguish
  between the runtime and system suspend case, inline the error
  printing, it's not used anywhere else (Rafael)
v4:
- don't refer to log levels as flags in code comment (Rafael)
- use pr_debug(), pr_err() instead of the corresponding printk() (Rafael)

Reported-by: Daniel Vetter <daniel.vetter@intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92992
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/pci/pci-driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4446fcb..32a9947 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1146,9 +1146,21 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_dev->state_saved = false;
 	pci_dev->no_d3cold = false;
 	error = pm->runtime_suspend(dev);
-	suspend_report_result(pm->runtime_suspend, error);
-	if (error)
+	if (error) {
+		/*
+		 * -EBUSY and -EAGAIN is used to request the runtime PM core
+		 * to schedule a new suspend, so log the event only with debug
+		 * log level.
+		 */
+		if (error == -EBUSY || error == -EAGAIN)
+			pr_debug("%s(): %pF returns %d\n", __func__,
+				 pm->runtime_suspend, error);
+		else
+			pr_err("%s(): %pF returns %d\n", __func__,
+			       pm->runtime_suspend, error);
+
 		return error;
+	}
 	if (!pci_dev->d3cold_allowed)
 		pci_dev->no_d3cold = true;
 
-- 
2.5.0

