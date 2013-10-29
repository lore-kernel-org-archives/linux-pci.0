Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:55405 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3J2Tqg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 15:46:36 -0400
Received: by mail-ie0-f176.google.com with SMTP id u16so584010iet.7
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 12:46:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHM4w1nyXCuTya+TR7Rxiw0ojmwZHwz9iUmz=cG8z_8h2wKhSw@mail.gmail.com>
References: <1382056042-7299-1-git-send-email-tharvey@gateworks.com>
 <201310190333.52772.marex@denx.de> <CAHM4w1nyXCuTya+TR7Rxiw0ojmwZHwz9iUmz=cG8z_8h2wKhSw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Oct 2013 13:46:15 -0600
Message-ID: <CAErSpo5NHXXZPm5wj05DSD94KkzEUkefceHPC_Zup+-APUYdKQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix imprecise abort handler
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 21, 2013 at 2:16 AM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> Hi,
>
> On Sat, Oct 19, 2013 at 7:03 AM, Marek Vasut <marex@denx.de> wrote:
>>
>> Dear Tim Harvey,
>>
>> > An imprecise abort is triggered when a port behind a switch is accessed
>> > and no device is present.  At enumeration, imprecise aborts are not
>> > enabled
>
>
>
> I do not know the complete history. But I do not understand, why
> imprecise aborts are not enabled during kernel enumeration.
> What happens when PCIe switch is already connected before boot?
> pci_common_init will try to read vendor/product ID for a non-existing
> function during kernel enumeration itself, which should result in imprecise
> external abort. In fact, I had observed with my system that if a switch is
> connected to PCIe RC, then abort occurs during kernel initialization itself.
> So a proper handling was needed. We called hook_fault_code from
> a subsys_init pcie_init (or similar) function, which insured that abort
> handler is called whenever, software tries to read vendor/product id of
> a non-existing function
>
>>
>> > thus this ends up getting deferred until the kernel has completed init.
>> > At
>> > that point we must not adjust PC - the handler must do nothing, but a
>> > handler must exist.
>> >
>> > This fixes random crashes that occur right after freeing init.
>> > This is against linux-pci/host-imx6.
>> >
>> > Acked-by: Marek Vasut <marex@denx.de>
>> > Tested-by: Marek Vasut <marex@denx.de>
>> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>
>> Expanding CC a bit, let's have more eyes on this.
>>
>> > ---
>> >  drivers/pci/host/pci-imx6.c |    6 ------
>> >  1 file changed, 6 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> > index 966bac6..90fce05 100644
>> > --- a/drivers/pci/host/pci-imx6.c
>> > +++ b/drivers/pci/host/pci-imx6.c
>> > @@ -200,12 +200,6 @@ static int pcie_phy_write(void __iomem *dbi_base,
>> > int
>> > addr, int data) static int imx6q_pcie_abort_handler(unsigned long addr,
>> >               unsigned int fsr, struct pt_regs *regs)
>> >  {
>> > -     /*
>> > -      * If it was an imprecise abort, then we need to correct the
>> > -      * return address to be _after_ the instruction.
>> > -      */
>> > -     if (fsr & (1 << 10))
>> > -             regs->ARM_pc += 4;
>
>
> Just for knowledge, is there any case other than read of IDs which might
> cause imprecise abort? If not, then this handler can be modified a bit to
> insure
> that it does not handle any unintended imprecise abort.
>
> Regards
> Pratyush
>
>>
>> >       return 0;
>> >  }

I'm sort of dubious about imx6q_pcie_abort_handler() to begin with --
it seems like it assumes that imprecise aborts are either enabled or
disabled.  Isn't there some way it can *check* whether that's the
case, so it won't break if those aborts are enabled at a different
point in the future?

For now, I'll apply this to my pci/host-imx6 branch for v3.13, but let
me know if you want to tweak it somehow.

Bjorn
