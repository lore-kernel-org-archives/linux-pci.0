Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v2 1/3] Revert "x86/PCI: Don't alloc pcibios-irq when MSI is
 enabled"
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 17 Feb 2016 12:37:06 -0600
Message-ID: <20160217183706.302.17831.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revert 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is
enabled").

This is part of reverting 991de2e59090 ("PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()") to fix regressions it
introduced.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=111211
Fixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>
CC: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/pci/common.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 2879efc..cb499c5 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -713,14 +713,6 @@ int pcibios_add_device(struct pci_dev *dev)
 
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	/*
-	 * If the PCI device was already claimed by core code and has
-	 * MSI enabled, probing of the pcibios IRQ will overwrite
-	 * dev->irq.  So bail out if MSI is already enabled.
-	 */
-	if (pci_dev_msi_enabled(dev))
-		return -EBUSY;
-
 	return pcibios_enable_irq(dev);
 }
 

