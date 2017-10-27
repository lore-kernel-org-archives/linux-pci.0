Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43118 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932301AbdJ0Wap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2017 18:30:45 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH v2 2/6] PCI / PM: Use the NEVER_SKIP driver flag
Date: Sat, 28 Oct 2017 00:19:17 +0200
Message-ID: <12179479.1WxA5E5Pkf@aspire.rjw.lan>
In-Reply-To: <16592954.7Zo1mAdIIH@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the PCI-specific flag PCI_DEV_FLAGS_NEEDS_RESUME with the
PM core's DPM_FLAG_NEVER_SKIP one everywhere and drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

-> v2: No changes.

---
 drivers/gpu/drm/i915/i915_drv.c |    2 +-
 drivers/misc/mei/pci-me.c       |    2 +-
 drivers/misc/mei/pci-txe.c      |    2 +-
 drivers/pci/pci.c               |    3 +--
 include/linux/pci.h             |    7 +------
 5 files changed, 5 insertions(+), 11 deletions(-)

Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -205,13 +205,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT = (__force pci_dev_flags_t) (1 << 9),
 	/* Do not use FLR even if device advertises PCI_AF_CAP */
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
-	/*
-	 * Resume before calling the driver's system suspend hooks, disabling
-	 * the direct_complete optimization.
-	 */
-	PCI_DEV_FLAGS_NEEDS_RESUME = (__force pci_dev_flags_t) (1 << 11),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
-	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 12),
+	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 };
 
 enum pci_irq_reroute_variant {
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2166,8 +2166,7 @@ bool pci_dev_keep_suspended(struct pci_d
 
 	if (!pm_runtime_suspended(dev)
 	    || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
-	    || platform_pci_need_resume(pci_dev)
-	    || (pci_dev->dev_flags & PCI_DEV_FLAGS_NEEDS_RESUME))
+	    || platform_pci_need_resume(pci_dev))
 		return false;
 
 	/*
Index: linux-pm/drivers/gpu/drm/i915/i915_drv.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/i915/i915_drv.c
+++ linux-pm/drivers/gpu/drm/i915/i915_drv.c
@@ -1304,7 +1304,7 @@ int i915_driver_load(struct pci_dev *pde
 	 * becaue the HDA driver may require us to enable the audio power
 	 * domain during system suspend.
 	 */
-	pdev->dev_flags |= PCI_DEV_FLAGS_NEEDS_RESUME;
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
 
 	ret = i915_driver_init_early(dev_priv, ent);
 	if (ret < 0)
Index: linux-pm/drivers/misc/mei/pci-txe.c
===================================================================
--- linux-pm.orig/drivers/misc/mei/pci-txe.c
+++ linux-pm/drivers/misc/mei/pci-txe.c
@@ -141,7 +141,7 @@ static int mei_txe_probe(struct pci_dev
 	 * MEI requires to resume from runtime suspend mode
 	 * in order to perform link reset flow upon system suspend.
 	 */
-	pdev->dev_flags |= PCI_DEV_FLAGS_NEEDS_RESUME;
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
 
 	/*
 	* For not wake-able HW runtime pm framework
Index: linux-pm/drivers/misc/mei/pci-me.c
===================================================================
--- linux-pm.orig/drivers/misc/mei/pci-me.c
+++ linux-pm/drivers/misc/mei/pci-me.c
@@ -223,7 +223,7 @@ static int mei_me_probe(struct pci_dev *
 	 * MEI requires to resume from runtime suspend mode
 	 * in order to perform link reset flow upon system suspend.
 	 */
-	pdev->dev_flags |= PCI_DEV_FLAGS_NEEDS_RESUME;
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
 
 	/*
 	* For not wake-able HW runtime pm framework
