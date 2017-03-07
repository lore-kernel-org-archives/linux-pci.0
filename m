Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 3/7] PCI: dwc: artpec6: Populate cpu_addr_fixup ops
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
 <1488880372-7390-4-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <bf20e36d-ba5f-1da6-8dda-6d2c8ac7023b@synopsys.com>
Date: Tue, 7 Mar 2017 11:12:50 +0000
MIME-Version: 1.0
In-Reply-To: <1488880372-7390-4-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nsekhar@ti.com, Niklas Cassel <niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 9:52 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Populate cpu_addr_fixup ops to extract the least 28 bits of the
> corresponding cpu address.
> =

> Cc: Niklas Cassel <niklas.cassel@axis.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-artpec6.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec=
6.c
> index fcd3ef8..5b3b3af 100644
> --- a/drivers/pci/dwc/pcie-artpec6.c
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -78,6 +78,11 @@ static void artpec6_pcie_writel(struct artpec6_pcie *a=
rtpec6_pcie, u32 offset, u
>  	regmap_write(artpec6_pcie->regmap, offset, val);
>  }
>  =

> +static u64 artpec6_pcie_cpu_addr_fixup(u64 pci_addr)
> +{
> +	return pci_addr & ARTPEC6_CPU_TO_BUS_ADDR;
> +}
> +
>  static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
>  {
>  	struct dw_pcie *pci =3D artpec6_pcie->pci;
> @@ -142,11 +147,6 @@ static int artpec6_pcie_establish_link(struct artpec=
6_pcie *artpec6_pcie)
>  	 */
>  	dw_pcie_writel_dbi(pci, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
>  =

> -	pp->io_base &=3D ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->mem_base &=3D ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &=3D ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &=3D ARTPEC6_CPU_TO_BUS_ADDR;
> -
>  	/* setup root complex */
>  	dw_pcie_setup_rc(pp);
>  =

> @@ -234,6 +234,10 @@ static int artpec6_add_pcie_port(struct artpec6_pcie=
 *artpec6_pcie,
>  	return 0;
>  }
>  =

> +static const struct dw_pcie_ops dw_pcie_ops =3D {
> +	.cpu_addr_fixup =3D artpec6_pcie_cpu_addr_fixup,
> +};
> +
>  static int artpec6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -252,6 +256,7 @@ static int artpec6_pcie_probe(struct platform_device =
*pdev)
>  		return -ENOMEM;
>  =

>  	pci->dev =3D dev;
> +	pci->ops =3D &dw_pcie_ops;
>  =

>  	artpec6_pcie->pci =3D pci;
>  =

> =


Simpler, no doubt.

Acked-By: Joao Pinto <jpinto@synopsys.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
