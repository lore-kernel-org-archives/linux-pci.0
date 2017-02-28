Return-Path: <SRS0=fuAy=2J=intel.com=rui.y.wang@kernel.org>
Return-Path: <SRS0=fuAy=2J=intel.com=rui.y.wang@kernel.org>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org,
	tglx@linutronix.de,
	rjw@rjwysocki.net
Cc: tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com,
	x86@kernel.org,
	fengguang.wu@intel.com,
	kbuild-all@01.org
Subject: [PATCH v2 1/2] x86/PCI: Implement pcibios_release_device to release IRQ from IOAPIC
Date: Tue, 28 Feb 2017 21:34:28 +0800
Message-Id: <1488288869-31290-2-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <1488288869-31290-1-git-send-email-rui.y.wang@intel.com>
References: <201702280904.A2EXAFMQ%fengguang.wu@intel.com>
 <1488288869-31290-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The revert of 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq()
and pcibios_free_irq()") causes a problem for IOAPIC hotplug. The
problem is that IRQs are allocated and freed in pci_enable_device()
and pci_disable_device(). But there are some drivers which don't call
pci_disable_device(), and they have good reasons not calling it, so
if they're using IOAPIC their IRQs won't have a chance to be released
from the IOAPIC. When this happens IOAPIC hot-removal fails with a
kernel stack dump and an error message like this:

[149335.697989] pin16 on IOAPIC2 is still in use.

It turns out that we can fix it in a different way without moving IRQ
allocation into pcibios_alloc_irq(), thus avoiding the regression of
991de2e59090. We can keep the allocation and freeing of IRQs as is
within pci_enable_device()/pci_disable_device(), without breaking any
previous assumption of the rest of the system, keeping compatibility
with both the legacy and the modern drivers. We can accomplish this by
implementing the existing __weak hook of pcibios_release_device() thus
when a pci device is about to be deleted we get notified in the hook
and take the chance to release its IRQ, if any, from the IOAPIC.

Besides implementing pcibios_release_device(), the hot-removal of
IOAPIC needs to be broken into two parts: the PCI part and the ACPI
part. The PCI part releases PCI resources before the PCI bus is gone,
and the ACPI part is moved to a stage later than the hot-removal of
the PCI root bus, so we have the chance to hook every PCI device's
pcibios_release_device(), before we remove the IOAPIC.

This patch implements pcibios_release_device() on x86 to release any
IRQ not released by the driver, so that the IOAPIC can then be safely
hot-removed.

v2: Fixed a typo (pcibios_release_device)

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
---
 arch/x86/pci/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 0cb52ae..190e718 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -735,6 +735,15 @@ void pcibios_disable_device (struct pci_dev *dev)
 		pcibios_disable_irq(dev);
 }
 
+#ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
+void pcibios_release_device(struct pci_dev *dev)
+{
+	if (atomic_dec_return(&dev->enable_cnt) >= 0)
+		pcibios_disable_device(dev);
+
+}
+#endif
+
 int pci_ext_cfg_avail(void)
 {
 	if (raw_pci_ext_ops)
-- 
1.8.3.1
