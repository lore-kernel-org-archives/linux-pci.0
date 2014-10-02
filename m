Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:57489 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbaJBAeN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 20:34:13 -0400
Message-ID: <1412210019.4285.251.camel@pasglop>
Subject: [PATCH v2 2/4] gpu/radeon: Move 64-bit MSI quirk from arch to driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 10:33:39 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A number of radeon cards have a HW limitation causing them to be
unable to generate the full 64-bit of address bits for MSIs. This
breaks MSIs on some platforms such as POWER machines.

We used to have a powerpc specific quirk to address that on a
single card, but this doesn't scale very well, this is better
put under control of the drivers who know precisely what a given
HW revision can do.

This moves the setting of the quirk flag to the radeon driver

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---

v2: This is just adjusted to the new flag name

 arch/powerpc/kernel/pci_64.c            |  1 -
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index d41a831..5330f6d 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -271,5 +271,4 @@ static void quirk_radeon_32bit_msi(struct pci_dev *dev)
 {
 	dev->no_64bit_msi = true;
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index 16807af..e760671 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -202,6 +202,16 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	if (rdev->flags & RADEON_IS_AGP)
 		return false;
 
+	/*
+	 * Older chips have a HW limitation, they can only generate 40 bits
+	 * of address for "64-bit" MSIs which breaks on some platforms, notably
+	 * IBM POWER servers, so we limit them
+	 */
+	if (rdev->family < CHIP_BONAIRE) {
+		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
+		rdev->pdev->no_64bit_msi = true;
+	}
+
 	/* force MSI on */
 	if (radeon_msi == 1)
 		return true;


