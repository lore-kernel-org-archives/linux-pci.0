Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113A511213
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624037; cv=pass; b=eXXGYMPA/yy8a7VkUNQS04CUzrATCQl8qpwhYaoWsBCs2iZuemzXHXij6pvddX/UH+O61jsHGkWwyJ5Sr8XaKu9YS5YqVhAsqplcHBRwIlY6rEsz/EqHE3zLg6d3M8ifBP5Ev9s/suKiM5iZvH5xp4nMVqtPDWE3VgfF83xXd4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624037; c=relaxed/simple;
	bh=49UVDPsfhpCuIHZ3UG5p9FtrrAcGEKNJjsJt45MZKOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDLfeugKFOHhdDH4mZr0JgRNu8AmiO40aYpXr6R2Nn1reDpsQ2SSw4fPK0FxYaReTERTHkbGMqwXO2pWdq0Lq4seKTn4yhjZTPq/o2s1ZDJmXBP4ZExt+wgfHlGv2ZFDVk3Z/APfJzecc0pbf2BmsLnxYOgs74ogEE66RN2d6cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJAc4DMW; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJAc4DMW"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c64c01c86so118183785a.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 12:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790624034; cv=none;
        d=google.com; s=arc-20260327;
        b=aMu1+Tc+8RJwN2LOj5kSggzoPrTip4FWfoYi6tVuKbfUPcSd12sXbfoP5OoXZu7aNq
         5AMHCb2aHxk/OiLaW834RoGDnbI3cbzhXUzeHNuR+V0bzhbMTzp56l0a9lSi0N7nlQPr
         i0Dq78e2DW+8IYdl5tgVnFI8zo7jPxVNNToGOp6OUYB/qpFeTf5bDkrt2rkaI0iAH361
         x4WxinFiJAWsNCpukc9kaCEYqXolhTJ8BKA+sTlpo72CXPSNNNbGhElergVaPuriYOtr
         PU3GD7nFGJJOGjKe1Mzt2Z02awKEN+DLBy4MOk44MYHRNmPsaaZUc687sVCDyf7HUHiY
         7JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IuIiIDvTF28b5jDv9opUgdHcN4uGqk2vytTOQavm6Es=;
        fh=s32eNJDkPGh1AdJU3qqJgG6mrCqMB2Av0pMjoC2bDkw=;
        b=kPhnBjbN1iS0PRwHZ3Hd6cgAMYF+kNciZjwrwSwif6xwc1pS9SDm6ZFPJJkEaEwvAD
         1Udae7Slbd77LNwTzFkvFNBQvLOXEOCBoxBQ3SfjKkfjYl2kM+Ux49DK1HS3y3Jyt/vX
         BuLkABV1HSU3NUbaFk9eMC91OV/ajck1aHdWl+gbHbGwZS18o4TlLbl/yn11zCLguhuU
         76znfaEAlNl3Jv1IcqlYbj/sR8NvAQiIm7FKEuaj5hb9bW2o44Mzaab3oW5SHpig0jV9
         J2xmj2/XYkMKVvj0juWRX8S06gB3mCDJPaf3EKRRxa04wTBOubOA1JKoSfyJJi+OGb80
         lk/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790624034; x=1791228834; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IuIiIDvTF28b5jDv9opUgdHcN4uGqk2vytTOQavm6Es=;
        b=eJAc4DMWrTLj4jGg9+/d/GqfzVzt16XTP9DDcsim6KcQZ/3fv25podszFOlSJhYo4b
         acFVpqmp1zMlvFpDNqrVhkSF9Ejq6HDl3VbfMprUaTJjTH+P643ggWtDmUxZpC5e1d25
         yT72XRPfYzeLFAGcwl5D5Zjc4GbT9mop5yNYp4BktnZNENUFRdCH55vM9W2tNuSB9f2+
         Sjc+WO3kP86eKEdk8SG7/UPtnQ9dGBKVQdx3s701t3J8RMtSJ657a8aqZC3zRis/qC0u
         UH6c6UntTsju8r7stOdq5uoIdI84U/No4JrR7UwZ58LdcCqyZV+/U6f/LPR5rPR4Bogt
         tFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624034; x=1791228834;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IuIiIDvTF28b5jDv9opUgdHcN4uGqk2vytTOQavm6Es=;
        b=1ZqGZnojNHMbV+A50pYsEajm6+qb4J8t03woFX3Xo5Wt4bOKXCxqizHjY1ouzOq4ji
         4IUBc6kGC2gIGo3o32qMutqOjjJJ6+bK8F6Nk8NqelYBvBF0l9Og2mSwtHjkePz0uJ3M
         zqTrQSgrC31cEP9aFIqDMJv5vI+t6fUOXgfoq4YbT18asFIkaEdBTgLJRQvr7nbttGTa
         fSrj5H0lyRf31V2njNp5DEcV1/nKPe2veBQT3ZjVLWESj7YPTf4C3FJkwOxqWRLX+A9t
         ewGaLXNb5tctGJ1mUAmBTv8kEQ5Il+NshUs6O/hZKqTKmTIKQABYaSeJ8Va5dqX5mRve
         06ng==
X-Forwarded-Encrypted: i=1; AKwUvBwF/Pp6g09qmmhIEAeo9IfkF9JJL/V5y2+SWmFz3hCSZK6ZCUFB0cWdeXmWmGfKjeHeYLSOx+IFDmM=@vger.kernel.org
X-Gm-Message-State: AFuF++m3sZgQezpxVC8B+aew1t5AdFVtoUmjG2MqPLDTkwkbyUTbKGWh
	5EheyI14h//uGc8/3Lsy6PbMZVEumB2cHY/CDK53sVqznqWn/O14x9VF7dDCzIx9WYMqCx9C3WS
	nm1y/quNXkrSKoFGKbfkkmLEZx316UHo=
X-Gm-Gg: AYBFou0bwE28Uiaeqh1abFTpLpcm8Y/1YC9Hu2op/qiyutFa6XkrpPetT1v15OnzqoC
	KxcFvEBuAAYaNeoAbjibhJM0VBN9lhl8xbOI12TH4mgCZUgxFBroCX1QfACDpb14GpW85AVUzYt
	vXQLVs0WAQbhKTKqQCKkFFDwcD3SHuqJRYtIczWkVUqlmr7C97mKYmOhR5NRBfWPZia+HQ9iOsu
	v/aaGDyq94SgMZ01ItgzKf04avgzfesmXQvf4CAnULIZRqM7oF66ZFr90/sG0oOx3s90zhp6wAi
	lAX/G+915DjegvVix78wL7fZqHHpIJp6rx06qjUOrOahCCUmkRCgQW6mEjxHUbOUSCyUqtQP1WY
	M/EhtuhcfiP1FwNs7n8zIeB5GAsASTk95dIO2SOG/
X-Received: by 2002:a05:620a:4686:b0:93b:d7a2:dd2c with SMTP id
 af79cd13be357-93c43d3468dmr2068881185a.60.1790624034002; Mon, 28 Sep 2026
 12:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com>
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 29 Sep 2026 05:33:41 +1000
X-Gm-Features: AclHuK-sQSLvzYjEjXWXH3RxSWPaJTQOvV3BfLQe4gXQZEzn2tL4fGGuHRa1r-A
Message-ID: <CAPM=9tx6A=hT8VS2s4KfxkDsTi3wBwmRQP6Cmqz6ng--uFnDog@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Dave Airlie <airlied@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"

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
> ---
> v2: fix loongson (spotted by sashiko)

@Alex Williamson or @Jason Gunthorpe can I get an ack on the vfio
piece, since I think the initial report on this problem came from
Jason.

Dave.

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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62b5b4a23f17..1344b2b1bd16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1435,10 +1435,10 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
> +static unsigned int amdgpu_device_vga_set_decode(void *data,
>                 bool state)
>  {
> -       struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
> +       struct amdgpu_device *adev = (struct amdgpu_device *)data;
>
>         amdgpu_asic_set_vga_state(adev, state);
>         if (state)
> @@ -4208,7 +4208,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          * ignore it
>          */
>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> -               vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> +               vga_client_register(adev->pdev, amdgpu_device_vga_set_decode, adev);
>
>         px = amdgpu_device_supports_px(adev);
>
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
> index 4966fd7eea92..0889edb36190 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -283,9 +283,10 @@ void intel_vga_disable(struct intel_display *display)
>         intel_de_posting_read(display, vga_reg);
>  }
>
> -static unsigned int intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
> +static unsigned int intel_vga_set_decode(void *data, bool enable_decode)
>  {
> -       struct intel_display *display = to_intel_display(pdev);
> +       struct intel_display *display = (struct intel_display *)data;
> +       struct pci_dev *pdev = to_pci_dev(display->drm->dev);
>         unsigned int decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>
>         drm_dbg_kms(display->drm, "%s VGA decode due to VGA arbitration\n",
> @@ -331,7 +332,7 @@ void intel_vga_register(struct intel_display *display)
>          * then we do not take part in VGA arbitration and the
>          * vga_client_register() fails with -ENODEV.
>          */
> -       ret = vga_client_register(pdev, intel_vga_set_decode);
> +       ret = vga_client_register(pdev, intel_vga_set_decode, display);
>         drm_WARN_ON(display->drm, ret && ret != -ENODEV);
>  }
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
> index 3fd828d23271..5a13df31eb90 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -254,7 +254,7 @@ lsdc_create_device(struct pci_dev *pdev,
>
>  /* For multiple GPU driver instance co-exixt in the system */
>
> -static unsigned int lsdc_vga_set_decode(struct pci_dev *pdev, bool state)
> +static unsigned int lsdc_vga_set_decode(void *data, bool state)
>  {
>         return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  }
> @@ -291,7 +291,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>         pci_set_drvdata(pdev, ddev);
>
> -       vga_client_register(pdev, lsdc_vga_set_decode);
> +       vga_client_register(pdev, lsdc_vga_set_decode, NULL);
>
>         drmm_kms_helper_poll_init(ddev);
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
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
> -       struct nouveau_drm *drm = pci_get_drvdata(pdev);
> +       struct nouveau_drm *drm = (struct nouveau_drm *)data;
>         struct nvif_object *device = &drm->client.device.object;
>
>         if (drm->client.device.info.family == NV_DEVICE_INFO_V0_CURIE &&
> @@ -103,7 +103,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
>                 return;
>         pdev = to_pci_dev(dev->dev);
>
> -       vga_client_register(pdev, nouveau_vga_set_decode);
> +       vga_client_register(pdev, nouveau_vga_set_decode, drm);
>
>         /* don't register Thunderbolt eGPU with vga_switcheroo */
>         if (pci_is_thunderbolt_attached(pdev))
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 9523240110a6..cf8a6bd00c77 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1076,10 +1076,9 @@ void radeon_combios_fini(struct radeon_device *rdev)
>   * Enable/disable vga decode (all asics).
>   * Returns VGA resource flags.
>   */
> -static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool state)
> +static unsigned int radeon_vga_set_decode(void *data, bool state)
>  {
> -       struct drm_device *dev = pci_get_drvdata(pdev);
> -       struct radeon_device *rdev = dev->dev_private;
> +       struct radeon_device *rdev = (struct radeon_device *)data;
>         radeon_vga_set_state(rdev, state);
>         if (state)
>                 return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1431,7 +1430,7 @@ int radeon_device_init(struct radeon_device *rdev,
>         /* if we have > 1 VGA cards, then disable the radeon VGA resources */
>         /* this will fail for cards that aren't VGA class devices, just
>          * ignore it */
> -       vga_client_register(rdev->pdev, radeon_vga_set_decode);
> +       vga_client_register(rdev->pdev, radeon_vga_set_decode, rdev);
>
>         if (rdev->flags & RADEON_IS_PX)
>                 runtime = true;
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
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
> +               unsigned int (*set_decode)(void *data, bool decode),
> +               void *data)
>  {
>         unsigned long flags;
>         struct vga_device *vgadev;
>
>         spin_lock_irqsave(&vga_lock, flags);
>         vgadev = vgadev_find(pdev);
> -       if (vgadev)
> +       if (vgadev) {
>                 vgadev->set_decode = set_decode;
> +               vgadev->set_decode_data = data;
> +       }
>         spin_unlock_irqrestore(&vga_lock, flags);
>         if (!vgadev)
>                 return -ENODEV;
> @@ -1464,7 +1469,7 @@ static void vga_arbiter_notify_clients(void)
>         spin_lock_irqsave(&vga_lock, flags);
>         list_for_each_entry(vgadev, &vga_list, list) {
>                 if (vgadev->set_decode) {
> -                       new_decodes = vgadev->set_decode(vgadev->pdev,
> +                       new_decodes = vgadev->set_decode(vgadev->set_decode_data,
>                                                          new_state);
>                         vga_update_device_decodes(vgadev, new_decodes);
>                 }
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6757054e9d87..b04ce3ded08c 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -162,9 +162,10 @@ static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
>   * has no way to get to it and routing can be disabled externally at the
>   * bridge.
>   */
> -static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
> +static unsigned int vfio_pci_set_decode(void *data, bool single_vga)
>  {
> -       struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +       struct vfio_pci_core_device *vdev = data;
> +       struct pci_dev *pdev = vdev->pdev;
>         struct pci_dev *tmp = NULL;
>         unsigned char max_busnr;
>         unsigned int decodes;
> @@ -2159,10 +2160,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
>         if (ret)
>                 return ret;
>
> -       ret = vga_client_register(pdev, vfio_pci_set_decode);
> +       ret = vga_client_register(pdev, vfio_pci_set_decode, vdev);
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
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data);
>  #else /* CONFIG_VGA_ARB */
>  static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>                 unsigned int decodes)
> @@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pdev)
>         return 0;
>  }
>  static inline int vga_client_register(struct pci_dev *pdev,
> -               unsigned int (*set_decode)(struct pci_dev *pdev, bool state))
> +               unsigned int (*set_decode)(void *data, bool state),
> +               void *data)
>  {
>         return 0;
>  }
> @@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
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
