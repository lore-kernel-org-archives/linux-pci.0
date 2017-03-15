Return-Path: <SRS0=bJ5t=2Y=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=bJ5t=2Y=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
To: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
 <CAPyr0yLWiGzU5ihFcj_NmA2Vk2R7GsKqo2LK8o3Eu+Df9m7vhw@mail.gmail.com>
 <6fac05e4-26ae-e959-9af6-cb68a04a1110@vodafone.de>
 <CAPyr0yL5a0vNnsThX1L0Zf_gjnCngPhD5hdetQjnvmajGhdmEQ@mail.gmail.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <04c71a4c-dfe7-c85e-f673-4511e055fa76@vodafone.de>
Date: Wed, 15 Mar 2017 12:03:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyr0yL5a0vNnsThX1L0Zf_gjnCngPhD5hdetQjnvmajGhdmEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

No, we resize the BAR on the fly during driver load without help from 
the BIOS or VBIOS.

Christian.

Am 15.03.2017 um 11:42 schrieb Ayyappa Ch:
> It also needs any support from VBIOS side ? I mean PCIe large bar support?
>
> Thanks,
> Ayyappa.
>
> On Wed, Mar 15, 2017 at 1:07 PM, Christian König
> <deathsimple@vodafone.de> wrote:
>> Carizzo is an APU and resizing BARs isn't needed nor supported there. The
>> CPU can access the full stolen VRAM directly on that hardware.
>>
>> As far as I know ASICs with support for this are Tonga, Fiji and all Polaris
>> variants.
>>
>> Christian.
>>
>>
>> Am 15.03.2017 um 08:23 schrieb Ayyappa Ch:
>>> Is it possible on Carrizo asics? Or only supports on newer asics?
>>>
>>> On Mon, Mar 13, 2017 at 6:11 PM, Christian König
>>> <deathsimple@vodafone.de> wrote:
>>>> From: Christian König <christian.koenig@amd.com>
>>>>
>>>> Try to resize BAR0 to let CPU access all of VRAM.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29
>>>> +++++++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  8 +++++---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  8 +++++---
>>>>    4 files changed, 40 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 3b81ded..905ded9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1719,6 +1719,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
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
>>>> index 118f4e6..92955fe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -692,6 +692,35 @@ void amdgpu_gtt_location(struct amdgpu_device *adev,
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
>>>> +{
>>>> +       u32 size = max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20;
>>>> +       int r;
>>>> +
>>>> +       r = pci_resize_resource(adev->pdev, 0, size);
>>>> +
>>>> +       if (r == -ENOTSUPP) {
>>>> +               /* The hardware don't support the extension. */
>>>> +               return;
>>>> +
>>>> +       } else if (r == -ENOSPC) {
>>>> +               DRM_INFO("Not enoigh PCI address space for a large
>>>> BAR.");
>>>> +       } else if (r) {
>>>> +               DRM_ERROR("Problem resizing BAR0 (%d).", r);
>>>> +       }
>>>> +
>>>> +       /* Reinit the doorbell mapping, it is most likely moved as well
>>>> */
>>>> +       amdgpu_doorbell_fini(adev);
>>>> +       BUG_ON(amdgpu_doorbell_init(adev));
>>>> +}
>>>> +
>>>>    /*
>>>>     * GPU helpers function.
>>>>     */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> index dc9b6d6..36a7aa5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> @@ -367,13 +367,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device
>>>> *adev)
>>>>                   break;
>>>>           }
>>>>           adev->mc.vram_width = numchan * chansize;
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
>>>> index c087b00..7761ad3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> @@ -459,13 +459,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device
>>>> *adev)
>>>>                   break;
>>>>           }
>>>>           adev->mc.vram_width = numchan * chansize;
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
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
