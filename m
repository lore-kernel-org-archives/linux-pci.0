Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36626 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756847AbbGUAOu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:50 -0400
Received: by iehx8 with SMTP id x8so49646199ieh.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:49 -0700 (PDT)
Subject: [PATCH v2 07/11] PCI: Use pci_physfn() rather than looking up
 physfn by hand
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:46 -0500
Message-ID: <20150721001446.28145.65839.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the pci_physfn() helper rather than looking up physfn by hand.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 95905f3..0b5b0ed 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,6 +42,7 @@ void pci_ats_init(struct pci_dev *dev)
 int pci_enable_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
+	struct pci_dev *pdev;
 
 	BUG_ON(dev->ats_cap && dev->ats_enabled);
 
@@ -57,8 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	 */
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (dev->is_virtfn) {
-		struct pci_dev *pdev = dev->physfn;
-
+		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
 
@@ -80,6 +80,7 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
  */
 void pci_disable_ats(struct pci_dev *dev)
 {
+	struct pci_dev *pdev;
 	u16 ctrl;
 
 	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
@@ -88,8 +89,7 @@ void pci_disable_ats(struct pci_dev *dev)
 		return;		/* VFs still enabled */
 
 	if (dev->is_virtfn) {
-		struct pci_dev *pdev = dev->physfn;
-
+		pdev = pci_physfn(dev);
 		atomic_dec(&pdev->ats_ref_cnt);
 	}
 

