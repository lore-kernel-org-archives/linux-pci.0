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
Subject: [PATCH v2 0/2] Improvement on ioapic hotplug
Date: Tue, 28 Feb 2017 21:34:27 +0800
Message-Id: <1488288869-31290-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <201702280904.A2EXAFMQ%fengguang.wu@intel.com>
References: <201702280904.A2EXAFMQ%fengguang.wu@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The revert of 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq()
and pcibios_free_irq()") causes a problem for IOAPIC hotplug. If
a device under the IOAPIC doesn't call pci_disable_device(), then
the hot-removal of the IOAPIC causes kernel stack dump.

This patchset can fix the problem. IOAPIC hot-removal works correctly
after applying this patchset.

v2: 0001 Fixed a missing stub function causing compiling error on i386 
    0002 Fixed a typo on the subject line.

Rui Wang (2):
  x86/PCI: Implement pcibios_release_device to release IRQ from IOAPIC
  x86/ioapic: Split IOAPIC hot-removal into two steps

 arch/x86/pci/common.c   |  9 +++++++++
 drivers/acpi/internal.h |  2 ++
 drivers/acpi/ioapic.c   | 22 ++++++++++++++++------
 drivers/acpi/pci_root.c |  4 ++--
 4 files changed, 29 insertions(+), 8 deletions(-)

-- 
1.8.3.1
