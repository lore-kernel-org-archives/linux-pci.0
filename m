Return-Path: <SRS0=v6DO=DL=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=v6DO=DL=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Chen Yu <y.c.chen@intel.com>
Subject: [PATCH] PCI / PM: Force devices to D0 in pci_pm_thaw_noirq()
Date: Fri, 15 Dec 2017 03:07:18 +0100
Message-ID: <2582328.YfNXS1jHhG@aspire.rjw.lan>
In-Reply-To: <11146834.AWaDHrVcmB@aspire.rjw.lan>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <alpine.DEB.2.20.1712141648190.4998@nanos> <11146834.AWaDHrVcmB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is incorrect to call pci_restore_state() for devices in low-power
states (D1-D3), as that involves the restoration of MSI setup which
requires MMIO to be operational and that is only the case in D0.

However, pci_pm_thaw_noirq() may do that if the driver's "freeze"
callbacks put the device into a low-power state, so fix it by making
it force devices into D0 via pci_set_power_state() instead of trying
to "update" their power state which is pointless.

Fixes: e60514bd4485 (PCI/PM: Restore the status of PCI devices across hibernation)
Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Maarten Lankhorst <dev@mblankhorst.nl>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Maarten Lankhorst <dev@mblankhorst.nl>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The bug is not as old as I thought, actually.

Yes, we did the pci_update_current_state() in pci_pm_thaw_noirq()
forever, but it started to be problematic in 4.13, when we started
to call pci_restore_state() in addition to it to fix another issue.

---
 drivers/pci/pci-driver.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1027,7 +1027,12 @@ static int pci_pm_thaw_noirq(struct devi
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
-	pci_update_current_state(pci_dev, PCI_D0);
+	/*
+	 * pci_restore_state() requires the device to be in D0 (because of MSI
+	 * restoration among other things), so force it into D0 in case the
+	 * driver's "freeze" callbacks put it into a low-power state directly.
+	 */
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 	if (drv && drv->pm && drv->pm->thaw_noirq)
