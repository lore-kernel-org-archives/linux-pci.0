Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33197 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbcC2NnU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 09:43:20 -0400
Received: by mail-ob0-f176.google.com with SMTP id x3so12081129obt.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2016 06:43:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459201536-5558-1-git-send-email-festevam@gmail.com>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
Date: Tue, 29 Mar 2016 06:43:19 -0700
Message-ID: <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 28, 2016 at 2:45 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
> cause regressions on some boards like MX6 Gateworks Ventana, for example.
>
> The reason for the breakage is that this commit sets the gpio polarity
> in the wrong logic level.
>
> Also, the commit log is wrong because active-low reset GPIO is what the
> driver used to support since the beginning.
>
> So keep the old behavior that ignores the gpio polarity specified in
> the device tree and treat the PCI reset GPIO as active-low.
>
> Cc: <stable@vger.kernel.org> # 4.5
> Reported-by: Krzysztof Hałasa <khalasa@piap.pl>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Improve wording of commit log (Tim)
>
>  drivers/pci/host/pci-imx6.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eb5a275..2f817fa 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -32,7 +32,7 @@
>  #define to_imx6_pcie(x)        container_of(x, struct imx6_pcie, pp)
>
>  struct imx6_pcie {
> -       struct gpio_desc        *reset_gpio;
> +       int                     reset_gpio;
>         struct clk              *pcie_bus;
>         struct clk              *pcie_phy;
>         struct clk              *pcie;
> @@ -309,10 +309,10 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>         usleep_range(200, 500);
>
>         /* Some boards don't have PCIe reset GPIO. */
> -       if (imx6_pcie->reset_gpio) {
> -               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +       if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
>                 msleep(100);
> -               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> +               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>         }
>         return 0;
>
> @@ -523,6 +523,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  {
>         struct imx6_pcie *imx6_pcie;
>         struct pcie_port *pp;
> +       struct device_node *np = pdev->dev.of_node;
>         struct resource *dbi_base;
>         struct device_node *node = pdev->dev.of_node;
>         int ret;
> @@ -544,8 +545,15 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>                 return PTR_ERR(pp->dbi_base);
>
>         /* Fetch GPIOs */
> -       imx6_pcie->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> -                                                       GPIOD_OUT_LOW);
> +       imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +       if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +               ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
> +                                           GPIOF_OUT_INIT_LOW, "PCIe reset");
> +               if (ret) {
> +                       dev_err(&pdev->dev, "unable to get reset gpio\n");
> +                       return ret;
> +               }
> +       }
>
>         /* Fetch clocks */
>         imx6_pcie->pcie_phy = devm_clk_get(&pdev->dev, "pcie_phy");
> --
> 1.9.1
>

Fabio/Krzysztof - thanks for finding this regression that breaks PCI
on most IMX6. I verified reverting this resolves Gateworks Ventana PCI
breakage in v4.5.

Acked-by: Tim Harvey <tharvey@gateworks.com>

Regards,

Tim
