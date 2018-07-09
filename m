Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33144 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933298AbeGIPcA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 11:32:00 -0400
Date: Mon, 9 Jul 2018 16:33:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 4/5] PCI: cadence: Add Power Management ops for host and
 EP
Message-ID: <20180709153351.GA16292@red-moon>
References: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
 <1529915453-4633-5-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529915453-4633-5-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 09:30:52AM +0100, Alan Douglas wrote:
> These PM ops will enable/disable the optional PHYs if present.  The
> AXI link-down register in the host driver is now cleared in
> cdns_pci_map_bus since the link-down bit will be set if the PHY has
> been disabled.  It is not cleared when enabling the PHY, since the
> link will not yet be up.

It is not entirely clear what you mean here, can you elaborate please ?

Thank you,
Lorenzo

> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/pci/controller/pcie-cadence-ep.c   |    1 +
>  drivers/pci/controller/pcie-cadence-host.c |    3 ++
>  drivers/pci/controller/pcie-cadence.c      |   30 ++++++++++++++++++++++++++++
>  drivers/pci/controller/pcie-cadence.h      |    4 +++
>  4 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index c02f33d..3eabd99 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -555,6 +555,7 @@ static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
>  	.driver = {
>  		.name = "cdns-pcie-ep",
>  		.of_match_table = cdns_pcie_ep_of_match,
> +		.pm	= &cdns_pcie_pm_ops,
>  	},
>  	.probe = cdns_pcie_ep_probe,
>  	.shutdown = cdns_pcie_ep_shutdown,
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
> index 36f3109..e3e9b7d 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -61,6 +61,8 @@ struct cdns_pcie_rc {
>  	/* Check that the link is up */
>  	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
>  		return NULL;
> +	/* Clear AXI link-down status */
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
>  
>  	/* Update Output registers for AXI region 0. */
>  	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> @@ -345,6 +347,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	.driver = {
>  		.name = "cdns-pcie-host",
>  		.of_match_table = cdns_pcie_host_of_match,
> +		.pm	= &cdns_pcie_pm_ops,
>  	},
>  	.probe = cdns_pcie_host_probe,
>  };
> diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
> index 2edc126..86f1b00 100644
> --- a/drivers/pci/controller/pcie-cadence.c
> +++ b/drivers/pci/controller/pcie-cadence.c
> @@ -217,3 +217,33 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  
>  	return ret;
>  }
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cdns_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +
> +	cdns_pcie_disable_phy(pcie);
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_resume_noirq(struct device *dev)
> +{
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = cdns_pcie_enable_phy(pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable phy\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +const struct dev_pm_ops cdns_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
> +				      cdns_pcie_resume_noirq)
> +};
> diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
> index b342c80..ae6bf2a 100644
> --- a/drivers/pci/controller/pcie-cadence.h
> +++ b/drivers/pci/controller/pcie-cadence.h
> @@ -166,6 +166,9 @@
>  #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
>  	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
>  
> +/* AXI link down register */
> +#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
> +
>  enum cdns_pcie_rp_bar {
>  	RP_BAR0,
>  	RP_BAR1,
> @@ -314,5 +317,6 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
>  void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
>  int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
>  int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
> +extern const struct dev_pm_ops cdns_pcie_pm_ops;
>  
>  #endif /* _PCIE_CADENCE_H */
> -- 
> 1.7.1
> 
