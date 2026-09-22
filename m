Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9E38DC69
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089572; cv=pass; b=KMhcvDOR7Cd+k8uISu4sUCKdjH/5BnSMyMRs+Qke4gqBcmIpLEBIcUt7QUp3LAj1o4CmPbXcsO/qvqt6DV0PPX2GKM3LCCMxA6V0kT2U/v4Lj2ZdmkY1revz4TmvNmTtSbl9pPeihPwEegXpLh8iIKDKoOAHanIrhv/XeBl4Psg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089572; c=relaxed/simple;
	bh=ONVmGvo87pUI426xuRcPM9yTSoJzn0EJCE96fjQSUjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1DuBzhGidiQJlg2Clj7Ft+XunCYGVL9BCmOBToqMJhXhFw/2d9qYuA6wmJPhZEXbLfy0zbuW+dMmd/0Zdd38VBNiPvVIBoAXt5oeudsWUrtQwAMvg7DrtdopKpJwVgKa2KpLRzCx7hjNK/vrbuEk2V/ZeZ0fQCQoqKxPa9pgyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAQ1PQXN; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAQ1PQXN"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804db2d0287so5667a34.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 08:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790089569; cv=none;
        d=google.com; s=arc-20260327;
        b=LFDTg3ohY+AX4rN7OiTfHkT0jj9UoxRNziAM695YXTQEPW4jsUVuWUIyd3uVFOB4TE
         wxaMSoUSJHxyysG5rUwqEhpJ7OqpINj5t8tbRsZI/kShhj9Za26zHwXb21N6ge2yROEe
         jsvXc9H8Tcw+Wtp6Gr/hhg6dv93yZemOxeM+Gn3Aa282WFisJ9JBIjhdIANfG2MBv20K
         Gyji5FIqI0RzPHOMwBhm2iC8KXilUrQcauRsg4w25YVkPJ5BKqUf9ORQzS2YnWOMnwQx
         xu6RW9aQyPfiFiGdQaoIMucKoEvtXcPFSXCL7/t63RCl0QkV6epUbXWaEsz2Mw8q4WIT
         bZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
        fh=SagXt+/M8999/9ccvuKCZnHmmSt0+z2foVpMi08J8sc=;
        b=pN8nUxFViDO7QUe3EwI1HRKleK6Xz0+4w1syAI0SR0oIRHertlFxFJH03ykPacUvS3
         kyIiB/6s9L7ehf51mDu1WXw4As7jYy0MNgNLL9a6Jq0W2Qs1WcOMYA1x5voK+FFjXJMk
         X/ybOzFFrYv0VolRYFpq4dZYgiBVsAhKCL4OuqFXxQe1czLLEo1LzfNVx/yHmorxeShw
         3of6RmCt8skAX5k4WA4tTEpqvUA3zJnPQXKh2MZ8a//Qsng29QqqSeqqfh+xz3WGJSea
         bco0aDLK4HXdiIePlIGD8LhZEE52xYl2CMAypaZUzDLsULqqfeyGLr3yy9vppA5MdWul
         g9WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089569; x=1790694369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
        b=nAQ1PQXNVOaQcxIphZX0BNj62ywHZd45gb0VZsmewE7fnZDHe0c7j5JooKz2daglwN
         Dlu1dsh4Gwhxz8p0PtVFMutXky/fa0SfdoKcSS6E+Lo2n5Qhs3Yp8v6WnTL9UPDcJg7j
         j6zH/TjEbLv/r6HgjbfX5C2dzRStxuwlpwy212Tt/hItGU/etkYiYl4nGcX3ZKANbeba
         1V38neoTjFdGgsluyy4CdjTBuZqtD66zILS6YfvyXMe1gG4F0z8rvNczxIJMoZyk1HjD
         YJfacSuLZe8SqWgNZAOzWt6WidloFxUS/7kQJds90QMCPPOJBWy8OrLe3TEsh3wjzOiS
         ZHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089569; x=1790694369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UkF8/vdFwFhIlxbTxtZ4OfBy/J+EAcxCqWudSjYRllg=;
        b=dvcoBtQOGAxb8y5EcU8wiEVWo6Qlvlg0O07Wg5oSdgCRjKyXHdjWmbAQs2kLg75WJp
         Ud4UNn11Dt2NVSnr/js/BrXuCFcklbZ1LVwguV5aG6RjrlX3Ot+UH9x0Uyffq3f8Q6Bp
         2SspTE+3JzfeexLdN/vsMJcH1GBsO8jsQWmb59ed2nfPkPAU050ZtRmpwgdpUa3JcibW
         yfubL+eSRXWFKs20krn8+uj0KnZeTV7ftjdUDJSB6fpy9vD5j2YReDFY+Ch+3TgvGCtW
         biESqxa/5LLIFl1XwA2HFGRrRkgpczGBjrwV7DjpdSkqe7wpaWaJe9nAiY/1t8MvcddH
         icDA==
X-Forwarded-Encrypted: i=1; AKwUvBwj0rMrA9h8ofar/7cU3XLIstI8dO98M5jK4gheFEjPgj87R5SzBpl+5Hxch6o/AaCi+AtPFzDgcg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kb2OaKdqjzEej8rqD8UbJY1KKWYU832t8CgN4kmI1foZsPqzuM
	lnsG0JYggbnSe5UUEdg858YZpyY+HekGhpJqPNH77wFwTsmn8jcf5hgnRpj4CXNFkibkz3ZoeSh
	ScfalQrO5qCTxAQ+BMRJdGPY/cLUxezY=
X-Gm-Gg: AYBFou1MUTXatuJMcddSsMnC0hMeltkzitmt7ebfzF6OJxv9vLzgHfVlCRQIySoXUU5
	lRCenrl0X2xWqYigbSPozxrHjIhquJotXUKzSHi6L0WEr/JlvkHYaf1eJepg0PAZSB7cT9vLfrI
	MWvP93Re83VhOOQWb6CcxPkyQvQJHW91noWf4KUYYDVWp75dLu2WoJ1OG8V1LONMDVFHHqTfP/G
	nhNSb96iQiniLfs4TR44nT0RdisXMMEsFQRzBTqBJ4H2GQfgtQRZ1OTIWIfUrfBThD6dAeWtl8X
	k4JH8Z6d+oAtmLiNiHUhBgD57MkdwrRjUwGNHL9wW8pRJvkXkRBv+0q+HItrCqPDKNI4pQpVG4C
	RqgAuscWTpD69ypnXnfW/VHXHD/DEOJjyVO5UbW27KA==
X-Received: by 2002:a05:6830:710b:b0:805:24d6:cb5 with SMTP id
 46e09a7af769-80e1e2cd412mr15435182a34.3.1790089567093; Tue, 22 Sep 2026
 08:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com>
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2026 11:05:54 -0400
X-Gm-Features: AcwNN1WCc1J-PDBCZhZYxVxsotQxDDlpubu-GLAK738d9Deq071zD5m-4kdMkkM
Message-ID: <CADnq5_NL3OtNOGGP2Cmhx0F7fe0coqQVR-md8mXZuxuX+FyKhg@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Dave Airlie <airlied@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:18=E2=80=AFAM Dave Airlie <airlied@gmail.com> wro=
te:
>
> From: Dave Airlie <airlied@redhat.com>
>
> This changes the vgaarb client API so that the user can pass a
> private data pointer into the register that will get used in
> the decode callback.
>
> This allows a bunch of pdev conversions in the drivers, and lets
> some future vfio cleanups be nicer.
>
> I'd like to merge this via the drm next tree but also fine with
> it going via pci.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: fix loongson (spotted by sashiko)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
>  drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
>  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
>  drivers/pci/vgaarb.c                       | 13 +++++++++----
>  drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
>  include/linux/vgaarb.h                     |  8 +++++---
>  8 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 62b5b4a23f17..1344b2b1bd16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1435,10 +1435,10 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_=
device *adev)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
> +static unsigned int amdgpu_device_vga_set_decode(void *data,
>                 bool state)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(pci_get_drvdata(pdev))=
;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
>
>         amdgpu_asic_set_vga_state(adev, state);
>         if (state)
> @@ -4208,7 +4208,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          * ignore it
>          */
>         if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> -               vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode);
> +               vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode, adev);
>
>         px =3D amdgpu_device_supports_px(adev);
>
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i=
915/display/intel_vga.c
> index 4966fd7eea92..0889edb36190 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -283,9 +283,10 @@ void intel_vga_disable(struct intel_display *display=
)
>         intel_de_posting_read(display, vga_reg);
>  }
>
> -static unsigned int intel_vga_set_decode(struct pci_dev *pdev, bool enab=
le_decode)
> +static unsigned int intel_vga_set_decode(void *data, bool enable_decode)
>  {
> -       struct intel_display *display =3D to_intel_display(pdev);
> +       struct intel_display *display =3D (struct intel_display *)data;
> +       struct pci_dev *pdev =3D to_pci_dev(display->drm->dev);
>         unsigned int decodes =3D VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM=
;
>
>         drm_dbg_kms(display->drm, "%s VGA decode due to VGA arbitration\n=
",
> @@ -331,7 +332,7 @@ void intel_vga_register(struct intel_display *display=
)
>          * then we do not take part in VGA arbitration and the
>          * vga_client_register() fails with -ENODEV.
>          */
> -       ret =3D vga_client_register(pdev, intel_vga_set_decode);
> +       ret =3D vga_client_register(pdev, intel_vga_set_decode, display);
>         drm_WARN_ON(display->drm, ret && ret !=3D -ENODEV);
>  }
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 3fd828d23271..5a13df31eb90 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -254,7 +254,7 @@ lsdc_create_device(struct pci_dev *pdev,
>
>  /* For multiple GPU driver instance co-exixt in the system */
>
> -static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state=
)
> +static unsigned int lsdc_vga_set_decode(void *data, bool state)
>  {
>         return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  }
> @@ -291,7 +291,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
>         pci_set_drvdata(pdev, ddev);
>
> -       vga_client_register(pdev, lsdc_vga_set_decode);
> +       vga_client_register(pdev, lsdc_vga_set_decode, NULL);
>
>         drmm_kms_helper_poll_init(ddev);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouv=
eau/nouveau_vga.c
> index 29a801124e56..6662e30466f2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -9,9 +9,9 @@
>  #include "nouveau_vga.h"
>
>  static unsigned int
> -nouveau_vga_set_decode(struct pci_dev *pdev, bool state)
> +nouveau_vga_set_decode(void *data, bool state)
>  {
> -       struct nouveau_drm *drm =3D pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm =3D (struct nouveau_drm *)data;
>         struct nvif_object *device =3D &drm->client.device.object;
>
>         if (drm->client.device.info.family =3D=3D NV_DEVICE_INFO_V0_CURIE=
 &&
> @@ -103,7 +103,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
>                 return;
>         pdev =3D to_pci_dev(dev->dev);
>
> -       vga_client_register(pdev, nouveau_vga_set_decode);
> +       vga_client_register(pdev, nouveau_vga_set_decode, drm);
>
>         /* don't register Thunderbolt eGPU with vga_switcheroo */
>         if (pci_is_thunderbolt_attached(pdev))
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 9523240110a6..cf8a6bd00c77 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1076,10 +1076,9 @@ void radeon_combios_fini(struct radeon_device *rde=
v)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool sta=
te)
> +static unsigned int radeon_vga_set_decode(void *data, bool state)
>  {
> -       struct drm_device *dev =3D pci_get_drvdata(pdev);
> -       struct radeon_device *rdev =3D dev->dev_private;
> +       struct radeon_device *rdev =3D (struct radeon_device *)data;
>         radeon_vga_set_state(rdev, state);
>         if (state)
>                 return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1431,7 +1430,7 @@ int radeon_device_init(struct radeon_device *rdev,
>         /* if we have > 1 VGA cards, then disable the radeon VGA resource=
s */
>         /* this will fail for cards that aren't VGA class devices, just
>          * ignore it */
> -       vga_client_register(rdev->pdev, radeon_vga_set_decode);
> +       vga_client_register(rdev->pdev, radeon_vga_set_decode, rdev);
>
>         if (rdev->flags & RADEON_IS_PX)
>                 runtime =3D true;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee7859..3e58b2c05c85 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -51,7 +51,8 @@ struct vga_device {
>         unsigned int mem_norm_cnt;      /* normal MEM count */
>         bool bridge_has_one_vga;
>         bool is_firmware_default;       /* device selected by firmware */
> -       unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> +       unsigned int (*set_decode)(void *data, bool decode);
> +       void *set_decode_data;
>  };
>
>  static LIST_HEAD(vga_list);
> @@ -935,6 +936,7 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>   * vga_client_register - register or unregister a VGA arbitration client
>   * @pdev: PCI device of the VGA client
>   * @set_decode: VGA decode change callback
> + * @data: private data to pass to callback
>   *
>   * Clients have two callback mechanisms they can use.
>   *
> @@ -956,15 +958,18 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>   * Returns: 0 on success, -ENODEV on failure
>   */
>  int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool dec=
ode))
> +               unsigned int (*set_decode)(void *data, bool decode),
> +               void *data)
>  {
>         unsigned long flags;
>         struct vga_device *vgadev;
>
>         spin_lock_irqsave(&vga_lock, flags);
>         vgadev =3D vgadev_find(pdev);
> -       if (vgadev)
> +       if (vgadev) {
>                 vgadev->set_decode =3D set_decode;
> +               vgadev->set_decode_data =3D data;
> +       }
>         spin_unlock_irqrestore(&vga_lock, flags);
>         if (!vgadev)
>                 return -ENODEV;
> @@ -1464,7 +1469,7 @@ static void vga_arbiter_notify_clients(void)
>         spin_lock_irqsave(&vga_lock, flags);
>         list_for_each_entry(vgadev, &vga_list, list) {
>                 if (vgadev->set_decode) {
> -                       new_decodes =3D vgadev->set_decode(vgadev->pdev,
> +                       new_decodes =3D vgadev->set_decode(vgadev->set_de=
code_data,
>                                                          new_state);
>                         vga_update_device_decodes(vgadev, new_decodes);
>                 }
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 6757054e9d87..b04ce3ded08c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -162,9 +162,10 @@ static inline void vfio_pci_core_debugfs_init(struct=
 vfio_pci_core_device *vdev)
>   * has no way to get to it and routing can be disabled externally at the
>   * bridge.
>   */
> -static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool singl=
e_vga)
> +static unsigned int vfio_pci_set_decode(void *data, bool single_vga)
>  {
> -       struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev)=
;
> +       struct vfio_pci_core_device *vdev =3D data;
> +       struct pci_dev *pdev =3D vdev->pdev;
>         struct pci_dev *tmp =3D NULL;
>         unsigned char max_busnr;
>         unsigned int decodes;
> @@ -2159,10 +2160,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core=
_device *vdev)
>         if (ret)
>                 return ret;
>
> -       ret =3D vga_client_register(pdev, vfio_pci_set_decode);
> +       ret =3D vga_client_register(pdev, vfio_pci_set_decode, vdev);
>         if (ret)
>                 return ret;
> -       vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
> +       vga_set_legacy_decoding(pdev, vfio_pci_set_decode(vdev, false));
>         return 0;
>  }
>
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7d..71a364669eaf 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
>  void vga_set_default_device(struct pci_dev *pdev);
>  int vga_remove_vgacon(struct pci_dev *pdev);
>  int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool sta=
te));
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data);
>  #else /* CONFIG_VGA_ARB */
>  static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>                 unsigned int decodes)
> @@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pde=
v)
>         return 0;
>  }
>  static inline int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool sta=
te))
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data)
>  {
>         return 0;
>  }
> @@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_de=
v *pdev,
>
>  static inline void vga_client_unregister(struct pci_dev *pdev)
>  {
> -       vga_client_register(pdev, NULL);
> +       vga_client_register(pdev, NULL, NULL);
>  }
>
>  #endif /* LINUX_VGA_H */
> --
> 2.54.0
>
