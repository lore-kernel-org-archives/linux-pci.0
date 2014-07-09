Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35005 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaGIBeT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 21:34:19 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N8F00I368CTJX10@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 09 Jul 2014 10:34:05 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Stephen Rothwell' <sfr@canb.auug.org.au>,
	'Fabio Estevam' <festevam@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	'Fabio Estevam' <fabio.estevam@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Mohit Kumar' <mohit.kumar@st.com>
References: <1403104613-9867-1-git-send-email-festevam@gmail.com>
 <20140709105731.1b3e2bbe@canb.auug.org.au>
In-reply-to: <20140709105731.1b3e2bbe@canb.auug.org.au>
Subject: Re: PCI: designware: Use IS_ENABLED()
Date: Wed, 09 Jul 2014 10:34:05 +0900
Message-id: <001101cf9b15$df01cf50$9d056df0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 09, 2014 9:58 AM, Stephen Rothwell wrote:
> 
> Hi Fabio,
> 
> [I noticed this in the pci tree in linux-next this morning]
> 
> On Wed, 18 Jun 2014 12:16:53 -0300 Fabio Estevam <festevam@gmail.com> wrote:
> >
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > We can get rid of the 'ifdef' by using the IS_ENABLED() macro.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > Acked-by: Mohit Kumar <mohit.kumar@st.com>
> >
> > ---
> > drivers/pci/host/pcie-designware.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 1eaf4df3..dc842fd 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >
> >  	pci_common_init_dev(pp->dev, &dw_pci);
> >  	pci_assign_unassigned_resources();
> > -#ifdef CONFIG_PCI_DOMAINS
> > -	dw_pci.domain++;
> > -#endif
> > +	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
> > +		dw_pci.domain++;
> >
> >  	return 0;
> >  }
> 
> Will this actually compile if CONFIG_PCI_DOMAINS is disabled, since the
> "domains" field of dw_pci does not even exist in that case (it is
> ifdeffed out in arch/arm/include/asm/mach/pci.h)?  Even if it works
> with newer compilers, will it work with older ones i.e. how new does
> the compiler have to be to elide the code before noticing that
> "domains" does not exist?

Oops, you're right! It makes build errors when CONFIG_PCI_DOMAINS
is disabled.

The "domain" variable is guarded by "#ifdef CONFIG_PCI_DOMAINS";
thus, IS_ENABLED() should NOT be used.

./arch/arm/include/asm/mach/pci.h
struct hw_pci {
#ifdef CONFIG_PCI_DOMAINS
	int		domain;
#endif

Bjorn Helgaas,
Please revert this patch from your pci tree. Thank you.

Best regards,
Jingoo Han

> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au

