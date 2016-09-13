Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758240AbcIMPSK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 11:18:10 -0400
Date: Tue, 13 Sep 2016 10:18:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: robh@kernel.org, bhelgaas@google.com, colin.king@canonical.com,
        soren.brinkmann@xilinx.com, marc.zyngier@arm.com,
        michal.simek@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: [PATCH 1/3] PCI: Xilinx NWL PCIe: Expanding PCIe core errors and
 printing event occurred.
Message-ID: <20160913151805.GD27748@localhost>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 30, 2016 at 04:09:16PM +0530, Bharat Kumar Gogada wrote:
> The current driver prints pcie core error, for all core events.
> Instead of just printing PCIe core error, now adding prints to show
> individual core events occurred.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>

I applied the first two patches to pci/host-xilinx for v4.9, thanks!

I'd like to work on the third one a little more, as I mentioned in my
response to it.

> ---
>  drivers/pci/host/pcie-xilinx-nwl.c | 48 +++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> index 3479d30..86c1834 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -85,10 +85,15 @@
>  #define MSGF_MISC_SR_MASTER_ERR		BIT(5)
>  #define MSGF_MISC_SR_I_ADDR_ERR		BIT(6)
>  #define MSGF_MISC_SR_E_ADDR_ERR		BIT(7)
> -#define MSGF_MISC_SR_UR_DETECT          BIT(20)
> -
> -#define MSGF_MISC_SR_PCIE_CORE		GENMASK(18, 16)
> -#define MSGF_MISC_SR_PCIE_CORE_ERR	GENMASK(31, 22)
> +#define MSGF_MISC_SR_FATAL_AER		BIT(16)
> +#define MSGF_MISC_SR_NON_FATAL_AER	BIT(17)
> +#define MSGF_MISC_SR_CORR_AER		BIT(18)
> +#define MSGF_MISC_SR_UR_DETECT		BIT(20)
> +#define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
> +#define MSGF_MISC_SR_FATAL_DEV		BIT(23)
> +#define MSGF_MISC_SR_LINK_DOWN		BIT(24)
> +#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
> +#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
>  
>  #define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
>  					MSGF_MISC_SR_RXMSG_OVER | \
> @@ -96,9 +101,15 @@
>  					MSGF_MISC_SR_MASTER_ERR | \
>  					MSGF_MISC_SR_I_ADDR_ERR | \
>  					MSGF_MISC_SR_E_ADDR_ERR | \
> +					MSGF_MISC_SR_FATAL_AER | \
> +					MSGF_MISC_SR_NON_FATAL_AER | \
> +					MSGF_MISC_SR_CORR_AER | \
>  					MSGF_MISC_SR_UR_DETECT | \
> -					MSGF_MISC_SR_PCIE_CORE | \
> -					MSGF_MISC_SR_PCIE_CORE_ERR)
> +					MSGF_MISC_SR_NON_FATAL_DEV | \
> +					MSGF_MISC_SR_FATAL_DEV | \
> +					MSGF_MISC_SR_LINK_DOWN | \
> +					MSGF_MSIC_SR_LINK_AUTO_BWIDTH | \
> +					MSGF_MSIC_SR_LINK_BWIDTH)
>  
>  /* Legacy interrupt status mask bits */
>  #define MSGF_LEG_SR_INTA		BIT(0)
> @@ -291,8 +302,29 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
>  		dev_err(pcie->dev,
>  			"In Misc Egress address translation error\n");
>  
> -	if (misc_stat & MSGF_MISC_SR_PCIE_CORE_ERR)
> -		dev_err(pcie->dev, "PCIe Core error\n");
> +	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
> +		dev_err(pcie->dev, "Fatal Error in AER Capability\n");
> +
> +	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
> +		dev_err(pcie->dev, "Non-Fatal Error in AER Capability\n");
> +
> +	if (misc_stat & MSGF_MISC_SR_CORR_AER)
> +		dev_err(pcie->dev, "Correctable Error in AER Capability\n");
> +
> +	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
> +		dev_err(pcie->dev, "Unsupported request Detected\n");
> +
> +	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
> +		dev_err(pcie->dev, "Non-Fatal Error Detected\n");
> +
> +	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
> +		dev_err(pcie->dev, "Fatal Error Detected\n");
> +
> +	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
> +		dev_info(pcie->dev, "Link Autonomous Bandwidth Management Status bit set\n");
> +
> +	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
> +		dev_info(pcie->dev, "Link Bandwidth Management Status bit set\n");
>  
>  	/* Clear misc interrupt status */
>  	nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
