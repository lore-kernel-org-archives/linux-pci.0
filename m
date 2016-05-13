Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:43340 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbcEMLYS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:24:18 -0400
Message-Id: <9f0713b23baf7c6139a4b476cd9637d96e18cc95.1463134232.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 11/13] PM / sleep: Allow opt-out from runtime resume after
 direct-complete
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit aae4518b3124 ("PM / sleep: Mechanism to avoid resuming
runtime-suspended devices unnecessarily"), we no longer wake up devices
which are already runtime suspended upon entering system sleep
("direct-complete").

However commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might
have been reset by firmware") changed this to mandatorily runtime resume
such devices after the system is woken.  The motivation was to ensure
that devices do not remain in a reset-power-on state after system
resume, potentially preventing deep SoC-wide low-power states from being
entered on idle.

This is counter-productive for devices of which we know that the
mandatory runtime resume is unnecessary.  Thunderbolt on the Mac is a
case in point: Runtime resume not just powers up the controller, but
multiple adjacent chips, including a 15V boost converter, multiplexers
and an eeprom.  Gratuitously powering this up after every system sleep
burns a not insignificant amount of energy and needlessly strains the
hardware.

Perhaps it would have been better to carry out the mandatory runtime
resume only for those devices that actually need it, but at least we
should allow an opt-out.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/base/power/generic_ops.c | 3 ++-
 include/linux/pm.h               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 07c3c4a..6e88f55 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -316,7 +316,8 @@ void pm_complete_with_resume_check(struct device *dev)
 	 * the sleep state it is going out of and it has never been resumed till
 	 * now, resume it in case the firmware powered it up.
 	 */
-	if (dev->power.direct_complete && pm_resume_via_firmware())
+	if (dev->power.direct_complete && pm_resume_via_firmware() &&
+	    !dev->power.direct_complete_noresume)
 		pm_request_resume(dev);
 }
 EXPORT_SYMBOL_GPL(pm_complete_with_resume_check);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 6a5d654..023de94 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -596,6 +596,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		direct_complete_noresume:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
-- 
2.8.1

