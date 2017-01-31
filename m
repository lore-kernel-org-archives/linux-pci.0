Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36354 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdAaPdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2017 10:33:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170131151044.14062.85997.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170131151044.14062.85997.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Jan 2017 16:33:15 +0100
Message-ID: <CAMuHMdWxoMsZAobYSmxeuga1NdMbruss4g-KQjczNeurcn_wkA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Check for OF device match early
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jan 31, 2017 at 4:10 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> A match in the rcar_pcie_of_match[] table is required, so check that first,
> before we start setting up things that need to be undone if it fails.  No
> functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-rcar.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 0d9b96c3c49d..c91ff0b91be8 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1129,6 +1129,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         int err;
>         int (*hw_init_fn)(struct rcar_pcie *);
>
> +       of_id = of_match_device(rcar_pcie_of_match, dev);
> +       if (!of_id || !of_id->data)
> +               return -EINVAL;
> +

As this driver is DT-only, none of the above can fail, and you could just do

       hw_init_fn = of_device_get_match_data(dev);

instead, getting rid of of_id completely.

>         pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>         if (!pcie)
>                 return -ENOMEM;
> @@ -1149,11 +1153,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         if (err)
>                 return err;
>
> -       of_id = of_match_device(rcar_pcie_of_match, dev);
> -       if (!of_id || !of_id->data)
> -               return -EINVAL;
> -       hw_init_fn = of_id->data;
> -
>         pm_runtime_enable(dev);
>         err = pm_runtime_get_sync(dev);
>         if (err < 0) {
> @@ -1162,6 +1161,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>         }
>
>         /* Failure to get a link might just be that no cards are inserted */
> +       hw_init_fn = of_id->data;
>         err = hw_init_fn(pcie);
>         if (err) {
>                 dev_info(dev, "PCIe link down\n");
>



-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
