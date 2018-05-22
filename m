Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45481 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEVSgp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 14:36:45 -0400
MIME-Version: 1.0
In-Reply-To: <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com> <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 20:36:43 +0200
Message-ID: <CAMuHMdVhrb_dR7TP3PU=rsbne+9BZu=BHA9XAK=L1so98HogtA@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Mon, May 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> If the rcar_pcie_enable() fails and MSIs are enabled, the setup done in
> rcar_pcie_enable_msi() is never undone. Add a function to tear down the
> MSI setup by disabling the MSI handling in the PCIe block, deallocating
> the pages requested for the MSIs and zapping the IRQ mapping.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -900,6 +900,28 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>         return err;
>  }
>
> +static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
> +{
> +       struct rcar_msi *msi = &pcie->msi;
> +       int irq, i;
> +
> +       /* Disable all MSI interrupts */
> +       rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
> +
> +       /* Disable address decoding of the MSI interrupt, MSIFE */
> +       rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
> +
> +       free_pages(msi->pages, 0);
> +
> +       for (i = 0; i < INT_PCI_MSI_NR; i++) {
> +               irq = irq_find_mapping(msi->domain, i);
> +               if (irq > 0)
> +                       irq_dispose_mapping(irq);
> +       }

Note that similar calls to irq_dispose_mapping() should be added to the
failure path of rcar_pcie_enable_msi(), too.

> +
> +       irq_domain_remove(msi->domain);
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
