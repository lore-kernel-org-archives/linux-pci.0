Return-Path: <SRS0=pWG6=7L=imgtec.com=Paul.Burton@kernel.org>
Return-Path: <SRS0=pWG6=7L=imgtec.com=Paul.Burton@kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Honghui Zhang <honghui.zhang@mediatek.com>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
	<hongkun.cao@mediatek.com>, <ryder.lee@mediatek.com>,
	<linux-pci@vger.kernel.org>, <sean.wang@mediatek.com>,
	<xinping.qian@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <yt.shen@mediatek.com>, <matthias.bgg@gmail.com>,
	<robh@kerenl.org>, <linux-mediatek@lists.infradead.org>,
	<yong.wu@mediatek.com>, <bhelgaas@google.com>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/5] PCI: mediatek: Add new generation controller support
Date: Wed, 9 Aug 2017 09:43:25 -0700
Message-ID: <3973443.7gXFUutQhY@np-p-burton>
In-Reply-To: <1502261392.17420.5.camel@mtksdaap41>
References: <cover.1501122135.git.honghui.zhang@mediatek.com> <20170808201912.GJ16580@bhelgaas-glaptop.roam.corp.google.com> <1502261392.17420.5.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4656749.UlJgSgIPiG";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--nextPart4656749.UlJgSgIPiG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Honghui & Bjorn,

On Tuesday, 8 August 2017 23:49:52 PDT Honghui Zhang wrote:
> On Tue, 2017-08-08 at 15:19 -0500, Bjorn Helgaas wrote:
> > On Fri, Aug 04, 2017 at 08:18:09AM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 04, 2017 at 04:39:36PM +0800, Honghui Zhang wrote:
> > > > On Thu, 2017-08-03 at 17:42 -0500, Bjorn Helgaas wrote:
> > > > > > +	port->irq_domain = irq_domain_add_linear(pcie_intc_node,
> > > > > > INTX_NUM,
> > > > > > +						 &intx_domain_ops, port);
> > > > > 
> > > > > I think there's an issue here with a 4-element IRQ domain and the
> > > > > hwirq numbers 1-4 from the of_irq_parse_and_map_pci() path, so INTD
> > > > > may not work correctly.
> > > > > 
> > > > > See
> > > > > http://lkml.kernel.org/r/20170801212931.GA26498@bhelgaas-glaptop.roa
> > > > > m.corp.google.com and related discussion.
> > > > 
> > > > Sorry, I did not get this,
> > > > I do some test with an intel E350T4 PCIe NICs, it's a x1 lane
> > > > multi-function device.
> > > > What I got from the log is below:
> > > > ->of_irq_parse_and_map_pci
> > > > 
> > > > 	->of_irq_parse_pci
> > > > 	
> > > > 		->irq_create_of_mapping
> > > > 		
> > > > 			->irq_create_fwspec_mapping
> > > > 			
> > > > 				->irq_domain_translate
> > > > 				which will go through
> > > > 				d->ops->translate #the hwirq really start from 0
> > > > 
> > > > And I tested every NIC port of the Intel E350T4 with tftp transfer
> > > > data,
> > > > seems all are OK with this code.
> > > 
> > > OK.  I don't know what d->ops->translate is involved here, but if it
> > > works, I guess this is OK for now.  We're trying to clean this up and
> > > make it consistent across all the drivers.  Many of them allocate a
> > > 5-element IRQ domain, some make a 4-element domain, and on some of
> > > them INTD doesn't work.  It's a mess.
> > 
> > Paul Burton is cleaning this up.  Can you point out the d->ops->translate
> > function that's involved here?
> 
> Hi, Bjorn,
> 
> Sorry for my last reply, I was tracking the wrong logs. The real trick
> is here:
> 
> ->of_irq_parse_and_map_pci
>   ->of_irq_parse_pci	#out_irq->args[0] start from 1(1 == INTA)
>      ->of_irq_parse_raw
> 
> After of_irq_parse_raw finished it's work, the out_irq->args[0] will be
> remapped as "interrupt-map" property defines[1], which in my case, it's
> start from 0, and then fwspec->param[0] is start from 0 (0 == INTA).
> 
> My "interrupt-map" property is defined as below:
> interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> 		<0 0 0 2 &pcie_intc0 1>,
> 		<0 0 0 3 &pcie_intc0 2>,
> 		<0 0 0 4 &pcie_intc0 3>;
> 
> I do some test with the changes of property defined as below:
> interrupt-map = <0 0 0 1 &pcie_intc0 1>,
> 		<0 0 0 2 &pcie_intc0 2>,
> 		<0 0 0 3 &pcie_intc0 3>,
> 		<0 0 0 4 &pcie_intc0 4>;
> Then I got the same running complain as Paul have got[2]
> 
> So I guess it's the "interrupt-map" property defined in dtsi node play
> the key role in this.
> 
> [1]http://elixir.free-electrons.com/linux/v4.13-rc4/source/drivers/of/irq.c#
> L265 [2]https://patchwork.kernel.org/patch/9794355
> 
> thanks.

That seems like a possibly more sensible way to handle it, so long as you have 
control over all the device trees that the driver may be exposed to.

Bjorn: is this something you want to deal with on a driver by driver basis? 
ie. new drivers just use interrupt-map as above and older ones with existing 
DT bindings use the xlate function? Looking at the drivers & device trees we 
have in-tree it seems we already have a mix of 0-3 & 1-4 ranges in use, so 
we'd just need to use the xlate function for those which currently use 1-4.

I had originally done the same thing with interrupt-map on the MIPS Boston 
board[1] and the Xilinx PCIe driver[2], though that change would break any 
pre-existing device trees that use 1-4 in the interrupt-map property (which is 
sadly what the driver's binding document shows...).

Thanks,
    Paul

[1] https://www.linux-mips.org/archives/linux-mips/2016-08/msg00425.html
[2] https://patchwork.kernel.org/patch/9763191/
--nextPart4656749.UlJgSgIPiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmLO60ACgkQgiDZ+mk8
HGUQbw//TmLHkh+bvOPQeUpZaogIb8o7hlE9wlntyCY8dk4+R/RvA2EP98ZPh6OW
mFbW1Ar0gDBK3jnEqoKIdKu5b69UjLONCEt8YaUKqWLUWNbGet8X7oNEmueiNkdu
BXkw223FMu0G70dQkQEDc4hpKITUs9mp5cBZMq4tdQCbKfzYenpOD2+jE9rWiyMf
pCnsnj+3FMIyOCUBvD6EBfHB4OH/ZBFI4cuTfCjDOptL4k1xSxGJNYklOu7NiG1M
s1XtnbQJOumK9TnZN0Rhsb8EH/uo8v/PDOoGR4HGgQXurYUjJ4nzi4lvmFXz+ZSK
u8w61kAn37S4rBrm4jZ3p7OaN84pRDI8UdGQMJY8WN4POK5tiKOHpVDRQZRlbTlE
BHhwRzrN7ez1db3PPSjGj8gx797ES9jdwpUL0W/8eGgSKGrKXFHRE+MlzJaW+l+C
B0yzoquvGTbAXB+JD26zfaJyd9DIDor4b+tXjcTEeY7HxPRh7qiY9CQV1xwPGgLY
Ih9ug9VWPotpvCB0f8hjytEKVd5vvDtHXLXVBK6Se5nqT6gVfvJbSswn4Bd+APgG
FYtRPShzyibYGKYlmqJSeVmUfKHfm/VPks+fVlOfg+xB0i0pkmbBxekI5aZ5l+H2
2l1l3/hsly96QSvzuBZgzrPMxM0VY2j8usiniBMzL7W3Kw00n24=
=rYvY
-----END PGP SIGNATURE-----

--nextPart4656749.UlJgSgIPiG--
