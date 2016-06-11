Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50088 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbcFKAJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:09:09 -0400
Date: Fri, 10 Jun 2016 19:09:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Remove redundant check of pcie_set_clkpm
Message-ID: <20160611000904.GF16462@localhost>
References: <1464082330-22437-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464082330-22437-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 05:32:10PM +0800, Shawn Lin wrote:
> Without supporting clock PM capable, if we want to disable
> clkpm, we don't need this extra check as it already be zero for
> the enable argument. And it's the same for enabling clkpm here.
> So let's remove this check.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/aspm for v4.8, thanks, Shawn.

> ---
> 
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2dfe7fd..0ec649d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -139,7 +139,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  {
>  	/* Don't enable Clock PM if the link is not Clock PM capable */
> -	if (!link->clkpm_capable && enable)
> +	if (!link->clkpm_capable)
>  		enable = 0;
>  	/* Need nothing if the specified equals to current state */
>  	if (link->clkpm_enabled == enable)
> -- 
> 2.3.7
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
