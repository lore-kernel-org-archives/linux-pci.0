Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	"bp @ alien8 . de" <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	"yinghai @ kernel . org" <yinghai@kernel.org>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device is disabled when unbinding
Date: Tue, 17 Mar 2015 15:37:12 +0800
Message-Id: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To support IOAPIC hot-removal, we need to release PCI interrupt resource
when unbinding PCI device driver. But due to historical reason,
/*
 * We would love to complain here if pci_dev->is_enabled is set, that
 * the driver should have called pci_disable_device(), but the
 * unfortunate fact is there are too many odd BIOS and bridge setups
 * that don't like drivers doing that all of the time.
 * Oh well, we can dream of sane hardware when we sleep, no matter how
 * horrible the crap we have to deal with is when we are awake...
 */
some drivers don't call pci_disable_device() when unloading, which
prevents us from reallocating PCI interrupt resource on reloading
PCI driver and causes regressions.

So release PCI interrupt resource only if PCI device is disabled when
unbinding. By this way, we could support IOAPIC hot-removal on latest
platforms and avoid regressions on old platforms.

Please aslo refer to:
https://bugzilla.kernel.org/show_bug.cgi?id=94721

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
Hi Rafael,
	I have assumed an Reviewed-by from you, is that OK?
Thanks!
Gerry
---
 arch/x86/pci/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3d2612b68694..8d792142cb2a 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -527,7 +527,7 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
 	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
 		return NOTIFY_DONE;
 
-	if (pcibios_disable_irq)
+	if (!pci_is_enabled(dev) && pcibios_disable_irq)
 		pcibios_disable_irq(dev);
 
 	return NOTIFY_OK;
-- 
1.7.10.4

