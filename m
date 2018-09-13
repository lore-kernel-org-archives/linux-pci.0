Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbeIMOYO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Sep 2018 10:24:14 -0400
Date: Thu, 13 Sep 2018 10:15:34 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180913091534.GB32721@e107981-ln.cambridge.arm.com>
References: <20180829110408.556c3622@xhacker.debian>
 <20180910165722.38218779@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910165722.38218779@xhacker.debian>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 04:57:22PM +0800, Jisheng Zhang wrote:
> Hi all,
> 
> On Wed, 29 Aug 2018 11:04:08 +0800 Jisheng Zhang wrote:
> 
> > When programming inbound/outbound atu, we call usleep_range() after
> > each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> > can be called in atomic context:
> > 
> > inbound atu programming could be called through
> > pci_epc_write_header()
> >   =>dw_pcie_ep_write_header()
> >     =>dw_pcie_prog_inbound_atu()  
> > 
> > outbound atu programming could be called through
> > pci_bus_read_config_dword()
> >   =>dw_pcie_rd_conf()
> >     =>dw_pcie_prog_outbound_atu()  
> > 
> > Fix this issue by calling mdelay() instead.
> 
> Any comments about this patch?
> 
> Thanks,
> Jisheng
> 
> > 
> > Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> > Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")

Can you split it into two patches and repost it please ? It will make
everyone's life easier to backport it if there is need, I will apply
then.

Thanks,
Lorenzo

> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> > 
> > since v2:
> >  - Add Fixes tag
> >  - Add Gustavo's Ack
> > 
> > since v1:
> >  - use mdelay() instead of udelay() to avoid __bad_udelay()
> > 
> >  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
> >  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 778c4f76a884..2153956a0b20 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> >  }
> > @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> >  }
> > @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> >  
> > @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 96126fd8403c..9f1a5e399b70 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -26,8 +26,7 @@
> >  
> >  /* Parameters for the waiting for iATU enabled routine */
> >  #define LINK_WAIT_MAX_IATU_RETRIES	5
> > -#define LINK_WAIT_IATU_MIN		9000
> > -#define LINK_WAIT_IATU_MAX		10000
> > +#define LINK_WAIT_IATU			9
> >  
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_LINK_CONTROL		0x710
> 
