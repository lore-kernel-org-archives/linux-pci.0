Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:41408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751015AbdIMLhm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Sep 2017 07:37:42 -0400
Date: Wed, 13 Sep 2017 04:37:36 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, David.Daney@cavium.com,
        jcm@redhat.com, Robert.Richter@cavium.com,
        Wilson.Snyder@cavium.com, Jayachandran.Nair@cavium.com
Subject: Re: [PATCH] PCI: quirks: update cavium ACS quirk implementation
Message-ID: <20170913113736.GA17702@localhost.localdomain>
References: <1505217316-15702-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170912101545.01977624@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170912101545.01977624@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 12, 2017 at 10:15:45AM -0600, Alex Williamson wrote:
> On Tue, 12 Sep 2017 04:55:16 -0700
> Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> 
> > This commit makes PIC ACS quirk applicable only to Cavium PCIE devices
> > and Cavium PCIE Root Ports which has limited PCI capabilities in terms
> > of no ACS support. Match function checks for ACS support and exact ACS
> > bits set at the device capabilities.
> > Also by this commit we get rid off device ID range values checkings.
> > 
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > ---
> >  drivers/pci/quirks.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index a4d3361..11ca951 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4211,6 +4211,29 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
> >  #endif
> >  }
> >  
> > +#define CAVIUM_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | \
> > +			  PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT)
> > +
> > +static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> > +{
> > +	int pos = 0;
> > +	u32 caps = 0;
> > +
> > +	/* Filter out a few obvious non-matches first */
> > +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > +		return false;
> > +
> > +	/* Get the ACS caps offset */
> > +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> > +	if (pos) {
> > +		pci_read_config_dword(dev, pos + PCI_ACS_CAP, &caps);
> > +		/* If we have no such bits set, then we will need a quirk */
> > +		return ((caps & CAVIUM_ACS_FLAGS) != CAVIUM_ACS_FLAGS);
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> >  {
> >  	/*
> > @@ -4218,13 +4241,10 @@ static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> >  	 * with other functions, allowing masking out these bits as if they
> >  	 * were unimplemented in the ACS capability.
> >  	 */
> > -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> > -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> > -
> > -	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
> > +	if (!pci_quirk_cavium_acs_match(dev))
> >  		return -ENOTTY;
> >  
> > -	return acs_flags ? 0 : 1;
> > +	return acs_flags & ~(CAVIUM_ACS_FLAGS) ? 0 : 1;
> >  }
> >  
> >  static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> 
> No please.  As I read it, this is assuming that any Cavium PCIe root
> port supports the equivalent isolation flags.  Do you have a crystal
> ball to know about all the future PCIe root ports that Cavium is going
> to ship?

Well, yes, my bad then.
Would the check for exact device id (or some range) of pcie device/root
port be more suitable here (as it is implemented for other vendors) ?

> Quirk the devices you can verify support the equivalent
> isolation capabilities and solve this problem automatically for future
> devices by implementing ACS in hardware.  No free pass for all future
> hardware, especially not one that overrides the hardware potentially
> implementing ACS in the future and ignoring it if it's not sufficient.
> We're actually trying to be diligent to test for isolation and this
> entirely ignores that.
> 
> Also, as we've been through with APM, how do you justify each of these
> ACS flags?  Claiming that a device does not support peer-to-peer does
> not automatically justify Source Validation.  What feature of your
> hardware allows you to claim that?  How does a root port that does not
> support P2P imply anything about Transaction Blocking?  What about
> Direct Translated P2P?  If the device doesn't support P2P, doesn't that
> mean it shouldn't claim DT?  Like the attempted APM quirk, I think this
> original quirk here has just taken and misapplied the mask we use for
> multifunction devices where downstream ports have much different
> requirements for ACS.  Thanks,

My understanding that CN81xx/83xx/88xx pcie bridges/root ports has no ACS support.
And the original mask was constructed in that way erroneously copied I guess.

Would the resetting of RR/CR/UF/SV bits be more correct here ?

> 
> Alex

WBR,
Vadim
