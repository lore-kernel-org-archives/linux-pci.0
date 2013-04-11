Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935048Ab3DKACL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Apr 2013 20:02:11 -0400
Message-ID: <1365638519.26525.5.camel@ul30vt.home>
Subject: Re: PCI warning on boot 3.8.0-rc1
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 10 Apr 2013 18:01:59 -0600
In-Reply-To: <20130410223650.GA6109@google.com>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	 <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	 <20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	 <1360009684.11144.539.camel@bling.home>
	 <1360017684.11144.547.camel@bling.home>
	 <20130206074900.02f04e3f@nehalam.linuxnetplumber.net>
	 <1360166321.11144.638.camel@bling.home> <20130410223650.GA6109@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-04-10 at 16:36 -0600, Bjorn Helgaas wrote:
> On Wed, Feb 06, 2013 at 08:58:41AM -0700, Alex Williamson wrote:
> > On Wed, 2013-02-06 at 07:49 -0800, Stephen Hemminger wrote:
> > > On Mon, 04 Feb 2013 15:41:24 -0700
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > 
> > > > On Mon, 2013-02-04 at 13:28 -0700, Alex Williamson wrote:
> > > > > On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > > > > > > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > > > > > > this the first time you've turned on the IOMMU on that box?
> > > > > > 
> > > > > > It exists in 3.7 and earlier kernels, just haven't turned on same config.
> > > > > > 
> > > > > > > It's the same warning as in this bugzilla:
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > > > > > > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > > > > > > it's just a quirk that turns off VT-d if we find certain broken
> > > > > > > bridges.  It doesn't look like you have any of those (although I don't
> > > > > > > know what you have at 05:00.0).
> > > > > > > 
> > > > > > > Bjorn
> > > > > > 
> > > > > > This is a standard ASUS motherboard, and don't want to disable VT-d.
> > > > > 
> > > > > Stephen,
> > > > > 
> > > > > Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
> > > > > seen before?  Does the patch below help?
> > > > > 
> > > > > Bjorn, I think we need to quirk it somehow.  So far they've all been
> > > > > PCI-to-PCI bridges attached to root ports where we expect it's actually
> > > > > a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
> > > > > to a downstream port.  The patch below avoids the WARN and gives us a
> > > > > device, but of course pci_is_pcie reports wrong for this device and may
> > > > > cause some trickle down breakage.  A more complete option might be to
> > > > > add a is_pcie flag to the device that can be set independent of
> > > > > pcie_cap.  We'd need to check all the callers for assumptions, but then
> > > > > we could put the quirk in one place and hopefully fix everything.
> > > > > Thoughts?  Thanks,
> > > > 
> > > > This latter approach seems like it might be easier than I expected since
> > > > all the users are so well filtered through the access functions.  A
> > > > quick look through who uses pci_is_pcie seems like this might be
> > > > complete, but more eyes are required.  I'll upload this to the bz for
> > > > those reporters to test as well.  Thoughts?  Thanks,
> > > > 
> > > > Alex
> > > 
> > > On my hardware this gives:
> > 
> > > [    0.254621] pci_bus 0000:05: busn_res: can not insert [bus 05-ff] under [bus 00-3e] (conflicts with (null) [bus 00-3e])
> > > [    0.254647] WARNING: Your hardware is broken, device (null) appears to be a
> > > [    0.254647]  Legacy PCI device attached directly to a PCIe device which is not a
> > > [    0.254647]  PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the
> > > [    0.254647]  PCI express capability structure is required for PCI express device
> > > [    0.254647] functions.
> > > [    0.254653] pci 0000:05:00.0: [1b21:1080] type 01 class 0x060401
> > 
> > I guess I must be calling pci_name() before it's set.  The warning
> > message needs some work too, it's mainly meant for hardware vendors with
> > the hope that they might test Linux and see it before shipping these
> > broken devices.  Bjorn, does this approach seem worth pursuing?  Thanks,
> 
> Sorry I dropped this for so long.  I'm looking at the patch
> here: https://bugzilla.kernel.org/attachment.cgi?id=92521,
> appended for convenience.
> 
> In case anybody else needs the context, I think we have
> this scenario (from John Wehin's original report at
> https://bugzilla.kernel.org/show_bug.cgi?id=44881):
> 
>     pci 0000:00:1c.4: PCI bridge to [bus 03-04]	# PCIe root port
>     pci 0000:03:00.0: PCI bridge to [bus 04]	# no PCIe cap
>     ...
>     pci 0000:03:00.0: expected upstream PCIe bridge; 0000:00:1c.4 is type 0x4
> 
> We called pci_find_upstream_pcie_bridge(03:00.0), which generated
> the warning because:
> 
>     - 03:00.0 is not a PCIe device, and
>     - 00:1c.4 (its upstream bridge) *is* a PCIe device, and
>     - 00:1c.4 is a Root Port (PCI_EXP_TYPE_ROOT_PORT == 0x4),
>       not a PCIe-to-PCI bridge (PCI_EXP_TYPE_PCI_BRIDGE == 0x7)
>       as we expected
> 
> > commit 60d668a3cdeeb0e29570cf0043736436c146bde8
> > Author: Alex Williamson <alex.williamson@redhat.com>
> > Date:   Mon Feb 4 15:34:34 2013 -0700
> > 
> >     pci: Handle unadvertised PCIe bridges
> >     
> >     There seem to be several PCIe-to-PCI bridges out in the wild that
> >     blatantly ignore the PCIe specification and do not expose a PCIe
> >     capability.  We can attempt to deduce their existence by looking
> >     for PCI bridges directly connected to root ports or downstream
> >     ports.  What this means is that pci_is_pcie() does not imply PCIe
> >     capability and we un-deprecate is_pcie to denote the difference.
> >     All the accesses seem to go through pcie_capability_reg_implemented,
> >     so we can significantly limit the footprint of this change by
> >     checking things there.
> >     
> >     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 3af0478..3df24e7 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -511,7 +511,7 @@ static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)
> >  
> >  static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
> >  {
> > -	if (!pci_is_pcie(dev))
> > +	if (!pci_is_pcie(dev) || !pci_pcie_cap(dev))
> >  		return false;
> >  
> >  	switch (pos) {
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 6186f03..0a87b6b 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -926,20 +926,46 @@ static void pci_read_irq(struct pci_dev *dev)
> >  	dev->irq = irq;
> >  }
> >  
> > +static bool is_unadvertised_pcie_bridge(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *parent;
> > +
> > +	if (pdev->hdr_type != PCI_HEADER_TYPE_BRIDGE ||
> > +	    pci_find_capability(pdev, PCI_CAP_ID_EXP) ||
> > +            pci_is_root_bus(pdev->bus))
> > +		return false;
> > +
> > +	parent = pdev->bus->self;
> > +
> > +	if (pci_is_pcie(parent) &&
> > +	    (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT ||
> > +	     pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM)) {
> > +		pr_warn("WARNING: Your hardware is broken, device %s appears to be a\n Legacy PCI device attached directly to a PCIe device which is not a\n PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the\n PCI express capability structure is required for PCI express device\nfunctions.\n",
> > +		        pci_name(pdev));
> 
> Vendors might see this warning, but I'm doubtful they'll do anything
> about it.  I suspect it will result in a lot of emails from concerned
> users to LKML and linux-pci, and we really can't do anything other
> than say "yup, it's broken, report it to your vendor."
> 
> And since the hardware seems to actually *work* if we just pretend that
> the problem device (e.g., 03:00.0 above) is PCIe, it's doubtful that
> the vendor would do anything anyway, so maybe a dev_info() would be
> sufficient.
> 
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  void set_pcie_port_type(struct pci_dev *pdev)
> >  {
> >  	int pos;
> > -	u16 reg16;
> > +	u16 flags, caps = 0;
> >  
> >  	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > -	if (!pos)
> > +	if (pos) {
> > +		pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &flags);
> > +		pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &caps);
> > +	} else if (is_unadvertised_pcie_bridge(pdev))
> > +		flags = PCI_EXP_TYPE_PCI_BRIDGE << 4;
> > +	else
> >  		return;
> > +
> >  	pdev->is_pcie = 1;
> >  	pdev->pcie_cap = pos;
> > -	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
> > -	pdev->pcie_flags_reg = reg16;
> > -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> > -	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> > +	pdev->pcie_flags_reg = flags;
> 
> If we can avoid it, I'd prefer not to complicate the meaning of
> "pci_is_pcie()" -- it used to mean "this device has a PCIe
> capability and you can do PCIe things with it."  But now it
> means something else, and we can't do PCIe things with these
> problem devices anyway.
> 
> Could we accomplish basically the same thing by making
> pci_find_upstream_pcie_bridge() look like this?
> 
>     if (pci_is_pcie(pdev))
> 	    return NULL;
> 
> +   bridge = pdev->bus->self;
> +   if (bridge && pci_is_pcie(bridge) &&
> +	(pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT ||
> +	 pci_pcie_type(bridge) == PCI_EXP_TYPE_DOWNSTREAM))
> +	    return NULL;
> 
>     while (1) {
> 	...

This only solves pci_find_upstream_pcie_bridge(3:00.0), I think it still
fails for any devices found on subordinate buses below that.  Thanks,

Alex

