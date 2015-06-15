Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 0/6] hv: Front-end driver for PCIe Pass-through on Hyper-V
Date: Mon, 15 Jun 2015 17:06:33 +0000
Message-Id: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch does some slight refactoring on the hv_vmbus driver and its
dependents and then introduces a new paravirtual front-end driver for PCI
which supports PCI Express devices passed through to a Linux guest running
in a Hyper-V VM.

To support this front-end, several new mechanisms are introduced:

1 - A common way of finding free memory-mapped I/O space in a Hyper-V VM, 
    available to all Hyper-V-related drivers.

2 - A way of handling PCI Message-Signaled Interrupt (MSI and MSI-X)
    creation and formatting when Hyper-V is running.

3 - A mapping function from Linux processor number to Hyper-V virtual
    processor number, available to drivers, which is necessary for MSI(-X)
    creation.

The Hyper-V Frame Buffer driver is modified to use the MMIO space
allocation function so that its allocations both don't collide with the
PCI front end and so that the chosen range can come from any available
part of MMIO space.

Finally, the new PCI front-end driver is the last patch in the series.

This patch series incorporates feedback from Greg K-H and Paul Bolle, and
it differs from the the first version in that it:

- Removes code that has no callers
- Updates the MODULE_LICENSE macro
- Provides explanations in each of the patches
- Fixes the Kconfig so that the defaults and depends are reasonable

Jake Oshins (6):
  drivers:hv: Modify vmbus to search for all MMIO ranges available
  drivers:hv: Move MMIO range picking from hyper_fb.mod to hv_vmbus.mod
  arch:x86:hv: Add mechanism for Hyper-V paravirt drivers to hook msi
    message creation
  drivers:hv: Export a function that maps Linux proc num onto Hyper-V
    proc num
  drivers:hv: Define the channel type for Hyper-V PCI Express
    pass-through
  drivers:pci:hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                     |    1 +
 arch/x86/include/asm/mshyperv.h |    2 +
 arch/x86/kernel/cpu/mshyperv.c  |   30 +
 drivers/hv/vmbus_drv.c          |  208 +++-
 drivers/pci/Kconfig             |    7 +
 drivers/pci/host/Makefile       |    1 +
 drivers/pci/host/hv_pcifront.c  | 1984 +++++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/hyperv_fb.c |   46 +-
 include/linux/hyperv.h          |   20 +-
 9 files changed, 2256 insertions(+), 43 deletions(-)
 create mode 100644 drivers/pci/host/hv_pcifront.c

-- 
1.9.1

