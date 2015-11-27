Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29636 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbbK0SRh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Nov 2015 13:17:37 -0500
From: Imre Deak <imre.deak@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Linux PM <linux-pm@vger.kernel.org>,
	intel-gfx@lists.freedesktop.org,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v3] PCI / PM: tune down RPM suspend error message with EBUSY and EAGAIN retval
Date: Fri, 27 Nov 2015 20:17:34 +0200
Message-Id: <1448648254-12639-1-git-send-email-imre.deak@intel.com>
In-Reply-To: <1447844188-21999-1-git-send-email-imre.deak@intel.com>
References: <1447844188-21999-1-git-send-email-imre.deak@intel.com>
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

Reported-by: Daniel Vetter <daniel.vetter@intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92992
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/pci/pci-driver.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4446fcb..67eb4ac 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1146,9 +1146,20 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_dev->state_saved = false;
 	pci_dev->no_d3cold = false;
 	error = pm->runtime_suspend(dev);
-	suspend_report_result(pm->runtime_suspend, error);
-	if (error)
+	if (error) {
+		/*
+		 * -EBUSY and -EAGAIN is used to request the runtime PM core
+		 * to schedule a new suspend, so don't flag it as an error.
+		 */
+		if (error == -EBUSY || error == -EAGAIN)
+			printk(KERN_DEBUG "%s(): %pF returns %d\n", __func__,
+			       pm->runtime_suspend, error);
+		else
+			printk(KERN_ERR "%s(): %pF returns %d\n", __func__,
+			       pm->runtime_suspend, error);
+
 		return error;
+	}
 	if (!pci_dev->d3cold_allowed)
 		pci_dev->no_d3cold = true;
 
-- 
2.5.0

