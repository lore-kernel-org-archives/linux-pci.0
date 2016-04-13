Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40409 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129AbcDMFww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 01:52:52 -0400
Subject: [PATCH 0/2] v4.3: Revert "PCI: Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
To: stable@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 13 Apr 2016 00:52:49 -0500
Message-ID: <20160413055208.6737.53693.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please apply these reverts to the v4.3 stable kernel.

We reverted the following changes from v4.6 to fix a regression:

  811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed")
  991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")

but I forgot to mark those reverts for stable.  This series contains the
backports for v4.3.

For reference, the v4.6 reverts are:

  fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"")
  67b4eab91caf ("Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"")
  6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")

The revert of "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
is not included in this series because that commit didn't appear until
v4.4, so it doesn't need to be reverted from v4.3.

---

Bjorn Helgaas (2):
      Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
      Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"


 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   20 +++++++++++---------
 arch/x86/pci/intel_mid_pci.c   |    9 +++------
 arch/x86/pci/irq.c             |   23 +++++++++++++++++++----
 drivers/acpi/pci_irq.c         |   17 +++++++++++++----
 include/linux/pci.h            |   17 -----------------
 6 files changed, 48 insertions(+), 40 deletions(-)
