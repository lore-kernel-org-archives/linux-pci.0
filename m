Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34620 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbaJXL5e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Oct 2014 07:57:34 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so2485903lab.14
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2014 04:57:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
	<1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
Date: Fri, 24 Oct 2014 09:57:32 -0200
Message-ID: <CAOMZO5CE=gDUTHQW7h1nDv_H+1iakPAatZ8Pzr=dqHxFZChTeA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <richard.zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>, m-karicheri2@ti.com,
	Richard Zhu <r65037@freescale.com>,
	Eric Nelson <eric.nelson@boundarydevices.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Fri, Oct 24, 2014 at 12:36 AM, Richard Zhu <richard.zhu@freescale.com> wrote:
> From: Richard Zhu <r65037@freescale.com>
>
> For boards without a reset GPIO we skip the delay between enabling the
> pcie_ref_clk and touching the RC registers for configuration.
> This hangs the system if there isn't a proper delay to ensure the clocks
> are settled in the DW PCIe core.
>
> Also iMX6Q always needs an additional 10us delay to make sure the reset
> is propagated through the core, as we don't have an explicitly
> controlled reset input on this SoC.
>
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Please always add Bjorn on Cc.

> ---
>  drivers/pci/host/pci-imx6.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233fe8a..eac96fb 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -275,15 +275,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>                 goto err_pcie;
>         }
>
> -       /* allow the clocks to stabilize */
> -       usleep_range(200, 500);
> -
>         /* power up core phy and enable ref clock */
>         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>                         IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +       /*
> +        * the async reset input need ref clock to sync internally,
> +        * when the ref clock comes after reset, internal synced
> +        * reset time is too short , cannot meet the requirement.
> +        * add one ~10us delay here.
> +        */
> +       udelay(10);

The patch that myself and Tim has given a Tested-by tag did not
contain this udelay:
http://www.spinics.net/lists/linux-pci/msg34748.html

In your original patch it only moved the the usleep range and that's
the version that Tim has run intensive boot tests over temperature, so
I would prefer that you re-send a patch like the original one.
