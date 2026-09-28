Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D236B91D;
	Mon, 28 Sep 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625636; cv=none; b=U0WTPN6VAZI+v1Z1aUpab8qYwGMD/VQlyzX2fThCE89az9ztH8LEse0/Dgj4IrBTlsAQ9kHi86lq8GAZun2tgcUAHzZVmhQeLttry8Vjhw4o4DrnijQmqWorv9ofS1W0VYQcBWvtTDfids0mwpynSFieKHxnDdErdfVkhRziwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625636; c=relaxed/simple;
	bh=ViAD/E+mnm7ngGc3SKqvxSiu/sT4mDNDzUCp1fg6gB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBYqrZpZhW7Ye6n2iLSul1nyr5Cvz/XzOxxf1p8tXYxBco4l0QS2zZ7SrSDRg9zGDGOqrMnQJhXbF2N8+b4hMikIQtgDPBF+2wINwSt3L0SiArHgPGCavZaBgHMo3DIGgHUdWMZkbawB0VJabfd4Ug1VpyCoNW05s743OVFNCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Mdj/lZn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5cRui9+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Mdj/lZn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5cRui9+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D5EB7A0158;
	Mon, 28 Sep 2026 16:00:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790625631;
	 x=1790712031; bh=52qrLPR1v+W4l+TnU+fJ0kLC3sIi6bZoNbc7A0mB5k8=; b=
	Mdj/lZn/RyLGjc4gLQ1xLNMiG/BhCTLnVtt5uMVtguSWFi8GwNl3/aVAMsdRYiib
	cMyToNdxFKVSag91m21/M8YqKrruv+zaTg7GtMcUWdHqNTeMIDK7neGFLTVwZshY
	KJlWNBaYZZjBv8l57ZwGzsVbCMJKbIBCFFonC5gH9mrIW6y1U9KeT8dcE4U3vDwz
	d3BMbg5ub1Q3Fylp+InDiRIRNRrJmdWa1p7AzdFSYegwWSVVqUjFABufMI6Ve96I
	pIo69XvkbS3i3V8oj1wXnGDfMXBwGS3hwYjXhhPDr2HbVWzouLTZi2mahw6avsbx
	FgeSLS7JGXzaUFdXtD7pmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790625631; x=
	1790712031; bh=52qrLPR1v+W4l+TnU+fJ0kLC3sIi6bZoNbc7A0mB5k8=; b=q
	5cRui9+gcFd3rx5weUWRKbMYg5LNcdk0jsAQGfIbDapdR3Ft90kzIy5pPLp4cKoX
	FW0dqWKka7ETYbuC297Zt4MmDT04sxSmlQydcAzs8VE5MMEnqphb8lmh2OPGwh0y
	VZceF/J8AdLmOZ2kgJpFosuHAJcz38fbDwX8tG6pkrNpfm6YlY2KV2TcVx3o6X+Z
	EkZVGt2m1+KL9gfSdkESJeoiUh2sZ8QJbu/V32WnxzRASw+7rPwlhyT12BGfRRfF
	tBOOUNn7XAwxqtCZ8z8NsN0VWlwz2pBBzvVftsr8NZNxE9YTserYoVi1sISeOBIC
	AXr0wOHfSFVDyVrW26Kpg==
X-ME-Sender: <xms:Xse6apUzTjKZlX9VeEV19Z9SV8rwJuknc2AaQfSKW7gYIBYT7n2VyA>
    <xme:Xse6alen5GcblXgS8G6BqdUcMmtHVFALf2KIqQGnZpmSk2dsb8L7ZmQW-lJZfIyiN
    jGSLVbO5BS08XdJ9b7VrCdzevclHBcwIWpls15sBm09rpNExRKd8A>
X-ME-Received: <xmr:Xse6aiaFsjDaCYl6XspN7rKFBbodZbVeTSFYRmtLuFTMWbO2hKFgHTIg3uiL0A>
X-ME-Proxy-Cause: dmFkZTECBFw91l/dFqrj5NtUh1dVLoOTyFAkyh+RW9igPujPTw7luImqD8CHmA9J/p9tvg
    Fy2DoOS45Bc0KMuvi8543bwnjVV3dm8ovNMk3VFVkq25K5cEeTWYi39MH45zSjplCYLyvP
    lt10iQPZeGaOp/EtTxrKXcQW76A+pVVYViSIZEhhuoJzXlMlLXwXKdRPL2Yn81uiVkEQvf
    84E4UiFBGHgYHYC06PjW8dU+GmkGAt4dh5KhbJp5I7o64KD8zzWnmOrWL4Q+X5kbYblwXO
    t7ns4abOD7vddsz3UBh4tGctiqrtZEvBf2qR+IIPZHqbQIPtnC3P4K5OCx3Oi1xr24IOZM
    sl3DTKHXo4UVUM/zTeeNq9yiCZkA3eiIAkv4pO0YbVzJwojtSRj26BiL4yzKeAAiACNMy+
    5CkrLhQ8ISokoFSVtU5SpL/sy49SmnEttecus29Twb8DRdTRlYfBa+rjPcnAud8T8WiZ2V
    QzaSBYL33luf9gkeYjCJ3FqDjLrF/EY+f/glRWoyYCBJgAjrokDKV4lqFbitvww/M9ydN8
    E5ruvLQRFbLRE1QWaSDVNEocyauytvEKQB+2JidbTgLHJAwG+zdUVd1Kei64XMig2YJyf6
    8H3/aZvCe7Bvaxll+NYu6vjXuTJfqpZWZPdaohPFTokRJFN8NfE3EsqKAh3w
X-ME-Proxy: <xmx:Xse6ahNA3I98yTfDvmQdapU_n39-8DE-wQKt6nabEYX7u2_QIKAH1w>
    <xmx:X8e6aoWTLXacfvE88DLe7Lqy-aAKfXjyllHOw3GIalGhWoh5LXEgKg>
    <xmx:X8e6auKKO8tAOSmalghpiVbFvM9bGgF1imovMCp4-Os9PR4TGK97Wg>
    <xmx:X8e6arrEA1JZMnoEJxUnZSqpo-4k4splpkB8Ug-ECiMHizSj3Hkx0w>
    <xmx:X8e6aprxtamkThElgZ3zaQOPU64ZMjCalBW0hwhmTpIc_zW7XDDfKFOd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 16:00:29 -0400 (EDT)
Date: Mon, 28 Sep 2026 14:00:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Dave Airlie
 <airlied@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>,
 alex@shazbot.org, "Simon Song (SW-GPU)" <xinmengs@nvidia.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback (v2)
Message-ID: <20260928140028.02900e68@shazbot.org>
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
References: <20260922071807.2533884-1-airlied@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:18:07 +1000
Dave Airlie <airlied@gmail.com> wrote:

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


Acked-by: Alex Williamson <alex@shazbot.org>

Preemptively, could this get merged via a topic branch that we could
share in case further drvdata cleanup arrives in vfio-pci this cycle?

I'm imagining this might also be a good time to push vgaarb
registration out of vfio-pci-core as well.  Thanks,

Alex

 
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
>  		bool state)
>  {
> -	struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>  
>  	amdgpu_asic_set_vga_state(adev, state);
>  	if (state)
> @@ -4208,7 +4208,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	 * ignore it
>  	 */
>  	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> -		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> +		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode, adev);
>  
>  	px = amdgpu_device_supports_px(adev);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
> index 4966fd7eea92..0889edb36190 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -283,9 +283,10 @@ void intel_vga_disable(struct intel_display *display)
>  	intel_de_posting_read(display, vga_reg);
>  }
>  
> -static unsigned int intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
> +static unsigned int intel_vga_set_decode(void *data, bool enable_decode)
>  {
> -	struct intel_display *display = to_intel_display(pdev);
> +	struct intel_display *display = (struct intel_display *)data;
> +	struct pci_dev *pdev = to_pci_dev(display->drm->dev);
>  	unsigned int decodes = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  
>  	drm_dbg_kms(display->drm, "%s VGA decode due to VGA arbitration\n",
> @@ -331,7 +332,7 @@ void intel_vga_register(struct intel_display *display)
>  	 * then we do not take part in VGA arbitration and the
>  	 * vga_client_register() fails with -ENODEV.
>  	 */
> -	ret = vga_client_register(pdev, intel_vga_set_decode);
> +	ret = vga_client_register(pdev, intel_vga_set_decode, display);
>  	drm_WARN_ON(display->drm, ret && ret != -ENODEV);
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
>  	return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>  }
> @@ -291,7 +291,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pci_set_drvdata(pdev, ddev);
>  
> -	vga_client_register(pdev, lsdc_vga_set_decode);
> +	vga_client_register(pdev, lsdc_vga_set_decode, NULL);
>  
>  	drmm_kms_helper_poll_init(ddev);
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
> -	struct nouveau_drm *drm = pci_get_drvdata(pdev);
> +	struct nouveau_drm *drm = (struct nouveau_drm *)data;
>  	struct nvif_object *device = &drm->client.device.object;
>  
>  	if (drm->client.device.info.family == NV_DEVICE_INFO_V0_CURIE &&
> @@ -103,7 +103,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
>  		return;
>  	pdev = to_pci_dev(dev->dev);
>  
> -	vga_client_register(pdev, nouveau_vga_set_decode);
> +	vga_client_register(pdev, nouveau_vga_set_decode, drm);
>  
>  	/* don't register Thunderbolt eGPU with vga_switcheroo */
>  	if (pci_is_thunderbolt_attached(pdev))
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
> -	struct drm_device *dev = pci_get_drvdata(pdev);
> -	struct radeon_device *rdev = dev->dev_private;
> +	struct radeon_device *rdev = (struct radeon_device *)data;
>  	radeon_vga_set_state(rdev, state);
>  	if (state)
>  		return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1431,7 +1430,7 @@ int radeon_device_init(struct radeon_device *rdev,
>  	/* if we have > 1 VGA cards, then disable the radeon VGA resources */
>  	/* this will fail for cards that aren't VGA class devices, just
>  	 * ignore it */
> -	vga_client_register(rdev->pdev, radeon_vga_set_decode);
> +	vga_client_register(rdev->pdev, radeon_vga_set_decode, rdev);
>  
>  	if (rdev->flags & RADEON_IS_PX)
>  		runtime = true;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee7859..3e58b2c05c85 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -51,7 +51,8 @@ struct vga_device {
>  	unsigned int mem_norm_cnt;	/* normal MEM count */
>  	bool bridge_has_one_vga;
>  	bool is_firmware_default;	/* device selected by firmware */
> -	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> +	unsigned int (*set_decode)(void *data, bool decode);
> +	void *set_decode_data;
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
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
> +		unsigned int (*set_decode)(void *data, bool decode),
> +		void *data)
>  {
>  	unsigned long flags;
>  	struct vga_device *vgadev;
>  
>  	spin_lock_irqsave(&vga_lock, flags);
>  	vgadev = vgadev_find(pdev);
> -	if (vgadev)
> +	if (vgadev) {
>  		vgadev->set_decode = set_decode;
> +		vgadev->set_decode_data = data;
> +	}
>  	spin_unlock_irqrestore(&vga_lock, flags);
>  	if (!vgadev)
>  		return -ENODEV;
> @@ -1464,7 +1469,7 @@ static void vga_arbiter_notify_clients(void)
>  	spin_lock_irqsave(&vga_lock, flags);
>  	list_for_each_entry(vgadev, &vga_list, list) {
>  		if (vgadev->set_decode) {
> -			new_decodes = vgadev->set_decode(vgadev->pdev,
> +			new_decodes = vgadev->set_decode(vgadev->set_decode_data,
>  							 new_state);
>  			vga_update_device_decodes(vgadev, new_decodes);
>  		}
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
> -	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +	struct vfio_pci_core_device *vdev = data;
> +	struct pci_dev *pdev = vdev->pdev;
>  	struct pci_dev *tmp = NULL;
>  	unsigned char max_busnr;
>  	unsigned int decodes;
> @@ -2159,10 +2160,10 @@ static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = vga_client_register(pdev, vfio_pci_set_decode);
> +	ret = vga_client_register(pdev, vfio_pci_set_decode, vdev);
>  	if (ret)
>  		return ret;
> -	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
> +	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(vdev, false));
>  	return 0;
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
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
> +		unsigned int (*set_decode)(void *data, bool state),
> +		void *data);
>  #else /* CONFIG_VGA_ARB */
>  static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>  		unsigned int decodes)
> @@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pdev)
>  	return 0;
>  }
>  static inline int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state))
> +		unsigned int (*set_decode)(void *data, bool state),
> +		void *data)
>  {
>  	return 0;
>  }
> @@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
>  
>  static inline void vga_client_unregister(struct pci_dev *pdev)
>  {
> -	vga_client_register(pdev, NULL);
> +	vga_client_register(pdev, NULL, NULL);
>  }
>  
>  #endif /* LINUX_VGA_H */

