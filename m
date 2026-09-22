Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBD531634;
	Tue, 22 Sep 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066674; cv=none; b=QCpyDL2vlsp5Oq8bMIpOtUCgjYAWySwe2z/ZHrilNNIVoDAtWLac3ItvuLcHTjoKdtCr9HHgldv2a5GD7UqAl9TZzsrlF6SmUyE6bd+AB+vox3lrcdf+Z50agAhjC7YRCoa0CG1AjiRpxw85jTilAh6tOJNzqcamqdIOofI2348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066674; c=relaxed/simple;
	bh=6sAwjJocnWnaVbgf7u36CNOeCkAGdd/x96zyTI9f3do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAmjD1oaqEgoOUD4SywS4XKI7Pnd9GSrwf/GCdXZc2JD6ZkVuQte+umDtBr9y/9DM7arMfQSpt8vohP8w4JF3pdxdF0WsWhfTrXWNYNd5em9nmubdy4oJUJXm+j/erD+uCfzOdIAdE97fDuElmLlXzc2NG3Ipv2jaHGAmYxM51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoRS+Dhl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoRS+Dhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790066671; x=1821602671;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6sAwjJocnWnaVbgf7u36CNOeCkAGdd/x96zyTI9f3do=;
  b=IoRS+Dhl7m4Dbf5Iw++jORQcrP6v8QTlqxbS1t4ZdUbFtVTeDHS1S/8G
   5n3RBez36DSfh67XCXNWyIGBRUXbmpnbxRmURuWF78HYCXJ0+vFMw/OqE
   572l2PCeEWnlduRuKKmRaivPY7ojlQZ1ZDVOyNfzfOEdu0WGRFp+sB/0a
   wVInouEkfrl4CBZVXECG8z8TolGxfIiiAhjlmQw2RrDAiPo8yxtFf272r
   InR7SU79OVmqe/dAods3PLFyIeXb755XBMwlQ5oE1O8D0mx9dKC8668VT
   XHKKPlEXOAW3qmc6mFpR98RsIjntDxmQKZ5U189NIwomlMG9mtdNiMw8b
   w==;
X-CSE-ConnectionGUID: nfcevRXCQVqwx+CFlN2Ffw==
X-CSE-MsgGUID: 3F41e+NwRaiTtT62aERLDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94481017"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="94481017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:44:30 -0700
X-CSE-ConnectionGUID: 6meNStNrQ0azg0iNQwQsag==
X-CSE-MsgGUID: p/c82XgmQJWEgMuSSINFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271583960"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:44:27 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Dave Airlie <airlied@redhat.com>, Alex
 Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback (v2)
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260922071807.2533884-1-airlied@gmail.com>
Date: Tue, 22 Sep 2026 11:44:24 +0300
Message-ID: <7ff92123891ada890c50ec7254fab46af187914d@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 22 Sep 2026, Dave Airlie <airlied@gmail.com> wrote:
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
>  		bool state)
>  {
> -	struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;

The cast is superfluous. Ditto everywhere else.

Other than that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


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

-- 
Jani Nikula, Intel
