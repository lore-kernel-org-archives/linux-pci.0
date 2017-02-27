Return-Path: <SRS0=KDlv=2I=intel.com=rui.y.wang@kernel.org>
Return-Path: <SRS0=KDlv=2I=intel.com=rui.y.wang@kernel.org>
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
	x86@kernel.org
Subject: [PATCH 0/2] Improvement on ioapic hotplug
Date: Mon, 27 Feb 2017 22:15:42 +0800
Message-Id: <1488204944-27189-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The revert of 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq()
and pcibios_free_irq()") causes a problem for IOAPIC hotplug. If
a device under the IOAPIC doesn't call pci_disable_device(), then
the hot-removal of the IOAPIC causes kernel stack dump.

This patchset can fix the problem. IOAPIC hot-removal works correctly
after applying this patchset.

Rui Wang (2):
  x86/PCI: Implement pci_release_device to release IRQ from IOAPIC
  x86/ioapic: Split IOAPIC hot-removal into two steps

 arch/x86/pci/common.c   |  9 +++++++++
 drivers/acpi/internal.h |  1 +
 drivers/acpi/ioapic.c   | 22 ++++++++++++++++------
 drivers/acpi/pci_root.c |  4 ++--
 4 files changed, 28 insertions(+), 8 deletions(-)

-- 
1.8.3.1
