Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28890 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752597AbbDWHvS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2015 03:51:18 -0400
Date: Thu, 23 Apr 2015 15:47:00 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] PCI: designware: use iATU0 for cfg and IO, iATU1
 for MEM
Message-ID: <20150423154700.2f2043c3@xhacker>
In-Reply-To: <5538A0AE.6050005@st.com>
References: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
	<1429707494-2732-3-git-send-email-jszhang@marvell.com>
	<5538A0AE.6050005@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabrice,

On Thu, 23 Apr 2015 00:35:10 -0700
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Hi Jisheng,
> 
> On 04/22/2015 02:58 PM, Jisheng Zhang wrote:
> > Most transactions' type are cfg0 and MEM, so the Current iATU usage is not
> > balanced, iATU0 is hot while iATU1 is rarely used. This patch refactors
> > the iATU usage: iATU0 for cfg and IO, iATU1 for MEM. This allocation
> > ideas comes from Minghuan Lian<Minghuan.Lian@freescale.com>:
> >
> >   http://www.spinics.net/lists/linux-pci/msg40440.html
> >
> > Signed-off-by: Jisheng Zhang<jszhang@marvell.com>
> > ---
> >   drivers/pci/host/pcie-designware.c | 83 +++++++++++++++++++++-----------------
> >   1 file changed, 47 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 1da1446..bb81c8ad 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -508,6 +508,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >   	if (pp->ops->host_init)
> >   		pp->ops->host_init(pp);
> >   
> > +	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> > +				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
> > +				  pp->io_bus_addr, pp->io_size);
> > +	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> > +				  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
> > +				  pp->mem_bus_addr, pp->mem_size);
> > +
> Some platforms doesn't have support for ATU. I think this is the reason 
> to have
> rd_other_conf / wr_other_conf ops in the driver.

oops. Thanks for the information. So what about something like:

if (!pp->ops->rd_other_conf) {
	dw_pcie_prog_outbound_atu(...);
	dw_pcie_prog_outbound_atu(...);
}

Thanks,
Jisheng

> IMO, this is not suitable to have this in the initialization routine for 
> all platforms.
> 
> Regards,
> Fabrice

