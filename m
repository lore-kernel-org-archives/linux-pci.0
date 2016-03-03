Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48174 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932764AbcCCQyH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:54:07 -0500
Subject: [PATCH v1 01/12] PCI: Mark shadow copy of VGA ROM as
 IORESOURCE_PCI_FIXED
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 03 Mar 2016 10:53:58 -0600
Message-ID: <20160303165358.3025.23146.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A shadow copy of an option ROM is placed by the BIOS as a fixed address.
Set IORESOURCE_PCI_FIXED to indicate that we can't move the shadow copy.
This prevents warnings like the following when we assign resources:

  BAR 6: [??? 0x00000000 flags 0x2] has bogus alignment

This warning is emitted by pdev_sort_resources(), which already ignores
IORESOURCE_PCI_FIXED resources.

Link: http://lkml.kernel.org/r/CA+55aFyVMfTBB0oz_yx8+eQOEJnzGtCsYSj9QuhEpdZ9BHdq5A@mail.gmail.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/pci/fixup.c |    3 ++-
 arch/x86/pci/fixup.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/pci/fixup.c b/arch/ia64/pci/fixup.c
index fc505d5..fd9ceff 100644
--- a/arch/ia64/pci/fixup.c
+++ b/arch/ia64/pci/fixup.c
@@ -61,7 +61,8 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	if (!vga_default_device() || pdev == vga_default_device()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
+				IORESOURCE_PCI_FIXED;
 			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
 		}
 	}
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 0ae7e9f..dac027c 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -336,7 +336,8 @@ static void pci_fixup_video(struct pci_dev *pdev)
 	if (!vga_default_device() || pdev == vga_default_device()) {
 		pci_read_config_word(pdev, PCI_COMMAND, &config);
 		if (config & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+			pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
+				IORESOURCE_PCI_FIXED;
 			dev_printk(KERN_DEBUG, &pdev->dev, "Video device with shadowed ROM\n");
 		}
 	}

