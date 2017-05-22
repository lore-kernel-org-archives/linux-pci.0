Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 22 May 2017 12:31:16 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH V4 3/4] ACPI/IORT: Ignore all errors except EPROBE_DEFER
Message-ID: <20170522113116.GB10449@red-moon>
References: <1495119257-26724-1-git-send-email-sricharan@codeaurora.org>
 <1495119257-26724-3-git-send-email-sricharan@codeaurora.org>
 <20170522103730.GB7553@red-moon>
 <ffb088d6-e40f-7a7d-dafb-e52dc86704fc@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <ffb088d6-e40f-7a7d-dafb-e52dc86704fc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 laurent.pinchart@ideasonboard.com, frowand.list@gmail.com,
 m.szyprowski@samsung.com, linux-arch@vger.kernel.org, tn@semihalf.com,
 joro@8bytes.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org,
 geert@linux-m68k.org, linux-pci@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 j.neuschaefer@gmx.net, robh+dt@kernel.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 04:35:43PM +0530, Sricharan R wrote:
> Hi Lorenzo,
> 
> On 5/22/2017 4:07 PM, Lorenzo Pieralisi wrote:
> > Hi Sricharan,
> > 
> > On Thu, May 18, 2017 at 08:24:16PM +0530, Sricharan R wrote:
> >> While deferring the probe of IOMMU masters, xlate and
> >> add_device callbacks called from iort_iommu_configure
> >> can pass back error values like -ENODEV, which means
> >> the IOMMU cannot be connected with that master for real
> >> reasons. Before the IOMMU probe deferral, all such errors
> >> were ignored. Now all those errors are propagated back,
> >> killing the master's probe for such errors. Instead ignore
> >> all the errors except EPROBE_DEFER, which is the only one
> >> of concern and let the master work without IOMMU, thus
> >> restoring the old behavior.
> >>
> >> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> ---
> >> [V4] Added this patch newly.
> >>
> >>  drivers/acpi/arm64/iort.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >> index c5fecf9..16e101f 100644
> >> --- a/drivers/acpi/arm64/iort.c
> >> +++ b/drivers/acpi/arm64/iort.c
> >> @@ -782,6 +782,12 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >>  	if (err)
> >>  		ops = ERR_PTR(err);
> >>  
> >> +	/* Ignore all other errors apart from EPROBE_DEFER */
> >> +	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> >> +		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> >> +		ops = NULL;
> >> +	}
> >> +
> >>  	return ops;
> >>  }
> >>  
> > 
> > It is getting a bit convoluted. Is not it better to propagate the
> > error back and let acpi_dma_configure() make a decision accordingly ?
> > 
> 
> ok, I was trying to keep it in same way as DT, where of_dma_configure
> (here acpi_dma_configure) calls of_iommu_configure(here iort_iommu_configure)
> which ends up doing the check. So will have to be changed in both places
> for symmetry.
> 
> > Something like:
> > 
> > -- >8 --
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index e39ec7b..3a10d757 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> >  	iort_set_dma_mask(dev);
> >  
> >  	iommu = iort_iommu_configure(dev);
> > -	if (IS_ERR(iommu))
> > -		return PTR_ERR(iommu);
> > +	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
> > +		return -EPROBE_DEFER;
> 
> In case of other errors apart from EPROBE_DEFER,
> iommu = NULL should be set, before passing it on to
> arch_setup_dma_ops.

Ah yes, sorry, that makes it uglier :(

Point is, it does not make sense to me to have of/acpi_dma_configure()
check a return code with (IS_ERR()) whilst we know the only error
code you are allowed to handle is -EPROBE_DEFER, while at it it is
better to make the -EPROBE_DEFER check explicit (otherwise it may
seem that of/acpi_dma_configure() can handle an error code that
is different from -EPROBE_DEFER - but they don't), no big deal either
way though.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
