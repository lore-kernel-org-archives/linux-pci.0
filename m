Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33216 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbGQVcf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:35 -0400
Received: by oige126 with SMTP id e126so78460634oig.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:35 -0700 (PDT)
Subject: [PATCH 6/8] PCI: Use pci_physfn() rather than looking up physfn by
 hand
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:32 -0500
Message-ID: <20150717213232.18379.64802.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the pci_physfn() helper rather than looking up physfn by hand.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index fe59182..c35de8e 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -53,9 +53,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (dev->is_virtfn) {
-		struct pci_dev *pdev = dev->physfn;
-
-		if (pdev->ats_stu != ps)
+		if (pci_physfn(dev)->ats_stu != ps)
 			return -EINVAL;
 	} else {
 		dev->ats_stu = ps;

