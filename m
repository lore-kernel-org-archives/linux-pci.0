Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753343AbcHYN3e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 09:29:34 -0400
Date: Thu, 25 Aug 2016 08:29:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Mathias Koehrer <mathias.koehrer@etas.com>
Subject: [GIT PULL] PCI fixes for v4.8
Message-ID: <20160825132929.GA10711@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are a few changes for v4.8.  One documentation fix, an Intel VMD IRQ
fix, and two updates to enable Christoph's MSI/legacy IRQ cleanup work.

Bjorn


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.8-fixes-1

for you to fetch changes up to 21c80c9fefc3db10b530a96eb0478c29eb28bf77:

  x86/PCI: VMD: Fix infinite loop executing irq's (2016-08-23 16:36:42 -0500)

----------------------------------------------------------------
PCI updates for v4.8:

  Resource management
    Update "pci=resource_alignment" documentation (Mathias Koehrer)

  MSI
    Use positive flags in pci_alloc_irq_vectors() (Christoph Hellwig)
    Call pci_intx() when using legacy interrupts in pci_alloc_irq_vectors() (Christoph Hellwig)

  Intel VMD host bridge driver
    Fix infinite loop executing irq's (Keith Busch)

----------------------------------------------------------------
Christoph Hellwig (2):
      PCI: Use positive flags in pci_alloc_irq_vectors()
      PCI: Call pci_intx() when using legacy interrupts in pci_alloc_irq_vectors()

Keith Busch (1):
      x86/PCI: VMD: Fix infinite loop executing irq's

Mathias Koehrer (1):
      PCI: Update "pci=resource_alignment" documentation

 Documentation/PCI/MSI-HOWTO.txt     | 24 ++++++++++--------------
 Documentation/kernel-parameters.txt |  4 ++++
 arch/x86/pci/vmd.c                  | 10 ++++++++--
 drivers/pci/msi.c                   | 18 ++++++++++--------
 include/linux/pci.h                 | 10 ++++++----
 5 files changed, 38 insertions(+), 28 deletions(-)
