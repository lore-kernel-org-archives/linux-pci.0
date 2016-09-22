Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934129AbcIVPBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 11:01:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: zhichang <zhichang.yuan02@gmail.com>,
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
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Thu, 22 Sep 2016 16:59:29 +0200
Message-ID: <1669038.JevuM4F83e@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F882AD3@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <9178320.n4yHmfyPA3@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F882AD3@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 22, 2016 2:47:14 PM CEST Gabriele Paoloni wrote:
> > >  static int of_empty_ranges_quirk(struct device_node *np)
> > >  {
> > >         if (IS_ENABLED(CONFIG_PPC)) {
> > > @@ -503,7 +512,7 @@ static int of_translate_one(struct device_node
> > *parent, struct of_bus *bus,
> > >          * This code is only enabled on powerpc. --gcl
> > >          */
> > >         ranges = of_get_property(parent, rprop, &rlen);
> > > -       if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
> > > +       if (ranges == NULL && !of_empty_ranges_quirk(parent) &&
> > !of_isa_indirect_io(parent)) {
> > >                 pr_debug("OF: no ranges; cannot translate\n");
> > >                 return 1;
> > >         }
> > 
> > I don't see what effect that would have. What do you want to
> > achieve with this?
> 
> If I read the code correctly adding the function above would end
> up in a 1:1 mapping:
> http://lxr.free-electrons.com/source/drivers/of/address.c#L513
> 
> so taddr will be assigned with the cpu address space specified
> in the children nodes of LPC and we are not using a quirk function
> (we are just checking that we have the indirect io assigned and
> that we are on a ISA bus). Now probably there is a nit in my 
> code sketch where of_isa_indirect_io should be probably an architecture
> specific function...

But the point is that it would then return an incorrect address,
which in the worst case could be the same as another I/O space
if that happens to be at CPU address zero.

> > I think all we need from this function is to return '1' if
> > we hit an ISA I/O window, and that should happen for the two
> > interesting cases, either no 'ranges' at all, or no translation
> > for the range in question, so that __of_translate_address can
> > return OF_BAD_ADDR, and we can enter the special case
> > handling in the caller, that handles it like
> > 
> 
> I don't think this is very right as you may fail for different
> reasons other than a missing range property, e.g:
> http://lxr.free-electrons.com/source/drivers/of/address.c#L575
> 
> And even if the only failure case was a missing range if in the
> future __of_translate_address had to be reworked we would again
> make a wrong assumption...you get my point?

The newly introduced function would clearly have to make
some sanity checks. The idea is that treat the case of
not being able to translate a bus specific I/O address
into a CPU address literally and fall back to another method
of translating that address.

This matches my mental model of how we find the resource:

- start with the bus address
- try to translate that into a CPU address
- if we arrive at a CPU physical address for IORESOURCE_MEM, use that
- if we arrive at a CPU physical address for IORESOURCE_IO, translate
  that into a Linux IORESOURCE_IO token
- if there is no valid CPU physical address, try to translate
  the address into an IORESOURCE_IO using the ISA accessor
- if that fails too, give up.

If you try to fake a CPU physical address inbetween, it just
gets more confusing.

	Arnd
