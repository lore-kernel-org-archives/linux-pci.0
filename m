Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38084 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965225AbbHKPwG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:52:06 -0400
Received: by igfj19 with SMTP id j19so74959804igf.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:52:05 -0700 (PDT)
Subject: [PATCH v3 08/11] PCI: Clean up ATS error handling
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 11 Aug 2015 10:52:02 -0500
Message-ID: <20150811155202.21078.33427.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/ats.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0b5b0ed..0f05274 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -44,11 +44,13 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	BUG_ON(dev->ats_cap && dev->ats_enabled);
-
 	if (!dev->ats_cap)
 		return -EINVAL;
 
+	WARN_ON(pci_ats_enabled(dev));
+	if (pci_ats_enabled(dev))
+		return -EBUSY;
+
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
@@ -83,7 +85,8 @@ void pci_disable_ats(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 ctrl;
 
-	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
+	if (!pci_ats_enabled(dev))
+		return;
 
 	if (atomic_read(&dev->ats_ref_cnt))
 		return;		/* VFs still enabled */
@@ -107,8 +110,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	if (!pci_ats_enabled(dev))
 		return;
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS))
-		BUG();
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)

