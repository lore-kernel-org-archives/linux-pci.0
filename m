Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 1/2] efi/fb: Correct PCI_STD_RESOURCE_END usage
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Douglas Lehr <dllehr@us.ibm.com>,
        Milton Miller <miltonm@us.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 May 2017 14:58:49 -0500
Message-ID: <20170519195849.25440.65477.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that covers the framebuffer")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/video/fbdev/efifb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index b827a8113e26..ff01bed7112f 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -408,7 +408,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
-	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *res = &dev->resource[i];
 
 		if (!(res->flags & IORESOURCE_MEM))
