Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:45280
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751635AbdIUIja (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Sep 2017 04:39:30 -0400
Date: Thu, 21 Sep 2017 01:39:21 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wilson.Snyder@cavium.com,
        jcm@redhat.com
Subject: Re: [PATCH v4] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Message-ID: <20170921083921.GA2135@localhost.localdomain>
References: <1505480233-22694-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1505724481-28413-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170920103151.7e3fdb77@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920103151.7e3fdb77@w520.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 20, 2017 at 10:31:51AM -0600, Alex Williamson wrote:
> On Mon, 18 Sep 2017 01:48:01 -0700
> Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> 
> > This commit makes Cavium PCI ACS quirk applicable only to Cavium
> > ThunderX (CN81/83/88XX) PCIE Root Ports which has limited PCI capabilities
> > in terms of no ACS support advertisement. However, the RTL internally
> > implements similar protection as if ACS had completion/request redirection,
> > upstream forwarding and validation features enabled.
> > 
> > Current quirk implementation doesn't take into account PCIERCs which
> > also needs to be quirked. So the pci device id check mask is updated
> > and check of device ID moved into separate function.
> > 
> > Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > ---
> > 	v1	: put device check into separate function and extend it to all
> > 		  Cavium PCIERC/PCCBR devices;
> > 	v1 -> v2: update match function in order to filter only ThunderX devices by device
> > 	      	  ids to properly filter CN8XXX devices, update subject & description with
> > 		  ACS register info (rejected by maillist due to triple X in subject);
> > 	v2 -> v3: update subject: remove CN8XXX from subject line, replace it with ThunderX;
> > 	v3 -> v4: update ACS mask (remove TB and TD bits), update commit message (remove
> > 	      	  ACS register printout);
> > 
> >  drivers/pci/quirks.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index a4d3361..e6b904a 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4211,20 +4211,26 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
> >  #endif
> >  }
> >  
> > -static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> > +/*
> > + * Cavium devices matching this quirk do not perform peer-to-peer
> > + * with other functions, allowing masking out these bits as if they
> > + * were unimplemented in the ACS capability.
> 
> nit,

put this down for later use..

> the description here still steals too much from the multifunction
> quirk.

description was just moved (and  needs to be rewrited) since the orignal idea was
just to extend quirk for all ThunderX family which has that limitation.

Would the following be more suitable here:

"The Cavium downstream ports doesn't advertise their ACS capability registers.
However, the RTL internally implements similar protection as if ACS had completion redirection,
forwarding and validation features enabled." ?

> Multifunction devices can often support ACS with unimplemented
> capabilities, which indicate that the device does not support the
> behavior described by that capability bit. However, downstream ports
> are required to implement certain ACS capabilities if they implement
> ACS at all.  So the code is actually asserting that the hardware
> implements *and* enables equivalent ACS functionality for these flags.

Yes it is. The hardware doesn't advertise ACS caps which is desing limitation,
however it implements similar functionality to ACS provided flags which allows code to assert this.

> 
> > + */
> > +#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF)
> > +
> > +static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> >  {
> > -	/*
> > -	 * Cavium devices matching this quirk do not perform peer-to-peer
> > -	 * with other functions, allowing masking out these bits as if they
> > -	 * were unimplemented in the ACS capability.
> > -	 */
> > -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> > -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> > +	return (pci_is_pcie(dev) &&
> > +		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> > +		((dev->device & 0xf800) == 0xa000));
> 
> That's effectively 2k device IDs, 0xa000-0xa7ff that you and Cavium are
> vouching for ACS equivalent isolation.  How many of these actually
> exist?  The PCI IDs database gets really sparse after the first 64
> entries.  Internally are these device IDs allocated to programs based on
> the same ASICs or is this just a slightly more restricted crystal ball
> (ie. wishful thinking)?  Thanks,

The latter; this represents 8 SoCs, the lower 8 bits of the DEVID are used
to indicate which subdevice is used within the SoC.

Vadim

> 
> Alex
> 
> > +}
> >  
> > -	if (!((dev->device >= 0xa000) && (dev->device <= 0xa0ff)))
> > +static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> > +{
> > +	if (!pci_quirk_cavium_acs_match(dev))
> >  		return -ENOTTY;
> >  
> > -	return acs_flags ? 0 : 1;
> > +	return acs_flags & ~(CAVIUM_CN8XXX_ACS_FLAGS) ? 0 : 1;
> >  }
> >  
> >  static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
> 
