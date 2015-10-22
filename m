Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42762 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbbJVQfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 12:35:38 -0400
Date: Thu, 22 Oct 2015 11:35:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"gabriel.fernandez@linaro.org" <gabriel.fernandez@linaro.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v11 1/6] PCI: designware: move calculation of bus
 addresses to DRA7xx
Message-ID: <20151022163534.GB21237@localhost>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
 <1444991021-109306-2-git-send-email-wangzhou1@hisilicon.com>
 <20151021221524.GM1583@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E16274DCC@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E16274DCC@lhreml503-mbs>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On Thu, Oct 22, 2015 at 07:21:41AM +0000, Gabriele Paoloni wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]

> > >  #define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
> > >  #define	LINK_UP						BIT(16)
> > > +#define	CPU_TO_BUS_ADDR					0x0FFFFFFF
> > 
> > "CPU_TO_BUS_ADDR" is a very generic name.  Since you do have DRA7XX in
> > other #defines and static symbols in this file, maybe it could be DRA7XX to
> > make it obvious that it only applies here?
> 
> Ok will change to DRA7XX_CPU_TO_BUS_ADRR in v12
> ..

> > > +	if (pp->io_mod_base)
> > > +		pp->io_mod_base &= CPU_TO_BUS_ADDR;
> > 
> > These are equivalent to
> > 
> >   pp->io_mod_base &= CPU_TO_BUS_ADDR;
> > 
> > (You don't need to test whether they're zero first.)
> 
> Yes agreed, will change in v12
> ...

> > >  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> > > @@ -415,8 +411,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >  			pp->io_base = range.cpu_addr;
> > >
> > >  			/* Find the untranslated IO space address */
> > > -			pp->io_mod_base = of_read_number(parser.range -
> > > -							 parser.np + na, ns);
> > > +			pp->io_mod_base = range.cpu_addr;
> > 
> > So apparently
> > 
> >   "of_read_number() == range.cpu_addr & CPU_TO_BUS_ADDR" on DRA7xx
> >   "of_read_number() == range.cpu_addr" everywhere else?
> 
> Yes correct
> 
> > Is that right?  Is that a valid assumption, i.e., are we assuming
> > anything about DTs in the field that we shouldn't?
> 
> Before I wrote a patch that was generic to accommodate intermediate level
> of translation between PCI_addr -> BUS_addr -> CPU_addr
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/360922.html
> 
> After discussion we agreed to solve it with a bitmask rather than adding
> a field to of_pci_range to make it generic.
> The bitmask only applies to DRA7xx

I haven't gotten all the way through this series yet, but don't bother with
a v12 just for these minor changes.  I can easily fix them up when applying
it.

Bjorn
