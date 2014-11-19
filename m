Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43603 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbaKSXbG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 18:31:06 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so1674876iec.30
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 15:31:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141119212229.GD23467@google.com>
References: <20141118105542.457d7863@free-electrons.com>
	<20141118105843.3c1651d5@free-electrons.com>
	<20141118123402.7318ec94@free-electrons.com>
	<CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
	<CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
	<20141118220000.3ab0d2d9@free-electrons.com>
	<CAE9FiQXo3ctdFk2Z+duaq1wxSAVCA0tG5_f85-UaLk8+Dafhvg@mail.gmail.com>
	<20141119212229.GD23467@google.com>
Date: Wed, 19 Nov 2014 15:31:05 -0800
Message-ID: <CAE9FiQXJ80GhjBZG1aG8aX1R=g6xmUi3w-AiXEODspvsB2vfpA@mail.gmail.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	=?UTF-8?Q?Gregory_Cl=C3=A9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 19, 2014 at 1:22 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I propose the following third alternative, which always computes full
> 64-bit base/limit, then casts them to the dma_addr_t size and compares to
> see if anything got chopped off.
>
> This is on top of pci/for-linus.  Whatever we settle on, I'll fold it into
> the original patch before asking Linus to pull it.
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c5b1ca53bcd..c8ca98c2b480 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -407,6 +407,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
>  {
>         struct pci_dev *dev = child->self;
>         u16 mem_base_lo, mem_limit_lo;
> +       u64 base64, limit64;
>         dma_addr_t base, limit;
>         struct pci_bus_region region;
>         struct resource *res;
> @@ -414,8 +415,8 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
>         res = child->resource[2];
>         pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
>         pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
> -       base = ((dma_addr_t) mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> -       limit = ((dma_addr_t) mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
> +       base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> +       limit64 = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
>
>         if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
>                 u32 mem_base_hi, mem_limit_hi;
> @@ -429,17 +430,20 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
>                  * this, just assume they are not being used.
>                  */
>                 if (mem_base_hi <= mem_limit_hi) {
> -                       if (sizeof(dma_addr_t) < 8) {
> -                               if (mem_base_hi || mem_limit_hi) {
> -                                       dev_err(&dev->dev, "can't handle 64-bit address space for bridge\n");
> -                                       return;
> -                               }
> -                       } else  {
> -                               base |= ((dma_addr_t) mem_base_hi) << 32;
> -                               limit |= ((dma_addr_t) mem_limit_hi) << 32;
> -                       }
> +                       base64 |= (u64) mem_base_hi << 32;
> +                       limit64 |= (u64) mem_limit_hi << 32;
>                 }
>         }
> +
> +       base = (dma_addr_t) base64;
> +       limit = (dma_addr_t) limit64;
> +
> +       if (base != base64) {
> +               dev_err(&dev->dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
> +                       (unsigned long long) base64);
> +               return;
> +       }
> +

Yes, that is better. on 64bit, compiler will omit last  7 lines for comparing...

Thanks

Yinghai
