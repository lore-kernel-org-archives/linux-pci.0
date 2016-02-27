Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48412 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992441AbcB0PPB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 27 Feb 2016 10:15:01 -0500
Date: Sat, 27 Feb 2016 09:14:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>,
	Jake Oshins <jakeo@microsoft.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	=?utf-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>,
	Sunjin Yang <fan4326@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PCI fixes for v4.5
Message-ID: <20160227151457.GA30280@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

The big chunk here is the paravirtual front-end for Linux guests of a
Microsoft Hyper-V VM.  It's new, so no risk of regressions to pci-hyperv
itself.  It does include minor changes to common code, but they are
low-risk.

This also reverts a few pieces of the recent IOAPIC hotplug work because
they caused a regression for existing drivers that require IRQs to be
enabled for upstream bridges.

Finally, explicitly restrict the MVEBU driver to 32-bit ARM because it uses
some PCI glue only available there.  It depends on ARCH_MVEBU, which used
to be 32-bit ARM only but is now becoming available for 64-bit ARM.

Bjorn


The following changes since commit 0cf1337e0b83c16de4e7e98dad3a6afce6043fea:

  PCI: rcar: Add device tree support for r8a7793 (2016-02-05 14:13:53 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-fixes-2

for you to fetch changes up to 2f8f01f7e495901042339a333d4385ed5b1e426a:

  Merge branch 'pci/host-hv' into for-linus (2016-02-27 08:52:36 -0600)

----------------------------------------------------------------
PCI updates for v4.5:

  Enumeration
    Revert x86 pcibios_alloc_irq() to fix regression (Bjorn Helgaas)

  Marvell MVEBU host bridge driver
    Restrict build to 32-bit ARM (Thierry Reding)

  Microsoft Hyper-V host bridge driver
    Add paravirtual front-end for guests of Microsoft Hyper-V VMs (Jake Oshins)

----------------------------------------------------------------
Bjorn Helgaas (4):
      Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
      Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
      Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"
      Merge branch 'pci/host-hv' into for-linus

Jake Oshins (3):
      PCI: Add fwnode_handle to x86 pci_sysdata
      PCI: Look up IRQ domain by fwnode_handle
      PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs

Thierry Reding (1):
      PCI: mvebu: Restrict build to 32-bit ARM

 MAINTAINERS                    |    1 +
 arch/x86/include/asm/pci.h     |   15 +
 arch/x86/include/asm/pci_x86.h |    2 +
 arch/x86/pci/common.c          |   26 +-
 arch/x86/pci/intel_mid_pci.c   |    9 +-
 arch/x86/pci/irq.c             |   23 +-
 drivers/acpi/pci_irq.c         |   17 +-
 drivers/pci/Kconfig            |    7 +
 drivers/pci/host/Kconfig       |    1 +
 drivers/pci/host/Makefile      |    1 +
 drivers/pci/host/pci-hyperv.c  | 2346 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c            |   15 +
 include/linux/pci.h            |   21 +-
 13 files changed, 2437 insertions(+), 47 deletions(-)
 create mode 100644 drivers/pci/host/pci-hyperv.c
