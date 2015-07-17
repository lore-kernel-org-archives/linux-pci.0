Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34289 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbGQVc1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:27 -0400
Received: by oigd21 with SMTP id d21so36099695oig.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:27 -0700 (PDT)
Subject: [PATCH 5/8] PCI: Inline the ATS setup code into pci_ats_init()
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:23 -0500
Message-ID: <20150717213223.18379.75832.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ATS setup code in ats_alloc_one() is only used by pci_ats_init(), so
inline it there.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ea459b3..fe59182 100644
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

