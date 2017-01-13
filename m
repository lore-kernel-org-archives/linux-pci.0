Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 10/37] PCI: dwc: designware: Fix style errors in
 pcie-designware.c
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-11-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <a138b0fb-f584-8953-658f-cf476e3d16e7@synopsys.com>
Date: Fri, 13 Jan 2017 16:38:24 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-11-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Fix all checkpatch warnings and check errors
> in pcie-designware.c
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |   42 ++++++++++++++++++-------------=
------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> =

> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-des=
ignware.c
> index 89cdb6b..ff04074 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -40,13 +40,13 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *v=
al)
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	}
>  =

> -	if (size =3D=3D 4)
> +	if (size =3D=3D 4) {
>  		*val =3D readl(addr);
> -	else if (size =3D=3D 2)
> +	} else if (size =3D=3D 2) {
>  		*val =3D readw(addr);
> -	else if (size =3D=3D 1)
> +	} else if (size =3D=3D 1) {
>  		*val =3D readb(addr);
> -	else {
> +	} else {
>  		*val =3D 0;
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  	}
> @@ -203,16 +203,15 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  =

>  	for (i =3D 0; i < MAX_MSI_CTRLS; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> -				(u32 *)&val);
> +				    (u32 *)&val);
>  		if (val) {
>  			ret =3D IRQ_HANDLED;
>  			pos =3D 0;
>  			while ((pos =3D find_next_bit(&val, 32, pos)) !=3D 32) {
>  				irq =3D irq_find_mapping(pp->irq_domain,
> -						i * 32 + pos);
> -				dw_pcie_wr_own_conf(pp,
> -						PCIE_MSI_INTR0_STATUS + i * 12,
> -						4, 1 << pos);
> +						       i * 32 + pos);
> +				dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
> +						    i * 12, 4, 1 << pos);
>  				generic_handle_irq(irq);
>  				pos++;
>  			}
> @@ -278,8 +277,9 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp,=
 int irq)
>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>  {
>  	int irq, pos0, i;
> -	struct pcie_port *pp =3D (struct pcie_port *) msi_desc_to_pci_sysdata(d=
esc);
> +	struct pcie_port *pp;
>  =

> +	pp  =3D (struct pcie_port *)msi_desc_to_pci_sysdata(desc);
>  	pos0 =3D bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>  				       order_base_2(no_irqs));
>  	if (pos0 < 0)
> @@ -341,7 +341,7 @@ static void dw_msi_setup_msg(struct pcie_port *pp, un=
signed int irq, u32 pos)
>  }
>  =

>  static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev =
*pdev,
> -			struct msi_desc *desc)
> +			    struct msi_desc *desc)
>  {
>  	int irq, pos;
>  	struct pcie_port *pp =3D pdev->bus->sysdata;
> @@ -389,7 +389,7 @@ static void dw_msi_teardown_irq(struct msi_controller=
 *chip, unsigned int irq)
>  {
>  	struct irq_data *data =3D irq_get_irq_data(irq);
>  	struct msi_desc *msi =3D irq_data_get_msi_desc(data);
> -	struct pcie_port *pp =3D (struct pcie_port *) msi_desc_to_pci_sysdata(m=
si);
> +	struct pcie_port *pp =3D (struct pcie_port *)msi_desc_to_pci_sysdata(ms=
i);
>  =

>  	clear_irq_range(pp, irq, 1, data->hwirq);
>  }
> @@ -431,7 +431,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  }
>  =

>  static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			irq_hw_number_t hwirq)
> +			   irq_hw_number_t hwirq)
>  {
>  	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
>  	irq_set_chip_data(irq, domain->host_data);
> @@ -468,8 +468,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  =

>  	cfg_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "config"=
);
>  	if (cfg_res) {
> -		pp->cfg0_size =3D resource_size(cfg_res)/2;
> -		pp->cfg1_size =3D resource_size(cfg_res)/2;
> +		pp->cfg0_size =3D resource_size(cfg_res) / 2;
> +		pp->cfg1_size =3D resource_size(cfg_res) / 2;
>  		pp->cfg0_base =3D cfg_res->start;
>  		pp->cfg1_base =3D cfg_res->start + pp->cfg0_size;
>  	} else if (!pp->va_cfg0_base) {
> @@ -508,8 +508,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			break;
>  		case 0:
>  			pp->cfg =3D win->res;
> -			pp->cfg0_size =3D resource_size(pp->cfg)/2;
> -			pp->cfg1_size =3D resource_size(pp->cfg)/2;
> +			pp->cfg0_size =3D resource_size(pp->cfg) / 2;
> +			pp->cfg1_size =3D resource_size(pp->cfg) / 2;
>  			pp->cfg0_base =3D pp->cfg->start;
>  			pp->cfg1_base =3D pp->cfg->start + pp->cfg0_size;
>  			break;
> @@ -615,7 +615,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  }
>  =

>  static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *b=
us,
> -		u32 devfn, int where, int size, u32 *val)
> +				 u32 devfn, int where, int size, u32 *val)
>  {
>  	int ret, type;
>  	u32 busdev, cfg_size;
> @@ -654,7 +654,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp=
, struct pci_bus *bus,
>  }
>  =

>  static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *b=
us,
> -		u32 devfn, int where, int size, u32 val)
> +				 u32 devfn, int where, int size, u32 val)
>  {
>  	int ret, type;
>  	u32 busdev, cfg_size;
> @@ -711,7 +711,7 @@ static int dw_pcie_valid_device(struct pcie_port *pp,=
 struct pci_bus *bus,
>  }
>  =

>  static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> -			int size, u32 *val)
> +			   int size, u32 *val)
>  {
>  	struct pcie_port *pp =3D bus->sysdata;
>  =

> @@ -727,7 +727,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 d=
evfn, int where,
>  }
>  =

>  static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> -			int where, int size, u32 val)
> +			   int where, int size, u32 val)
>  {
>  	struct pcie_port *pp =3D bus->sysdata;
>  =

> =


Always good to make clean up! Thanks!

Acked-By: Joao Pinto <jpinto@synopsys.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
