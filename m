Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:34149 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966701AbcCPOTX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 10:19:23 -0400
Received: by mail-io0-f182.google.com with SMTP id m184so60881907iof.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 07:19:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56E81C56.8060404@tekno-soft.it>
References: <56D5E3DF.9030906@tekno-soft.it>
	<56D71F27.7070708@tekno-soft.it>
	<20160302195634.GA19223@localhost>
	<DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D80435.90408@tekno-soft.it>
	<DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	<56D8180A.1050708@tekno-soft.it>
	<56D84B6D.1050800@tekno-soft.it>
	<56D883AD.5060601@tekno-soft.it>
	<56DEE426.8030902@tekno-soft.it>
	<1457448829.3207.22.camel@pengutronix.de>
	<56E1B04A.9010206@tekno-soft.it>
	<56E679FE.20409@tekno-soft.it>
	<56E7ED1E.3070506@tekno-soft.it>
	<CAOMZO5C9H92mMqTPiOwMYhywBCyQuXQen3Vw==ELE-ppTtogqg@mail.gmail.com>
	<56E81C56.8060404@tekno-soft.it>
Date: Wed, 16 Mar 2016 11:19:22 -0300
Message-ID: <CAOMZO5C0rvszTg0bPoSnT5zzL8EC2Vk1PVDJgB1m1FREy9ncaQ@mail.gmail.com>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Fabio Estevam <festevam@gmail.com>
To: Roberto Fichera <kernel@tekno-soft.it>,
	Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tim,

On Tue, Mar 15, 2016 at 11:29 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 03/15/2016 03:10 PM, Fabio Estevam wrote:
>> On Tue, Mar 15, 2016 at 8:08 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>
>>> Just to say that I've fixed the problem by asserting PERST before to drop PCIe refclk and enable
>>> power down. PERST is finally released at the usual place.
>> Excellent! Do you plan to submit a patch to fix this issue?
>
> I don't know, in my case the problem was related to the XIO2001 that require PERST to be
> asserted before to drop PCIe refclk as reported by its datasheet:

Does your board detect XIO2001 bridge with kernel 4.4.x or do you also
need something like Roberto's changes below?


> @@ -214,6 +352,16 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>      struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>      u32 val, gpr1, gpr12;
>
> +        /*
> +         * Our PCIe link is connected to a TI XIO2001 PCIe-to-PCI
> +         * bridge and this require PERST to be asserted before to
> +         * drop PCIe ref_clk otherwise it will get "confused" and
> +         * the PCIe link state will stuck in POLL_STATE
> +         */
> +    if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +            gpio_set_value(imx6_pcie->reset_gpio, 0);
> +        }
> +
>      /*
>       * If the bootloader already enabled the link we need some special
>       * handling to get the core back into a state where it is safe to
> @@ -241,6 +389,7 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>
>      regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>              IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> +    udelay(10);
>      regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>              IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
>
>
> I've also slightly changed the Gen2 negotiation with this relevant part where the Gen2 speed
> change is only done if necessary
>
> @@ -387,46 +541,57 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>
>      /* Start LTSSM. */
>      regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -            IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> -
> -    ret = imx6_pcie_wait_for_link(pp);
> -    if (ret)
> -        return ret;
> -
> -    /* Allow Gen2 mode after the link is up. */
> -    tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> -    tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> -    tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> -    writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> -
> -    /*
> -     * Start Directed Speed Change so the best possible speed both link
> -     * partners support can be negotiated.
> -     */
> -    tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -    tmp |= PORT_LOGIC_SPEED_CHANGE;
> -    writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> -
> -    ret = imx6_pcie_wait_for_speed_change(pp);
> -    if (ret) {
> -        dev_err(pp->dev, "Failed to bring link up!\n");
> -        return ret;
> -    }
> +                  IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>
> -    /* Make sure link training is finished as well! */
>      ret = imx6_pcie_wait_for_link(pp);
> -    if (ret) {
> -        dev_err(pp->dev, "Failed to bring link up!\n");
> -        return ret;
> +        if(ret)
> +                return ret;
> +
> +        if(pp->link_gen == 2) {
> +            /* Allow Gen2 mode after the link is up. */
> +            tmp = readl(pp->dbi_base + PCIE_RC_LCR);
> +            tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> +            tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> +            writel(tmp, pp->dbi_base + PCIE_RC_LCR);
> +
> +            /*
> +             * Start Directed Speed Change so the best possible speed both link
> +             * partners support can be negotiated.
> +             */
> +            tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> +            tmp |= PORT_LOGIC_SPEED_CHANGE;
> +            writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> +
> +            ret = imx6_pcie_wait_for_speed_change(pp);
> +            if (ret) {
> +                dev_err(pp->dev, "Failed to bring link up!\n");
> +                return ret;
> +            }
> +
> +            /* Make sure link training is finished as well! */
> +            ret = imx6_pcie_wait_for_link(pp);
> +            if (ret) {
> +                dev_err(pp->dev, "Failed to bring link up!\n");
> +                return ret;
> +            }
> +
> +    } else {
> +        dev_info(pp->dev, "Link: Gen2 disabled\n");
>      }
>
>      tmp = readl(pp->dbi_base + PCIE_RC_LCSR);
> -    dev_dbg(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
> +    dev_info(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);
>      return 0;
>  }
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
