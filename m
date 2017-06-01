Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdFAUOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jun 2017 16:14:46 -0400
Date: Thu, 1 Jun 2017 15:14:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
Message-ID: <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
 <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc ADMGPU, DRM folks]

On Tue, May 09, 2017 at 06:49:07PM +0200, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> Try to resize BAR0 to let CPU access all of VRAM.
> 
> v2: rebased, style cleanups, disable mem decode before resize,
>     handle gmc_v9 as well, round size up to power of two.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 ++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 ++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++----
>  5 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5310781..d6f5286 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1884,6 +1884,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>  				 struct ttm_mem_reg *mem);
>  void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
>  void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
> +void amdgpu_resize_bar0(struct amdgpu_device *adev);
>  void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2719c02..4e83a56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -694,6 +694,43 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
>  			mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
>  }
>  
> +/**
> + * amdgpu_resize_bar0 - try to resize BAR0
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Try to resize BAR0 to make all VRAM CPU accessible.
> + */
> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
> +{
> +	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
> +	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) -1;
> +	u16 cmd;
> +	int r;
> +
> +	/* Free the doorbell mapping, it most likely needs to move as well */
> +	amdgpu_doorbell_fini(adev);
> +	pci_release_resource(adev->pdev, 2);
> +
> +	/* Disable memory decoding while we change the BAR addresses and size */
> +	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(adev->pdev, PCI_COMMAND,
> +			      cmd & ~PCI_COMMAND_MEMORY);
> +
> +	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +	if (r == -ENOSPC)
> +		DRM_INFO("Not enough PCI address space for a large BAR.");
> +	else if (r && r != -ENOTSUPP)
> +		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +
> +	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> +
> +	/* When the doorbell BAR isn't available we have no chance of
> +	 * using the device.
> +	 */
> +	BUG_ON(amdgpu_doorbell_init(adev));

This amdgpu_doorbell_fini()/amdgpu_doorbell_init() thing doesn't look
right.  amdgpu_device_init() only calls amdgpu_doorbell_init() for
"adev->asic_type >= CHIP_BONAIRE", but we call it unconditionally
here.

This is the call graph:

  amdgpu_device_init
    adev->rmmio_base = pci_resource_start(adev->pdev, 5)   # 2 for < BONAIRE
    adev->rmmio = ioremap(adev->rmmio_base, ...)
    DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base)
    if (adev->asic_type >= CHIP_BONAIRE) {
      amdgpu_doorbell_init
	adev->doorbell.base = pci_resource_start(adev->pdev, 2)
	adev->doorbell.ptr = ioremap(adev->doorbell.base, ...)
    }
    amdgpu_init
      gmc_v7_0_sw_init              # gmc_v7_0_ip_funcs.sw_init
	gmc_v7_0_mc_init
  +         amdgpu_resize_bar0
  +           amdgpu_doorbell_fini
  +           pci_release_resource(adev->pdev, 2)
  +           pci_resize_resource(adev->pdev, 0, size)
  +           amdgpu_doorbell_init
	  adev->mc.aper_base = pci_resource_start(adev->pdev, 0)

If "asic_type < CHIP_BONAIRE", we ioremapped BAR 2 in
amdgpu_device_init(), then we released the resource here and never
updated the ioremap.

>From the PCI core perspective, it would be much cleaner to do the BAR
resize before the driver calls pci_enable_device().  If that could be
done, there would be no need for this sort of shutdown/reinit stuff
and we wouldn't have to worry about issues like these.  The amdgpu
init path is pretty complicated, so I don't know whether this is
possible.

I would also like to simplify the driver usage model and get the
PCI_COMMAND_MEMORY twiddling into the PCI core instead of the driver.
Ideally, the driver would do something like this:

  pci_resize_resource(adev->pdev, 0, rbar_size);
  pci_enable_device(adev->pdev);

And the PCI core would be something along these lines:

  int pci_resize_resource(dev, bar, size)
  {
    if (pci_is_enabled(dev))
      return -EBUSY;

    pci_disable_decoding(dev);          # turn off MEM, IO decoding
    pci_release_resources(dev);         # (all of them)
    err = pci_resize_bar(dev, bar, size);     # change BAR size (only)
    if (err)
      return err;

    pci_assign_resources(dev);          # reassign all "dev" resources
    return 0;
  }

> +}
> +
>  /*
>   * GPU helpers function.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index a9083a1..ae71524 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -372,13 +372,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>  		}
>  		adev->mc.vram_width = numchan * chansize;
>  	}
> -	/* Could aper size report 0 ? */
> -	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>  	/* size in MB on si */
>  	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
>  	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
>  
> +	if (!(adev->flags & AMD_IS_APU))
> +		amdgpu_resize_bar0(adev);
> +	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
> +
>  #ifdef CONFIG_X86_64
>  	if (adev->flags & AMD_IS_APU) {
>  		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 4ac9978..1655de2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -534,13 +534,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>  		}
>  		adev->mc.vram_width = numchan * chansize;
>  	}
> -	/* Could aper size report 0 ? */
> -	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>  	/* size in MB on si */
>  	adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
>  	adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL * 1024ULL;
>  
> +	if (!(adev->flags & AMD_IS_APU))
> +		amdgpu_resize_bar0(adev);
> +	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
> +
>  #ifdef CONFIG_X86_64
>  	if (adev->flags & AMD_IS_APU) {
>  		adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b9f11fa..d65728a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -469,16 +469,18 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>  	}
>  	adev->mc.vram_width = numchan * chansize;
>  
> -	/* Could aper size report 0 ? */
> -	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>  	/* size in MB on si */
>  	adev->mc.mc_vram_size =
>  		nbio_v6_1_get_memsize(adev) * 1024ULL * 1024ULL;
>  	adev->mc.real_vram_size = adev->mc.mc_vram_size;
> -	adev->mc.visible_vram_size = adev->mc.aper_size;
> +
> +	if (!(adev->flags & AMD_IS_APU))
> +		amdgpu_resize_bar0(adev);
> +	adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>  
>  	/* In case the PCI BAR is larger than the actual amount of vram */
> +	adev->mc.visible_vram_size = adev->mc.aper_size;
>  	if (adev->mc.visible_vram_size > adev->mc.real_vram_size)
>  		adev->mc.visible_vram_size = adev->mc.real_vram_size;
>  
> -- 
> 2.7.4
> 
