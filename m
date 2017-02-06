Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34239 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdBFJzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 04:55:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id 89so2828198wrr.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2017 01:55:08 -0800 (PST)
Date: Mon, 6 Feb 2017 10:55:03 +0100 (CET)
From: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1702061038590.7077@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org> <20170128204839.18330-4-linus.walleij@linaro.org> <alpine.LNX.2.00.1702051101110.26313@T420s> <CACRpkdbrys49Yv5fJ_te2H1mEUqquc1jn2dP-uvkdLixFbtYFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

On Sun, 5 Feb 2017, Linus Walleij wrote:

> On Sun, Feb 5, 2017 at 11:03 AM, Hans Ulli Kroll
> <ulli.kroll@googlemail.com> wrote:
> 
> > We need to the remove hwirq 26-28 from DT.
> > First one will print this warning while boot.
> >
> > irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller@48000000!
> (...)
> > -                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> > -                                       <26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> > -                                       <27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> > -                                       <28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> > +                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* chained irq PCI A-D */
> 
> Sure I can remove them ... just found them in the irqs.h file and thought it
> made sense to add them. I'll just cut them.
> 
> Since there is actually an internal IRQ controller in the host controller
> cascading the four PCI child IRQs that we model as an irqchip, I don't
> really see why they have these "PCI B-D" IRQs... anyone has a guess?

I think they used some other IP vendor.

from my IB 4220 sources.

#define IRQ_PCI_INTA				       PCI_IRQ_OFFSET + 0
#ifndef CONFIG_DUAL_PCI
#define IRQ_PCI_INTB				       PCI_IRQ_OFFSET + 1
#define IRQ_PCI_INTC				       PCI_IRQ_OFFSET + 2
#define IRQ_PCI_INTD				       PCI_IRQ_OFFSET + 3
#else
#define IRQ_PCI_INTB				       27
#define IRQ_PCI_INTC				       28
#define IRQ_PCI_INTD				       29
#endif

CONFIG_DUAL_PCI is never used
IRQ_PCIB - IRQ_PCID or IRQ_PCI_INTB - IRQ_PCI_INTD are also never used.

You can download my original NAS 4220 here
http://ulli-kroll.de/gemini/kernel.tgz

Greetings
Hans Ulli Kroll
