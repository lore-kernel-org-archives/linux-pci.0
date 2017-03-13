Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] PCI: dwc: all: Modify dbi accessors to access data
 of 4/2/1 bytes
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20170313134328.1588-1-kishon@ti.com>
 <20170313134328.1588-6-kishon@ti.com>
CC: <nsekhar@ti.com>, Jingoo Han <jingoohan1@gmail.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <3353f3f7-9c27-b929-c8d4-e8e2605c11bc@axis.com>
Date: Mon, 13 Mar 2017 15:32:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170313134328.1588-6-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Niklas Cassel <niklas.cassel@axis.com>

On 03/13/2017 02:43 PM, Kishon Vijay Abraham I wrote:
> Previously dbi accessors can be used to access data of size 4
> bytes. But there might be situations (like accessing
> MSI_MESSAGE_CONTROL in order to set/get the number of required
> MSI interrupts in EP mode) where dbi accessors must
> be used to access data of size 2. This is in preparation for
> adding endpoint mode support to designware driver.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-exynos.c      | 16 ++++++++--------
>  drivers/pci/dwc/pcie-designware.c | 34 ++++++++++++++++++++++++----------
>  drivers/pci/dwc/pcie-designware.h | 20 +++++++++++---------
>  3 files changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> index a0d40f74b88d..37d6d2b7378f 100644
> --- a/drivers/pci/dwc/pci-exynos.c
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -521,25 +521,25 @@ static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
>  		exynos_pcie_msi_init(ep);
>  }
>  
> -static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base,
> -				 u32 reg)
> +static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
>  {
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
>  	u32 val;
>  
>  	exynos_pcie_sideband_dbi_r_mode(ep, true);
> -	val = readl(base + reg);
> +	dw_pcie_read(base + reg, size, &val);
>  	exynos_pcie_sideband_dbi_r_mode(ep, false);
>  	return val;
>  }
>  
> -static void exynos_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base,
> -				   u32 reg, u32 val)
> +static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				  u32 reg, size_t size, u32 val)
>  {
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
>  
>  	exynos_pcie_sideband_dbi_w_mode(ep, true);
> -	writel(val, base + reg);
> +	dw_pcie_write(base + reg, size, val);
>  	exynos_pcie_sideband_dbi_w_mode(ep, false);
>  }
>  
> @@ -646,8 +646,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
>  }
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -	.readl_dbi = exynos_pcie_readl_dbi,
> -	.writel_dbi = exynos_pcie_writel_dbi,
> +	.read_dbi = exynos_pcie_read_dbi,
> +	.write_dbi = exynos_pcie_write_dbi,
>  	.link_up = exynos_pcie_link_up,
>  };
>  
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index ea403e2240cf..734acac1926d 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -61,21 +61,35 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -u32 __dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg)
> +u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +		       size_t size)
>  {
> -	if (pci->ops->readl_dbi)
> -		return pci->ops->readl_dbi(pci, base, reg);
> +	int ret;
> +	u32 val;
> +
> +	if (pci->ops->read_dbi)
> +		return pci->ops->read_dbi(pci, base, reg, size);
>  
> -	return readl(base + reg);
> +	ret = dw_pcie_read(base + reg, size, &val);
> +	if (ret)
> +		dev_err(pci->dev, "read DBI address failed\n");
> +
> +	return val;
>  }
>  
> -void __dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			  u32 val)
> +void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +			 size_t size, u32 val)
>  {
> -	if (pci->ops->writel_dbi)
> -		pci->ops->writel_dbi(pci, base, reg, val);
> -	else
> -		writel(val, base + reg);
> +	int ret;
> +
> +	if (pci->ops->write_dbi) {
> +		pci->ops->write_dbi(pci, base, reg, size, val);
> +		return;
> +	}
> +
> +	ret = dw_pcie_write(base + reg, size, val);
> +	if (ret)
> +		dev_err(pci->dev, "write DBI address failed\n");
>  }
>  
>  static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e97fc4ce7d49..bfaf2b850a88 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -144,9 +144,10 @@ struct pcie_port {
>  
>  struct dw_pcie_ops {
>  	u64	(*cpu_addr_fixup)(u64 cpu_addr);
> -	u32	(*readl_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg);
> -	void	(*writel_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> -			      u32 val);
> +	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> +			    size_t size);
> +	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> +			     size_t size, u32 val);
>  	int	(*link_up)(struct dw_pcie *pcie);
>  };
>  
> @@ -164,9 +165,10 @@ struct dw_pcie {
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
>  
> -u32 __dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg);
> -void __dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			  u32 val);
> +u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +		       size_t size);
> +void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +			 size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> @@ -174,14 +176,14 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       u32 size);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  
> -static inline dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> +static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -	__dw_pcie_writel_dbi(pci, pci->dbi_base, reg, val);
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
>  }
>  
>  static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return  __dw_pcie_readl_dbi(pci, pci->dbi_base, reg);
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
>  }
>  
>  #ifdef CONFIG_PCIE_DW_HOST
