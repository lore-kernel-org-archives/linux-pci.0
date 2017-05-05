Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1486136933-20328-8-git-send-email-sricharan@codeaurora.org>
 <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
 <2bfd11dc-9f94-2b69-7b03-c640e53155e1@arm.com>
 <26defadf-6380-4af4-6323-b51198376bc1@codeaurora.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 May 2017 15:23:40 +0200
Message-ID: <CAMuHMdUoLp1oVT_=NG8HS-jgG6AhOeVUsGgu7fLbGY+7A+0cOg@mail.gmail.com>
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
To: Sricharan R <sricharan@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 okaya@codeaurora.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Hanjun Guo <hanjun.guo@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 tn@semihalf.com,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sricharan, Robin,

On Wed, May 3, 2017 at 12:24 PM, Sricharan R <sricharan@codeaurora.org> wrote:
> On 5/3/2017 3:24 PM, Robin Murphy wrote:
>> On 02/05/17 19:35, Geert Uytterhoeven wrote:
>>> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R <sricharan@codeaurora.org> wrote:
>>>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>>
>>>> Failures to look up an IOMMU when parsing the DT iommus property need to
>>>> be handled separately from the .of_xlate() failures to support deferred
>>>> probing.
>>>>
>>>> The lack of a registered IOMMU can be caused by the lack of a driver for
>>>> the IOMMU, the IOMMU device probe not having been performed yet, having
>>>> been deferred, or having failed.
>>>>
>>>> The first case occurs when the device tree describes the bus master and
>>>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>>>> or the device driver has not been compiled in. Return NULL, the caller
>>>> will configure the device without an IOMMU.
>>>>
>>>> The second and third cases are handled by deferring the probe of the bus
>>>> master device which will eventually get reprobed after the IOMMU.
>>>>
>>>> The last case is currently handled by deferring the probe of the bus
>>>> master device as well. A mechanism to either configure the bus master
>>>> device without an IOMMU or to fail the bus master device probe depending
>>>> on whether the IOMMU is optional or mandatory would be a good
>>>> enhancement.
>>>>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>
>>> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
>>> As the IOMMU nodes in DT are not yet enabled, all devices having iommus
>>> properties in DT now fail to probe.
>>
>> How exactly do they fail to probe? Per d7b0558230e4, if there are no ops
>> registered then they should merely defer until we reach the point of
>> giving up and ignoring the IOMMU. Is it just that you have no other
>> late-probing drivers or post-init module loads to kick the deferred
>> queue after that point? I did try to find a way to explicitly kick it
>> from a suitably late initcall, but there didn't seem to be any obvious
>> public interface - anyone have any suggestions?
>>
>> I think that's more of a general problem with the probe deferral
>> mechanism itself (I've seen the same thing happen with some of the
>> CoreSight stuff on Juno due to the number of inter-component
>> dependencies) rather than any specific fault of this series.

I had a deeper look into the issue.

What changed, is that of_dma_configure() now returns an error code,
and dma_configure() looks at it.

Actually there are two failure modes:
  1. Devices with an iommus property pointing to a disabled IOMMU node.
     These return -EPROBE_DEFER, and are now retried forever.
  2. Devices that are blacklisted in the IPMMU driver, as we don't want to
     use them with an IOMMU yet.
     These return -ENODEV, due to ipmmu_of_xlate_dma().

> I was thinking of an additional check like below to avoid the
> situation ?
>
> From 499b6e662f60f23740b8880882b0a16f16434501 Mon Sep 17 00:00:00 2001
> From: Sricharan R <sricharan@codeaurora.org>
> Date: Wed, 3 May 2017 13:16:59 +0530
> Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
>
> While returning EPROBE_DEFER for iommu masters
> take in to account of iommu nodes that could be
> marked in DT as 'status=disabled', in which case
> simply return NULL and let the master's probe
> continue rather than deferring.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/of_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 9f44ee8..e6e9bec 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
>
>         ops = iommu_ops_from_fwnode(fwnode);
>         if ((ops && !ops->of_xlate) ||
> +           !of_device_is_available(iommu_spec->np) ||
>             (!ops && !of_iommu_driver_present(iommu_spec->np)))
>                 return NULL;

Thanks, this fixes the first class of failures.

The second class can be worked around using:

--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -196,6 +196,11 @@ static const struct iommu_ops
                ops = of_iommu_xlate(dev, &iommu_spec);
                of_node_put(iommu_spec.np);
                idx++;
+               if (PTR_ERR(ops) == -ENODEV) {
+                       dev_info(dev, "%s: Ignoring -ENODEV => NULL\n",
+                                __func__);
+                       return NULL;
+               }
                if (IS_ERR_OR_NULL(ops))
                        break;
        }

but obviously that's too hackish to apply...
Magnus, do you have a suggestion?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
