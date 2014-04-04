Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38203 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaDDQ4G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 12:56:06 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so3572096pdj.18
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 09:56:05 -0700 (PDT)
Date: Fri, 4 Apr 2014 10:55:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
Message-ID: <20140404165559.GE9007@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 05, 2014 at 02:25:47PM +0100, Lucas Stach wrote:
> This is the recommended method of doing the IRQ
> mapping. For old devicetrees we fall back to the
> previous practice.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied with Stephen's Tested-by to my pending/host-tegra branch.  I'll
rebase and rename it after v3.15-rc1, and I think we can squeeze it into
v3.15 shortly after that.  Thanks.

> ---
>  drivers/pci/host/pci-tegra.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 330f7e3a32dd..083cf37ca047 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -639,10 +639,15 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
>  static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>  	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
> +	int irq;
>  
>  	tegra_cpuidle_pcie_irqs_in_use();
>  
> -	return pcie->irq;
> +	irq = of_irq_parse_and_map_pci(pdev, slot, pin);
> +	if (!irq)
> +		irq = pcie->irq;
> +
> +	return irq;
>  }
>  
>  static void tegra_pcie_add_bus(struct pci_bus *bus)
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
