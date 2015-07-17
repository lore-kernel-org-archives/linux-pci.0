Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34582 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbGQVcT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 17:32:19 -0400
Received: by obre1 with SMTP id e1so73281975obr.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 14:32:18 -0700 (PDT)
Subject: [PATCH 4/8] PCI: Rationalize pci_ats_queue_depth() error checking
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gregor Dick <gdick@solarflare.com>
Date: Fri, 17 Jul 2015 16:32:16 -0500
Message-ID: <20150717213215.18379.59848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We previously returned -ENODEV for devices that don't support ATS (except
that we always returned 0 for VFs, whether or not they support ATS).

For consistency, always return -EINVAL (not -ENODEV) if the device doesn't
support ATS.  Return zero for VFs that support ATS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 2f1fb9c..ea459b3 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -121,13 +121,13 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
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
 

