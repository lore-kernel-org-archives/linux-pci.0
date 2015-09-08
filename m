Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44302 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbbIHHX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Sep 2015 03:23:29 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [Bugfix] PCI, x86: Correctly allocate IRQs for PCI devices managed by non-PCI drivers
Date: Tue,  8 Sep 2015 15:26:29 +0800
Message-Id: <1441697190-27993-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <55EE8106.6060100@internode.on.net>
References: <55EE8106.6060100@internode.on.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") changes the way to allocate PCI legacy IRQ
for PCI devices on x86 platforms. Instead of allocating PCI legacy
IRQs when pcibios_enable_device() gets called, now pcibios_alloc_irq()
will be called by pci_device_probe() to allocate PCI legacy IRQs
when binding PCI drivers to PCI devices.

But some device drivers, such as eata, directly access PCI devices
without implementing corresponding PCI drivers, so pcibios_alloc_irq()
won't be called for those PCI devices and wrong IRQ number may be
used to manage the PCI device.

So detect such a case in pcibios_enable_device() by checking
pci_dev->driver is NULL and call pcibios_alloc_irq() to allocate PCI
legacy IRQs.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/pci/common.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 09d3afc0a181..60b237783582 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -685,6 +685,16 @@ void pcibios_free_irq(struct pci_dev *dev)
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	/*
+	 * By design, pcibios_alloc_irq() will be called by pci_device_probe()
+	 * when binding a PCI device to a PCI driver. But some device drivers,
+	 * such as eata, directly make use of PCI devices without implementing
+	 * PCI device drivers, so pcibios_alloc_irq() won't be called for those
+	 * PCI devices.
+	 */
+	if (!dev->driver)
+		pcibios_alloc_irq(dev);
+
 	return pci_enable_resources(dev, mask);
 }
 
-- 
1.7.10.4

