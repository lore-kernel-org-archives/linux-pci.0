Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:13952 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTP5z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 11:57:55 -0400
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Tal Gilboa <talgi@mellanox.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: RE: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel
 log
Date: Tue, 20 Mar 2018 15:57:53 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882CFFA64@ORSMSX115.amr.corp.intel.com>
References: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
 <1520856370-15404-4-git-send-email-talgi@mellanox.com>
 <20180320140527.GL77194@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180320140527.GL77194@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, March 20, 2018 7:05 AM
> To: Tal Gilboa <talgi@mellanox.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Linux PCI <linux-
> pci@vger.kernel.org>; Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel log
> 
> [+cc Jacob]
> 
> >  /**
> > + * pcie_print_link_status - Reports the PCI device's link speed and width.
> > + * @dev: PCI device to query
> > + *
> > + * This function checks whether the PCI device current speed and width are
> equal
> > + * to the maximum PCI device capabilities.
> > + */
> > +void pcie_print_link_status(struct pci_dev *dev)
> > +{
> > +	enum pcie_link_width width, width_cap;
> > +	enum pci_bus_speed speed, speed_cap;
> > +
> > +	pcie_get_speed_cap(dev, &speed_cap);
> > +	pcie_get_width_cap(dev, &width_cap);
> > +	pcie_get_minimum_link(dev, &speed, &width);
> > +
> > +	if (speed == speed_cap && width == width_cap)
> > +		pci_info(dev, "%s x%d link\n", PCIE_SPEED2STR(speed), width);
> > +	else
> > +		pci_info(dev, "%s x%d link (capable of %s x%d)\n",
> > +			 PCIE_SPEED2STR(speed), width,
> > +			 PCIE_SPEED2STR(speed_cap), width_cap);
> 
> I think pcie_get_minimum_link() is misleading.  This new use of
> it is very similar to the existing uses, but I think we should clean
> this up before using it in more places.
> 

Based on your outline here, I completely agree!

> pcie_get_minimum_link() finds the minimum speed and minimum link width
> (separately) across all the links in the path, and I don't think
> that's what we really want.  What we *want* is the total bandwidth
> available to the device, because we're trying to learn if the device
> is capable of more than the fabric can deliver.
> 
> That means we want to look at all the links in the path leading to the
> device and find the link with the lowest bandwidth, i.e., width *
> speed.  Obviously this is not necessarily the link with the fewest
> lanes or the lowest link speed.
> 

Wow, yep you're right! That is a very subtle difference, and one I wish I'd been more aware of prior to writing the get_minimum_link code. I *intended* the code to give a minimum bandwidth calculation. IMHO, this is a bug in pcie_get_minimum_link, and should be fixed there.

> I hinted at this before, but you thought it would result in more
> questions than answers [1], and I failed to continue the conversation.
> 
> Let's continue it now :)
> 
> Here are some straw-man interfaces to return a device's capabilities
> and the available bandwidth in MB/s:
> 
>   unsigned int pcie_bandwidth_capable(struct pci_dev *dev,
>                                       enum pci_bus_speed *speed,
>                                       enum pcie_link_width *width);
>   unsigned int pcie_bandwidth_available(struct pci_dev *dev);
> 
> Then we can compare the result with what "dev" is capable of, e.g.,
> 
>   my_bw = pcie_bandwidth_capable(dev, &my_speed, &my_width);
>   avail_bw = pcie_bandwidth_available(dev);
>   if (avail_bw >= my_bw)
>     pci_info(dev, "%d MB/s available bandwidth (%s x%d link)\n",
>              my_bw, PCIE_SPEED2STR(my_speed), my_width);
>   else
>     pci_info(dev, "%d MB/s available bandwidth (capable of %d MB/s, %s x%d)\n",
>              avail_bw, my_bw, PCIE_SPEED2STR(my_speed), my_width);
> 
> Using GB/s would be nicer; I lazily used MB/s to avoid dealing with
> decimals, e.g., 2.5GB/s.

MBs is better, imo for the same reason.

I like the names here, they're easier to understand. Additionally, we can deprecate and remove pcie_get_minimum_link after fixing up the uses, since this functionality is what the pcie_get_minimum_link was *supposed* to provide.

Thanks,
Jake

> 
> [1] https://lkml.kernel.org/r/46f54e24-e65e-08c6-60b3-
> e34ffd79e91a@mellanox.com
