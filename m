Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753050AbeCUTsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 15:48:00 -0400
Date: Wed, 21 Mar 2018 14:47:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel
 log
Message-ID: <20180321194758.GC38649@bhelgaas-glaptop.roam.corp.google.com>
References: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
 <1520856370-15404-4-git-send-email-talgi@mellanox.com>
 <20180320140527.GL77194@bhelgaas-glaptop.roam.corp.google.com>
 <c513c09c-69d6-3a01-b183-496622daebdc@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c513c09c-69d6-3a01-b183-496622daebdc@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 09:43:48AM +0200, Tal Gilboa wrote:
> On 3/20/2018 4:05 PM, Bjorn Helgaas wrote:
> > [+cc Jacob]
> > 
> > On Mon, Mar 12, 2018 at 02:06:08PM +0200, Tal Gilboa wrote:
> > > Add pcie_print_link_status() function for querying and verifying
> > > a PCI device link status. The PCI speed and width are reported
> > > in kernel log.
> > > This provides a unified method for all PCI devices to
> > > report status and issues, instead of each device reporting in a
> > > different way, using different code.
> > > 
> > > Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> > > Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> > > ---
> > >   drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
> > >   include/linux/pci.h |  1 +
> > >   2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 48b9fd6..ac876c4 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5229,6 +5229,31 @@ int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
> > >   EXPORT_SYMBOL(pcie_get_width_cap);
> > >   /**
> > > + * pcie_print_link_status - Reports the PCI device's link speed and width.
> > > + * @dev: PCI device to query
> > > + *
> > > + * This function checks whether the PCI device current speed and width are equal
> > > + * to the maximum PCI device capabilities.
> > > + */
> > > +void pcie_print_link_status(struct pci_dev *dev)
> > > +{
> > > +	enum pcie_link_width width, width_cap;
> > > +	enum pci_bus_speed speed, speed_cap;
> > > +
> > > +	pcie_get_speed_cap(dev, &speed_cap);
> > > +	pcie_get_width_cap(dev, &width_cap);
> > > +	pcie_get_minimum_link(dev, &speed, &width);
> > > +
> > > +	if (speed == speed_cap && width == width_cap)
> > > +		pci_info(dev, "%s x%d link\n", PCIE_SPEED2STR(speed), width);
> > > +	else
> > > +		pci_info(dev, "%s x%d link (capable of %s x%d)\n",
> > > +			 PCIE_SPEED2STR(speed), width,
> > > +			 PCIE_SPEED2STR(speed_cap), width_cap);
> > 
> > I think pcie_get_minimum_link() is misleading.  This new use of
> > it is very similar to the existing uses, but I think we should clean
> > this up before using it in more places.
> > 
> > pcie_get_minimum_link() finds the minimum speed and minimum link width
> > (separately) across all the links in the path, and I don't think
> > that's what we really want.  What we *want* is the total bandwidth
> > available to the device, because we're trying to learn if the device
> > is capable of more than the fabric can deliver.
> > 
> > That means we want to look at all the links in the path leading to the
> > device and find the link with the lowest bandwidth, i.e., width *
> > speed.  Obviously this is not necessarily the link with the fewest
> > lanes or the lowest link speed.
> 
> The problem I see here is we need to consider differences in PCIe
> gens.  Let's consider this example: gen3 x4 device which down the
> chain goes over gen2 x8 pcie bridge. The device's bandwidth is
> D=4*8*(gen3 encoding) and the bridge's bandwidth is B=8*5*(gen2
> encoding). D~=31.5 and B~=32. So it would seem like there's no
> issue, but don't we want to know we actually went up as gen2?

If you're saying the "bandwidth = width * speed" equation should be
enhanced to consider the effect of encoding, I would agree with that.
fm10k_slot_warn() has an example of doing that.

I don't think we specifically care about whether it is gen2/gen3/etc.
If a device with a narrow gen3 link can't keep a wide gen2 link
upstream from it saturated, the device has nothing to complain about.

> > I hinted at this before, but you thought it would result in more
> > questions than answers [1], and I failed to continue the conversation.
> 
> You raised the concern of not knowing the device limiting the total
> bandwidth of the chain. I thought it was an argument against the
> idea, but maybe I misunderstood. Let's agree on a design (below)
> before I make anymore changes :).

I was basically asking whether you wanted to know which device was
the limiting factor.  If we care about that, we could easily return
it, but I don't see any drivers that care about it now.

> > Let's continue it now :)
> > 
> > Here are some straw-man interfaces to return a device's capabilities
> > and the available bandwidth in MB/s:
> > 
> >    unsigned int pcie_bandwidth_capable(struct pci_dev *dev,
> >                                        enum pci_bus_speed *speed,
> >                                        enum pcie_link_width *width);
> >    unsigned int pcie_bandwidth_available(struct pci_dev *dev);
> > 
> > Then we can compare the result with what "dev" is capable of, e.g.,
> > 
> >    my_bw = pcie_bandwidth_capable(dev, &my_speed, &my_width);
> >    avail_bw = pcie_bandwidth_available(dev);
> >    if (avail_bw >= my_bw)
> 
> Can it really be >?

If pcie_bandwidth_available() looks at my device or the immediate
upstream bridge (two ends of the last link), then no, the available
bandwidth (based on current link settings) should never be greater
than the bandwidth my device could support (based on link
capabilities).

> >      pci_info(dev, "%d MB/s available bandwidth (%s x%d link)\n",
> >               my_bw, PCIE_SPEED2STR(my_speed), my_width);
> >    else
> >      pci_info(dev, "%d MB/s available bandwidth (capable of %d MB/s, %s x%d)\n",
> >               avail_bw, my_bw, PCIE_SPEED2STR(my_speed), my_width);
> > 
> > Using GB/s would be nicer; I lazily used MB/s to avoid dealing with
> > decimals, e.g., 2.5GB/s.
> 
> So let's see if we agree on the steps:
> 1. my_speed_cap, my_width_cap <- calculate device PCIe caps
> 2. avail_bw, limiting_dev <- calculate PCIe chain bandwidth
> 3. my_bw <- my_speed_cap * my_width_cap
> 4. If avail_bw == my_bw print available bandwidth + PCIe caps
> 5. Else print available bandwidth + limited by + capable bandwidth + PCIe
> caps
> 
> What do you think?

Steps 2 and 3 might need to be smart enough to apply the effect of
encoding differences between generations.

In step 2, we don't have any current user of the "limiting_dev"
information, so I'd omit it until we have somebody who wants it.

In step 5, we don't know the "limited by" part (unless you want to add
that).
