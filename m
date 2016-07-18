Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42434 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751391AbcGRCn2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Jul 2016 22:43:28 -0400
Date: Mon, 18 Jul 2016 10:38:51 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>
CC: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] PCI: designware: let dw_pcie_link_up() beware of
 LTSSM training bit
Message-ID: <20160718103851.7cd3984a@xhacker>
In-Reply-To: <2e9d2b8c-f4c3-aa6d-38be-314213db7727@synopsys.com>
References: <1467802782-3024-1-git-send-email-jszhang@marvell.com>
	<1467802782-3024-3-git-send-email-jszhang@marvell.com>
	<2e9d2b8c-f4c3-aa6d-38be-314213db7727@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Joao,

On Fri, 15 Jul 2016 16:10:24 +0100 Joao Pinto wrote:

> Hi,
> 
> On 7/6/2016 11:59 AM, Jisheng Zhang wrote:
> > The link may be UP but still in link training. In this case, we can't
> > think the link is up and operating correctly. So we need to teach
> > dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.
> > 
> > This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
> > it's consistent with other MACROS.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/pci/host/pcie-designware.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 9df879a..29e10dd 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -73,7 +73,8 @@
> >  /* PCIe Port Logic registers */
> >  #define PLR_OFFSET			0x700
> >  #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
> > -#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
> > +#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
> > +#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)  
> 
> According to the databook bit 29 is inside a range that is dedicated to M-PCIe.
> Have you checked bit 29 state by experience?

bit 29 here is bit 61 of cxpl_debug_info(64bit) in databook, the debug info is
composited by debug 0 and debug 1 registers.

I checked databook 4.3 and 4.21, bit 29 (bit 61 in databook) isn't dedicated to
M-PCIe. I think you may misread the bit 29 here as the bit29 in databook?
Databook indeed mentioned that bit[31:28] is reserved for M-PCIe

And after more code checking, I think this is not only marvell have this
case(link is up but still in link training), but pci-imx6.c also has this
case, we could check imx6_pcie_link_up() for reference.

Thanks,
Jisheng

> 
> >  
> >  /* Parameters for the waiting for link up routine */
> >  #define LINK_WAIT_MAX_RETRIES		10
> > @@ -417,7 +418,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
> >  		return pp->ops->link_up(pp);
> >  
> >  	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> > -	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
> > +	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
> > +		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
> >  }
> >  
> >  static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> >   
> 
> Thanks,
> Joao

