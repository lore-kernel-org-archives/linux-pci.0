Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:36411 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdAOUHD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2017 15:07:03 -0500
Message-Id: <2422ada28df350e51b025884b9c6cd7f4242a1cd.1484486499.git.lukas@wunner.de>
In-Reply-To: <cover.1484486499.git.lukas@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 15 Jan 2017 21:03:45 +0100
Subject: [PATCH v5 8/8] thunderbolt: Runtime suspend NHI when idle
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Runtime suspend the NHI when no Thunderbolt devices have been plugged in
for 10 sec (user-configurable via autosuspend_delay_ms in sysfs).

The NHI is not able to detect plug events while suspended, it relies on
the GPE handler to resume it on hotplug.

After the NHI resumes, it takes about 700 ms until a hotplug event
appears on the RX ring.  In case autosuspend_delay_ms has been reduced
to 0 by the user, we need to wait in tb_resume() to avoid going back to
sleep before we had a chance to detect a hotplugged device.  A runtime
pm ref is held for the duration of tb_handle_hotplug() to keep the NHI
awake while the hotplug event is processed.

Apart from that we acquire a runtime pm ref for each newly allocated
switch (except for the root switch) and drop one when a switch is freed,
thereby ensuring the NHI stays active as long as devices are plugged in.
This behaviour is identical to the macOS driver.

Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/nhi.c    |  2 ++
 drivers/thunderbolt/power.c  |  9 +++++++++
 drivers/thunderbolt/switch.c |  9 +++++++++
 drivers/thunderbolt/tb.c     | 13 +++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 88fb2fb8cf4e..319ed81422c5 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -632,6 +632,8 @@ static const struct dev_pm_ops nhi_pm_ops = {
 					    * pci-tunnels stay alive.
 					    */
 	.restore_noirq = nhi_resume_noirq,
+	.runtime_suspend = nhi_suspend_noirq,
+	.runtime_resume = nhi_resume_noirq,
 };
 
 static struct pci_device_id nhi_ids[] = {
diff --git a/drivers/thunderbolt/power.c b/drivers/thunderbolt/power.c
index 6e7ef07f4aa9..06f535c932e0 100644
--- a/drivers/thunderbolt/power.c
+++ b/drivers/thunderbolt/power.c
@@ -319,6 +319,12 @@ void thunderbolt_power_init(struct tb *tb)
 
 	tb->power = power;
 
+	pm_runtime_allow(nhi_dev);
+	pm_runtime_set_autosuspend_delay(nhi_dev, 10000);
+	pm_runtime_use_autosuspend(nhi_dev);
+	pm_runtime_mark_last_busy(nhi_dev);
+	pm_runtime_put_autosuspend(nhi_dev);
+
 	return;
 
 err_free:
@@ -335,6 +341,9 @@ void thunderbolt_power_fini(struct tb *tb)
 	if (!power)
 		return; /* thunderbolt_power_init() failed */
 
+	pm_runtime_get(nhi_dev);
+	pm_runtime_forbid(nhi_dev);
+
 	tb->power = NULL;
 	dev_pm_domain_set(upstream_dev, NULL);
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c6f30b1695a9..422fe6e96f09 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "tb.h"
@@ -326,6 +327,11 @@ void tb_switch_free(struct tb_switch *sw)
 	if (!sw->is_unplugged)
 		tb_plug_events_active(sw, false);
 
+	if (sw != sw->tb->root_switch) {
+		pm_runtime_mark_last_busy(&sw->tb->nhi->pdev->dev);
+		pm_runtime_put_autosuspend(&sw->tb->nhi->pdev->dev);
+	}
+
 	kfree(sw->ports);
 	kfree(sw->drom);
 	kfree(sw);
@@ -420,6 +426,9 @@ struct tb_switch *tb_switch_alloc(struct tb *tb, u64 route)
 	if (tb_plug_events_active(sw, true))
 		goto err;
 
+	if (tb->root_switch)
+		pm_runtime_get(&tb->nhi->pdev->dev);
+
 	return sw;
 err:
 	kfree(sw->ports);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 24b6d30c3c86..a3fedf90e545 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -217,8 +218,11 @@ static void tb_handle_hotplug(struct work_struct *work)
 {
 	struct tb_hotplug_event *ev = container_of(work, typeof(*ev), work);
 	struct tb *tb = ev->tb;
+	struct device *dev = &tb->nhi->pdev->dev;
 	struct tb_switch *sw;
 	struct tb_port *port;
+
+	pm_runtime_get(dev);
 	mutex_lock(&tb->lock);
 	if (!tb->hotplug_active)
 		goto out; /* during init, suspend or shutdown */
@@ -274,6 +278,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 out:
 	mutex_unlock(&tb->lock);
 	kfree(ev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 /**
@@ -433,4 +439,11 @@ void thunderbolt_resume(struct tb *tb)
 	tb->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 	tb_info(tb, "resume finished\n");
+
+	/*
+	 * If runtime resuming due to a hotplug event (rather than resuming
+	 * from system sleep), wait for it to arrive. May take about 700 ms.
+	 */
+	if (tb->nhi->pdev->dev.power.runtime_status == RPM_RESUMING)
+		msleep(1000);
 }
-- 
2.11.0

