Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:3520 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbcIVOsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 10:48:01 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: zhichang <zhichang.yuan02@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "kantyzc@163.com" <kantyzc@163.com>
Subject: RE: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 22 Sep 2016 14:47:14 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F882AD3@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <3538381.vOsx75UXVU@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F881744@lhreml507-mbx>
 <9178320.n4yHmfyPA3@wuerfel>
In-Reply-To: <9178320.n4yHmfyPA3@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 22 September 2016 13:15
> To: Gabriele Paoloni
> Cc: zhichang; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; lorenzo.pieralisi@arm.com; minyard@acm.org;
> linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; John Garry;
> will.deacon@arm.com; linux-kernel@vger.kernel.org; Yuanzhichang;
> Linuxarm; xuwei (O); linux-serial@vger.kernel.org;
> benh@kernel.crashing.org; zourongrong@gmail.com; liviu.dudau@arm.com;
> kantyzc@163.com
> Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Thursday, September 22, 2016 11:55:45 AM CEST Gabriele Paoloni
> wrote:
> > > > I think extending of_empty_ranges_quirk() may be a reasonable
> > > solution.
> > > > What do you think Arnd?
> > >
> > > I don't really like that idea, that quirk is meant to work around
> > > broken DTs, but we can just make the DT valid and implement the
> > > code properly.
> >
> > Ok  I understand your point where it is not right to use
> of_empty_ranges_quirk()
> > As a quirk is used to work around broken HW or broken FW (as in this
> case)
> > rather than to fix code
> >
> > What about the following? I think adding the check you suggested next
> to
> > of_empty_ranges_quirk() is adding the case we need in the right point
> (thus
> > avoiding any duplication)
> >
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -457,6 +457,15 @@ static struct of_bus *of_match_bus(struct
> device_node *np)
> >         return NULL;
> >  }
> >
> > +static inline int of_isa_indirect_io(struct device_node *np)
> > +{
> > +       /*
> > +        * check if the current node is an isa bus and if indirectio
> operation
> > +        * are registered
> > +        */
> > +       return (of_bus_isa_match(np) && arm64_extio_ops);
> > +}
> > +
> >  static int of_empty_ranges_quirk(struct device_node *np)
> >  {
> >         if (IS_ENABLED(CONFIG_PPC)) {
> > @@ -503,7 +512,7 @@ static int of_translate_one(struct device_node
> *parent, struct of_bus *bus,
> >          * This code is only enabled on powerpc. --gcl
> >          */
> >         ranges = of_get_property(parent, rprop, &rlen);
> > -       if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
> > +       if (ranges == NULL && !of_empty_ranges_quirk(parent) &&
> !of_isa_indirect_io(parent)) {
> >                 pr_debug("OF: no ranges; cannot translate\n");
> >                 return 1;
> >         }
> 
> I don't see what effect that would have. What do you want to
> achieve with this?

If I read the code correctly adding the function above would end
up in a 1:1 mapping:
http://lxr.free-electrons.com/source/drivers/of/address.c#L513

so taddr will be assigned with the cpu address space specified
in the children nodes of LPC and we are not using a quirk function
(we are just checking that we have the indirect io assigned and
that we are on a ISA bus). Now probably there is a nit in my 
code sketch where of_isa_indirect_io should be probably an architecture
specific function...

> 
> I think all we need from this function is to return '1' if
> we hit an ISA I/O window, and that should happen for the two
> interesting cases, either no 'ranges' at all, or no translation
> for the range in question, so that __of_translate_address can
> return OF_BAD_ADDR, and we can enter the special case
> handling in the caller, that handles it like
> 

I don't think this is very right as you may fail for different
reasons other than a missing range property, e.g:
http://lxr.free-electrons.com/source/drivers/of/address.c#L575

And even if the only failure case was a missing range if in the
future __of_translate_address had to be reworked we would again
make a wrong assumption...you get my point?

Thanks

Gab

> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903fe9d2..a18d96843fae 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -685,17 +685,24 @@ static int __of_address_to_resource(struct
> device_node *dev,
>  	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
>  		return -EINVAL;
>  	taddr = of_translate_address(dev, addrp);
> -	if (taddr == OF_BAD_ADDR)
> -		return -EINVAL;
>  	memset(r, 0, sizeof(struct resource));
> +
>  	if (flags & IORESOURCE_IO) {
>  		unsigned long port;
> -		port = pci_address_to_pio(taddr);
> +
> +		if (taddr == OF_BAD_ADDR)
> +			port = arch_of_address_to_pio(dev, addrp)
> +		else
> +			port = pci_address_to_pio(taddr);
> +
>  		if (port == (unsigned long)-1)
>  			return -EINVAL;
>  		r->start = port;
>  		r->end = port + size - 1;
>  	} else {
> +		if (taddr == OF_BAD_ADDR)
> +			return -EINVAL;
> +
>  		r->start = taddr;
>  		r->end = taddr + size - 1;
>  	}
> 
> 
> 
> 	Arnd
