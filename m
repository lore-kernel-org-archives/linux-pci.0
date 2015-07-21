Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35287 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbbGUAOl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2015 20:14:41 -0400
Received: by igr7 with SMTP id 7so26845292igr.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2015 17:14:41 -0700 (PDT)
Subject: [PATCH v2 06/11] PCI: Inline the ATS setup code into pci_ats_init()
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Date: Mon, 20 Jul 2015 19:14:38 -0500
Message-ID: <20150721001438.28145.28518.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ATS setup code in ats_alloc_one() is only used by pci_ats_init(), so
inline it there.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9a98b3a..95905f3 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -17,7 +17,7 @@
 
 #include "pci.h"
 
-static void ats_alloc_one(struct pci_dev *dev)
+void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
@@ -32,11 +32,6 @@ static void ats_alloc_one(struct pci_dev *dev)
 					    PCI_ATS_MAX_QDEP;
 }
 
-void pci_ats_init(struct pci_dev *dev)
-{
-	ats_alloc_one(dev);
-}
-
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device

