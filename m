Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 30 May 2017 10:06:52 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, robin.murphy@arm.com,
        will.deacon@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, lenb@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        nwatters@codeaurora.org, linux@armlinux.org.uk
Subject: Re: [PATCH v6 3/6] ACPI/IORT: Ignore all errors except EPROBE_DEFER
Message-ID: <20170530090652.GA1767@red-moon>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
 <1495892865-9506-3-git-send-email-sricharan@codeaurora.org>
 <1564836.5iBbgoacpH@aspire.rjw.lan>
 <68bc9be5-22df-e7af-3fcd-182e935e681c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68bc9be5-22df-e7af-3fcd-182e935e681c@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 29, 2017 at 10:36:42AM +0530, Sricharan R wrote:
> Hi Rafael,
> 
> On 5/28/2017 12:48 AM, Rafael J. Wysocki wrote:
> > On Saturday, May 27, 2017 07:17:42 PM Sricharan R wrote:
> >> While deferring the probe of IOMMU masters, xlate and
> >> add_device callbacks called from iort_iommu_configure
> >> can pass back error values like -ENODEV, which means
> >> the IOMMU cannot be connected with that master for real
> >> reasons. Before the IOMMU probe deferral, all such errors
> >> were ignored. Now all those errors are propagated back,
> >> killing the master's probe for such errors. Instead ignore
> >> all the errors except EPROBE_DEFER, which is the only one
> >> of concern and let the master work without IOMMU, thus
> >> restoring the old behavior. Also make explicit that
> >> acpi_dma_configure handles only -EPROBE_DEFER from
> >> iort_iommu_configure.
> >>
> >> Fixes: 5a1bb638d567 ("drivers: acpi: Handle IOMMU lookup failure with deferred probing or error")
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> ---
> >>  drivers/acpi/arm64/iort.c | 6 ++++++
> >>  drivers/acpi/scan.c       | 4 ++--
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
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
> >> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> index e39ec7b..3a10d757 100644
> >> --- a/drivers/acpi/scan.c
> >> +++ b/drivers/acpi/scan.c
> >> @@ -1371,8 +1371,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> >>  	iort_set_dma_mask(dev);
> >>  
> >>  	iommu = iort_iommu_configure(dev);
> >> -	if (IS_ERR(iommu))
> >> -		return PTR_ERR(iommu);
> >> +	if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
> >> +		return -EPROBE_DEFER;
> >>  
> >>  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> >>  	/*
> >>
> > 
> > ACK for the scan.c change and I'm assuming this to go in via ARM64.
> > 
> 
> Thanks for the ACK, should go through the IOMMU tree, since this fixes the IOMMU probe deferral
> that got merged through it.

Yes and it would be good to get them merged for -rc4 given that there
are bug fixes there, I agree the IOMMU tree is the way they should
go upstream.

Lorenzo
