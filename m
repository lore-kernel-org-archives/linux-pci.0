Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9416ECE562
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 10:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A85214D5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 10:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A85214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeIQP6d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:58:33 -0400
Received: from foss.arm.com ([217.140.101.70]:56214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeIQP6d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 11:58:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97D318A;
        Mon, 17 Sep 2018 03:31:46 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C033F5BD;
        Mon, 17 Sep 2018 03:31:45 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:31:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] PCI: imx6: support MPLL reconfiguration for 100MHz and
 200MHz refclock
Message-ID: <20180917103142.GB7239@e107981-ln.cambridge.arm.com>
References: <20180731102149.8537-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731102149.8537-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917103142.LPJRjKr7t8FbD_nvIIpItp_AtKdFXPrr8gs1S7HiaQQ@z>

On Tue, Jul 31, 2018 at 12:21:49PM +0200, Lucas Stach wrote:
> The power up defaults of the MPLL are designed for the standard 125MHz
> refclock derived from the ENET PLL. As this clock has a jitter that
> violates the PCIe Gen2 timing requirements, some board designs use
> an external reference clock generator. Those clock generators may
> output a clock at a different rate than what the MPLL expects
> (usually a 100MHz clock, to re-use the PCIe bus clock).
> 
> In that case the MPLL must be reconfigured via overrides to use
> different refclock dividers and loop multipliers. The i.MX6
> reference manual lists both 100MHz and 200MHz as supported refclock
> rates and the associated mult and div values.
> 
> Only the 100MHz setup has been tested on a real board, but since the
> 200MHz setup only differs in the used pre-divider it seems safe to
> add it now.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 55 +++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Applied to pci/dwc for v4.20, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 80f604602783..c481c61a41b8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -97,6 +97,16 @@ struct imx6_pcie {
>  #define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
>  
>  /* PHY registers (not memory-mapped) */
> +#define PCIE_PHY_ATEOVRD			0x10
> +#define  PCIE_PHY_ATEOVRD_EN			(0x1 << 2)
> +#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT	0
> +#define  PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK	0x1
> +
> +#define PCIE_PHY_MPLL_OVRD_IN_LO		0x11
> +#define  PCIE_PHY_MPLL_MULTIPLIER_SHIFT		2
> +#define  PCIE_PHY_MPLL_MULTIPLIER_MASK		0x7f
> +#define  PCIE_PHY_MPLL_MULTIPLIER_OVRD		(0x1 << 9)
> +
>  #define PCIE_PHY_RX_ASIC_OUT 0x100D
>  #define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
>  
> @@ -508,6 +518,50 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
>  }
>  
> +static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
> +{
> +	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> +	int mult, div;
> +	u32 val;
> +
> +	switch (phy_rate) {
> +	case 125000000:
> +		/*
> +		 * The default settings of the MPLL are for a 125MHz input
> +		 * clock, so no need to reconfigure anything in that case.
> +		 */
> +		return 0;
> +	case 100000000:
> +		mult = 25;
> +		div = 0;
> +		break;
> +	case 200000000:
> +		mult = 25;
> +		div = 1;
> +		break;
> +	default:
> +		dev_err(imx6_pcie->pci->dev,
> +			"Unsupported PHY reference clock rate %lu\n", phy_rate);
> +		return -EINVAL;
> +	}
> +
> +	pcie_phy_read(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, &val);
> +	val &= ~(PCIE_PHY_MPLL_MULTIPLIER_MASK <<
> +		 PCIE_PHY_MPLL_MULTIPLIER_SHIFT);
> +	val |= mult << PCIE_PHY_MPLL_MULTIPLIER_SHIFT;
> +	val |= PCIE_PHY_MPLL_MULTIPLIER_OVRD;
> +	pcie_phy_write(imx6_pcie, PCIE_PHY_MPLL_OVRD_IN_LO, val);
> +
> +	pcie_phy_read(imx6_pcie, PCIE_PHY_ATEOVRD, &val);
> +	val &= ~(PCIE_PHY_ATEOVRD_REF_CLKDIV_MASK <<
> +		 PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT);
> +	val |= div << PCIE_PHY_ATEOVRD_REF_CLKDIV_SHIFT;
> +	val |= PCIE_PHY_ATEOVRD_EN;
> +	pcie_phy_write(imx6_pcie, PCIE_PHY_ATEOVRD, val);
> +
> +	return 0;
> +}
> +
>  static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> @@ -632,6 +686,7 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
> +	imx6_setup_phy_mpll(imx6_pcie);
>  	dw_pcie_setup_rc(pp);
>  	imx6_pcie_establish_link(imx6_pcie);
>  
> -- 
> 2.18.0
> 
