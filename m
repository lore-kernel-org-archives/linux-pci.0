Return-Path: <jthumshirn@suse.de>
Return-Path: <jthumshirn@suse.de>
Date: Mon, 31 Oct 2016 15:52:39 -0600
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, agraf@suse.de
Subject: Re: [PATCH v2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
Message-ID: <20161031215237.7mr45lvmsa2os57i@linux-x5ow.site>
References: <1477492216-39910-1-git-send-email-jthumshirn@suse.de>
 <20161031204144.GA14603@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161031204144.GA14603@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 03:41:44PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 26, 2016 at 04:30:16PM +0200, Johannes Thumshirn wrote:
> > The Read Completion Boundary bit must only be set on a device or endpoint if
> > it is set on the upstream bridge.
> 
> Please include the spec reference and a stable tag (if you think
> that's relevant) in the next version.
> 
> I know you have an internal SuSE bugzilla that isn't useful here.  I
> would like a public bugzilla at bugzilla.kernel.org with an attached
> "lspci -vv" output and dmesg log.  You can exclude things that are
> proprietary or otherwise secret, but this is a fairly subtle area
> related to MPS and MRRS.  We have known issue there, and if/when we
> get around to addressing them, I'd like to have public documentation
> about pitfalls we need to avoid.
> 
> It would really be helpful if this changelog could include an outline
> of what's going wrong from the hardware point of view when the
> endpoint's RCB is set incorrectly.  I've read the spec, but I'm not
> enough of a hardware person to develop intution about what's failing
> here.  A concrete scenario would help a lot, e.g.,
> 
>   - Root Port RCB is 64 bytes
>   - Endpoint RCB is 128 bytes (incorrect per spec, since Root Port's
>     RDB is only 64 bytes)
>   - Endpoint issues Memory Read Request for 128 bytes, 128-byte
>     aligned
>   - Root Port responds to Memory Read Request with two 64-byte
>     Completions
>   - Endpoint (as the Receiver) has RCB of 128, so it is expecting a
>     single Completion and sees two Completions as a violation of the
>     "Completions for Requests which do not cross the naturally aligned
>     address boundaries at integer multiples of RCB bytes must include
>     all data specified in the Request" rule in 2.3.1.1, and treats
>     this as a Malformed TLP.
> 
> If that's really the scenario, we should be able to see this in the
> lspci output, e.g., something like:
> 
>   # lspci -vv
>   # modprobe mlx4
>   # lspci -vv
> 
> should show no error in the first lspci, but something in the second.

You actually see the error already before probing the driver. But I can
include the lspci output between a known good and a known bad version.

> 
> It seems plausible that this is exposed by a BIOS bug.  I'd like to
> include specifics about the adapter, the machine, and BIOS version in
> the changelog to help connect this fix with the machine known to have
> the problem.

It is a BIOS bug, yes. I'll collect the info about it. But this may take some
days as I do not have direct access to the hardware and have to request this
information from people who have access.

> 
> > Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Hannes Reinecke <hare@suse.com>
> > ---
> >  drivers/pci/probe.c | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > Changes from v1:
> > * Check if we have a upstream bridge to not trip on a NULL pointer
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index ab00267..716c5cf 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1439,6 +1439,19 @@ static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
> >  		dev_warn(&dev->dev, "PCI-X settings not supported\n");
> >  }
> >  
> > +static bool pcie_get_upstream_rcb(struct pci_dev *dev)
> > +{
> > +	struct pci_dev *bridge = pci_upstream_bridge(dev);
> > +	u16 lnkctl;
> > +
> > +	if (!bridge)
> > +		return false;
> > +
> > +	pcie_capability_read_word(bridge, PCI_EXP_LNKCTL, &lnkctl);
> > +
> > +	return lnkctl & PCI_EXP_LNKCTL_RCB;
> > +}
> > +
> >  static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
> >  {
> >  	int pos;
> > @@ -1468,9 +1481,21 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
> >  			~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or);
> >  
> >  	/* Initialize Link Control Register */
> > -	if (pcie_cap_has_lnkctl(dev))
> > +	if (pcie_cap_has_lnkctl(dev)) {
> > +		bool us_rcb;
> > +		u16 clear;
> > +		u16 set;
> > +
> > +		us_rcb = pcie_get_upstream_rcb(dev);
> 
> Per spec (PCIe r3.0, sec 7.8.7), RCB is applicable only to Root Ports,
> Endpoints, and Bridges.  This is somewhat ambiguous: the "Bridge"
> definition in "Terms and Acronyms" seems to include Switch Ports, but
> the text in 7.8.7 seems to exclude Switch Ports.
> 
> In any case, 7.8.7 is clear that we should set this bit only if the
> RCB in the upstream *Root Port* (not the nearest upstream switch port
> as we're using here) is set.

Yes I was a bit confused about this as well and figured, it'll be safer to
test the upstream swicth port than the root port. But chaning it into the root
port should be ok.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
