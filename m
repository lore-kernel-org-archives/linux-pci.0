Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:42223 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdJ0H1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 03:27:19 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-pci@vger.kernel.org
Subject: [RFC PATCH v10 5/7] PCI: Make pci_platform_pm_ops's callbacks optional
Date: Fri, 27 Oct 2017 15:26:10 +0800
Message-Id: <20171027072612.26565-6-jeffy.chen@rock-chips.com>
In-Reply-To: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow platforms not to provide some of the pci_platform_pm_ops's
callbacks.

Also change the return value from -ENOSYS to -ENODEV for:
warning: drivers/pci/pci.c,594: ENOSYS means 'invalid syscall nr' and nothing else

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v3: None
Changes in v2: None

 drivers/pci/pci.c | 38 +++++++++++++++++++++++++-------------
 drivers/pci/pci.h |  5 +----
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f0d68066c726..e120b00a9017 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -572,46 +572,58 @@ static void pci_restore_bars(struct pci_dev *dev)
 
 static const struct pci_platform_pm_ops *pci_platform_pm;
 
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
+void pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
-	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
-		return -EINVAL;
 	pci_platform_pm = ops;
-	return 0;
 }
 
 static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
+	if (pci_platform_pm && pci_platform_pm->is_manageable)
+		return pci_platform_pm->is_manageable(dev);
+
+	return false;
 }
 
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
 					       pci_power_t t)
 {
-	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
+	if (pci_platform_pm && pci_platform_pm->set_state)
+		return pci_platform_pm->set_state(dev, t);
+
+	return -ENODEV;
 }
 
 static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
+	if (pci_platform_pm && pci_platform_pm->get_state)
+		return pci_platform_pm->get_state(dev);
+
+	return PCI_UNKNOWN;
 }
 
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
-	return pci_platform_pm ?
-			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
+	if (pci_platform_pm && pci_platform_pm->choose_state)
+		return pci_platform_pm->choose_state(dev);
+
+	return PCI_POWER_ERROR;
 }
 
 static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 {
-	return pci_platform_pm ?
-			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
+	if (pci_platform_pm && pci_platform_pm->set_wakeup)
+		return pci_platform_pm->set_wakeup(dev, enable);
+
+	return -ENODEV;
 }
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
+	if (pci_platform_pm && pci_platform_pm->need_resume)
+		return pci_platform_pm->need_resume(dev);
+
+	return false;
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e816a13e6259..048668271014 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -52,9 +52,6 @@ int pci_probe_reset_function(struct pci_dev *dev);
  * @need_resume: returns 'true' if the given device (which is currently
  *		suspended) needs to be resumed to be configured for system
  *		wakeup.
- *
- * If given platform is generally capable of power managing PCI devices, all of
- * these callbacks are mandatory.
  */
 struct pci_platform_pm_ops {
 	bool (*is_manageable)(struct pci_dev *dev);
@@ -65,7 +62,7 @@ struct pci_platform_pm_ops {
 	bool (*need_resume)(struct pci_dev *dev);
 };
 
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
+void pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
-- 
2.11.0
