Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42024 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeBECDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Feb 2018 21:03:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-21-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-21-ulfalizer@gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 5 Feb 2018 03:03:29 +0100
Message-ID: <CAFkk2KRNMKEoArwi9XQryEDe-VMbbL0WySXh_ydLKchke6XQcw@mail.gmail.com>
Subject: Re: [PATCH 20/20] x86/PCI: VMD: Fix malformed default
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan@altera.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> 'default N' should be 'default n', though they happen to have the same
> effect here, due to undefined symbols (N in this case) evaluating to n
> in a tristate sense.
>
> Remove the default from VMD instead of changing it. bool and tristate
> symbols implicitly default to n.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  drivers/pci/host/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index a4ed7484d127..dc8a2a175f19 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -215,7 +215,6 @@ config PCIE_TANGO_SMP8759
>  config VMD
>         depends on PCI_MSI && X86_64 && SRCU
>         tristate "Intel Volume Management Device Driver"
> -       default N
>         ---help---
>           Adds support for the Intel Volume Management Device (VMD). VMD is a
>           secondary PCI host bridge that allows PCI Express root ports,
> --
> 2.14.1
>

The PCIE_ALTERA symbol in this file also depends on the globally
undefined symbol OF_PCI, which was removed in 4670d610d592 ("PCI: Move
OF-related PCI functions into PCI core").

Cheers,
Ulf
