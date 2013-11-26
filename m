Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44659 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab3KZLEy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 06:04:54 -0500
Received: by mail-lb0-f180.google.com with SMTP id w6so4149275lbh.25
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2013 03:04:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/2] PM / Runtime: Add second macro for definition of runtime PM callbacks
Date: Tue, 26 Nov 2013 12:04:45 +0100
Message-Id: <1385463886-9335-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is allowed and will in many cases make sense to have the runtime PM
callbacks to be defined for CONFIG_PM instead of CONFIG_PM_RUNTIME.

Since the PM core disables runtime PM during system suspend, before the
.suspend_late callbacks are invoked, drivers could at this point
directly invoke it's runtime PM callbacks or even walk through it's bus
or power domain, to put it's device into low power state.

Use the new macro SET_PM_RUNTIME_PM_OPS in cases were the above makes
sense. Make sure the callbacks are encapsulated within CONFIG_PM
instead of CONFIG_PM_RUNTIME.

Do note that the old macro SET_RUNTIME_PM_OPS, which is being quite
widely used right now, requires the callbacks to be defined for
CONFIG_PM_RUNTIME. In many cases it will certainly be convenient to
convert to the new macro above, but still some cases are optimal for
only CONFIG_PM_RUNTIME.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..7a830a7 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -320,6 +320,15 @@ struct dev_pm_ops {
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
 
+#ifdef CONFIG_PM
+#define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+#else
+#define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
+#endif
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
-- 
1.7.9.5

