Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40829 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758663AbcDMF5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 01:57:01 -0400
Subject: [PATCH 0/3] v4.4: Revert "PCI: Implement pcibios_alloc_irq() and
To: stable@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 13 Apr 2016 00:56:59 -0500
Message-ID: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcibios_free_irq()"

Please apply these reverts to the v4.4 stable kernel.

We reverted the following changes from v4.5 to fix a regression:

  8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
  811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed")
  991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")

but I forgot to mark those reverts for stable.  This series contains the
backports for v4.4.

For reference, the v4.5 reverts are:

  fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"")
  67b4eab91caf ("Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"")
  6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")

---

Bjorn Helgaas (3):
      Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
      Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
      Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"


 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   26 ++++++++++----------------
 arch/x86/pci/intel_mid_pci.c   |    9 +++------
 arch/x86/pci/irq.c             |   23 +++++++++++++++++++----
 drivers/acpi/pci_irq.c         |   17 +++++++++++++----
 include/linux/pci.h            |   17 -----------------
 6 files changed, 47 insertions(+), 47 deletions(-)
