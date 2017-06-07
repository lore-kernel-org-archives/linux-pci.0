Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbdFGTBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jun 2017 15:01:01 -0400
Subject: [PATCH] PCI: Add Intel XXV710 to broken INTx masking quirk
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Stefan Assmann <sassmann@redhat.com>,
        linux-kernel@vger.kernel.org
Date: Wed, 07 Jun 2017 13:00:48 -0600
Message-ID: <20170607190027.22611.92564.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just like the other XL710 and X710 variants, the XXV710 device IDs
appear to have the same hardware bug, the status register doesn't
report pending interrupts resulting in "irq xx: nobody cared..."
errors from the spurious interrupt handler when we try to use it
with device assignment.

Reported-by: Stefan Assmann <sassmann@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/pci/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 16e6cd86ad71..aa1c9e65f562 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3236,6 +3236,10 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1589,
 			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158a,
+			quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x158b,
+			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d0,
 			quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x37d1,
