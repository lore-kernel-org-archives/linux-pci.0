Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45225 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763561AbdAET3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2017 14:29:53 -0500
From: Dan Streetman <dan.streetman@canonical.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xen: do not re-use pirq number cached in pci device msi msg data
Date: Thu,  5 Jan 2017 14:28:56 -0500
Message-Id: <20170105192856.25559-1-dan.streetman@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Do not read a pci device's msi message data to see if a pirq was
previously configured for the device's msi/msix, as the old pirq was
unmapped and may now be in use by another pci device.  The previous
pirq should never be re-used; instead a new pirq should always be
allocated from the hypervisor.

The xen_hvm_setup_msi_irqs() function currently checks the pci device's
msi descriptor message data for each msi/msix vector it sets up, and if
it finds the vector was previously configured with a pirq, and that pirq
is mapped to an irq, it re-uses the pirq instead of requesting a new pirq
from the hypervisor.  However, that pirq was unmapped when the pci device
disabled its msi/msix, and it cannot be re-used; it may have been given
to a different pci device.

This exact situation is happening in a Xen guest where multiple NVMe
controllers (pci devices) are present.  The NVMe driver configures each
pci device's msi/msix twice; first to configure a single vector (to
talk to the controller for its configuration info), and then it disables
that msi/msix and re-configures with all the msi/msix it needs.  When
multiple NVMe controllers are present, this happens concurrently on all
of them, and in the time between controller A calling pci_disable_msix()
and then calling pci_enable_msix_range(), controller B enables its msix
and gets controller A's pirq allocated from the hypervisor.  Then when
controller A re-configures its msix, its first vector tries to re-use
the same pirq that it had before; but that pirq was allocated to
controller B, and thus the Xen event channel for controller A's re-used
pirq fails to map its irq to that pirq; the hypervisor already has the
pirq mapped elsewhere.

Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
---
 arch/x86/pci/xen.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index bedfab9..a00a6c0 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -234,23 +234,14 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 		return 1;
 
 	for_each_pci_msi_entry(msidesc, dev) {
-		__pci_read_msi_msg(msidesc, &msg);
-		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
-			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
-		if (msg.data != XEN_PIRQ_MSI_DATA ||
-		    xen_irq_from_pirq(pirq) < 0) {
-			pirq = xen_allocate_pirq_msi(dev, msidesc);
-			if (pirq < 0) {
-				irq = -ENODEV;
-				goto error;
-			}
-			xen_msi_compose_msg(dev, pirq, &msg);
-			__pci_write_msi_msg(msidesc, &msg);
-			dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
-		} else {
-			dev_dbg(&dev->dev,
-				"xen: msi already bound to pirq=%d\n", pirq);
+		pirq = xen_allocate_pirq_msi(dev, msidesc);
+		if (pirq < 0) {
+			irq = -ENODEV;
+			goto error;
 		}
+		xen_msi_compose_msg(dev, pirq, &msg);
+		__pci_write_msi_msg(msidesc, &msg);
+		dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
 		irq = xen_bind_pirq_msi_to_irq(dev, msidesc, pirq,
 					       (type == PCI_CAP_ID_MSI) ? nvec : 1,
 					       (type == PCI_CAP_ID_MSIX) ?
-- 
2.9.3

