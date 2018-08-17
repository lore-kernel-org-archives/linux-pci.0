Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32458 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeHQMkB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 08:40:01 -0400
Date: Fri, 17 Aug 2018 12:37:16 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180817093716.GS2343@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
 <20180815152139.4e469fd4@t450s.home>
 <20180815164308.6ad5dd39@t450s.home>
 <20180816061015.GD2343@lahna.fi.intel.com>
 <20180816091303.69ce8e45@t450s.home>
 <20180816192805.GN2343@lahna.fi.intel.com>
 <20180816142504.4e3d121c@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180816142504.4e3d121c@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 02:25:04PM -0600, Alex Williamson wrote:
> On Thu, 16 Aug 2018 22:28:05 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > On Thu, Aug 16, 2018 at 09:13:03AM -0600, Alex Williamson wrote:
> > >  static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> > >  {
> > >  	int pos;
> > > +	u16 std_ctrl;
> > >  	u32 cap, ctrl;
> > >  
> > >  	if (!pci_quirk_intel_spt_pch_acs_match(dev))
> > > @@ -4621,6 +4628,18 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> > >  	if (!pos)
> > >  		return -ENOTTY;
> > >  
> > > +	/* If the std control word has bits set or is writable, do not quirk */
> > > +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &std_ctrl);
> > > +	if (std_ctrl)
> > > +		return -ENOTTY;
> > > +
> > > +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0xff);  
> > 
> > I don't know ACS well but could the above have some unwanted
> > side-effects, even if we write back zeroes below?
> 
> It can certainly influence in-flight packet routing, but at the point
> we're performing this test, we're about to do that anyway.  This should
> only be happening during discovery and we're limited to a set of root
> ports for this test, so we shouldn't have any drivers attached
> downstream from here.  For the majority of devices that would pass
> through this quirk, we expect the register to behave as if it were
> read-only so we can only potentially break the already broken C246 port
> through here.

OK.

> We could possibly refine this to fully replace pci_std_enable_acs(),
> even for the matched Intel root ports that seem to be fixed by
> attempting to set the requested flags at the standard location, test if
> they stick, if so consider it done (exit success rather than -ENOTTY),
> if not try the dword version.  Thanks,

Before going there, I would like to get some definitive answer from our
PCIe people regarding this (currently waiting for their reply).
