Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUoLp1oVT_=NG8HS-jgG6AhOeVUsGgu7fLbGY+7A+0cOg@mail.gmail.com>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1486136933-20328-8-git-send-email-sricharan@codeaurora.org>
 <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
 <2bfd11dc-9f94-2b69-7b03-c640e53155e1@arm.com>
 <26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
 <CAMuHMdUoLp1oVT_=NG8HS-jgG6AhOeVUsGgu7fLbGY+7A+0cOg@mail.gmail.com>
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 May 2017 18:22:24 +0900
Message-ID: <CANqRtoSEwdoufUxP-Rm=qZJ7G8V3ow5F0ggV3tALrfiRad+j4Q@mail.gmail.com>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
To: Geert Uytterhoeven <geert@linux-m68k.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Sricharan R <sricharan@codeaurora.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 okaya@codeaurora.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Hanjun Guo <hanjun.guo@linaro.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, tn@semihalf.com,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Geert, everyone,

On Fri, May 5, 2017 at 10:23 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Sricharan, Robin,
>
> On Wed, May 3, 2017 at 12:24 PM, Sricharan R <sricharan@codeaurora.org> wrote:
>> On 5/3/2017 3:24 PM, Robin Murphy wrote:
>>> On 02/05/17 19:35, Geert Uytterhoeven wrote:
>>>> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R <sricharan@codeaurora.org> wrote:
>>>>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>>>
>>>>> Failures to look up an IOMMU when parsing the DT iommus property need to
>>>>> be handled separately from the .of_xlate() failures to support deferred
>>>>> probing.
>>>>>
>>>>> The lack of a registered IOMMU can be caused by the lack of a driver for
>>>>> the IOMMU, the IOMMU device probe not having been performed yet, having
>>>>> been deferred, or having failed.
>>>>>
>>>>> The first case occurs when the device tree describes the bus master and
>>>>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>>>>> or the device driver has not been compiled in. Return NULL, the caller
>>>>> will configure the device without an IOMMU.
>>>>>
>>>>> The second and third cases are handled by deferring the probe of the bus
>>>>> master device which will eventually get reprobed after the IOMMU.
>>>>>
>>>>> The last case is currently handled by deferring the probe of the bus
>>>>> master device as well. A mechanism to either configure the bus master
>>>>> device without an IOMMU or to fail the bus master device probe depending
>>>>> on whether the IOMMU is optional or mandatory would be a good
>>>>> enhancement.
>>>>>
>>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
>>>> As the IOMMU nodes in DT are not yet enabled, all devices having iommus
>>>> properties in DT now fail to probe.
>>>
>>> How exactly do they fail to probe? Per d7b0558230e4, if there are no ops
>>> registered then they should merely defer until we reach the point of
>>> giving up and ignoring the IOMMU. Is it just that you have no other
>>> late-probing drivers or post-init module loads to kick the deferred
>>> queue after that point? I did try to find a way to explicitly kick it
>>> from a suitably late initcall, but there didn't seem to be any obvious
>>> public interface - anyone have any suggestions?
>>>
>>> I think that's more of a general problem with the probe deferral
>>> mechanism itself (I've seen the same thing happen with some of the
>>> CoreSight stuff on Juno due to the number of inter-component
>>> dependencies) rather than any specific fault of this series.
>
> I had a deeper look into the issue.
>
> What changed, is that of_dma_configure() now returns an error code,
> and dma_configure() looks at it.
>
> Actually there are two failure modes:
>   1. Devices with an iommus property pointing to a disabled IOMMU node.
>      These return -EPROBE_DEFER, and are now retried forever.
>   2. Devices that are blacklisted in the IPMMU driver, as we don't want to
>      use them with an IOMMU yet.
>      These return -ENODEV, due to ipmmu_of_xlate_dma().
>
>> I was thinking of an additional check like below to avoid the
>> situation ?
>>
>> From 499b6e662f60f23740b8880882b0a16f16434501 Mon Sep 17 00:00:00 2001
>> From: Sricharan R <sricharan@codeaurora.org>
>> Date: Wed, 3 May 2017 13:16:59 +0530
>> Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
>>
>> While returning EPROBE_DEFER for iommu masters
>> take in to account of iommu nodes that could be
>> marked in DT as 'status=disabled', in which case
>> simply return NULL and let the master's probe
>> continue rather than deferring.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  drivers/iommu/of_iommu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 9f44ee8..e6e9bec 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
>>
>>         ops = iommu_ops_from_fwnode(fwnode);
>>         if ((ops && !ops->of_xlate) ||
>> +           !of_device_is_available(iommu_spec->np) ||
>>             (!ops && !of_iommu_driver_present(iommu_spec->np)))
>>                 return NULL;
>
> Thanks, this fixes the first class of failures.
>
> The second class can be worked around using:
>
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -196,6 +196,11 @@ static const struct iommu_ops
>                 ops = of_iommu_xlate(dev, &iommu_spec);
>                 of_node_put(iommu_spec.np);
>                 idx++;
> +               if (PTR_ERR(ops) == -ENODEV) {
> +                       dev_info(dev, "%s: Ignoring -ENODEV => NULL\n",
> +                                __func__);
> +                       return NULL;
> +               }
>                 if (IS_ERR_OR_NULL(ops))
>                         break;
>         }
>
> but obviously that's too hackish to apply...
> Magnus, do you have a suggestion?

Thanks for your efforts guys!

I've recently been working on up-porting the IPMMU patches and
addressing review comments. Now with my local driver stack on top of
v4.12-rc (a95cfad) I did not notice these issues initially since I
only tested devices with IPMMU enabled. Once these issues were pointed
out to me by Geert I have now reproduced the 64-bit ARM specific ones
on r8a7796 Salvator-X.

On my r8a7796 platform I'm using the following IOMMU and DMA Engine devices:

IOMMU device IPMMU-DS0 - Connected to SYS-DMAC0
IOMMU device IPMMU-DS1 - Connected to SYS-DMAC1 and SYS-DMAC2
IOMMU device IPMMU-MM - Root device serving IPMMU-DS0 and IPMMU-DS1

For testing the serial port SCIF1 is used with DMA Engine devices
SYS-DMAC1 or SYS-DMAC2.

The software environment is configured as follows:
- The DTS comes with all devices above enabled except IPMMU-DS0 which
comes with status = "disabled".
- The IPMMU driver is during run time only allowing use of SYS-DMAC2.
For other devices ->of_xlate() returns -ENODEV.

The above used to work just fine with v4.11 or earlier.

My observations for v4.12-rc:

1) Default state for a95cfad

The devices SYS-DMAC0 and SYS-DMAC1 will never probe. However SYS-DMAC2 is fine.

2) After applying "[PATCH] iommu: of: Fix check for returning EPROBE_DEFER" [1]

This fixes SYS-DMAC0 that now probes and operates without IPMMU-DS0 as
expected. Same as v4.11 or earlier.

3) After also applying "[PATCH] of: iommu: Ignore all errors except
EPROBE_DEFER" [2]

This fixes SYS-DMAC1 that now probes and operates without IPMMU-DS1 as
expected. Same as v4.11 or earlier.

With fix [1] and [2] things seem back to normal. Unless I'm mistaken
it also seems that [1] allows me to drop the similar patch "[PATCH/RFC
v2 1/4] iommu/of: Skip IOMMU devices disabled in DT".

Thanks for your help.

Cheers,

/ magnus


[1] https://lkml.org/lkml/2017/5/16/25
[2] https://www.spinics.net/lists/arm-kernel/msg581485.html
[3] https://patchwork.kernel.org/patch/9540605/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
