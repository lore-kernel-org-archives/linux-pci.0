Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54601 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751134AbaIXEP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 00:15:29 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Date: Wed, 24 Sep 2014 12:14:46 +0800
Subject: RE: [PATCH] PCI: designware: Fix IO resource end address calculation
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661ABCDBA8EEC@EAPEX1MAIL1.st.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
 <20140923225356.GG27117@google.com>
In-Reply-To: <20140923225356.GG27117@google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, September 24, 2014 4:24 AM
> To: Minghuan Lian
> Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Zang
> Roy-R61911; Hu Mingkai-B21284; Scott Wood; Yoder Stuart-B08248; Arnd
> Bergmann; Mohit KUMAR DCG; Jingoo Han
> Subject: Re: [PATCH] PCI: designware: Fix IO resource end address
> calculation
> 
> [+cc Mohit, Jingoo]
> 
> On Tue, Sep 23, 2014 at 10:28:57PM +0800, Minghuan Lian wrote:
> > End address should be equal to start_addr + size - 1.
> > The patch fixes PCI IO resource end address calculation.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > ---
> >  drivers/pci/host/pcie-designware.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-
> designware.c
> > index 0f3cb2a..c19184f7 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -459,7 +459,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> >  			pp->io.end = min_t(resource_size_t,
> >  					   IO_SPACE_LIMIT,
> >  					   range.pci_addr + range.size
> > -					   + global_io_offset);
> > +					   + global_io_offset - 1);
> >  			pp->io_size = resource_size(&pp->io);
> >  			pp->io_bus_addr = range.pci_addr;
> >  			pp->io_base = range.cpu_addr;
> > --
> > 1.9.1
> >
- Acked-by: Mohit KUMAR <mohit.kumar@st.com>

Thanks
Mohit
