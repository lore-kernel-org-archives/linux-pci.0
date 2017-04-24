Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44560 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1172139AbdDXO1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Apr 2017 10:27:48 -0400
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Mon, 24 Apr 2017 17:27:42 +0300
Message-Id: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some drivers - like i915 - may not support the system suspend direct
complete optimization due to differences in their runtime and system
suspend sequence. Add a flag that when set resumes the device before
calling the driver's system suspend handlers which effectively disables
the optimization.

Needed by the next patch fixing suspend/resume on i915.

Suggested by Rafael.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..020f02d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2141,7 +2141,8 @@ bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 
 	if (!pm_runtime_suspended(dev)
 	    || pci_target_state(pci_dev) != pci_dev->current_state
-	    || platform_pci_need_resume(pci_dev))
+	    || platform_pci_need_resume(pci_dev)
+	    || pci_dev->needs_resume)
 		return false;
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..3fe00a6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -316,6 +316,9 @@ struct pci_dev {
 	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
 						      controlled exclusively by
 						      user sysfs */
+	unsigned int	needs_resume:1;	/* Resume before calling the driver's
+					   system suspend hooks, disabling the
+					   direct_complete optimization. */
 	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
@@ -1113,6 +1116,10 @@ bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
 void pci_d3cold_enable(struct pci_dev *dev);
 void pci_d3cold_disable(struct pci_dev *dev);
+static inline void pci_resume_before_suspend(struct pci_dev *dev, bool enable)
+{
+	dev->needs_resume = enable;
+}
 
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 				  bool enable)
-- 
2.5.0
