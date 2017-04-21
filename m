Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
 <linux-pci@vger.kernel.org>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <20170419164913.19674-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-15-lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 14/21] PCI: designware: update PCI config space remap
 function
Date: Fri, 21 Apr 2017 18:02:54 -0400
Message-ID: <000001d2baeb$07e84870$17b8d950$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
 'Joao Pinto' <Joao.Pinto@synopsys.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 19, 2017 12:49 PM, Lorenzo Pieralisi wrote:
> 
> PCI configuration space should be mapped with a memory region type that
> generates on the CPU host bus non-posted write transations. Update the
> driver to use the devm_pci_remap_cfg* interface to make sure the correct
> memory mappings for PCI configuration space are used.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han


> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index 5ba3349..2b789af 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -338,8 +338,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
> 
>  	if (!pci->dbi_base) {
> -		pci->dbi_base = devm_ioremap(dev, pp->cfg->start,
> -					resource_size(pp->cfg));
> +		pci->dbi_base = devm_pci_remap_cfgspace(dev,
> +						pp->cfg->start,
> +						resource_size(pp->cfg));
>  		if (!pci->dbi_base) {
>  			dev_err(dev, "error with ioremap\n");
>  			ret = -ENOMEM;
> @@ -350,8 +351,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	pp->mem_base = pp->mem->start;
> 
>  	if (!pp->va_cfg0_base) {
> -		pp->va_cfg0_base = devm_ioremap(dev, pp->cfg0_base,
> -						pp->cfg0_size);
> +		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
> +					pp->cfg0_base, pp->cfg0_size);
>  		if (!pp->va_cfg0_base) {
>  			dev_err(dev, "error with ioremap in function\n");
>  			ret = -ENOMEM;
> @@ -360,7 +361,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
> 
>  	if (!pp->va_cfg1_base) {
> -		pp->va_cfg1_base = devm_ioremap(dev, pp->cfg1_base,
> +		pp->va_cfg1_base = devm_pci_remap_cfgspace(dev,
> +						pp->cfg1_base,
>  						pp->cfg1_size);
>  		if (!pp->va_cfg1_base) {
>  			dev_err(dev, "error with ioremap\n");
> --
> 2.10.0



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
