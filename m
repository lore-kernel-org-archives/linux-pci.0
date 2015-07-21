Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35410 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbbGUAO6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:58 -0400
Received: by igr7 with SMTP id 7so26848916igr.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:58 -0700 (PDT)
Subject: [PATCH v2 08/11] PCI: Clean up ATS error handling
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:54 -0500
Message-ID: <20150721001454.28145.35617.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no need to BUG() if we enable ATS when it's already enabled.  We
don't need to BUG() when disabling ATS on a device that doesn't support ATS
or if it's already disabled.  If ATS is enabled, certainly we found an ATS
capability in the past, so it should still be there now.

Clean up these error paths.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0b5b0ed..67524a7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -44,11 +44,12 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	BUG_ON(dev->ats_cap && dev->ats_enabled);
-
 	if (!dev->ats_cap)
 		return -EINVAL;
 
+	if (pci_ats_enabled(dev))
+		return -EINVAL;
+
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
@@ -83,7 +84,8 @@ void pci_disable_ats(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 ctrl;
 
-	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
+	if (!pci_ats_enabled(dev))
+		return;
 
 	if (atomic_read(&dev->ats_ref_cnt))
 		return;		/* VFs still enabled */
@@ -107,8 +109,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	if (!pci_ats_enabled(dev))
 		return;
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS))
-		BUG();
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)

