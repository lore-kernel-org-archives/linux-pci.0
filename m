Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:55125 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdAOUGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2017 15:06:15 -0500
Message-Id: <9deb018c4b1286ccd69bb264f1a784148c4b3d16.1484486499.git.lukas@wunner.de>
In-Reply-To: <cover.1484486499.git.lukas@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Jan 2017 21:03:45 +0100
Subject: [PATCH v5 6/8] PM / sleep: Define constant for direct_complete
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>, Lee Jones <lee.jones@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
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

