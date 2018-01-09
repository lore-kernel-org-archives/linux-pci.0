Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Tue, 9 Jan 2018 17:10:22 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper
 <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>,
 stable@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu
 <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Antoine Tenart
 <antoine.tenart@free-electrons.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: aardvark: set PIO_ADDR_LS correctly in
 advk_pcie_rd_conf()
Message-ID: <20180109171022.7c989501@windsurf.lan>
In-Reply-To: <20171005172545.GQ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20170928125838.11887-3-thomas.petazzoni@free-electrons.com>
	<20171005172545.GQ25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 5 Oct 2017 12:25:45 -0500, Bjorn Helgaas wrote:

> > diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> > index da2881ba7737..af7a9c4a61a4 100644
> > --- a/drivers/pci/host/pci-aardvark.c
> > +++ b/drivers/pci/host/pci-aardvark.c
> > @@ -459,7 +459,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  	advk_writel(pcie, reg, PIO_CTRL);
> >  
> >  	/* Program the address registers */
> > -	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
> > +	reg = PCIE_CONF_ADDR(bus->number, devfn, where);  
> 
> I think PCIE_BDF() is now unused and should be removed.

True, I'll fix this in v3.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
