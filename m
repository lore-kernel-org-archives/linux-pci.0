Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44300 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934009AbdKBTZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 15:25:52 -0400
MIME-Version: 1.0
In-Reply-To: <a55409b0-9839-d9b5-5c90-606c22d0c58b@users.sourceforge.net>
References: <c598933b-b14f-91a1-c7a3-f4a46ec98e77@users.sourceforge.net>
 <20171101081831.ssnuqp5b75lbfu5p@verge.net.au> <7047eb7a-cf93-6a56-08db-a5e8bedbfc57@users.sourceforge.net>
 <20171102081239.bzaunax3uotejqja@verge.net.au> <a55409b0-9839-d9b5-5c90-606c22d0c58b@users.sourceforge.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Nov 2017 20:25:50 +0100
Message-ID: <CAMuHMdVgte--7gOnp9DFZCKUsneT-S9ttO3gninnfhv43BOyKQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar: Use common error handling code in rcar_pcie_enable_msi()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 2, 2017 at 2:00 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 2 Nov 2017 13:35:17 +0100
>
> * Adjust a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
>
> * Replace two calls of the function "dev_err" by goto statements.
>
> This issue was detected by using the Coccinelle software.
>
> Link: https://lkml.org/lkml/2017/11/2/140
> Link: https://lkml.kernel.org/r/<20171102081239.bzaunax3uotejqja@verge.net.au>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> An other jump label was requested by Simon Horman.
>
>  drivers/pci/host/pcie-rcar.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 12796eccb2be..f3c1ffdf8072 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -873,18 +873,14 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>         err = devm_request_irq(dev, msi->irq1, rcar_pcie_msi_irq,
>                                IRQF_SHARED | IRQF_NO_THREAD,
>                                rcar_msi_irq_chip.name, pcie);
> -       if (err < 0) {
> -               dev_err(dev, "failed to request IRQ: %d\n", err);
> -               goto err;
> -       }
> +       if (err < 0)
> +               goto err_remove_domain;
>
>         err = devm_request_irq(dev, msi->irq2, rcar_pcie_msi_irq,
>                                IRQF_SHARED | IRQF_NO_THREAD,
>                                rcar_msi_irq_chip.name, pcie);
> -       if (err < 0) {
> -               dev_err(dev, "failed to request IRQ: %d\n", err);
> -               goto err;
> -       }
> +       if (err < 0)
> +               goto err_remove_domain;
>
>         /* setup MSI data target */
>         msi->pages = __get_free_pages(GFP_KERNEL, 0);
> @@ -898,7 +894,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>
>         return 0;
>
> -err:
> +err_remove_domain:
> +       dev_err(dev, "failed to request IRQ: %d\n", err);

Moving the error message is confusing and counter-productive:
if you need to add another error case + goto err_remove_domain
later, you'll have to move it back to all the older cases.

Hence
NAKed-by: Geert Uytterhoeven <geert@linux-m68k.org>

>         irq_domain_remove(msi->domain);
>         return err;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
