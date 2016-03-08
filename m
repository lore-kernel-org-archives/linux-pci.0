Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36392 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbcCHVoq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 16:44:46 -0500
Date: Tue, 8 Mar 2016 15:44:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: tegra: Remove unused field
Message-ID: <20160308214442.GE27132@localhost>
References: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 09, 2016 at 03:52:31PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The num_ports field of the tegra_pcie structure is never used so it can
> be safely removed.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied all three of these to pci/host-tegra for v4.6, thanks!

> ---
>  drivers/pci/host/pci-tegra.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 4cb8157a4678..82d7ad3a1c3a 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -295,7 +295,6 @@ struct tegra_pcie {
>  	struct tegra_msi msi;
>  
>  	struct list_head ports;
> -	unsigned int num_ports;
>  	u32 xbar_config;
>  
>  	struct regulator_bulk_data *supplies;
> -- 
> 2.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
