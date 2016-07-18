Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] pci: Add DMA alias quirk for Adaptec 3805
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Mon, 18 Jul 2016 08:32:45 -0600
Message-ID: <20160718143209.7169.80117.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just like the 3405 quirk added in commit d3d2ab43ddae ("PCI: Add DMA
alias quirk for Adaptec 3405").

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://www.redhat.com/archives/vfio-users/2016-July/msg00046.html
---
 drivers/pci/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 98b0af0..b69321c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3752,6 +3752,9 @@ static const struct pci_device_id fixed_dma_alias_tbl[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
 			 PCI_VENDOR_ID_ADAPTEC2, 0x02bb), /* Adaptec 3405 */
 	  .driver_data = PCI_DEVFN(1, 0) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
+			 PCI_VENDOR_ID_ADAPTEC2, 0x02bc), /* Adaptec 3805 */
+	  .driver_data = PCI_DEVFN(1, 0) },
 	{ 0 }
 };
 
