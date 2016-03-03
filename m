Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48901 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932968AbcCCQz3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 11:55:29 -0500
Subject: [PATCH v1 12/12] PCI: Simplify sysfs ROM cleanup
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
Date: Thu, 03 Mar 2016 10:55:25 -0600
Message-ID: <20160303165525.3025.11790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The value of pdev->rom_attr is the definitive indicator of the fact that
we're created a sysfs attribute.  Check that rather than rom_size, which is
only used incidentally when deciding whether to create a sysfs attribute.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-sysfs.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 95d9e7b..a4cfa52 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1409,7 +1409,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	return 0;
 
 err_rom_file:
-	if (rom_size) {
+	if (pdev->rom_attr) {
 		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
 		kfree(pdev->rom_attr);
 		pdev->rom_attr = NULL;
@@ -1447,8 +1447,6 @@ static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
  */
 void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
-	int rom_size = 0;
-
 	if (!sysfs_initialized)
 		return;
 
@@ -1461,18 +1459,13 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_resource_files(pdev);
 
-	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	else if (pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW)
-		rom_size = 0x20000;
-
-	if (rom_size && pdev->rom_attr) {
+	if (pdev->rom_attr) {
 		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
 		kfree(pdev->rom_attr);
+		pdev->rom_attr = NULL;
 	}
 
 	pci_remove_firmware_label_files(pdev);
-
 }
 
 static int __init pci_sysfs_init(void)

