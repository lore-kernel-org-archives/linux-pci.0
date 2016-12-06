Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33363 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLFO2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2016 09:28:36 -0500
From: Konrad Rzeszutek Wilk <konrad@kernel.org>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, bhelgaas@google.com, jgross@suse.com,
        x86@kernel.org, linux-pci@vger.kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] xen/pci: Bubble up error and fix description.
Date: Tue,  6 Dec 2016 09:28:21 -0500
Message-Id: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function is never called under PV guests, and only shows up
when MSI (or MSI-X) cannot be allocated. Convert the message
to include the error value.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index bedfab9..e1fb269 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -264,8 +264,8 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return 0;
 
 error:
-	dev_err(&dev->dev,
-		"Xen PCI frontend has not registered MSI/MSI-X support!\n");
+	dev_err(&dev->dev, "Failed to create MSI%s! ret=%d!\n",
+		type == PCI_CAP_ID_MSI ? "" : "-X", irq);
 	return irq;
 }
 
-- 
2.7.4

