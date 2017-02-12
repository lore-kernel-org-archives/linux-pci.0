Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <996cae2518fb2bee8988481a18487b8aab4de2a0.1486913733.git.lukas@wunner.de>
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 6/8] PM / sleep: Define constant for direct_complete
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-ID: <linux-pci.vger.kernel.org>

From: Chen Yu <yu.c.chen@intel.com>

The PM core introduced the ability to keep devices runtime suspended
during the entire system sleep process with commit aae4518b3124
("PM / sleep: Mechanism to avoid resuming runtime-suspended devices
unnecessarily").

Drivers opt in to this so-called "direct_complete" mechanism by
returning a positive value from their ->prepare hook.  Usually this is
achieved with a "return 1;" statement, which looks somewhat cryptic to
readers not intimately familiar with the PM core.

Improve clarity by defining a DPM_DIRECT_COMPLETE constant which drivers
may use instead.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
[LW: separate this hunk out of mfd patch, add commit message]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/pm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index f926af41e122..2d651a30b35c 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -788,4 +788,11 @@ enum dpm_order {
 	DPM_ORDER_DEV_LAST,
 };
 
+/*
+ * Return this from system suspend/hibernation ->prepare() callback to
+ * request the core to leave the device runtime-suspended during system
+ * suspend if possible.
+ */
+#define DPM_DIRECT_COMPLETE 1
+
 #endif /* _LINUX_PM_H */
-- 
2.11.0
