Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36111 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965225AbbHKPvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 11:51:49 -0400
Received: by igbij6 with SMTP id ij6so93528390igb.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 08:51:48 -0700 (PDT)
Subject: [PATCH v3 06/11] PCI: Inline the ATS setup code into pci_ats_init()
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>,
	iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 11 Aug 2015 10:51:46 -0500
Message-ID: <20150811155146.21078.16008.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

