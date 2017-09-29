Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:23808
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbdI2MWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Sep 2017 08:22:43 -0400
Date: Fri, 29 Sep 2017 05:22:38 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wilson.Snyder@cavium.com, alex.williamson@redhat.com
Subject: Re: [PATCH v6] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Message-ID: <20170929122238.GA527@localhost.localdomain>
References: <1506344920-24016-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170927141854.2ff65c73@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927141854.2ff65c73@w520.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Sep 27, 2017 at 02:18:54PM -0600, Alex Williamson wrote:
> On Wed, 27 Sep 2017 11:20:39 -0700
> Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> 
> > This commit makes Cavium PCI ACS quirk applicable only to Cavium
> > ThunderX (CN8XXX) family PCIE Root Ports which has limited PCI capabilities
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
> > 	v5 -> v6: comment typo fix: change 0xa00 to 0xa000
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>

If there is no any objections, could you please take this patch ?

WBR,
Vadim

>  
> >  drivers/pci/quirks.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index a4d3361..ed6c76d 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4211,20 +4211,33 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
> >  #endif
> >  }
> >  
> > -static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> > +/*
> > + * The Cavium downstream ports doesn't advertise their ACS capability registers.
> > + * However, the RTL internally implements similar protection as if
> > + * ACS had completion redirection, forwarding and validation features enabled.
> > + * So by this flags we're asserting that the hardware implements and
> > + * enables equivalent ACS functionality for these flags.
> > + */
> > +#define CAVIUM_CN8XXX_ACS_FLAGS (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF)
> > +
> > +static __inline__  bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> >  {
> >  	/*
> > -	 * Cavium devices matching this quirk do not perform peer-to-peer
> > -	 * with other functions, allowing masking out these bits as if they
> > -	 * were unimplemented in the ACS capability.
> > +	 * Effectively selects all downstream ports for whole ThunderX 1 family
> > +	 * by 0xa000 mask (which represents 8 SoCs), while the lower bits of device ID
> > +	 * are used to indicate which subdevice is used within the SoC.
> >  	 */
> > -	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> > -		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> > +	return (pci_is_pcie(dev) &&
> > +		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> > +		((dev->device & 0xf800) == 0xa000));
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
