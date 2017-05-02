Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:1472 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdEBMEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 May 2017 08:04:13 -0400
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Tue,  2 May 2017 15:04:08 +0300
Message-Id: <1493726649-32094-1-git-send-email-imre.deak@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some drivers - like i915 - may not support the system suspend direct
complete optimization due to differences in their runtime and system
suspend sequence. Add a flag that when set resumes the device before
calling the driver's system suspend handlers which effectively disables
the optimization.

Needed by the next patch fixing suspend/resume on i915.

Suggested by Rafael.

v2-v3:
- unchanged

v4:
- Move the flag to dev_flags instead of using a bit field. (Rafael)

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Imre Deak <imre.deak@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> (v3)
---
 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..a4ef755 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2141,7 +2141,8 @@ bool pci_dev_keep_suspended(struct pci_dev *pci_dev)
 
 	if (!pm_runtime_suspended(dev)
 	    || pci_target_state(pci_dev) != pci_dev->current_state
-	    || platform_pci_need_resume(pci_dev))
+	    || platform_pci_need_resume(pci_dev)
+	    || (pci_dev->dev_flags & PCI_DEV_FLAGS_NEEDS_RESUME))
 		return false;
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5948cfd..8acb560 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -178,6 +178,11 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
 	/* Get VPD from function 0 VPD */
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	/*
+	 * Resume before calling the driver's system suspend hooks, disabling
+	 * the direct_complete optimization.
+	 */
+	PCI_DEV_FLAGS_NEEDS_RESUME = (__force pci_dev_flags_t) (1 << 9),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.7.4
