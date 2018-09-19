Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITA1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 20:27:40 -0400
Date: Wed, 19 Sep 2018 11:48:21 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: lorenzo.pieralisi@arm.com, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
Message-ID: <20180919184821.GA28548@flashbox>
References: <20180919053829.4858-1-natechancellor@gmail.com>
 <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
 <CAKwvOd=ughACX1DVPrk9N-qhe_ww4hCu3FkuDTVOq+MUEuGUbA@mail.gmail.com>
 <20180919175849.GA8787@flashbox>
 <CAKwvOdkQGHvE4JgfwZ2Hvk0HowBFvTBWwBSpkVtKX4U4iBEg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKwvOdkQGHvE4JgfwZ2Hvk0HowBFvTBWwBSpkVtKX4U4iBEg=w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 11:35:45AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 10:58 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Sep 19, 2018 at 10:35:55AM -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 19, 2018 at 3:29 AM Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > >
> > > > Xiaowei, Binghui,
> > > >
> > > > On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> > > > > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > > > > the function kirin_pcie_probe() to the function
> > > > > .init.text:kirin_add_pcie_port()
> > > > > The function kirin_pcie_probe() references
> > > > > the function __init kirin_add_pcie_port().
> > > > > This is often because kirin_pcie_probe lacks a __init
> > > > > annotation or the annotation of kirin_add_pcie_port is wrong.
> > > > >
> > > > > Remove '__init' from kirin_add_pcie_port so there is no mismatch.
> > > >
> > > > I think that instead of removing __init section tag we should add
> > > > it to kirin_pcie_probe().
> > >
> > > A bunch of these functions have a single call site, with a mix of __init:
> > >
> > > kirin_pcie_probe() ->
> > >   kirin_add_pcie_port() ->  // __init
> > >     kirin_pcie_add_msi()
> > >
> > > But it looks like probe functions should be marked init:
> > > $ cd drivers; grep -r __init | grep probe
> > >
> > > seems to turn up quite a lot of *probe() functions that are marked __init.
> > > https://www.tldp.org/LDP/lkmpg/2.4/html/x281.htm has more info, and
> > > from reading that, it seems that it's a no-op for a module that's
> > > marked loadable.
> > >
> > > So I agree; __init should be added to kirin_pcie_probe(), but also
> > > kirin_pcie_add_msi().  That way if the module is statically compiled
> > > into the kernel image, these functions with a single call site get
> > > cleaned up after init.
> > >
> > > Nathan, would you mind sending a v2?
> > >
> >
> > Hi Nick and Lorenzo,
> >
> > I had tested adding __init to both kirin_pcie_probe and
> > kirin_pcie_add_msi but ran into this warning:
> >
> > WARNING: vmlinux.o(.data+0x68b78): Section mismatch in reference from
> > the variable kirin_pcie_driver to the function
> 
> I think we want builtin_platform_driver_probe() here.
> 
> Try removing the probe reference from the declaration of
> kirin_pcie_driver, and then calling
> 
> builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);
> 
> Does that fix the section mismatches, while keeping as much in __init
> as possible?
> 

Hi Nick,

Thank you for that suggestion, it worked. I will send a v2 for review
shortly.

Nathan

> > .init.text:kirin_pcie_probe()
> > The variable kirin_pcie_driver references
> > the function __init kirin_pcie_probe()
> >
> > Doing a quick 'grep -r __init | grep platform_driver' doesn't show any
> > 'static struct platform_driver' constructs marked as __init, leading me
> > to believe this patch is the proper solution.
> >
> > I'm happy to hear otherwise, thank you both for the quick responses,
> > Nathan
> >
> > > >
> > > > Please let me know and ACK accordingly.
> > > >
> > > > Lorenzo
> > > >
> > > > > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > index 5352e0c3be82..9b599296205d 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > > @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > > > > -                                   struct platform_device *pdev)
> > > > > +static int kirin_add_pcie_port(struct dw_pcie *pci,
> > > > > +                            struct platform_device *pdev)
> > > > >  {
> > > > >       int ret;
> > > > >
> > > > > --
> > > > > 2.19.0
> > > > >
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
