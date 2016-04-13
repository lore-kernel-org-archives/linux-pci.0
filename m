Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40856 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759305AbcDMF5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 01:57:08 -0400
Subject: [PATCH 1/3] Revert "x86/PCI: Don't alloc pcibios-irq when MSI is
 enabled"
To: stable@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 13 Apr 2016 00:57:05 -0500
Message-ID: <20160413055705.6877.38953.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This reverts commit 8affb487d4a4e223d961d7034cb41cd31982b618.

Revert 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is
enabled").

This is part of reverting 991de2e59090 ("PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()") to fix regressions it
introduced.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=111211
Fixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
CC: stable@vger.kernel.org	# v4.4
CC: Jiang Liu <jiang.liu@linux.intel.com>
CC: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/pci/common.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index eccd4d9..dc78a4a 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -675,14 +675,6 @@ int pcibios_add_device(struct pci_dev *dev)
 
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
 

