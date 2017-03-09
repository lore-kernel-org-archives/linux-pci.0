Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 6/7] PCI: dwc: designware: Move _unroll
 configurations to a separate function
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-7-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <e4cf80f5-08f3-5ebc-ef55-8d43f8e02104@synopsys.com>
Date: Thu, 9 Mar 2017 12:25:05 +0000
MIME-Version: 1.0
In-Reply-To: <1489041545-15730-7-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nsekhar@ti.com
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 6:39 AM de 3/9/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Rename dw_pcie_writel_unroll/dw_pcie_readl_unroll
> to dw_pcie_writel_ob_unroll/dw_pcie_readl_ob_unroll respectively as these
> functions are used to perform only outbound configurations. Also move
> these _unroll configurations to a separate function.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |  112 ++++++++++++++++++++++---------=
------
>  1 file changed, 67 insertions(+), 45 deletions(-)
> =

> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-des=
ignware.c
> index 557ee53..6657a84 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -92,22 +92,64 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, void __io=
mem *base, u32 reg,
>  		dev_err(pci->dev, "write DBI address failed\n");
>  }
>  =

> -static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
> -				u32 index, u32 reg)
> +static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, void __iomem *ba=
se,
> +				   u32 index, u32 reg)
>  {
>  	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  =

>  	return dw_pcie_read_dbi(pci, base, offset + reg, 0x4);
>  }
>  =

> -static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *bas=
e,
> -				  u32 index, u32 reg, u32 val)
> +static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, void __iomem *=
base,
> +				     u32 index, u32 reg, u32 val)
>  {
>  	u32 offset =3D PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  =

>  	dw_pcie_write_dbi(pci, base, offset + reg, 0x4, val);
>  }
>  =

> +void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, in=
t type,
> +				      u64 cpu_addr, u64 pci_addr, u32 size)
> +{
> +	u32 retries, val;
> +	void __iomem *base =3D pci->dbi_base;
> +
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_LOWER_BASE,
> +				 lower_32_bits(cpu_addr));
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_UPPER_BASE,
> +				 upper_32_bits(cpu_addr));
> +	dw_pcie_writel_ob_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
> +				 lower_32_bits(cpu_addr + size - 1));
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_LOWER_TARGET,
> +				 lower_32_bits(pci_addr));
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_UPPER_TARGET,
> +				 upper_32_bits(pci_addr));
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_REGION_CTRL1,
> +				 type);
> +	dw_pcie_writel_ob_unroll(pci, base, index,
> +				 PCIE_ATU_UNR_REGION_CTRL2,
> +				 PCIE_ATU_ENABLE);
> +
> +	/*
> +	 * Make sure ATU enable takes effect before any subsequent config
> +	 * and I/O accesses.
> +	 */
> +	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> +		val =3D dw_pcie_readl_ob_unroll(pci, base, index,
> +					      PCIE_ATU_UNR_REGION_CTRL2);
> +		if (val & PCIE_ATU_ENABLE)
> +			return;
> +
> +		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +	}
> +	dev_err(pci->dev, "outbound iATU is not being enabled\n");
> +}
> +
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			       u64 cpu_addr, u64 pci_addr, u32 size)
>  {
> @@ -118,59 +160,39 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,=
 int index, int type,
>  		cpu_addr =3D pci->ops->cpu_addr_fixup(cpu_addr);
>  =

>  	if (pci->iatu_unroll_enabled) {
> -		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LOWER_BASE,
> -				      lower_32_bits(cpu_addr));
> -		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_UPPER_BASE,
> -				      upper_32_bits(cpu_addr));
> -		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
> -				      lower_32_bits(cpu_addr + size - 1));
> -		dw_pcie_writel_unroll(pci, base, index,
> -				      PCIE_ATU_UNR_LOWER_TARGET,
> -				      lower_32_bits(pci_addr));
> -		dw_pcie_writel_unroll(pci, base, index,
> -				      PCIE_ATU_UNR_UPPER_TARGET,
> -				      upper_32_bits(pci_addr));
> -		dw_pcie_writel_unroll(pci, base, index,
> -				      PCIE_ATU_UNR_REGION_CTRL1,
> -				      type);
> -		dw_pcie_writel_unroll(pci, base, index,
> -				      PCIE_ATU_UNR_REGION_CTRL2,
> -				      PCIE_ATU_ENABLE);
> -	} else {
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
> -				  PCIE_ATU_REGION_OUTBOUND | index);
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
> -				  lower_32_bits(cpu_addr));
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
> -				  upper_32_bits(cpu_addr));
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
> -				  lower_32_bits(cpu_addr + size - 1));
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
> -				  lower_32_bits(pci_addr));
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
> -				  upper_32_bits(pci_addr));
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
> -		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4,
> -				  PCIE_ATU_ENABLE);
> +		dw_pcie_prog_outbound_atu_unroll(pci, index, type, cpu_addr,
> +						 pci_addr, size);
> +		return;
>  	}
>  =

> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
> +			  PCIE_ATU_REGION_OUTBOUND | index);
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
> +			  lower_32_bits(cpu_addr));
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
> +			  upper_32_bits(cpu_addr));
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
> +			  lower_32_bits(cpu_addr + size - 1));
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
> +			  lower_32_bits(pci_addr));
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
> +			  upper_32_bits(pci_addr));
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4,
> +			  PCIE_ATU_ENABLE);
> +
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
>  	 * and I/O accesses.
>  	 */
>  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> -		if (pci->iatu_unroll_enabled)
> -			val =3D dw_pcie_readl_unroll(pci, base, index,
> -						   PCIE_ATU_UNR_REGION_CTRL2);
> -		else
> -			val =3D dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
> -
> +		val =3D dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
>  		if (val =3D=3D PCIE_ATU_ENABLE)
>  			return;
>  =

>  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
>  	}
> -	dev_err(pci->dev, "iATU is not being enabled\n");
> +	dev_err(pci->dev, "outbound iATU is not being enabled\n");
>  }
>  =

>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> =


Acked-By: Joao Pinto <jpinto@synopsys.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
