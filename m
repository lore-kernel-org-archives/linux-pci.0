Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:60165 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab3KZLE6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 06:04:58 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so2259773lam.11
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2013 03:04:57 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 2/2] PM / Sleep: Add macro to define common late/early system PM callbacks
Date: Tue, 26 Nov 2013 12:04:46 +0100
Message-Id: <1385463886-9335-2-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1385463886-9335-1-git-send-email-ulf.hansson@linaro.org>
References: <1385463886-9335-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We use the same approach as for the existing SET_SYSTEM_SLEEP_PM_OPS,
but for the late and early callbacks instead.

The new SET_LATE_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
point ->suspend_late, ->freeze_late and ->poweroff_late to the same
function. Vice verse happens for ->resume_early, ->thaw_early and
->restore_early.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 7a830a7..8c6583a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -311,6 +311,18 @@ struct dev_pm_ops {
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_late = suspend_fn, \
+	.resume_early = resume_fn, \
+	.freeze_late = suspend_fn, \
+	.thaw_early = resume_fn, \
+	.poweroff_late = suspend_fn, \
+	.restore_early = resume_fn,
+#else
+#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#endif
+
 #ifdef CONFIG_PM_RUNTIME
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	.runtime_suspend = suspend_fn, \
-- 
1.7.9.5

