Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754041AbdGJWXj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 18:23:39 -0400
Date: Mon, 10 Jul 2017 17:23:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 6/6] drm/amdgpu: resize VRAM BAR for CPU access v4
Message-ID: <20170710222335.GG5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
 <1499698794-1718-7-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1499698794-1718-7-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 04:59:54PM +0200, Christian König wrote:
> From: Christian König <christian.koenig@amd.com>
> 
> Try to resize BAR0 to let CPU access all of VRAM.
> 
> v2: rebased, style cleanups, disable mem decode before resize,
>     handle gmc_v9 as well, round size up to power of two.
> v3: handle gmc_v6 as well, release and reassign all BARs in the driver.
> v4: rename new function to amdgpu_device_resize_fb_bar,
>     reenable mem decoding only if all resources are assigned.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  8 ++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 ++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 ++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++---
>  6 files changed, 68 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ff7bf1a..5809e0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1944,6 +1944,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>  				 struct ttm_mem_reg *mem);
>  void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc *mc, u64 base);
>  void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc);
> +void amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
>  void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64 size);
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7d1a04a..a5123f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -428,6 +428,9 @@ static int amdgpu_doorbell_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> +	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +		return -EINVAL;
> +
>  	/* doorbell bar mapping */
>  	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>  	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> @@ -709,6 +712,49 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
>  			mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
>  }
>  
> +/**
> + * amdgpu_device_resize_fb_bar - try to resize FB BAR
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Try to resize FB BAR to make all VRAM CPU accessible.
> + */
> +void amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
> +{
> +	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
> +	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
> +	u16 cmd;
> +	int r;
> +
> +	/* Disable memory decoding while we change the BAR addresses and size */
> +	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(adev->pdev, PCI_COMMAND,
> +			      cmd & ~PCI_COMMAND_MEMORY);
> +
> +	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
> +	amdgpu_doorbell_fini(adev);
> +	pci_release_resource(adev->pdev, 0);
> +	if (adev->asic_type >= CHIP_BONAIRE)
> +		pci_release_resource(adev->pdev, 2);

The related pieces should be together, e.g.,

  amdgpu_doorbell_fini(adev);
  if (adev->asic_type >= CHIP_BONAIRE)
	  pci_release_resource(adev->pdev, 2);

  pci_release_resource(adev->pdev, 0);

> +	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +	if (r == -ENOSPC)
> +		DRM_INFO("Not enough PCI address space for a large BAR.");
> +	else if (r && r != -ENOTSUPP)
> +		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +
> +	pci_assign_unassigned_bus_resources(adev->pdev->bus);
> +
> +	/* When the doorbell or fb BAR isn't available we have no chance of
> +	 * using the device.
> +	 */
> +	r = amdgpu_doorbell_init(adev);
> +	if ((pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET) || r)
> +		BUG();

Seems extreme to panic the system in this case.

I don't think IORESOURCE_UNSET should appear in a driver.  I think that's
an internal property that should be handled in the core.

What if you added something like this:

  int pci_enable_mem_decoding(struct pci_dev *dev)
  {
    unsigned int bars = 0;

    for (i = 0; i <= PCI_ROM_RESOURCE; i++)
      if (dev->resource[i].flags & IORESOURCE_MEM)
        bars |= (1 << i);

    return pci_enable_resources(pdev, bars);
  }

> +	else
> +		pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> +}
