Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
 <1488880372-7390-3-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <14c771fd-f225-338b-3b1a-255df0e0b278@synopsys.com>
Date: Tue, 7 Mar 2017 11:12:36 +0000
MIME-Version: 1.0
In-Reply-To: <1488880372-7390-3-git-send-email-kishon@ti.com>
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

=C0s 9:52 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Populate cpu_addr_fixup ops to extract the least 28 bits of the
> corresponding cpu address.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 0984baf..07c45ec 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -88,6 +88,11 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pc=
ie *pcie, u32 offset,
>  	writel(value, pcie->base + offset);
>  }
>  =

> +static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
> +{
> +	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
> +}
> +
>  static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci);
> @@ -152,11 +157,6 @@ static void dra7xx_pcie_host_init(struct pcie_port *=
pp)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci);
>  =

> -	pp->io_base &=3D DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->mem_base &=3D DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &=3D DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &=3D DRA7XX_CPU_TO_BUS_ADDR;
> -
>  	dw_pcie_setup_rc(pp);
>  =

>  	dra7xx_pcie_establish_link(dra7xx);
> @@ -329,6 +329,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_=
pcie *dra7xx,
>  }
>  =

>  static const struct dw_pcie_ops dw_pcie_ops =3D {
> +	.cpu_addr_fixup =3D dra7xx_pcie_cpu_addr_fixup,
>  	.link_up =3D dra7xx_pcie_link_up,
>  };
>  =

> =


Simpler, no doubt.

Acked-By: Joao Pinto <jpinto@synopsys.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
