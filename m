Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50716 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbcCFWCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 6 Mar 2016 17:02:32 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 2288D340A5D
	for <linux-pci@vger.kernel.org>; Sun,  6 Mar 2016 22:02:31 +0000 (UTC)
Date: Sun, 6 Mar 2016 22:02:30 +0000
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org,
	"Robin H. Johnson" <robbat2@gentoo.org>, mst@redhat.com,
	perex@perex.cz, tiwai@suse.com, bhelgaas@google.com,
	Dave Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH resend] PCI: QEMU top-level IDs for (sub)vendor & device
Message-ID: <20160306220230.GB3720@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce PCI_VENDOR/PCI_SUBVENDOR/PCI_SUBDEVICE defines to replace the
constants scattered in the kernel already used to detect QEMU.

They are defined in the QEMU codebase per docs/specs/pci-ids.txt.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
This change prompted by a near-miss in the review of recent change:
'drm/i915: refine qemu south bridge detection'

This patch was previously sent to LKML 25 Jan 2016; and got some
reviews, but otherwise slipped through the cracks.

---
 drivers/gpu/drm/bochs/bochs_drv.c   | 4 ++--
 drivers/gpu/drm/cirrus/cirrus_drv.c | 5 +++--
 drivers/virtio/virtio_pci_common.c  | 2 +-
 include/linux/pci_ids.h             | 4 ++++
 sound/pci/intel8x0.c                | 4 ++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 7f1a360..b332b4d3 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -182,8 +182,8 @@ static const struct pci_device_id bochs_pci_tbl[] = {
 	{
 		.vendor      = 0x1234,
 		.device      = 0x1111,
-		.subvendor   = 0x1af4,
-		.subdevice   = 0x1100,
+		.subvendor   = PCI_SUBVENDOR_ID_REDHAT_QUMRANET,
+		.subdevice   = PCI_SUBDEVICE_ID_QEMU,
 		.driver_data = BOCHS_QEMU_STDVGA,
 	},
 	{
diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index b1619e2..7bc394e 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -33,8 +33,9 @@ static struct drm_driver driver;
 
 /* only bind to the cirrus chip in qemu */
 static const struct pci_device_id pciidlist[] = {
-	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446, 0x1af4, 0x1100, 0,
-	  0, 0 },
+	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
+	  PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU,
+	  0, 0, 0 },
 	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446, PCI_VENDOR_ID_XEN,
 	  0x0001, 0, 0, 0 },
 	{0,}
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 36205c2..127dfe4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -467,7 +467,7 @@ static const struct dev_pm_ops virtio_pci_pm_ops = {
 
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
 static const struct pci_device_id virtio_pci_id_table[] = {
-	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
 	{ 0 }
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 37f05cb..6d249d3 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2506,6 +2506,10 @@
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
 
+#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4
+#define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x1af4
+#define PCI_SUBDEVICE_ID_QEMU            0x1100
+
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
 
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 42bcbac..12c2c18 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2980,8 +2980,8 @@ static int snd_intel8x0_inside_vm(struct pci_dev *pci)
 		goto fini;
 
 	/* check for known (emulated) devices */
-	if (pci->subsystem_vendor == 0x1af4 &&
-	    pci->subsystem_device == 0x1100) {
+	if (pci->subsystem_vendor == PCI_SUBVENDOR_ID_REDHAT_QUMRANET &&
+	    pci->subsystem_device == PCI_SUBDEVICE_ID_QEMU) {
 		/* KVM emulated sound, PCI SSID: 1af4:1100 */
 		msg = "enable KVM";
 	} else if (pci->subsystem_vendor == 0x1ab8) {
-- 
2.3.0

