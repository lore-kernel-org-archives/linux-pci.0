Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH] x86/PCI: Fully disable devices before releasing IRQ resource
From: Alex Williamson <alex.williamson@redhat.com>
To: x86@kernel.org, rjw@rjwysocki.net, mingo@redhat.com, bp@alien8.de,
	lv.zheng@intel.com, hpa@zytor.com, bhelgaas@google.com,
	tglx@linutronix.de, yinghai@kernel.org, lenb@kernel.org
Cc: linux-pci@vger.kernel.org, tony.luck@intel.com,
	linux-acpi@vger.kernel.org, jiang.liu@linux.intel.com,
	linux-kernel@vger.kernel.org
Date: Thu, 05 Mar 2015 14:06:58 -0700
Message-ID: <20150305210529.6393.29546.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The IRQ resource for a device is established when pci_enabled_device()
is called on a fully disabled device (ie. enable_cnt == 0).  With
commit b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ
resources") this same IRQ resource is released when the driver is
unbound from the device, regardless of the enable_cnt.  This presents
the situation that an ill-behaved driver can now make a device
unusable to subsequent drivers by an imbalance in their use of
pci_enable/disable_device().  It's one thing to break your own device
if you're one of these ill-behaved drivers, but it's a serious
regression for secondary drivers like vfio-pci, which are innocent
of the transgressions of the previous driver.

Resolve by pushing the device to a fully disabled state before
releasing the IRQ resource.

Fixes: b4b55cda5874 ("x86/PCI: Refine the way to release PCI IRQ resources")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/common.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 3d2612b..4810194 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -527,8 +527,19 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
 	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
 		return NOTIFY_DONE;
 
-	if (pcibios_disable_irq)
+	if (pcibios_disable_irq) {
+		/*
+		 * Broken drivers may allow a device to be .remove()'d while
+		 * still enabled.  pci_enable_device() will only re-establish
+		 * dev->irq if the devices is fully disabled.  So if we want
+		 * to release the IRQ, we need to make sure the next driver
+		 * can re-establish it using pci_enable_device().
+		 */
+		while (pci_is_enabled(dev))
+			pci_disable_device(dev);
+
 		pcibios_disable_irq(dev);
+	}
 
 	return NOTIFY_OK;
 }

