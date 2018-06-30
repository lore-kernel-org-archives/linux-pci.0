Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755150AbeF3CVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 22:21:43 -0400
Subject: [PATCH] PCI: Make pci_get_rom_size() static
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rex Zhu <Rex.Zhu@amd.com>
Date: Fri, 29 Jun 2018 21:21:39 -0500
Message-ID: <153032529978.134892.3376112989125005436.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pci_get_rom_size() is called only from pci_map_rom(), so it can be static.
Make it static and remove the declaration from include/linux/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/rom.c   |    3 ++-
 include/linux/pci.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 3a33f5ce314a..137bf0cee897 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -80,7 +80,8 @@ EXPORT_SYMBOL_GPL(pci_disable_rom);
  * The PCI window size could be much larger than the
  * actual image size.
  */
-size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
+static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
+			       size_t size)
 {
 	void __iomem *image;
 	int last_image;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..f40d3e05ccd1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1122,7 +1122,6 @@ int pci_enable_rom(struct pci_dev *pdev);
 void pci_disable_rom(struct pci_dev *pdev);
 void __iomem __must_check *pci_map_rom(struct pci_dev *pdev, size_t *size);
 void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
-size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size);
 void __iomem __must_check *pci_platform_rom(struct pci_dev *pdev, size_t *size);
 
 /* Power management related routines */
