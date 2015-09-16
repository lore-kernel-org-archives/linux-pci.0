Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbbIPEYr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Sep 2015 00:24:47 -0400
Subject: [PATCH] PCI: Relax function 0 VPD test and relocate
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: mark.d.rustad@intel.com, myron.stowe@redhat.com,
	linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2015 22:24:46 -0600
Message-ID: <20150916041858.26694.97435.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we quirk a device with PCI_DEV_FLAGS_VPD_REF_F0 we're expecting
to find a device where all the functions are identical.  If we don't
find that, we don't make VPD accessible through pci_vpd_ops.  That
means that if we quirk devices we shouldn't, we filter them out by
hiding VPD entirely rather than allowing default access.  Instead, we
can flip this around to only quirk devices that match a slightly more
rigorous test in the quirk, allowing regular access for anything else.

Tests for the multifunction flag are removed since a) function 0 and
the function under test are clearly a multifunction device if we're
scanning a non-zero function in the same slot and b) at this point the
flag is only set in the device under test if the multifunction bit is
set in the PCI HEADER, which is a point of interpretation for the PCI
spec.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

This is potentially another stable candiate since we're continuing to
iterate on 932c435caba8, but since we don't actually know of a device
where VPD is blocked (we don't think my Skylake example actually
supports VPD), I'm not including it.  I would support it if requested
though.

 drivers/pci/access.c |   22 ----------------------
 drivers/pci/quirks.c |   20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 5a5f0a7..59ac36f 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -475,23 +475,6 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.release = pci_vpd_pci22_release,
 };
 
-static int pci_vpd_f0_dev_check(struct pci_dev *dev)
-{
-	struct pci_dev *tdev = pci_get_slot(dev->bus,
-					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
-	int ret = 0;
-
-	if (!tdev)
-		return -ENODEV;
-	if (!tdev->vpd || !tdev->multifunction ||
-	    dev->class != tdev->class || dev->vendor != tdev->vendor ||
-	    dev->device != tdev->device)
-		ret = -ENODEV;
-
-	pci_dev_put(tdev);
-	return ret;
-}
-
 int pci_vpd_pci22_init(struct pci_dev *dev)
 {
 	struct pci_vpd_pci22 *vpd;
@@ -500,12 +483,7 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
 	cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	if (!cap)
 		return -ENODEV;
-	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0) {
-		int ret = pci_vpd_f0_dev_check(dev);
 
-		if (ret)
-			return ret;
-	}
 	vpd = kzalloc(sizeof(*vpd), GFP_ATOMIC);
 	if (!vpd)
 		return -ENOMEM;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6a30252..b03373f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1907,11 +1907,27 @@ static void quirk_netmos(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID,
 			 PCI_CLASS_COMMUNICATION_SERIAL, 8, quirk_netmos);
 
+/*
+ * Quirk non-zero PCI functions to route VPD access through function 0 for
+ * devices that share VPD resources between functions.  The functions are
+ * expected to be identical devices.
+ */
 static void quirk_f0_vpd_link(struct pci_dev *dev)
 {
-	if (!dev->multifunction || !PCI_FUNC(dev->devfn))
+	struct pci_dev *f0;
+
+	if (!PCI_FUNC(dev->devfn))
 		return;
-	dev->dev_flags |= PCI_DEV_FLAGS_VPD_REF_F0;
+
+	f0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	if (!f0)
+		return;
+
+	if (f0->vpd && dev->class == f0->class &&
+	    dev->vendor == f0->vendor && dev->device == f0->device)
+		dev->dev_flags |= PCI_DEV_FLAGS_VPD_REF_F0;
+
+	pci_dev_put(f0);
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_NETWORK_ETHERNET, 8, quirk_f0_vpd_link);

