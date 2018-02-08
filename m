Return-Path: <SRS0=5Nig=FC=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=5Nig=FC=kernel.crashing.org=benh@kernel.org>
Message-ID: <1518128503.2312.219.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>,
        Alistair
 Popple <alistair@popple.id.au>, linux-pci@vger.kernel.org
Date: Fri, 09 Feb 2018 09:21:43 +1100
In-Reply-To: <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208053354.41725-1-aik@ozlabs.ru>
	 <CAErSpo7S7vJTKBrxuzH-G0y-U2Z15jKpPJDZEEuhh7vAs0hjOA@mail.gmail.com>
	 <20180208213956.GC98765@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-02-08 at 15:39 -0600, Bjorn Helgaas wrote:
> I don't understand how this fix works.  We used to check the result of
> of_irq_parse_and_map_pci() and entered the block if it was zero.
> 
> Now you enter the block if it is zero or less than zero, but:
> 
>   static int pci_read_irq_line(...)
>   {
>     unsigned int virq = 0;     /* unnecessarily initialized, BTW */
> 
>     virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
>     if (virq <= 0) {
>       ...
> 
> virq is unsigned, so "virq < 0" can never be true.  So how does this
> change anything?

Yes it does:

So the unsigned thing is a second bug in the original patch that Alexey
isn't fixing, we need to fix it too.

However, the actual bug Alexey is fixing is that we lost the actual
value of virq. IE, without his fix, we test it for 0 but we don't
actually return it if it's positive.

So he fixes the normal case but there's still a bug in the error case,
we need to make virq signed.

Cheers,
Ben.
