Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
	bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	hanjun.guo@linaro.org, davem@davemloft.net,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 8/9] PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
Date: Wed, 18 Nov 2015 22:24:52 +0100
Message-ID: <7324830.G6XBOApVhh@vostro.rjw.lan>
In-Reply-To: <564CAD63.3020306@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com> <3822315.uJPjk3L2zB@wuerfel> <564CAD63.3020306@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 18, 2015 10:54:59 AM Suravee Suthikulanit wrote:
> Hi All,
> 
> On 11/18/2015 6:41 AM, Arnd Bergmann wrote:
> > On Wednesday 18 November 2015 12:00:32 Robin Murphy wrote:
> >> On 17/11/15 15:00, Robin Murphy wrote:
> >>> On 28/10/15 22:50, Suravee Suthikulpanit wrote:
> >>>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >>>> Acked-by: Rob Herring <robh+dt@kernel.org>
> >>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> >> [...]
> >>>> +/**
> >>>> + * pci_dma_configure - Setup DMA configuration
> >>>> + * @dev: ptr to pci_dev struct of the PCI device
> >>>> + *
> >>>> + * Function to update PCI devices's DMA configuration using the same
> >>>> + * info from the OF node of host bridge's parent (if any).
> >>>> + */
> >>>> +static void pci_dma_configure(struct pci_dev *dev)
> >>>> +{
> >>>> +    struct device *bridge = pci_get_host_bridge_device(dev);
> >>>> +
> >>>> +    if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> >>>
> >>> Previously I was seeing of_dma_configure, and thus of_iommu_configure,
> >>> called for every PCI device on Juno. The check above now prevents this
> >>> happening, since the PCI devices are probed directly from the bus and
> >>> don't have OF nodes of their own. They now get left in some
> >>> half-configured state where arch_setup_dma_ops isn't called either.
> >>
> >> Just to follow up on that, Arnd's patch to tidy up dma_get_ops (now
> >> queued[1]) makes this even worse, since preventing arch_setup_dma_ops
> >> being called means the PCI devices now get the dummy DMA ops which leave
> >> the drivers failing to probe at all, IOMMU hacks or not
> >
> > Ok, glad we found that with my patch then. We really have to
> > configure the DMA (offset/size/coherency/iommu) for all devices that might
> > be masters, otherwise things can randomly go wrong.
> >
> > 	ARnd
> 
> Robin is correct. Thanks for catching the bug. Rafael, do you want me to 
> submit just the fixed-up patch on top of what we had earlier. Or do you 
> want a new revision (V6)?

This is in 4.4-rc1, right?  So new revisions surely won't work, will they?

Thanks,
Rafael

