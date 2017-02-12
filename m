Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Message-Id: <920a91bf915983758d4b19b9dcf28f9fb10c70cb.1486913733.git.lukas@wunner.de>
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Feb 2017 17:07:45 +0100
Subject: [PATCH v6 8/8] thunderbolt: Runtime suspend NHI when idle
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org
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

Just as the rest of the Thunderbolt driver, runtime PM is an ongoing
work in progress.  In particular, two issues remain:

* When a daisy-chained device is hotplugged and a PCIe port between the
  end of the chain and the host controller is in D3hot, the pciehp
  hotplug interrupt cannot be expected to be delivered.  The plug event
  sent via the CIO switch to the NHI serves as a side-band signal and
  the NHI should runtime resume the PCIe hotplug port on which the plug
  event occurred.  We do not support daisy chaining yet so this is only
  an issue for PCI tunnels established by the EFI driver.

* On Cactus Ridge and newer, directly-attached DisplayPort devices are
  not wired to the GPU, but rather the DP signal is routed through the
  Thunderbolt controller.  It may thus be necessary to check presence of
  attached DisplayPort devices when scanning the root switch and
  acquire a runtime ref for each of them to prevent the controller
  from powering off while displays are attached.  Unfortunately my own
  machine predates Cactus Ridge and wires the DP signal directly to the
  GPU, so I cannot test this.

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
index e17edab13e4c..b9dd2a1ab96d 100644
--- a/drivers/thunderbolt/power.c
+++ b/drivers/thunderbolt/power.c
@@ -323,6 +323,12 @@ void thunderbolt_power_init(struct tb *tb)
 
 	tb->power = power;
 
+	pm_runtime_allow(nhi_dev);
+	pm_runtime_set_autosuspend_delay(nhi_dev, 10000);
+	pm_runtime_use_autosuspend(nhi_dev);
+	pm_runtime_mark_last_busy(nhi_dev);
+	pm_runtime_put_autosuspend(nhi_dev);
+
 	return;
 
 err_free:
@@ -339,6 +345,9 @@ void thunderbolt_power_fini(struct tb *tb)
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
