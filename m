Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:48970 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeBHMdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 07:33:05 -0500
Date: Thu, 8 Feb 2018 13:33:01 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: designware-ep: Return an error when requesting
 a too large BAR size
Message-ID: <20180208123301.GB9630@axis.com>
References: <20180201161119.3852-1-niklas.cassel@axis.com>
 <20180201161119.3852-4-niklas.cassel@axis.com>
 <CAHp75VdX5=kzKFunM-Kbw7KOBt3+xik_pxhX1EZdO9eA3QHrBQ@mail.gmail.com>
 <000601d39b8e$f58a76f0$e09f64d0$@gmail.com>
 <20180205162519.GA3044@axis.com>
 <CAHp75VcXt+gVucFYVv8rUYtPH6iAJBOeDTo45Y+k7hifF91Heg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VcXt+gVucFYVv8rUYtPH6iAJBOeDTo45Y+k7hifF91Heg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 06, 2018 at 09:38:09PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 5, 2018 at 6:25 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> > On Thu, Feb 01, 2018 at 02:00:40PM -0500, Jingoo Han wrote:
> >> On Thursday, February 1, 2018 1:58 PM, Andy Shevchenko wrote:
> >> >
> >> > On Thu, Feb 1, 2018 at 6:11 PM, Niklas Cassel <niklas.cassel@axis.com>
> >> > wrote:
> >> >
> >> > include/linux/sizes.h:
> >> >
> >> > +SZ_4G  0x100000000ULL
> >> >
> >> > > +       if (size > 0x100000000ULL) {
> >> >
> >> > #include <linux/sizes.h>
> >> >
> >> > if (size > SZ_4G) {
> >>
> >> I like this one for the readability.
> >> Thank you.
> >>
> >
> > I liked it too, however both variants
> >
> > if (size > 0x100000000ULL) {
> >
> > if (size > SZ_4G) {
> >
> > result in:
> >
> > drivers/pci/dwc/pcie-designware-ep.c:131:11: warning:
> >   comparison is always false due to limited range of data type [-Wtype-limits]
> >
> > when compiling with W=1 on a platform with 32-bit size_t.
> >
> >
> > The annoying thing here is that a BAR can be 64-bit,
> > yet the parameter size is defined as a size_t,
> > so the error will only show on 32-bit and not on 64-bit.
> 
> Oh, indeed. And it looks moving to u64 or alike is not a solution
> (because if would not describe real hardware in that case).
> 
> > What do you think about:
> 
> > if (upper_32_bits(size)) {
> >         dev_err(pci->dev, "can't handle BAR larger than 4GB\n");
> >         return -EINVAL;
> > }
> >
> > That should compile without warnings for both
> > 32-bit size_t and 64-bit size_t.
> 
> Can you derive some helper based on the code in __pci_read_base() code?

Hello Andy,

I guess that would be possible, however I think that
simply checking upper_32_bits(size) is simpler.

If someone is ever to fix dw_pcie_ep_set_bar()
so that it works with 64-bit BARs, the function will
probably need to check upper_32_bits(size) anyway.


Regards,
Niklas
