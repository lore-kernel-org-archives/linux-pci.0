Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14186 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbbG2BjQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 21:39:16 -0400
Message-ID: <1438133951.1856.23.camel@rzhang1-mobl4>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
From: Zhang Rui <rui.zhang@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, chuansheng.liu@intel.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	mister.freeman@laposte.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Wed, 29 Jul 2015 09:39:11 +0800
In-Reply-To: <20150728175848.GI5322@mtj.duckdns.org>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
	 <20150728175848.GI5322@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-07-28 at 13:58 -0400, Tejun Heo wrote:
> On Tue, Jul 28, 2015 at 09:42:27AM +0800, Zhang Rui wrote:
> > From 57edba9c677e47354846db951014dc4d5b13ce54 Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Sun, 26 Jul 2015 14:15:36 +0800
> > Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
> > 
> > In https://bugzilla.kernel.org/show_bug.cgi?id=81551,
> > we found that Jmicron chip 361/363 is broken after resume if async noirq
> > (76569faa62 (PM / sleep: Asynchronous threads for resume_noirq)) is supported,
> > thus commit e6b7e41cdd (ata: Disabling the async PM for JMicron chip 363/361)
> > is introduced to fix this problem.
> > But then, we found that Jmicron chip 368 also has this problem, and it is decided
> > to disable the pm async feature for all the Jmicron chips.
> > 
> > But how to fix this was discussed in the mailing list for some time.
> > After some investigation, we believe that a proper fix is to disable
> > the async PM in PCI instead of ata driver, because, on this platform,
> > pci_resume_noirq() of IDE controller must happen after pci_resume_noirq()
> > of AHCI controller. But as .resume_noirq() of the pata_jmicron driver is
> > no-op, this suggests that it is the PCI common actions, aka,
> > pci_pm_default_resume_early(), have the dependency.
> > To fix this, using device_pm_wait_for_dev() in pata_jmicron driver can not
> > solve the dependency because pci_pm_default_resume_early() is invoked before
> > driver callback being invoked, plus, as it is the PCI common actions that
> > have the dependency, it is reasonable to fix it in PCI bus code,
> > rather than driver code.
> > 
> > This patch is made based on the patch from Liu Chuansheng at
> > https://lkml.org/lkml/2014/12/5/74
> > it reverts commit e6b7e41cdd ("ata: Disabling the async PM for JMicron
> > chip 363/361"), and introduces a PCI quirk to disable async PM for Jmicron
> > chips.
> > 
> > Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81551
> > Tested-by: Jay <MyMailClone@t-online.de>
> > Tested-by: Barto <mister.freeman@laposte.net>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> >  /*
> > + * For JMicron chips, we need to disable the async_suspend method, otherwise
> > + * they will hit the power-on issue when doing device resume, add one quick
> > + * solution to disable the async_suspend method.
> > + */
> 
> Maybe add a link to the bug report and/or discussion thread?

Yes, refreshed patch is attached below.


>From c6b063b2874b62466362a10b53097216b16e400d Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Sun, 26 Jul 2015 14:15:36 +0800
Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip

In https://bugzilla.kernel.org/show_bug.cgi?id=81551,
we found that Jmicron chip 361/363 is broken after resume if async noirq
(76569faa62 (PM / sleep: Asynchronous threads for resume_noirq)) is supported,
thus commit e6b7e41cdd (ata: Disabling the async PM for JMicron chip 363/361)
is introduced to fix this problem.
But then, we found that Jmicron chip 368 also has this problem, and it is decided
to disable the pm async feature for all the Jmicron chips.

But how to fix this was discussed in the mailing list for some time.
After some investigation, we believe that a proper fix is to disable
the async PM in PCI instead of ata driver, because, on this platform,
pci_resume_noirq() of IDE controller must happen after pci_resume_noirq()
of AHCI controller. But as .resume_noirq() of the pata_jmicron driver is
no-op, this suggests that it is the PCI common actions, aka,
pci_pm_default_resume_early(), have the dependency.
To fix this, using device_pm_wait_for_dev() in pata_jmicron driver can not
solve the dependency because pci_pm_default_resume_early() is invoked before
driver callback being invoked, plus, as it is the PCI common actions that
have the dependency, it is reasonable to fix it in PCI bus code,
rather than driver code.

This patch is made based on the patch from Liu Chuansheng at
https://lkml.org/lkml/2014/12/5/74
it reverts commit e6b7e41cdd ("ata: Disabling the async PM for JMicron
chip 363/361"), and introduces a PCI quirk to disable async PM for Jmicron
chips.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81511
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81551
Reviewed-by: Aaron Lu <aaron.lu@intel.com>
Acked-by: Chuansheng Liu <chuansheng.liu@intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/ata/ahci.c         | 12 ------------
 drivers/ata/pata_jmicron.c | 12 ------------
 drivers/pci/quirks.c       | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7e62751..26bb40d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1451,18 +1451,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
 		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 
-	/*
-	 * The JMicron chip 361/363 contains one SATA controller and one
-	 * PATA controller,for powering on these both controllers, we must
-	 * follow the sequence one by one, otherwise one of them can not be
-	 * powered on successfully, so here we disable the async suspend
-	 * method for these chips.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
-		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
-		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
-		device_disable_async_suspend(&pdev->dev);
-
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 47e418b..4d1a5d2 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -143,18 +143,6 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
-	/*
-	 * The JMicron chip 361/363 contains one SATA controller and one
-	 * PATA controller,for powering on these both controllers, we must
-	 * follow the sequence one by one, otherwise one of them can not be
-	 * powered on successfully, so here we disable the async suspend
-	 * method for these chips.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
-		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
-		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
-		device_disable_async_suspend(&pdev->dev);
-
 	return ata_pci_bmdma_init_one(pdev, ppi, &jmicron_sht, NULL, 0);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e9fd0e9..02803f8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -29,6 +29,23 @@
 #include "pci.h"
 
 /*
+ * For JMicron chips, we need to disable the async_suspend method, otherwise
+ * they will hit the power-on issue when doing device resume, add one quick
+ * solution to disable the async_suspend method.
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=81551
+ */
+static void pci_async_suspend_fixup(struct pci_dev *pdev)
+{
+	/*
+	 * disabling the async_suspend method for JMicron chips to
+	 * avoid device resuming issue.
+	 */
+	device_disable_async_suspend(&pdev->dev);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, pci_async_suspend_fixup);
+
+/*
  * Decoding should be disabled for a PCI device during BAR sizing to avoid
  * conflict. But doing so may cause problems on host bridge and perhaps other
  * key system devices. For devices that need to have mmio decoding always-on,
-- 
1.9.1



