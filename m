Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
To: Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        tn@semihalf.com, Hanjun Guo <hanjun.guo@linaro.org>,
        okaya@codeaurora.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1486136933-20328-8-git-send-email-sricharan@codeaurora.org>
 <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
 <2bfd11dc-9f94-2b69-7b03-c640e53155e1@arm.com>
 <26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
 <CAMuHMdUoLp1oVT_=NG8HS-jgG6AhOeVUsGgu7fLbGY+7A+0cOg@mail.gmail.com>
 <CANqRtoSEwdoufUxP-Rm=qZJ7G8V3ow5F0ggV3tALrfiRad+j4Q@mail.gmail.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <3b154db4-6ebb-c05c-91f0-beefa75fae00@codeaurora.org>
Date: Wed, 17 May 2017 15:58:12 +0530
MIME-Version: 1.0
In-Reply-To: <CANqRtoSEwdoufUxP-Rm=qZJ7G8V3ow5F0ggV3tALrfiRad+j4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Magnus,

<snip..>

>> Magnus, do you have a suggestion?
> 
> Thanks for your efforts guys!
> 
> I've recently been working on up-porting the IPMMU patches and
> addressing review comments. Now with my local driver stack on top of
> v4.12-rc (a95cfad) I did not notice these issues initially since I
> only tested devices with IPMMU enabled. Once these issues were pointed
> out to me by Geert I have now reproduced the 64-bit ARM specific ones
> on r8a7796 Salvator-X.
> 
> On my r8a7796 platform I'm using the following IOMMU and DMA Engine devices:
> 
> IOMMU device IPMMU-DS0 - Connected to SYS-DMAC0
> IOMMU device IPMMU-DS1 - Connected to SYS-DMAC1 and SYS-DMAC2
> IOMMU device IPMMU-MM - Root device serving IPMMU-DS0 and IPMMU-DS1
> 
> For testing the serial port SCIF1 is used with DMA Engine devices
> SYS-DMAC1 or SYS-DMAC2.
> 
> The software environment is configured as follows:
> - The DTS comes with all devices above enabled except IPMMU-DS0 which
> comes with status = "disabled".
> - The IPMMU driver is during run time only allowing use of SYS-DMAC2.
> For other devices ->of_xlate() returns -ENODEV.
> 
> The above used to work just fine with v4.11 or earlier.
> 
> My observations for v4.12-rc:
> 
> 1) Default state for a95cfad
> 
> The devices SYS-DMAC0 and SYS-DMAC1 will never probe. However SYS-DMAC2 is fine.
> 
> 2) After applying "[PATCH] iommu: of: Fix check for returning EPROBE_DEFER" [1]
> 
> This fixes SYS-DMAC0 that now probes and operates without IPMMU-DS0 as
> expected. Same as v4.11 or earlier.
> 
> 3) After also applying "[PATCH] of: iommu: Ignore all errors except
> EPROBE_DEFER" [2]
> 
> This fixes SYS-DMAC1 that now probes and operates without IPMMU-DS1 as
> expected. Same as v4.11 or earlier.
> 
> With fix [1] and [2] things seem back to normal. Unless I'm mistaken

Thanks, will use this as your Tested-by.

Regards,
 Sricharan

> it also seems that [1] allows me to drop the similar patch "[PATCH/RFC
> v2 1/4] iommu/of: Skip IOMMU devices disabled in DT".
> 
> Thanks for your help.
> 
> Cheers,
> 
> / magnus
> 
> 
> [1] https://lkml.org/lkml/2017/5/16/25
> [2] https://www.spinics.net/lists/arm-kernel/msg581485.html
> [3] https://patchwork.kernel.org/patch/9540605/
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
