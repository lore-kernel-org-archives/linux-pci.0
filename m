Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:61326 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3K0QXj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 11:23:39 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so7470249obc.8
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2013 08:23:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1385500248-6551-4-git-send-email-marex@denx.de>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
	<1385500248-6551-4-git-send-email-marex@denx.de>
Date: Wed, 27 Nov 2013 17:23:37 +0100
Message-ID: <CAB5oZtCTDJEWFxr-f1YJg7ihw0aCuiJiYvrHV597oNb6cZz92Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] PCI: imx6: Split away the PHY reset
From: Harro Haan <hrhaan@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26 November 2013 22:10, Marek Vasut <marex@denx.de> wrote:
> Split the PCIe PHY reset from the link up function to make
> the code a little more structured.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Harro Haan <hrhaan@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/host/pci-imx6.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 4d5be4e..a9781e7 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -336,6 +336,23 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>         return;
>  }
>
> +static void imx6_pcie_reset_phy(struct pcie_port *pp)
> +{
> +       uint32_t temp;
> +
> +       pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
> +       temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> +                PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +       pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
> +
> +       usleep_range(2000, 3000);
> +
> +       pcie_phy_read(pp->dbi_base, PHY_RX_OVRD_IN_LO, &temp);
> +       temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> +                 PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +       pcie_phy_write(pp->dbi_base, PHY_RX_OVRD_IN_LO, temp);
> +}
> +
>  static int imx6_pcie_link_up(struct pcie_port *pp)
>  {
>         u32 rc, ltssm, rx_valid, temp;
> @@ -370,21 +387,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>
>         dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
>
> -       pcie_phy_read(pp->dbi_base,
> -               PHY_RX_OVRD_IN_LO, &temp);
> -       temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN
> -               | PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> -       pcie_phy_write(pp->dbi_base,
> -               PHY_RX_OVRD_IN_LO, temp);
> -
> -       usleep_range(2000, 3000);
> -
> -       pcie_phy_read(pp->dbi_base,
> -               PHY_RX_OVRD_IN_LO, &temp);
> -       temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN
> -               | PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> -       pcie_phy_write(pp->dbi_base,
> -               PHY_RX_OVRD_IN_LO, temp);
> +       imx6_pcie_reset_phy(pp);
>
>         return 0;
>  }
> --
> 1.8.4.3
>

Thanks Marek,

A minor:
drivers/pci/host/pci-imx6.c: In function 'imx6_pcie_link_up':
drivers/pci/host/pci-imx6.c:353:27: warning: unused variable 'temp'
[-Wunused-variable]

See the following mail for more info which tests I did with patch 1/7,
3/7, 4/7, 5/7 and 6/7:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/214640.html

Regards,

Harro
