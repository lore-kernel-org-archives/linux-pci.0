Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbcIMOcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 10:32:13 -0400
Date: Tue, 13 Sep 2016 09:32:02 -0500
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
Message-ID: <20160913143202.GB27748@localhost>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bharat,

On Tue, Aug 30, 2016 at 04:09:16PM +0530, Bharat Kumar Gogada wrote:
> The current driver prints pcie core error, for all core events.
> Instead of just printing PCIe core error, now adding prints to show
> individual core events occurred.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
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

This patch looks fine, but looking at the code as a whole, I have a
question.  You basically have this:

  misc_stat = nwl_bridge_readl(pcie, MSGF_MISC_STATUS) & MSGF_MISC_SR_MASKALL;
  if (!misc_stat)
    return IRQ_NONE;
  ...
  nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);

The masking with MSGF_MISC_SR_MASKALL seems wrong.  Let's say
MSGF_MISC_STATUS had some other bit set, e.g., BIT(31), indicating
some yet-unsupported interrupt cause.  BIT(31) is not in
MSGF_MISC_SR_MASKALL, so we return IRQ_NONE without clearing the
interrupt bit in MSGF_MISC_STATUS.  Won't that cause an interrupt
storm where the interrupt is continually re-asserted because we never
clear it?

It seems like it would make more sense to do this:

  misc_stat = nwl_bridge_readl(pcie, MSGF_MISC_STATUS);
  if (!misc_stat)
    return IRQ_NONE;
  ...
  if (misc_stat != (misc_stat & MSGF_MISC_SR_MASKALL))
    dev_err(dev, "unexpected IRQ, MSGF_MISC_STATUS %#010x\n", misc_stat);
  nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);

