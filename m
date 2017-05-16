Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: sricharan@codeaurora.org
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
Date: Tue, 16 May 2017 17:06:10 +0300
Message-ID: <2288554.Av5LKGd7Dv@avalon>
In-Reply-To: <71c52ac6c5b7839388ebe1608804da45@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1924197.MWBQ7kvoOo@avalon> <71c52ac6c5b7839388ebe1608804da45@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: okaya@codeaurora.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Magnus Damm <magnus.damm@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, tn@semihalf.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm-owner@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sricharan,

On Tuesday 16 May 2017 19:10:03 sricharan@codeaurora.org wrote:
> On 2017-05-16 12:47, Laurent Pinchart wrote:
> > On Tuesday 16 May 2017 07:53:57 sricharan@codeaurora.org wrote:
> >> On 2017-05-16 03:04, Laurent Pinchart wrote:
> >>> On Monday 15 May 2017 23:37:16 Laurent Pinchart wrote:
> >>>> On Wednesday 03 May 2017 15:54:59 Sricharan R wrote:
> >>>>> On 5/3/2017 3:24 PM, Robin Murphy wrote:
> >>>>>> On 02/05/17 19:35, Geert Uytterhoeven wrote:
> >>>>>>> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R wrote:
> >>>>>>>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >>>>>>>> 
> >>>>>>>> Failures to look up an IOMMU when parsing the DT iommus property
> >>>>>>>> need to be handled separately from the .of_xlate() failures to
> >>>>>>>> support deferred probing.
> >>>>>>>> 
> >>>>>>>> The lack of a registered IOMMU can be caused by the lack of a
> >>>>>>>> driver for the IOMMU, the IOMMU device probe not having been
> >>>>>>>> performed yet, having been deferred, or having failed.
> >>>>>>>> 
> >>>>>>>> The first case occurs when the device tree describes the bus
> >>>>>>>> master and IOMMU topology correctly but no device driver exists for
> >>>>>>>> the IOMMU yet or the device driver has not been compiled in. Return
> >>>>>>>> NULL, the caller will configure the device without an IOMMU.
> >>>>>>>> 
> >>>>>>>> The second and third cases are handled by deferring the probe of
> >>>>>>>> the bus master device which will eventually get reprobed after the
> >>>>>>>> IOMMU.
> >>>>>>>> 
> >>>>>>>> The last case is currently handled by deferring the probe of the
> >>>>>>>> bus master device as well. A mechanism to either configure the bus
> >>>>>>>> master device without an IOMMU or to fail the bus master device
> >>>>>>>> probe depending on whether the IOMMU is optional or mandatory would
> >>>>>>>> be a good enhancement.
> >>>>>>>> 
> >>>>>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>>>>>> Signed-off-by: Laurent Pichart
> >>>>>>>> <laurent.pinchart+renesas@ideasonboard.com>
> >>>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>>>>>> 
> >>>>>>> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
> >>>>>>> As the IOMMU nodes in DT are not yet enabled, all devices having
> >>>>>>> iommus properties in DT now fail to probe.
> >>>>>> 
> >>>>>> How exactly do they fail to probe? Per d7b0558230e4, if there are no
> >>>>>> ops registered then they should merely defer until we reach the
> >>>>>> point of giving up and ignoring the IOMMU. Is it just that you have
> >>>>>> no other late-probing drivers or post-init module loads to kick the
> >>>>>> deferred queue after that point? I did try to find a way to
> >>>>>> explicitly kick it from a suitably late initcall, but there didn't
> >>>>>> seem to be any obvious public interface - anyone have any
> >>>>>> suggestions?
> >>>>>> 
> >>>>>> I think that's more of a general problem with the probe deferral
> >>>>>> mechanism itself (I've seen the same thing happen with some of the
> >>>>>> CoreSight stuff on Juno due to the number of inter-component
> >>>>>> dependencies) rather than any specific fault of this series.
> >>>>> 
> >>>>> I was thinking of an additional check like below to avoid the
> >>>>> situation ?
> >>>>> 
> >>>>> From 499b6e662f60f23740b8880882b0a16f16434501 Mon Sep 17 00:00:00
> >>>>> 2001
> >>>>> From: Sricharan R <sricharan@codeaurora.org>
> >>>>> Date: Wed, 3 May 2017 13:16:59 +0530
> >>>>> Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
> >>>>> 
> >>>>> While returning EPROBE_DEFER for iommu masters
> >>>>> take in to account of iommu nodes that could be
> >>>>> marked in DT as 'status=disabled', in which case
> >>>>> simply return NULL and let the master's probe
> >>>>> continue rather than deferring.
> >>>>> 
> >>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >>>>> ---
> >>>>> 
> >>>>>  drivers/iommu/of_iommu.c | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>> 
> >>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >>>>> index 9f44ee8..e6e9bec 100644
> >>>>> --- a/drivers/iommu/of_iommu.c
> >>>>> +++ b/drivers/iommu/of_iommu.c
> >>>>> @@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct
> >>>>> device_node *np)
> >>>>> 
> >>>>>         ops = iommu_ops_from_fwnode(fwnode);
> >>>>>         if ((ops && !ops->of_xlate) ||
> >>>>> +           !of_device_is_available(iommu_spec->np) ||
> >>>>>             (!ops && !of_iommu_driver_present(iommu_spec->np)))
> >>>>>                 return NULL;
> >>>> 
> >>>> This looks good to me, but won't be enough. The ipmmu-vmsa driver in
> >>>> v4.12-rc1 doesn't call iommu_device_register() and thus won't be found
> >>>> by iommu_ops_from_fwnode(). Furthermore, it doesn't
> >>>> IOMMU_OF_DECLARE(),
> >>>> and thus will always be considered as absent.
> >>>> 
> >>>> I agree that the ipmmu-vmsa driver needs to be fixed, but it would
> >>>> have been nice to check existing IOMMU drivers before merging this
> >>>> patch series...
> >>> 
> >>> Please pardon the question, but has this patch series been tested on
> >>> ARM32 ?
> >>> 
> >>> When the device is probed the arch_setup_dma_ops() function is called.
> >>> It sets the device's dma_ops and the mapping (in
> >>> __arm_iommu_attach_device()). If probe is deferred,
> >>> arch_teardown_dma_ops() is called which in turn calls
> >>> arch_teardown_dma_ops(). This removes the mapping but doesn't touch the
> >>> dma_ops. The next time the device is probed, arch_setup_dma_ops() bails
> >>> out immediately as the dma_ops are already set, leaving us with a
> >>> device bound to IOMMU operations but with no mapping. This oopses later
> >>> as soon as the kernel tries to map memory for the device through the
> >>> IOMMU.
> >> 
> >> Resetting the dma_ops for arm32 was added in this patch [1], which I
> >> missed to send in the original series, but now have added to Russell's
> >> patch tracking system.
> > 
> > Thank you. I fear that won't be enough though.
> > 
> >> [1] https://patchwork.kernel.org/patch/9434105/
> > 
> > Quoting the patch:
> >
> >> arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
> >> ,dma_ops should be cleared in the teardown path. Otherwise
> >> this causes problem when the probe of device is retried after
> >> being deferred. The device's iommu structures are cleared
> >> after EPROBEDEFER error, but on the next try dma_ops will still
> >> be set to old value, which is not right.
> >> 
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >> 
> >>   arch/arm/mm/dma-mapping.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> >> index ab4f745..a40f03e 100644
> >> --- a/arch/arm/mm/dma-mapping.c
> >> +++ b/arch/arm/mm/dma-mapping.c
> >> @@ -2358,6 +2358,7 @@ static void arm_teardown_iommu_dma_ops(struct
> >> device *dev)
> > 
> >>   	__arm_iommu_detach_device(dev);
> >>   	arm_iommu_release_mapping(mapping);
> >> +	set_dma_ops(dev, NULL);
> >>   }
> >>   #else
> > 
> > The subject mentions arch_teardown_dma_ops(), which I think is correct,
> > but the patch adds the set_dma_ops() call to arm_teardown_iommu_dma_ops().
> > 
> > However, the situation is perhaps more complex. Note the check at the
> > 
> > beginning of arch_setup_dma_ops():
> > 	/*
> > 	 * Don't override the dma_ops if they have already been set. Ideally
> > 	 * this should be the only location where dma_ops are set, remove this
> > 	 * check when all other callers of set_dma_ops will have disappeared.
> > 	 */
> > 	if (dev->dma_ops)
> > 		return;
> > 
> > If you set the dma_ops to NULL in arm_teardown_iommu_dma_ops() or
> > arch_teardown_dma_ops(), the next call to arch_setup_dma_ops() will
> > override them. To be safe you should only set them to NULL if they have
> > been set by arch_setup_dma_ops(). More than that, arch_teardown_dma_ops()
> > should probably not call arm_teardown_iommu_dma_ops() at all if the
> > dma_ops were set by arm_iommu_attach_device() and not
> > arch_teardown_dma_ops(). One option would be to add a field to struct
> > dev_archdata to store that information. To avoid growing the structure,
> > which is embedded in every struct device, you could possibly turn the
> > dma_coherent bool into a bitfield.
> > 
> > @@ -19,7 +19,8 @@ struct dev_archdata {
> >  #ifdef CONFIG_XEN
> >  	const struct dma_map_ops *dev_dma_ops;
> >  #endif
> > -	bool dma_coherent;
> > +	bool dma_coherent:1;
> > +	bool dma_ops_setup:1;
> >  };
> >  
> >  struct omap_device;
> > 
> > I haven't checked, however, whether the dma_coherent field would need
> > to be accessed atomically, so this might be a bad idea.
> > 
> > Last but not least, a fix must be merged in v4.12, and the sooner the
> > better.
> 
> ho, yet another combination. This seems to be a problem with exynos_iommu,
> ipmmu-vmsa, mtk_iommu_v1 which calls the arm_iommu_attach_device with its
> own custom mapping. They are calling arm_iommu_attach_device from the
> add_device callback and that is not always replayed when the reprobe happens
> and these archs are storing the old mapping data in private structures which
> might not be cleared in the teardown path.

Yes, I know, it's messy :-/ There's a handful of non-IOMMU drivers calling 
arm_iommu_attach_device() directly too. All these should be fixed, but in the 
meantime, let's try not to break them.

> I will post the fix that you have suggested.

Thank you. You might want to use an unsigned int bitfield instead of a bool 
bitfield as Sakari suggested. It would be nice to check the code setting the 
dma_coherent field to make sure there will be no race with code setting the 
new dma_ops_setup field (which might not be the best name, feel free to rename 
it).

I have successfully test the patch, let me know if there's anything else I can 
do to help.

> >>> I might be missing something obvious, but I don't see how this can
> >>> work.
> >>> 
> >>>>>>> This can be fixed by either:
> >>>>>>>   - Disabling CONFIG_IPMMU_VMSA, or
> >>>>>>>   - Reverting commit 7b07cbefb68d486f (but keeping "int ret = 0;").
> >>>>>>> 
> >>>>>>> Note that this was a bit hard to investigate, as R-Car Gen3 support
> >>>>>>> wasn't upstreamed yet, so bisection pointed to a merge commit.

-- 
Regards,

Laurent Pinchart


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
