Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:48335 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeAEBTt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 20:19:49 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] PM / wakeup: Do not fail dev_pm_attach_wake_irq() unnecessarily
Date: Fri, 05 Jan 2018 02:18:42 +0100
Message-ID: <3262092.gurR7s35C6@aspire.rjw.lan>
In-Reply-To: <1542734.kK7NjWylRh@aspire.rjw.lan>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <6120485.xubBpvge6h@aspire.rjw.lan> <1542734.kK7NjWylRh@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Returning an error code from dev_pm_attach_wake_irq() if
device_wakeup_attach_irq() called by it returns an error is
pointless, because the wakeup source used by it may be deleted
by user space via sysfs at any time and in particular right after
dev_pm_attach_wake_irq() has returned.  Moreover, it requires
the callers of dev_pm_attach_wake_irq() to create that wakeup
source via device_wakeup_enable() upfront, but that obviously is
racy with respect to the sysfs-based manipulations of it.

To avoid the race, modify device_wakeup_attach_irq() to check
that the wakeup source it is going to use is there (and return
early otherwise), make it void (as it cannot fail after that
change) and make dev_pm_attach_wake_irq() to simply call it
for the device unconditionally.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The previous version didn't compile with CONFIG_PM_SLEEP unset.

The changes from it to v2 are not essential for the code flow, so I have
retained the Tested-by: tag from Tony.

Thanks,
Rafael

---
 drivers/base/power/power.h   |   11 +++--------
 drivers/base/power/wakeirq.c |    8 +++-----
 drivers/base/power/wakeup.c  |   11 ++++-------
 3 files changed, 10 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/base/power/wakeirq.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeirq.c
+++ linux-pm/drivers/base/power/wakeirq.c
@@ -33,7 +33,6 @@ static int dev_pm_attach_wake_irq(struct
 				  struct wake_irq *wirq)
 {
 	unsigned long flags;
-	int err;
 
 	if (!dev || !wirq)
 		return -EINVAL;
@@ -45,12 +44,11 @@ static int dev_pm_attach_wake_irq(struct
 		return -EEXIST;
 	}
 
-	err = device_wakeup_attach_irq(dev, wirq);
-	if (!err)
-		dev->power.wakeirq = wirq;
+	dev->power.wakeirq = wirq;
+	device_wakeup_attach_irq(dev, wirq);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
-	return err;
+	return 0;
 }
 
 /**
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -291,22 +291,19 @@ EXPORT_SYMBOL_GPL(device_wakeup_enable);
  *
  * Call under the device's power.lock lock.
  */
-int device_wakeup_attach_irq(struct device *dev,
+void device_wakeup_attach_irq(struct device *dev,
 			     struct wake_irq *wakeirq)
 {
 	struct wakeup_source *ws;
 
 	ws = dev->power.wakeup;
-	if (!ws) {
-		dev_err(dev, "forgot to call device_init_wakeup?\n");
-		return -EINVAL;
-	}
+	if (!ws)
+		return;
 
 	if (ws->wakeirq)
-		return -EEXIST;
+		dev_err(dev, "Leftover wakeup IRQ found, overriding\n");
 
 	ws->wakeirq = wakeirq;
-	return 0;
 }
 
 /**
Index: linux-pm/drivers/base/power/power.h
===================================================================
--- linux-pm.orig/drivers/base/power/power.h
+++ linux-pm/drivers/base/power/power.h
@@ -41,20 +41,15 @@ extern void dev_pm_disable_wake_irq_chec
 
 #ifdef CONFIG_PM_SLEEP
 
-extern int device_wakeup_attach_irq(struct device *dev,
-				    struct wake_irq *wakeirq);
+extern void device_wakeup_attach_irq(struct device *dev, struct wake_irq *wakeirq);
 extern void device_wakeup_detach_irq(struct device *dev);
 extern void device_wakeup_arm_wake_irqs(void);
 extern void device_wakeup_disarm_wake_irqs(void);
 
 #else
 
-static inline int
-device_wakeup_attach_irq(struct device *dev,
-			 struct wake_irq *wakeirq)
-{
-	return 0;
-}
+static inline void device_wakeup_attach_irq(struct device *dev,
+					    struct wake_irq *wakeirq) {}
 
 static inline void device_wakeup_detach_irq(struct device *dev)
 {
