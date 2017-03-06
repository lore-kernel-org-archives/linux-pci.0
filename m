Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix printing the doorbell BAR info
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1488800428-2854-1-git-send-email-deathsimple@vodafone.de>
 <1488800428-2854-4-git-send-email-deathsimple@vodafone.de>
 <CAHp75VeUTWC0p6PpRu+nw6Vqwnm2Q4-nTYh59T1efBReDou+Og@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <442bd430-eea2-34e3-4392-262eabbd2c1a@vodafone.de>
Date: Mon, 6 Mar 2017 13:09:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAHp75VeUTWC0p6PpRu+nw6Vqwnm2Q4-nTYh59T1efBReDou+Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 06.03.2017 um 13:00 schrieb Andy Shevchenko:
> On Mon, Mar 6, 2017 at 1:40 PM, Christian König <deathsimple@vodafone.de> wrote:
>> From: Christian König <christian.koenig@amd.com>
>>
>> The address is 64bit, not 32bit.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bf31aaf..a470869 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -385,7 +385,7 @@ static int amdgpu_doorbell_init(struct amdgpu_device *adev)
>>          if (adev->doorbell.ptr == NULL) {
>>                  return -ENOMEM;
>>          }
>
>> -       DRM_INFO("doorbell mmio base: 0x%08X\n", (uint32_t)adev->doorbell.base);
>> +       DRM_INFO("doorbell mmio base: 0x%llX\n", (uint64_t)adev->doorbell.base);
>>          DRM_INFO("doorbell mmio size: %u\n", (unsigned)adev->doorbell.size);
> It seems I sent patch to remove those at all, but if you wish to leave
> them, please convert to %pap and remove explicit casting.
Sorry, looked like both Alex and I missed your patch. But yes that the 
PCI subsystem prints that info anyway is a good argument.

Going to put my rb on your patch and push it into our internal repo, 
Alex should then pick it up for the next drm-next pull request.

Thanks,
Christian.
