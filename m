Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jan Kiszka'" <jan.kiszka@siemens.com>,
 "'Bjorn Helgaas'" <bhelgaas@google.com>,
 "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <d76c32d535bb555076b3f7c010a6856ac97bbdae.1524582822.git.jan.kiszka@siemens.com>
In-Reply-To: <d76c32d535bb555076b3f7c010a6856ac97bbdae.1524582822.git.jan.kiszka@siemens.com>
Subject: Re: [PATCH 4/6] PCI: Convert of_pci_get_host_bridge_resources users
 to devm variant
Date: Wed, 25 Apr 2018 15:47:44 -0400
Message-ID: <000001d3dcce$48284a10$d878de30$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
 'Joao Pinto' <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, April 24, 2018 11:14 AM
> To: Bjorn Helgaas <bhelgaas@google.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: Jingoo Han <jingoohan1@gmail.com>; Joao Pinto
> <Joao.Pinto@synopsys.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: [PATCH 4/6] PCI: Convert of_pci_get_host_bridge_resources users
> to devm variant
> 
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Straightforward for all of them, no more leaks afterwards.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>

For drivers/pci/dwc/pcie-designware-host.c,

Acked-by: Jingoo Han <jingoo1han@gmail.com>

Best regards,
Jingoo Han

> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/host/pci-aardvark.c        | 5 ++---
>  drivers/pci/host/pci-ftpci100.c        | 4 ++--
>  drivers/pci/host/pci-v3-semi.c         | 3 ++-
>  drivers/pci/host/pci-versatile.c       | 3 +--
>  drivers/pci/host/pci-xgene.c           | 3 ++-
>  drivers/pci/host/pcie-altera.c         | 5 ++---
>  drivers/pci/host/pcie-iproc-platform.c | 4 ++--
>  drivers/pci/host/pcie-rcar.c           | 5 ++---
>  drivers/pci/host/pcie-rockchip.c       | 4 ++--
>  drivers/pci/host/pcie-xilinx-nwl.c     | 4 ++--
>  drivers/pci/host/pcie-xilinx.c         | 4 ++--
>  drivers/pci/of.c                       | 4 ++--
>  13 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index 6c409079d514..a8f6ab54b4c0 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -342,7 +342,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (!bridge)
>  		return -ENOMEM;
> 
> -	ret = of_pci_get_host_bridge_resources(np, 0, 0xff,
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>  					&bridge->windows, &pp->io_base);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-
> aardvark.c
> index b04d37b3c5de..709f0d69e35b 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -815,14 +815,13 @@ static int
> advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
>  {
>  	int err, res_valid = 0;
>  	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct resource_entry *win, *tmp;
>  	resource_size_t iobase;
> 
>  	INIT_LIST_HEAD(&pcie->resources);
> 
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie-
> >resources,
> -					       &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &pcie->resources,
&iobase);
>  	if (err)
>  		return err;
> 
> diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-
> ftpci100.c
> index 5008fd87956a..87748eaeaaed 100644
> --- a/drivers/pci/host/pci-ftpci100.c
> +++ b/drivers/pci/host/pci-ftpci100.c
> @@ -476,8 +476,8 @@ static int faraday_pci_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(p->base))
>  		return PTR_ERR(p->base);
> 
> -	ret = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> -					       &res, &io_base);
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &res, &io_base);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-
> semi.c
> index 0a4dea796663..167bf6f6b378 100644
> --- a/drivers/pci/host/pci-v3-semi.c
> +++ b/drivers/pci/host/pci-v3-semi.c
> @@ -791,7 +791,8 @@ static int v3_pci_probe(struct platform_device *pdev)
>  	if (IS_ERR(v3->config_base))
>  		return PTR_ERR(v3->config_base);
> 
> -	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &io_base);
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &io_base);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-
> versatile.c
> index 5b3876f5312b..ff2cd12b3978 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -64,11 +64,10 @@ static int
> versatile_pci_parse_request_of_pci_ranges(struct device *dev,
>  						     struct list_head *res)
>  {
>  	int err, mem = 1, res_valid = 0;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
> 
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, res, &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res,
> &iobase);
>  	if (err)
>  		return err;
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 0a0d7ee6d3c9..7b3ed6e34b6c 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -632,7 +632,8 @@ static int xgene_pcie_probe(struct platform_device
> *pdev)
>  	if (ret)
>  		return ret;
> 
> -	ret = of_pci_get_host_bridge_resources(dn, 0, 0xff, &res, &iobase);
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &iobase);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-
> altera.c
> index a6af62e0256d..49410c7ba0cc 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -488,11 +488,10 @@ static int
> altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
>  {
>  	int err, res_valid = 0;
>  	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct resource_entry *win;
> 
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie-
> >resources,
> -					       NULL);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff
> +						    &pcie->resources, NULL);
>  	if (err)
>  		return err;
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c
> b/drivers/pci/host/pcie-iproc-platform.c
> index e764a2a2693c..99c2022813e4 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -99,8 +99,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device
> *pdev)
>  		pcie->phy = NULL;
>  	}
> 
> -	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &resources,
> -					       &iobase);
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> &resources,
> +						    &iobase);
>  	if (ret) {
>  		dev_err(dev, "unable to get PCI host bridge resources\n");
>  		return ret;
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 6ab28f29ac6a..6eb36c924983 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1067,12 +1067,11 @@ static int
> rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
>  {
>  	int err;
>  	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
> 
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> -					       &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &pci->resources,
&iobase);
>  	if (err)
>  		return err;
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-
> rockchip.c
> index f1e8f97ea1fb..27b97fcddf15 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1560,8 +1560,8 @@ static int rockchip_pcie_probe(struct
> platform_device *pdev)
>  	if (err < 0)
>  		goto err_deinit_port;
> 
> -	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> -					       &res, &io_base);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +						    &res, &io_base);
>  	if (err)
>  		goto err_remove_irq_domain;
> 
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-
> xilinx-nwl.c
> index 4839ae578711..64df768c795c 100644
> --- a/drivers/pci/host/pcie-xilinx-nwl.c
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -825,7 +825,6 @@ static const struct of_device_id nwl_pcie_of_match[] =
> {
>  static int nwl_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->of_node;
>  	struct nwl_pcie *pcie;
>  	struct pci_bus *bus;
>  	struct pci_bus *child;
> @@ -855,7 +854,8 @@ static int nwl_pcie_probe(struct platform_device
*pdev)
>  		return err;
>  	}
> 
> -	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res,
> &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &iobase);
>  	if (err) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return err;
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-
> xilinx.c
> index 0ad188effc09..88c96e5669e0 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -643,8 +643,8 @@ static int xilinx_pcie_probe(struct platform_device
> *pdev)
>  		return err;
>  	}
> 
> -	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff, &res,
> -					       &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &iobase);
>  	if (err) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return err;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 6eab0bde2ab3..4f816c93e562 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -626,12 +626,12 @@ int pci_parse_request_of_pci_ranges(struct device
> *dev,
>  				    struct resource **bus_range)
>  {
>  	int err, res_valid = 0;
> -	struct device_node *np = dev->of_node;
>  	resource_size_t iobase;
>  	struct resource_entry *win, *tmp;
> 
>  	INIT_LIST_HEAD(resources);
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources,
> &iobase);
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
> +						    &iobase);
>  	if (err)
>  		return err;
> 
> --
> 2.13.6



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
