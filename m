Return-Path: <SRS0=RIT1=7L=mediatek.com=honghui.zhang@kernel.org>
Return-Path: <SRS0=RIT1=7L=mediatek.com=honghui.zhang@kernel.org>
Message-ID: <1502261392.17420.5.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Add new generation controller
 support
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>, <paul.burton@imgtec.com>
CC: <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
	<hongkun.cao@mediatek.com>, <ryder.lee@mediatek.com>,
	<linux-pci@vger.kernel.org>, <sean.wang@mediatek.com>,
	<xinping.qian@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <yt.shen@mediatek.com>, <matthias.bgg@gmail.com>,
	<robh@kerenl.org>, <linux-mediatek@lists.infradead.org>,
	<yong.wu@mediatek.com>, <bhelgaas@google.com>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date: Wed, 9 Aug 2017 14:49:52 +0800
In-Reply-To: <20170808201912.GJ16580@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
	 <824c61d13fe2731d812df8a0a878ca1a36399e76.1501122135.git.honghui.zhang@mediatek.com>
	 <20170803224206.GN20308@bhelgaas-glaptop.roam.corp.google.com>
	 <1501835976.24341.21.camel@mtksdaap41>
	 <20170804131808.GA16580@bhelgaas-glaptop.roam.corp.google.com>
	 <20170808201912.GJ16580@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2017-08-08 at 15:19 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 04, 2017 at 08:18:09AM -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> > > On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:
> 
> > > > > +	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
> > > > > +						 &intx_domain_ops, port);
> > > > 
> > > > I think there's an issue here with a 4-element IRQ domain and the
> > > > hwirq numbers 1-4 from the of_irq_parse_and_map_pci() path, so INTD
> > > > may not work correctly.
> > > > 
> > > > See
> > > > http://lkml.kernel.org/r/20170801212931.GA26498@bhelgaas-glaptop.roam.corp.google.com
> > > > and related discussion.
> > > 
> > > Sorry, I did not get this,
> > > I do some test with an intel E350T4 PCIe NICs, it's a x1 lane
> > > multi-function device.
> > > What I got from the log is below:
> > > ->of_irq_parse_and_map_pci
> > > 	->of_irq_parse_pci
> > > 		->irq_create_of_mapping
> > > 			->irq_create_fwspec_mapping
> > > 				->irq_domain_translate
> > > 				which will go through
> > > 				d->ops->translate #the hwirq really start from 0
> > > 
> > > And I tested every NIC port of the Intel E350T4 with tftp transfer data,
> > > seems all are OK with this code.
> > 
> > OK.  I don't know what d->ops->translate is involved here, but if it
> > works, I guess this is OK for now.  We're trying to clean this up and
> > make it consistent across all the drivers.  Many of them allocate a
> > 5-element IRQ domain, some make a 4-element domain, and on some of
> > them INTD doesn't work.  It's a mess.
> 
> Paul Burton is cleaning this up.  Can you point out the d->ops->translate
> function that's involved here?

Hi, Bjorn,

Sorry for my last reply, I was tracking the wrong logs. The real trick
is here:

->of_irq_parse_and_map_pci
  ->of_irq_parse_pci	#out_irq->args[0] start from 1(1 == INTA)
     ->of_irq_parse_raw

After of_irq_parse_raw finished it's work, the out_irq->args[0] will be
remapped as "interrupt-map" property defines[1], which in my case, it's
start from 0, and then fwspec->param[0] is start from 0 (0 == INTA).

My "interrupt-map" property is defined as below:
interrupt-map = <0 0 0 1 &pcie_intc0 0>,
		<0 0 0 2 &pcie_intc0 1>,
		<0 0 0 3 &pcie_intc0 2>,
		<0 0 0 4 &pcie_intc0 3>;

I do some test with the changes of property defined as below:
interrupt-map = <0 0 0 1 &pcie_intc0 1>,
		<0 0 0 2 &pcie_intc0 2>,
		<0 0 0 3 &pcie_intc0 3>,
		<0 0 0 4 &pcie_intc0 4>;
Then I got the same running complain as Paul have got[2]

So I guess it's the "interrupt-map" property defined in dtsi node play
the key role in this.

[1]http://elixir.free-electrons.com/linux/v4.13-rc4/source/drivers/of/irq.c#L265
[2]https://patchwork.kernel.org/patch/9794355

thanks.
