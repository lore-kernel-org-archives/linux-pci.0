Return-Path: <SRS0=KP1q=YL=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=KP1q=YL=intel.com=ashok.raj@kernel.org>
Date: Tue, 27 Dec 2016 19:21:39 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	g@bhelgaas-glaptop.roam.corp.google.com, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	rwright@hpe.com, ashok.raj@intel.com
Subject: Re: possible dmar_init_reserved_ranges() error
Message-ID: <20161228032139.GA254916@otc-nc-03>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
 <20161227234417.GA24366@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161227234417.GA24366@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Dec 27, 2016 at 05:44:17PM -0600, Bjorn Helgaas wrote:
> 
>   dmar_init_reserved_ranges()
>   {
>     ...
>     for_each_pci_dev(pdev) {
>       for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>         r = &pdev->resource[i];
>         reserve_iova(r)
> 
> But I assume it's possible to have more than one IOTLB in a system,

You meant IOMMU?  

> so you could have some PCI devices under one IOTLB and others under a
> different IOTLB.  So it seems like we should reserve only the IOVA
> space used by the devices under *this* IOTLB.

Yes, it seems we are aggressive reserving all pci devices bars's when 
potentially you need to only reserve ranges for the IOMMU under which 
this pci device exist. We also need to make sure devices under the
INCLUDE_ALL is handled correctly. 
> 
> Also, we may hot-add a device under the IOTLB, and I don't see where
> we reserve the IOVA space it uses.
> 
> I think the best thing to do would be to reserve the host bridge
> apertures related to each IOTLB.  That would resolve both questions.
> It looks like iova_reserve_pci_windows() does this in the
> iommu_dma_init_domain() path.

This sounds reasonable, if we can reserve from the host bridge apertures 
it should take care of hot-plug cases as well, and should simply how the
reservation is made.

Cheers,
Ashok
