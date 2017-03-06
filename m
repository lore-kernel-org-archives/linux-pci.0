Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: resize VRAM BAR for CPU access
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
 <1488800428-2854-5-git-send-email-deathsimple@vodafone.de>
 <CAHp75Ve8WyfNjrRq2jw_puqBUOAfWMBgVFdo--tdvQ4ta5tjzQ@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <2fe5b055-5e8f-a7f5-a492-f65c80221190@vodafone.de>
Date: Mon, 6 Mar 2017 13:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve8WyfNjrRq2jw_puqBUOAfWMBgVFdo--tdvQ4ta5tjzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 06.03.2017 um 13:06 schrieb Andy Shevchenko:
> On Mon, Mar 6, 2017 at 1:40 PM, Christian König <deathsimple@vodafone.de> wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> Try to resize BAR0 to let CPU access all of VRAM.
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -616,6 +616,35 @@ void amdgpu_gtt_location(struct amdgpu_device *adev, struct amdgpu_mc *mc)
>> +void amdgpu_resize_bar0(struct amdgpu_device *adev)
>> +{
>> +       u32 size = max(ilog2(adev->mc.real_vram_size - 1) + 1, 20) - 20;
> Too complicated.
>
> unsigned long = fls_long(real_vram_size | BIT(20));

That would round down, not up. We got boards with 6GB VRAM as well and 
then need a 8GB BAR.

And the vram size won't fit into a long on 32bit systems. What I really 
need is order_base_2 for 64bit values.

But wait a second, thinking more about it we could do 
"order_base_2((real_vram_size >> 20) | 1)".

> And the result is not a size, right? It's a logarithm from size.

Yeah, and subtracted by 20. Thought about a better wording as well, but 
couldn't come up with something.

"size" is just what the spec uses. How about rbar_size to note that it 
is size as the meaning in the RBAR specification?

>
>> +       int r;
>> +
>> +       r = pci_resize_resource(adev->pdev, 0, size);
>> +
> Redundant line.
>
>> +       if (r == -ENOTSUPP) {
>> +               /* The hardware don't support the extension. */
>> +               return;
>> +
>> +       } else if (r == -ENOSPC) {
>> +               DRM_INFO("Not enoigh PCI address space for a large BAR.");
>> +       } else if (r) {
>> +               DRM_ERROR("Problem resizing BAR0 (%d).", r);
>> +       }
>> +
>> +       /* Reinit the doorbell mapping, it is most likely moved as well */
>> +       amdgpu_doorbell_fini(adev);
>> +       BUG_ON(amdgpu_doorbell_init(adev));
> No way to recover?!

Nope, I actually thought about calling panic() here instead.

If we hit this we have messed things so badly up that we can't access 
the hardware any more, so no way to tell it to shut down or something 
like this.

Well, I could completely rewrite the call chain to signal modprobe that 
loading the driver didn't worked at all. But that comes pretty near to 
calling BUG_ON() as well.

Thanks for the comments,
Christian.

>
>> +}
>> +
