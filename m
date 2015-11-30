Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31815 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719AbbK3TD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Nov 2015 14:03:27 -0500
From: Imre Deak <imre.deak@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Linux PM <linux-pm@vger.kernel.org>,
	intel-gfx@lists.freedesktop.org,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v5] PCI / PM: Tune down retryable runtime suspend error messages
Date: Mon, 30 Nov 2015 21:02:55 +0200
Message-Id: <1448910175-5904-1-git-send-email-imre.deak@intel.com>
In-Reply-To: <1448699664-4178-1-git-send-email-imre.deak@intel.com>
References: <1448699664-4178-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The runtime PM core doesn't treat EBUSY and EAGAIN retvals from the driver
suspend hooks as errors, but they still show up as errors in dmesg. Tune
them down. See rpm_suspend() for details of handling these return values.

Note that we use dev_dbg() for the retryable retvals, so after this
change you'll need either CONFIG_DYNAMIC_DEBUG or CONFIG_PCI_DEBUG
for them to show up in the log.

One problem caused by this was noticed by Daniel: the i915 driver
returns EAGAIN to signal a temporary failure to suspend and as a request
towards the RPM core for scheduling a suspend again. This is a normal
event, but the resulting error message flags a breakage during the
driver's automated testing which parses dmesg and picks up the error.

Reported-by: Daniel Vetter <daniel.vetter@intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92992
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>

---

v2:
- fix compile breake when CONFIG_PM_SLEEP=n (0-day builder)
v3:
- instead of modifying the suspend_report_result() helper to disinguish
  between the runtime and system suspend case, inline the error
  printing, it's not used anywhere else (Rafael)
v4:
- don't refer to log levels as flags in code comment (Rafael)
- use pr_debug(), pr_err() instead of the corresponding printk() (Rafael)
v5:
- clarify commit message (Bjorn)
- use dev_dbg, dev_err instead of pr_debug, pr_err (Bjorn)
- use %pf in printk format instead of %pF (Bjorn)
- make the debug/error messages more meaningful (Bjorn)
---
 drivers/pci/pci-driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4446fcb..d7ffd66 100644
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
+			dev_dbg(dev, "can't suspend now (%pf returned %d)\n",
+				pm->runtime_suspend, error);
+		else
+			dev_err(dev, "can't suspend (%pf returned %d)\n",
+				pm->runtime_suspend, error);
+
 		return error;
+	}
 	if (!pci_dev->d3cold_allowed)
 		pci_dev->no_d3cold = true;
 
-- 
2.5.0

