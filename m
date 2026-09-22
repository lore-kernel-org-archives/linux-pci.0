Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4894DD3CD
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061518; cv=none; b=f4/78vEoNSfyPpTfS4xc9PKJ9cXcEzoy6QrRB9RJZLHQtVPkA3MqmkkUlNM3QA9wVudrR8A1RCmbBQEs85JH6HDkX8Ev/eat93kXHeISMJdnFjpgSJ+veeUZEdHdor6FiFXoU2icaJxasTcioaq+cm2X41wDJJli2cMg8nFUJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061518; c=relaxed/simple;
	bh=/c6cs3Wv6ewHzi6YIG6+r/KZ5oYPJuzWmF8vL43h66k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=sob43JZTmsuxeNstdkNylE/ET5KxsQHFkMglAcvspaxLHOqP13Lvd4zOZm1NnPmDTYVkOi2InBPAsHyhXE7Q9eW3jUXg59oJ/nZJVUYzWCMCk1IgNMBbKXIRV5UOm3gKsgsbAOAOh/HaUfZSVfc8Nex5M/mecZZH7ic1q0CYu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-tFOi3OTHNZqgONxobXICeg-1; Tue,
 22 Sep 2026 03:18:25 -0400
X-MC-Unique: tFOi3OTHNZqgONxobXICeg-1
X-Mimecast-MFC-AGG-ID: tFOi3OTHNZqgONxobXICeg_1790061503
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE4AB1955F12;
	Tue, 22 Sep 2026 07:18:23 +0000 (UTC)
Received: from dreadlord.lan (unknown [10.67.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E248E1800345;
	Tue, 22 Sep 2026 07:18:16 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Dave Airlie <airlied@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode callback (v2)
Date: Tue, 22 Sep 2026 17:18:07 +1000
Message-ID: <20260922071807.2533884-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RDUFzgWOecD7MvWWyYFocNmcGQt6MCKFJU2gj38ikc8_1790061503
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

From: Dave Airlie <airlied@redhat.com>

This changes the vgaarb client API so that the user can pass a
private data pointer into the register that will get used in
the decode callback.

This allows a bunch of pdev conversions in the drivers, and lets
some future vfio cleanups be nicer.

I'd like to merge this via the drm next tree but also fine with
it going via pci.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
v2: fix loongson (spotted by sashiko)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
 drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
 drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
 drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
 drivers/pci/vgaarb.c                       | 13 +++++++++----
 drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
 include/linux/vgaarb.h                     |  8 +++++---
 8 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 62b5b4a23f17..1344b2b1bd16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1435,10 +1435,10 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_de=
vice *adev)
  * Enable/disable vga decode (all asics).
  * Returns VGA resource flags.
  */
-static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
+static unsigned int amdgpu_device_vga_set_decode(void *data,
 =09=09bool state)
 {
-=09struct amdgpu_device *adev =3D drm_to_adev(pci_get_drvdata(pdev));
+=09struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
=20
 =09amdgpu_asic_set_vga_state(adev, state);
 =09if (state)
@@ -4208,7 +4208,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 =09 * ignore it
 =09 */
 =09if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
-=09=09vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
+=09=09vga_client_register(adev->pdev, amdgpu_device_vga_set_decode, adev);
=20
 =09px =3D amdgpu_device_supports_px(adev);
=20
diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i91=
5/display/intel_vga.c
index 4966fd7eea92..0889edb36190 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -283,9 +283,10 @@ void intel_vga_disable(struct intel_display *display)
 =09intel_de_posting_read(display, vga_reg);
 }
=20
-static unsigned int intel_vga_set_decode(struct pci_dev *pdev, bool enable=
_decode)
+static unsigned int intel_vga_set_decode(void *data, bool enable_decode)
 {
-=09struct intel_display *display =3D to_intel_display(pdev);
+=09struct intel_display *display =3D (struct intel_display *)data;
+=09struct pci_dev *pdev =3D to_pci_dev(display->drm->dev);
 =09unsigned int decodes =3D VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
=20
 =09drm_dbg_kms(display->drm, "%s VGA decode due to VGA arbitration\n",
@@ -331,7 +332,7 @@ void intel_vga_register(struct intel_display *display)
 =09 * then we do not take part in VGA arbitration and the
 =09 * vga_client_register() fails with -ENODEV.
 =09 */
-=09ret =3D vga_client_register(pdev, intel_vga_set_decode);
+=09ret =3D vga_client_register(pdev, intel_vga_set_decode, display);
 =09drm_WARN_ON(display->drm, ret && ret !=3D -ENODEV);
 }
=20
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson=
/lsdc_drv.c
index 3fd828d23271..5a13df31eb90 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -254,7 +254,7 @@ lsdc_create_device(struct pci_dev *pdev,
=20
 /* For multiple GPU driver instance co-exixt in the system */
=20
-static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state)
+static unsigned int lsdc_vga_set_decode(void *data, bool state)
 {
 =09return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
 }
@@ -291,7 +291,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
=20
 =09pci_set_drvdata(pdev, ddev);
=20
-=09vga_client_register(pdev, lsdc_vga_set_decode);
+=09vga_client_register(pdev, lsdc_vga_set_decode, NULL);
=20
 =09drmm_kms_helper_poll_init(ddev);
=20
diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouvea=
u/nouveau_vga.c
index 29a801124e56..6662e30466f2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -9,9 +9,9 @@
 #include "nouveau_vga.h"
=20
 static unsigned int
-nouveau_vga_set_decode(struct pci_dev *pdev, bool state)
+nouveau_vga_set_decode(void *data, bool state)
 {
-=09struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
+=09struct nouveau_drm *drm =3D (struct nouveau_drm *)data;
 =09struct nvif_object *device =3D &drm->client.device.object;
=20
 =09if (drm->client.device.info.family =3D=3D NV_DEVICE_INFO_V0_CURIE &&
@@ -103,7 +103,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
 =09=09return;
 =09pdev =3D to_pci_dev(dev->dev);
=20
-=09vga_client_register(pdev, nouveau_vga_set_decode);
+=09vga_client_register(pdev, nouveau_vga_set_decode, drm);
=20
 =09/* don't register Thunderbolt eGPU with vga_switcheroo */
 =09if (pci_is_thunderbolt_attached(pdev))
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeo=
n/radeon_device.c
index 9523240110a6..cf8a6bd00c77 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1076,10 +1076,9 @@ void radeon_combios_fini(struct radeon_device *rdev)
  * Enable/disable vga decode (all asics).
  * Returns VGA resource flags.
  */
-static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool state=
)
+static unsigned int radeon_vga_set_decode(void *data, bool state)
 {
-=09struct drm_device *dev =3D pci_get_drvdata(pdev);
-=09struct radeon_device *rdev =3D dev->dev_private;
+=09struct radeon_device *rdev =3D (struct radeon_device *)data;
 =09radeon_vga_set_state(rdev, state);
 =09if (state)
 =09=09return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
@@ -1431,7 +1430,7 @@ int radeon_device_init(struct radeon_device *rdev,
 =09/* if we have > 1 VGA cards, then disable the radeon VGA resources */
 =09/* this will fail for cards that aren't VGA class devices, just
 =09 * ignore it */
-=09vga_client_register(rdev->pdev, radeon_vga_set_decode);
+=09vga_client_register(rdev->pdev, radeon_vga_set_decode, rdev);
=20
 =09if (rdev->flags & RADEON_IS_PX)
 =09=09runtime =3D true;
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3de05aee7859..3e58b2c05c85 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -51,7 +51,8 @@ struct vga_device {
 =09unsigned int mem_norm_cnt;=09/* normal MEM count */
 =09bool bridge_has_one_vga;
 =09bool is_firmware_default;=09/* device selected by firmware */
-=09unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
+=09unsigned int (*set_decode)(void *data, bool decode);
+=09void *set_decode_data;
 };
=20
 static LIST_HEAD(vga_list);
@@ -935,6 +936,7 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
  * vga_client_register - register or unregister a VGA arbitration client
  * @pdev: PCI device of the VGA client
  * @set_decode: VGA decode change callback
+ * @data: private data to pass to callback
  *
  * Clients have two callback mechanisms they can use.
  *
@@ -956,15 +958,18 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
  * Returns: 0 on success, -ENODEV on failure
  */
 int vga_client_register(struct pci_dev *pdev,
-=09=09unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
+=09=09unsigned int (*set_decode)(void *data, bool decode),
+=09=09void *data)
 {
 =09unsigned long flags;
 =09struct vga_device *vgadev;
=20
 =09spin_lock_irqsave(&vga_lock, flags);
 =09vgadev =3D vgadev_find(pdev);
-=09if (vgadev)
+=09if (vgadev) {
 =09=09vgadev->set_decode =3D set_decode;
+=09=09vgadev->set_decode_data =3D data;
+=09}
 =09spin_unlock_irqrestore(&vga_lock, flags);
 =09if (!vgadev)
 =09=09return -ENODEV;
@@ -1464,7 +1469,7 @@ static void vga_arbiter_notify_clients(void)
 =09spin_lock_irqsave(&vga_lock, flags);
 =09list_for_each_entry(vgadev, &vga_list, list) {
 =09=09if (vgadev->set_decode) {
-=09=09=09new_decodes =3D vgadev->set_decode(vgadev->pdev,
+=09=09=09new_decodes =3D vgadev->set_decode(vgadev->set_decode_data,
 =09=09=09=09=09=09=09 new_state);
 =09=09=09vga_update_device_decodes(vgadev, new_decodes);
 =09=09}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_c=
ore.c
index 6757054e9d87..b04ce3ded08c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -162,9 +162,10 @@ static inline void vfio_pci_core_debugfs_init(struct v=
fio_pci_core_device *vdev)
  * has no way to get to it and routing can be disabled externally at the
  * bridge.
  */
-static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_=
vga)
+static unsigned int vfio_pci_set_decode(void *data, bool single_vga)
 {
-=09struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
+=09struct vfio_pci_core_device *vdev =3D data;
+=09struct pci_dev *pdev =3D vdev->pdev;
 =09struct pci_dev *tmp =3D NULL;
 =09unsigned char max_busnr;
 =09unsigned int decodes;
@@ -2159,10 +2160,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core_d=
evice *vdev)
 =09if (ret)
 =09=09return ret;
=20
-=09ret =3D vga_client_register(pdev, vfio_pci_set_decode);
+=09ret =3D vga_client_register(pdev, vfio_pci_set_decode, vdev);
 =09if (ret)
 =09=09return ret;
-=09vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
+=09vga_set_legacy_decoding(pdev, vfio_pci_set_decode(vdev, false));
 =09return 0;
 }
=20
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 97129a1bbb7d..71a364669eaf 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
 void vga_set_default_device(struct pci_dev *pdev);
 int vga_remove_vgacon(struct pci_dev *pdev);
 int vga_client_register(struct pci_dev *pdev,
-=09=09unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
+=09=09unsigned int (*set_decode)(void *data, bool state),
+=09=09void *data);
 #else /* CONFIG_VGA_ARB */
 static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
 =09=09unsigned int decodes)
@@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pdev)
 =09return 0;
 }
 static inline int vga_client_register(struct pci_dev *pdev,
-=09=09unsigned int (*set_decode)(struct pci_dev *pdev, bool state))
+=09=09unsigned int (*set_decode)(void *data, bool state),
+=09=09void *data)
 {
 =09return 0;
 }
@@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_dev =
*pdev,
=20
 static inline void vga_client_unregister(struct pci_dev *pdev)
 {
-=09vga_client_register(pdev, NULL);
+=09vga_client_register(pdev, NULL, NULL);
 }
=20
 #endif /* LINUX_VGA_H */
--=20
2.54.0

