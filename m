Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pegasos-out.vodafone.de ([80.84.1.38]:44664 "EHLO
        pegasos-out.vodafone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdFBJc2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2017 05:32:28 -0400
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
 <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
 <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <72e061a5-9684-06e2-3021-80de8ca97bd7@vodafone.de>
Date: Fri, 2 Jun 2017 11:32:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

sorry for not responding earlier and thanks for picking this thread up 
again.

Am 01.06.2017 um 22:14 schrieb Bjorn Helgaas:
> [+cc ADMGPU, DRM folks]
>
> On Tue, May 09, 2017 at 06:49:07PM +0200, Christian König wrote:
>> [SNIP]
>> +/**
>> + * amdgpu_resize_bar0 - try to resize BAR0
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Try to resize BAR0 to make all VRAM CPU accessible.
>> + */
>> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
>> +{
>> +	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
>> +	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) -1;
>> +	u16 cmd;
>> +	int r;
>> +
>> +	/* Free the doorbell mapping, it most likely needs to move as well */
>> +	amdgpu_doorbell_fini(adev);
>> +	pci_release_resource(adev->pdev, 2);
>> +
>> +	/* Disable memory decoding while we change the BAR addresses and size */
>> +	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>> +	pci_write_config_word(adev->pdev, PCI_COMMAND,
>> +			      cmd & ~PCI_COMMAND_MEMORY);
>> +
>> +	r = pci_resize_resource(adev->pdev, 0, rbar_size);
>> +	if (r == -ENOSPC)
>> +		DRM_INFO("Not enough PCI address space for a large BAR.");
>> +	else if (r && r != -ENOTSUPP)
>> +		DRM_ERROR("Problem resizing BAR0 (%d).", r);
>> +
>> +	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>> +
>> +	/* When the doorbell BAR isn't available we have no chance of
>> +	 * using the device.
>> +	 */
>> +	BUG_ON(amdgpu_doorbell_init(adev));
> This amdgpu_doorbell_fini()/amdgpu_doorbell_init() thing doesn't look
> right.  amdgpu_device_init() only calls amdgpu_doorbell_init() for
> "adev->asic_type >= CHIP_BONAIRE", but we call it unconditionally
> here.
>
> This is the call graph:
>
>    amdgpu_device_init
>      adev->rmmio_base = pci_resource_start(adev->pdev, 5)   # 2 for < BONAIRE
>      adev->rmmio = ioremap(adev->rmmio_base, ...)
>      DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base)
>      if (adev->asic_type >= CHIP_BONAIRE) {
>        amdgpu_doorbell_init
> 	adev->doorbell.base = pci_resource_start(adev->pdev, 2)
> 	adev->doorbell.ptr = ioremap(adev->doorbell.base, ...)
>      }
>      amdgpu_init
>        gmc_v7_0_sw_init              # gmc_v7_0_ip_funcs.sw_init
> 	gmc_v7_0_mc_init
>    +         amdgpu_resize_bar0
>    +           amdgpu_doorbell_fini
>    +           pci_release_resource(adev->pdev, 2)
>    +           pci_resize_resource(adev->pdev, 0, size)
>    +           amdgpu_doorbell_init
> 	  adev->mc.aper_base = pci_resource_start(adev->pdev, 0)
>
> If "asic_type < CHIP_BONAIRE", we ioremapped BAR 2 in
> amdgpu_device_init(), then we released the resource here and never
> updated the ioremap.

The first hardware with a resizeable BAR I could find is a Tonga, and 
that is even a generation later than Bonaire.

So we are never going to call this code on earlier hardware generations.

But I think I will just move the asic_type check into the function to be 
absolute sure.

>  From the PCI core perspective, it would be much cleaner to do the BAR
> resize before the driver calls pci_enable_device().  If that could be
> done, there would be no need for this sort of shutdown/reinit stuff
> and we wouldn't have to worry about issues like these.  The amdgpu
> init path is pretty complicated, so I don't know whether this is
> possible.

I completely agree on this and it is actually the approach I tried first.

There are just two problems with this approach:
1. When the amdgpu driver is loaded there can already be the VGA 
console, Vesa or EFI driver active for the device and displaying the 
splash screen.

When we resize and most likely relocate the BAR while those drivers are 
active it will certainly cause problems.

What amdgpu does before trying to resize the BAR is kicking out other 
driver and making sure it has exclusive access to the hardware.

2. Without taking a look at the registers you don't know how much memory 
there actually is on the board.

We could always resize it to the maximum supported, but that would mean 
we could easily waste 128GB of address space while the hardware only has 
8GB of VRAM.

That would not necessarily hurt us when we have enough address space, 
but at least kind of sucks.

> I would also like to simplify the driver usage model and get the
> PCI_COMMAND_MEMORY twiddling into the PCI core instead of the driver.
> Ideally, the driver would do something like this:
>
>    pci_resize_resource(adev->pdev, 0, rbar_size);
>    pci_enable_device(adev->pdev);
>
> And the PCI core would be something along these lines:
>
>    int pci_resize_resource(dev, bar, size)
>    {
>      if (pci_is_enabled(dev))
>        return -EBUSY;
>
>      pci_disable_decoding(dev);          # turn off MEM, IO decoding
>      pci_release_resources(dev);         # (all of them)
>      err = pci_resize_bar(dev, bar, size);     # change BAR size (only)
>      if (err)
>        return err;
>
>      pci_assign_resources(dev);          # reassign all "dev" resources
>      return 0;
>    }

I already tried the approach with releasing all resources, but it didn't 
worked so well.

When resizing fails because we don't have enough address space then we 
at least want to get back to a working config.

Releasing everything makes that rather tricky, since I would then need 
to keep a backup of the old config and try to restore it.

Additional to that I'm not sure if releasing the register BAR and 
relocating it works with amdgpu.

Regards,
Christian.
