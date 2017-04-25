Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=0hWc=4B=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access v2
To: Alex Deucher <alexdeucher@gmail.com>
References: <1493126394-1239-1-git-send-email-deathsimple@vodafone.de>
 <1493126394-1239-5-git-send-email-deathsimple@vodafone.de>
 <CADnq5_NHDo3Y0Ao_5uWQ=Q2mb5-qYZu9Z-cx1M48cfD0rxMi2w@mail.gmail.com>
 <9d345f33-a291-1647-9d03-d0df17733b14@vodafone.de>
 <CADnq5_PquOLg1RLNE36-ZXGpSZFBu_N56-3Ox18CXu6oG2nk=w@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI
 <linux-pci@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <acd547a0-17d9-e5ba-8005-07a8f47c2f74@vodafone.de>
Date: Tue, 25 Apr 2017 18:22:07 +0200
MIME-Version: 1.0
In-Reply-To: <CADnq5_PquOLg1RLNE36-ZXGpSZFBu_N56-3Ox18CXu6oG2nk=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 25.04.2017 um 17:14 schrieb Alex Deucher:
> On Tue, Apr 25, 2017 at 11:09 AM, Christian König
> <deathsimple@vodafone.de> wrote:
>> Am 25.04.2017 um 16:34 schrieb Alex Deucher:
>>> On Tue, Apr 25, 2017 at 9:19 AM, Christian König
>>> <deathsimple@vodafone.de> wrote:
>>>> From: Christian König <christian.koenig@amd.com>
>>>>
>>>> Try to resize BAR0 to let CPU access all of VRAM.
>>>>
>>>> v2: rebased, style cleanups, disable mem decode before resize,
>>>>       handle gmc_v9 as well, round size up to power of two.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37
>>>> ++++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 ++++---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 ++++---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++----
>>>>    5 files changed, 54 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 4a16e3c..9484062 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1879,6 +1879,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
>>>> amdgpu_device *adev, struct ttm_tt *ttm,
>>>>                                    struct ttm_mem_reg *mem);
>>>>    void amdgpu_vram_location(struct amdgpu_device *adev, struct amdgpu_mc
>>>> *mc, u64 base);
>>>>    void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc
>>>> *mc);
>>>> +void amdgpu_resize_bar0(struct amdgpu_device *adev);
>>>>    void amdgpu_ttm_set_active_vram_size(struct amdgpu_device *adev, u64
>>>> size);
>>>>    int amdgpu_ttm_init(struct amdgpu_device *adev);
>>>>    void amdgpu_ttm_fini(struct amdgpu_device *adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index a09ad3cf..d5ca77a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -695,6 +695,43 @@ void amdgpu_gtt_location(struct amdgpu_device *adev,
>>>> struct amdgpu_mc *mc)
>>>>                           mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
>>>>    }
>>>>
>>>> +/**
>>>> + * amdgpu_resize_bar0 - try to resize BAR0
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Try to resize BAR0 to make all VRAM CPU accessible.
>>>> + */
>>>> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
>>> I'd suggest renaming this to amdgpu_device_resize_bar() to try and
>>> impose some consistency in this file, but not a big deal either way.
>>>
>>>> +{
>>>> +       u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
>>>> +       u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) -1;
>>>> +       u16 cmd;
>>>> +       int r;
>>>> +
>>>> +       /* Free the doorbell mapping, it most likely needs to move as
>>>> well */
>>>> +       amdgpu_doorbell_fini(adev);
>>>> +       pci_release_resource(adev->pdev, 2);
>>> This should check for if (adev->asic_type >= CHIP_BONAIRE) since SI
>>> didn't have doorbells.
>>>
>>>> +
>>>> +       /* Disable memory decoding while we change the BAR addresses and
>>>> size */
>>>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND,
>>>> +                             cmd & ~PCI_COMMAND_MEMORY);
>>>> +
>>>> +       r = pci_resize_resource(adev->pdev, 0, rbar_size);
>>>> +       if (r == -ENOSPC)
>>>> +               DRM_INFO("Not enough PCI address space for a large
>>>> BAR.");
>>>> +       else if (r && r != -ENOTSUPP)
>>>> +               DRM_ERROR("Problem resizing BAR0 (%d).", r);
>>>> +
>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>> +
>>>> +       /* When the doorbell BAR isn't available we have no chance of
>>>> +        * using the device.
>>>> +        */
>>>> +       BUG_ON(amdgpu_doorbell_init(adev));
>>> Same here.
>>>
>>>> +}
>>>> +
>>>>    /*
>>>>     * GPU helpers function.
>>>>     */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> index a9083a1..ae71524 100644
>>> What about SI (gmc_v6_0.c)?
>>
>> As far as I know there is no SI hardware with resizeable BAR support.
>>
>> The all VI generation can do this, but I'm not 100% sure if there aren't any
>> Bonaires out there which can handle it as well that's why I added gmc_v7
>> support.
>>
>> Still need to double check that.
> I think NI or even evergreen supported resizeable bars in theory,
> although I'm not sure if any boards were fused to expose it.

In theory yes, in practice no.

Their PCIE config space defines the necessary registers, but I haven't 
found any board from Evergreen, NI, SI or CIK generation where that is 
actually validated.

Tonga is the first one I'm 100% sure that it is supported and I have 
hardware to test it.

I would rather drop Bonaire support as well and wait for somebody with 
the hardware to complain so that we can test and enable it.

Christian.

>
> Alex
>
>
>> Christian.
>>
>>
>>> Alex
>>>
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> @@ -372,13 +372,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device
>>>> *adev)
>>>>                   }
>>>>                   adev->mc.vram_width = numchan * chansize;
>>>>           }
>>>> -       /* Could aper size report 0 ? */
>>>> -       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> -       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>>           /* size in MB on si */
>>>>           adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL *
>>>> 1024ULL;
>>>>           adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL *
>>>> 1024ULL;
>>>>
>>>> +       if (!(adev->flags & AMD_IS_APU))
>>>> +               amdgpu_resize_bar0(adev);
>>>> +       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> +       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>> +
>>>>    #ifdef CONFIG_X86_64
>>>>           if (adev->flags & AMD_IS_APU) {
>>>>                   adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) <<
>>>> 22;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> index 4ac9978..1655de2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> @@ -534,13 +534,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device
>>>> *adev)
>>>>                   }
>>>>                   adev->mc.vram_width = numchan * chansize;
>>>>           }
>>>> -       /* Could aper size report 0 ? */
>>>> -       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> -       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>>           /* size in MB on si */
>>>>           adev->mc.mc_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL *
>>>> 1024ULL;
>>>>           adev->mc.real_vram_size = RREG32(mmCONFIG_MEMSIZE) * 1024ULL *
>>>> 1024ULL;
>>>>
>>>> +       if (!(adev->flags & AMD_IS_APU))
>>>> +               amdgpu_resize_bar0(adev);
>>>> +       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> +       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>> +
>>>>    #ifdef CONFIG_X86_64
>>>>           if (adev->flags & AMD_IS_APU) {
>>>>                   adev->mc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) <<
>>>> 22;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index e5d4dfe..4bbef79 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -469,16 +469,18 @@ static int gmc_v9_0_mc_init(struct amdgpu_device
>>>> *adev)
>>>>           }
>>>>           adev->mc.vram_width = numchan * chansize;
>>>>
>>>> -       /* Could aper size report 0 ? */
>>>> -       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> -       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>>           /* size in MB on si */
>>>>           adev->mc.mc_vram_size =
>>>>                   nbio_v6_1_get_memsize(adev) * 1024ULL * 1024ULL;
>>>>           adev->mc.real_vram_size = adev->mc.mc_vram_size;
>>>> -       adev->mc.visible_vram_size = adev->mc.aper_size;
>>>> +
>>>> +       if (!(adev->flags & AMD_IS_APU))
>>>> +               amdgpu_resize_bar0(adev);
>>>> +       adev->mc.aper_base = pci_resource_start(adev->pdev, 0);
>>>> +       adev->mc.aper_size = pci_resource_len(adev->pdev, 0);
>>>>
>>>>           /* In case the PCI BAR is larger than the actual amount of vram
>>>> */
>>>> +       adev->mc.visible_vram_size = adev->mc.aper_size;
>>>>           if (adev->mc.visible_vram_size > adev->mc.real_vram_size)
>>>>                   adev->mc.visible_vram_size = adev->mc.real_vram_size;
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
