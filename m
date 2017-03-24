Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Mar 2017 16:42:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
Message-ID: <20170324214215.GG25380@bhelgaas-glaptop.roam.corp.google.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 01:41:36PM +0100, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> Try to resize BAR0 to let CPU access all of VRAM.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 +++++---
>  4 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3b81ded..905ded9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1719,6 +1719,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>  				 struct ttm_mem_reg *mem);
>  void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
>  void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
> +void amdgpu_resize_bar0(struct amdgpu_device *adev);
>  void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 118f4e6..92955fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -692,6 +692,35 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
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
> +	u32 size = max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20;
> +	int r;
> +
> +	r = pci_resize_resource(adev->pdev, 0, size);
> +
> +	if (r == -ENOTSUPP) {
> +		/* The hardware don't support the extension. */
> +		return;
> +
> +	} else if (r == -ENOSPC) {
> +		DRM_INFO("Not enoigh PCI address space for a large BAR.");

s/enoigh/enough/

> +	} else if (r) {
> +		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +	}
> +
> +	/* Reinit the doorbell mapping, it is most likely moved as well */

I think you should assume all BARs moved (I don't know how many you have;
maybe this already covers all of them).

> +	amdgpu_doorbell_fini(adev);
> +	BUG_ON(amdgpu_doorbell_init(adev));

I think things inside BUG_ON() tend to get overlooked, so I avoid things
that have side-effects.  But that's just my personal preference.
