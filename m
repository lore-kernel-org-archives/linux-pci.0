Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34221 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481AbbGUAOd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:33 -0400
Received: by iebmu5 with SMTP id mu5so129467529ieb.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:33 -0700 (PDT)
Subject: [PATCH v2 05/11] PCI: Rationalize pci_ats_queue_depth() error
 checking
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:30 -0500
Message-ID: <20150721001429.28145.76331.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We previously returned -ENODEV for devices that don't support ATS (except
that we always returned 0 for VFs, whether or not they support ATS).

For consistency, always return -EINVAL (not -ENODEV) if the device doesn't
support ATS.  Return zero for VFs that support ATS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 690ae6e..9a98b3a 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -136,13 +136,13 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
  */
 int pci_ats_queue_depth(struct pci_dev *dev)
 {
+	if (!dev->ats_cap)
+		return -EINVAL;
+
 	if (dev->is_virtfn)
 		return 0;
 
-	if (dev->ats_cap)
-		return dev->ats_qdep;
-
-	return -ENODEV;
+	return dev->ats_qdep;
 }
 EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
 

