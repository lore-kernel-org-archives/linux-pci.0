Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] PCI: designware: Add generic
 dw_pcie_wait_for_link()
To: Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <20160225172957.2103.8326.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160225173736.2103.59017.stgit@bhelgaas-glaptop2.roam.corp.google.com>
CC: <mark.rutland@arm.com>, <Alexey.Brodkin@synopsys.com>,
	<arnd@arndb.de>, <pawel.moll@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <linux-pci@vger.kernel.org>,
	<Vineet.Gupta1@synopsys.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	<linux-kernel@vger.kernel.org>, <CARLOS.PALMINHA@synopsys.com>,
	<robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>,
	<galak@codeaurora.org>, Jingoo Han <jingoohan1@gmail.com>,
	<linux-snps-arc@lists.infradead.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56CFBBAF.4060203@synopsys.com>
Date: Fri, 26 Feb 2016 10:42:55 +0800
MIME-Version: 1.0
In-Reply-To: <20160225173736.2103.59017.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi! This patch seems OK also.
I did not received the 3/4 and 4/4 patches.

Thanks.

On 2/26/2016 1:37 AM, Bjorn Helgaas wrote:
> From: Joao Pinto <Joao.Pinto@synopsys.com>
> 
> Several DesignWare-based drivers (dra7xx, exynos, imx6 and spear13xx) had
> similar loops waiting for the link to come up.
> 
> FIXME Doesn't update keystone
> FIXME Doesn't update qcom
> 
> Add a generic dw_pcie_wait_for_link() for use by all these drivers so the
> waiting is done consistently, e.g., always using usleep_range() rather than
> mdelay() and using similar timeouts and retry counts.
> 
> [bhelgaas: changelog, split into its own patch]
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-dra7xx.c      |   11 +++--------
>  drivers/pci/host/pci-exynos.c      |   11 ++---------
>  drivers/pci/host/pci-imx6.c        |   11 +++--------
>  drivers/pci/host/pcie-designware.c |   19 +++++++++++++++++++
>  drivers/pci/host/pcie-designware.h |    6 ++++++
>  drivers/pci/host/pcie-spear13xx.c  |   12 ++----------
>  6 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 923607b..8d3d350 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -10,7 +10,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -108,7 +107,6 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
>  	u32 reg;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "link is already up\n");
> @@ -119,13 +117,10 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
>  	reg |= LTSSM_EN;
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
>  
> -	for (retries = 0; retries < 1000; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(10, 20);
> -	}
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "link is not up\n");
>  	return -EINVAL;
>  }
>  
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index d997d22..41f3248 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -318,7 +318,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  {
>  	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
>  	u32 val;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "Link already up\n");
> @@ -357,13 +356,8 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  			  PCIE_APP_LTSSM_ENABLE);
>  
>  	/* check if the link is up or not */
> -	for (retries = 0; retries < 10; retries++) {
> -		if (dw_pcie_link_up(pp)) {
> -			dev_info(pp->dev, "Link up\n");
> -			return 0;
> -		}
> -		mdelay(100);
> -	}
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
>  	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
>  		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
> @@ -372,7 +366,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  	/* power off phy */
>  	exynos_pcie_power_off_phy(pp);
>  
> -	dev_err(pp->dev, "PCIe Link Fail\n");
>  	return -EINVAL;
>  }
>  
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fe60096..c53da17 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -330,15 +330,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  
>  static int imx6_pcie_wait_for_link(struct pcie_port *pp)
>  {
> -	unsigned int retries;
> -
> -	for (retries = 0; retries < 200; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(100, 1000);
> -	}
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "phy link never came up\n");
>  	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
>  		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
>  		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2171682..4fff2d2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/delay.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -380,6 +381,24 @@ static struct msi_controller dw_pcie_msi_chip = {
>  	.teardown_irq = dw_msi_teardown_irq,
>  };
>  
> +int dw_pcie_wait_for_link(struct pcie_port *pp)
> +{
> +	int retries;
> +
> +	/* check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (dw_pcie_link_up(pp)) {
> +			dev_info(pp->dev, "link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	dev_err(pp->dev, "phy link never came up\n");
> +
> +	return -EINVAL;
> +}
> +
>  int dw_pcie_link_up(struct pcie_port *pp)
>  {
>  	if (pp->ops->link_up)
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 2356d29..f437f9b 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -22,6 +22,11 @@
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>  
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES		10
> +#define LINK_WAIT_USLEEP_MIN		90000
> +#define LINK_WAIT_USLEEP_MAX		100000
> +
>  struct pcie_port {
>  	struct device		*dev;
>  	u8			root_bus_nr;
> @@ -76,6 +81,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> +int dw_pcie_wait_for_link(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index a6cd823..0e5a2f1 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -13,7 +13,6 @@
>   */
>  
>  #include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -149,7 +148,6 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
>  	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
>  	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
>  	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "link already up\n");
> @@ -201,15 +199,9 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
>  			&app_reg->app_ctrl_0);
>  
>  	/* check if the link is up or not */
> -	for (retries = 0; retries < 10; retries++) {
> -		if (dw_pcie_link_up(pp)) {
> -			dev_info(pp->dev, "link up\n");
> -			return 0;
> -		}
> -		mdelay(100);
> -	}
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "link Fail\n");
>  	return -EINVAL;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
