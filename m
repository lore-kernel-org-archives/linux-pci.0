Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbdEST65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 May 2017 15:58:57 -0400
Subject: [PATCH v1 2/2] PCI: Correct PCI_STD_RESOURCE_END usage
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Douglas Lehr <dllehr@us.ibm.com>,
        Milton Miller <miltonm@us.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 May 2017 14:58:55 -0500
Message-ID: <20170519195855.25440.29969.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170519195849.25440.65477.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170519195849.25440.65477.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 9fe373f9997b ("PCI: Increase IBM ipr SAS Crocodile BARs to at least system page size")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 085fb787aa9e..16e6cd86ad71 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -304,7 +304,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *dev)
 {
 	int i;
 
-	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *r = &dev->resource[i];
 
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
