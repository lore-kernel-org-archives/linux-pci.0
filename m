Return-Path: <SRS0=PmUz=JF=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=PmUz=JF=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if translated
 by the bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, ard.biesheuvel@linaro.org,
 "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
 <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
 <733101d0-9051-a5a6-ef64-162d8d1e10a1@codeaurora.org>
 <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <61384244-49f9-2020-04f0-6e188cf6a6b7@codeaurora.org>
Date: Tue, 19 Jun 2018 18:14:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180619215955.GF33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 6/19/2018 5:59 PM, Bjorn Helgaas wrote:
> On Fri, May 18, 2018 at 10:20:29AM -0400, Sinan Kaya wrote:
>> On 5/18/2018 6:42 AM, Robin Murphy wrote:
>>>
>>> FWIW, now that I've actually gone and looked, it appears you could simplify the whole function quite a bit by getting rid of these and just using the new local resource directly, especially since the only actual use of size is an open-coded resource_contains().
>>
>> Posted V2 a minute ago. I did the simplification on a prior patch in order not to
>> mix the issues.
> 
> I don't see the V2 on linux-pci, but it sounds like Ard would merge this
> anyway.  So I'll drop this and you can let me know if there's anything you
> need from me.
> 

It is planned to go through fbdev tree for 4.19. 

https://patchwork.kernel.org/patch/10410895/

Feel free to review/ACK.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
