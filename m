Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A059C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574C206BA
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 17:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E574C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406181AbeKTDdp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:33:45 -0500
Received: from foss.arm.com ([217.140.101.70]:33482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405988AbeKTDdo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 22:33:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2947D80D;
        Mon, 19 Nov 2018 09:09:26 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CB933F5B7;
        Mon, 19 Nov 2018 09:09:24 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:09:48 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Antoine =?iso-8859-1?Q?T=E9nart?= 
        <antoine.tenart@free-electrons.com>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement 
        <gregory.clement@free-electrons.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal 
        <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH RFC v4.14] PCI: aadrvark: warm reset the cores and card
Message-ID: <20181119170948.GA30910@red-moon>
References: <20181024152056.17813-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024152056.17813-1-marek.behun@nic.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 24, 2018 at 05:20:56PM +0200, Marek Behún wrote:
> Add code to do a warm reset on the PHY and PCIE cores and if PERSTN GPIO
> is specified in device tree (as reset-gpio), also reset the card.
> 
> The reset-gpio is inspired by what is done in U-Boot and linux-marvell,
> and is not final version: I am hoping this can be done via a PCIe register
> rather than GPIO - bit 3 of CTRL_WARM_RESET_REG register (which is added
> by this patch) is called PERSTN_GPIO_EN (Enable PERSTN from GPIO) and
> I think this is the right register, but manipulating this register did
> not have any effect on the PERSTN pin, even when pinctrl was correctly set.
> 
> I asked Marvell about this and am awaiting their reply.
> 
> The reset-gpio is needed for Compex 5 GHz wifi card model WLE900VX. Without
> this patch the PCIe link never comes up in kernel (although U-Boot pci
> command was able to enumerate the card).
> 
> What is weird is that the link does not come up for this card when
> pci-aardvark driver is probed in U-Boot. I haven't yet had time to discover
> the problem there. My temporary solution is to compile out the pci-aardvark
> driver from U-Boot.
> 
> This patch is based on 4.14 kernel.

This is not a commit log, these comments go either in a cover letter
or below the log, prior to the diff.

Patches should always be aimed at mainline, that's what is discussed
and merged on linux-pci@vger.kernel.org

Given its RFC status I consider this patch a proof of concept and
won't consider it for upstreaming, not yet at least.

> If you have time, please try it with some PCIe cards and let me know
> if they work correctly.

See above. For the time being I will drop this patch from the linux-pci
patch queue, I really do not know what to do with it.

Thanks,
Lorenzo

> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Lorenzo  Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Bjorn Helgaas  <helgaas@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Antoine Ténart  <antoine.tenart@free-electrons.com>
> Cc: Grégory  Clement  <gregory.clement@free-electrons.com>
> Cc: Miquèl Raynal  <miquel.raynal@free-electrons.com>
> Cc: Victor Gu <xigu@marvell.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 46 +++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 50e8addc22f9..5610fcb3f426 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/of_gpio.h>
>  
>  /* PCIe core registers */
>  #define PCIE_CORE_CMD_STATUS_REG				0x4
> @@ -147,6 +148,9 @@
>  #define     CTRL_MODE_MASK			0x1
>  #define     PCIE_CORE_MODE_DIRECT		0x0
>  #define     PCIE_CORE_MODE_COMMAND		0x1
> +#define CTRL_WARM_RESET_REG			(CTRL_CORE_BASE_ADDR + 0x4)
> +#define     CTRL_PCIE_CORE_WARM_RESET		BIT(0)
> +#define     CTRL_PHY_CORE_WARM_RESET		BIT(1)
>  
>  /* PCIe Central Interrupts Registers */
>  #define CENTRAL_INT_BASE_ADDR			0x1b000
> @@ -270,8 +274,25 @@ static void advk_pcie_set_ob_win(struct advk_pcie *pcie,
>  	advk_writel(pcie, match_ls | BIT(0), OB_WIN_MATCH_LS(win_num));
>  }
>  
> +static void advk_pcie_warm_reset(struct advk_pcie *pcie)
> +{
> +	u32 reg;
> +
> +	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
> +	reg |= CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET;
> +	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
> +
> +	mdelay(100);
> +
> +	reg = advk_readl(pcie, CTRL_WARM_RESET_REG);
> +	reg &= ~(CTRL_PCIE_CORE_WARM_RESET | CTRL_PHY_CORE_WARM_RESET);
> +	advk_writel(pcie, reg, CTRL_WARM_RESET_REG);
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
>  	u32 reg;
>  	int i;
>  
> @@ -311,10 +332,15 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  		PCIE_CORE_CTRL2_TD_ENABLE;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
>  
> -	/* Set GEN2 */
> +	/* Set GEN */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg &= ~PCIE_GEN_SEL_MSK;
> -	reg |= SPEED_GEN_2;
> +	if (of_pci_get_max_link_speed(node) == 1)
> +		reg |= SPEED_GEN_1;
> +	if (of_pci_get_max_link_speed(node) == 3)
> +		reg |= SPEED_GEN_3;
> +	else
> +		reg |= SPEED_GEN_2;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
>  
>  	/* Set lane X1 */
> @@ -948,6 +974,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	struct pci_bus *bus, *child;
>  	struct pci_host_bridge *bridge;
>  	int ret, irq;
> +	int reset_gpio;
> +	enum of_gpio_flags flags;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
>  	if (!bridge)
> @@ -970,6 +998,20 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	/* Config reset gpio for pcie if there is valid gpio setting in DTS */
> +	reset_gpio = of_get_named_gpio_flags(pdev->dev.of_node, "reset-gpio",
> +					     0, &flags);
> +	if (gpio_is_valid(reset_gpio)) {
> +		struct gpio_desc *reset_gpiod;
> +		reset_gpiod = gpio_to_desc(reset_gpio);
> +		gpiod_direction_output(reset_gpiod, 0);
> +		mdelay(200);
> +		gpiod_direction_output(reset_gpiod, 1);
> +		mdelay(200);
> +	}
> +
> +	advk_pcie_warm_reset(pcie);
> +
>  	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to parse resources\n");
> -- 
> 2.18.1
> 
