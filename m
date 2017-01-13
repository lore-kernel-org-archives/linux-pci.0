Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 09/37] PCI: dwc: designware: Parse *num-lanes* property in
 dw_pcie_setup_rc
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-10-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <c3c55af3-29d1-dc59-3ae4-9a4132c99092@synopsys.com>
Date: Fri, 13 Jan 2017 17:13:12 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-10-git-send-email-kishon@ti.com>
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

Hi,

=C0s 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> *num-lanes* dt property is parsed in dw_pcie_host_init. However
> *num-lanes* property is applicable to both root complex mode and
> endpoint mode. As a first step, move the parsing of this property
> outside dw_pcie_host_init. This is in preparation for splitting
> pcie-designware.c to pcie-designware.c and pcie-designware-host.c
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |   18 +++++++++++-------
>  drivers/pci/dwc/pcie-designware.h |    1 -
>  2 files changed, 11 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-des=
ignware.c
> index 00a0fdc..89cdb6b 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -551,10 +551,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  =

> -	ret =3D of_property_read_u32(np, "num-lanes", &pci->lanes);
> -	if (ret)
> -		pci->lanes =3D 0;
> -
>  	ret =3D of_property_read_u32(np, "num-viewport", &pci->num_viewport);
>  	if (ret)
>  		pci->num_viewport =3D 2;
> @@ -751,18 +747,26 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32=
 devfn,
>  =

>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
> +	int ret;
> +	u32 lanes;
>  	u32 val;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct device *dev =3D pci->dev;
> +	struct device_node *np =3D dev->of_node;
>  =

>  	/* get iATU unroll support */
>  	pci->iatu_unroll_enabled =3D dw_pcie_iatu_unroll_enabled(pci);
>  	dev_dbg(pci->dev, "iATU unroll: %s\n",
>  		pci->iatu_unroll_enabled ? "enabled" : "disabled");
>  =

> +	ret =3D of_property_read_u32(np, "num-lanes", &lanes);
> +	if (ret)
> +		lanes =3D 0;

You moved from host_init to root complex setup function, which in my opinio=
n did
not improve (in this scope).

I suggest that instead of making so much intermediary patches, which is nic=
e to
understand your development sequence, but hard to review. Wouldn't be bette=
r to
condense some of the patches? We would have a cloear vision of the final pr=
oduct :)

Joao

> +
>  	/* set the number of lanes */
>  	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>  	val &=3D ~PORT_LINK_MODE_MASK;
> -	switch (pci->lanes) {
> +	switch (lanes) {
>  	case 1:
>  		val |=3D PORT_LINK_MODE_1_LANES;
>  		break;
> @@ -776,7 +780,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		val |=3D PORT_LINK_MODE_8_LANES;
>  		break;
>  	default:
> -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->lanes);
> +		dev_err(pci->dev, "num-lanes %u: invalid value\n", lanes);
>  		return;
>  	}
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> @@ -784,7 +788,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	/* set link width speed control register */
>  	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  	val &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	switch (pci->lanes) {
> +	switch (lanes) {
>  	case 1:
>  		val |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
>  		break;
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-des=
ignware.h
> index d4b3d43..491fbe3 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -148,7 +148,6 @@ struct dw_pcie_ops {
>  struct dw_pcie {
>  	struct device		*dev;
>  	void __iomem		*dbi_base;
> -	u32			lanes;
>  	u32			num_viewport;
>  	u8			iatu_unroll_enabled;
>  	struct pcie_port	pp;
> =



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
