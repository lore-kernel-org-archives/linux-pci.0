Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 28 Jun 2018 08:22:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pci: fix I/O space page leak
Message-ID: <20180628132259.GB90450@bhelgaas-glaptop.roam.corp.google.com>
References: <1ca6adde-a91e-84d0-c7dc-fd01bfd9edcc@cogentembedded.com>
MIME-Version: 1.0
In-Reply-To: <1ca6adde-a91e-84d0-c7dc-fd01bfd9edcc@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Rob Herring <robh@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-renesas-soc@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-mediatek@lists.infradead.org, Tanmay Inamdar <tinamdar@apm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2018 at 08:51:37PM +0300, Sergei Shtylyov wrote:
> When testing the R-Car PCIe driver on the Condor board, I noticed that iff
> I  left the PCIe PHY driver disabled, the kernel crashed  with this BUG:
> 
> [    1.225819] kernel BUG at lib/ioremap.c:72!
> [    1.230007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    1.235496] Modules linked in:
> [    1.238561] CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
> [    1.245526] Hardware name: Renesas Condor board based on r8a77980 (DT)
> [    1.252075] Workqueue: events deferred_probe_work_func
> [    1.257220] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    1.262024] pc : ioremap_page_range+0x370/0x3c8
> [    1.266558] lr : ioremap_page_range+0x40/0x3c8
> [    1.271002] sp : ffff000008da39e0
> [    1.274317] x29: ffff000008da39e0 x28: 00e8000000000f07
> [    1.279636] x27: ffff7dfffee00000 x26: 0140000000000000
> [    1.284954] x25: ffff7dfffef00000 x24: 00000000000fe100
> [    1.290272] x23: ffff80007b906000 x22: ffff000008ab8000
> [    1.295590] x21: ffff000008bb1d58 x20: ffff7dfffef00000
> [    1.300909] x19: ffff800009c30fb8 x18: 0000000000000001
> [    1.306226] x17: 00000000000152d0 x16: 00000000014012d0
> [    1.311544] x15: 0000000000000000 x14: 0720072007200720
> [    1.316862] x13: 0720072007200720 x12: 0720072007200720
> [    1.322180] x11: 0720072007300730 x10: 00000000000000ae
> [    1.327498] x9 : 0000000000000000 x8 : ffff7dffff000000                      
> [    1.332816] x7 : 0000000000000000 x6 : 0000000000000100
> [    1.338134] x5 : 0000000000000000 x4 : 000000007b906000
> [    1.343452] x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
> [    1.348770] x1 : 0000000040000000 x0 : 00e80000fe100f07
> [    1.354090] Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))  
> [    1.361056] Call trace:
> [    1.363504]  ioremap_page_range+0x370/0x3c8
> [    1.367695]  pci_remap_iospace+0x7c/0xac
> [    1.371624]  pci_parse_request_of_pci_ranges+0x13c/0x190
> [    1.376945]  rcar_pcie_probe+0x4c/0xb04
> [    1.380786]  platform_drv_probe+0x50/0xbc
> [    1.384799]  driver_probe_device+0x21c/0x308
> [    1.389072]  __device_attach_driver+0x98/0xc8
> [    1.393431]  bus_for_each_drv+0x54/0x94
> [    1.397269]  __device_attach+0xc4/0x12c
> [    1.401107]  device_initial_probe+0x10/0x18
> [    1.405292]  bus_probe_device+0x90/0x98
> [    1.409130]  deferred_probe_work_func+0xb0/0x150
> [    1.413756]  process_one_work+0x12c/0x29c
> [    1.417768]  worker_thread+0x200/0x3fc
> [    1.421522]  kthread+0x108/0x134
> [    1.424755]  ret_from_fork+0x10/0x18
> [    1.428334] Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)
> 
> It turned out that pci_remap_iospace() wasn't undone when the driver's
> probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
> the probe was retried,  finally causing the BUG due to trying to remap
> already remapped pages.
> 
> The most feasible solution seems to introduce devm_pci_remap_iospace()
> and call it instead of pci_remap_iospace(), so that the pages get unmapped
> automagically on any probe failure.
> 
> And  while fixing pci_parse_request_of_pci_ranges(), aslo fix the other
> drivers that have probably copied the bad example...
> 
> Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")
> Fixes: cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
> Fixes: b7e78170efd4 ("PCI: versatile: Add DT-based ARM Versatile PB PCIe host driver")
> Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
> Fixes: 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org

Let me know if you want me to take this, Lorenzo, otherwise:
s/pci: fix/PCI: Fix/ and

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> The patch is against the 'master' branch of Bjorn Helgaas' 'pci.git' repo...
> It  has only been tested with the R-Car PCIe driver...
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c |    3 +
>  drivers/pci/controller/pci-aardvark.c             |    2 -
>  drivers/pci/controller/pci-ftpci100.c             |    2 -
>  drivers/pci/controller/pci-v3-semi.c              |    2 -
>  drivers/pci/controller/pci-versatile.c            |    2 -
>  drivers/pci/controller/pci-xgene.c                |    2 -
>  drivers/pci/controller/pcie-mediatek.c            |    2 -
>  drivers/pci/of.c                                  |    2 -
>  drivers/pci/pci.c                                 |   38 ++++++++++++++++++++++
>  include/linux/pci.h                               |    2 +
>  10 files changed, 49 insertions(+), 8 deletions(-)
> 
> Index: pci/drivers/pci/controller/dwc/pcie-designware-host.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ pci/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -363,7 +363,8 @@ int dw_pcie_host_init(struct pcie_port *
>  	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
>  		switch (resource_type(win->res)) {
>  		case IORESOURCE_IO:
> -			ret = pci_remap_iospace(win->res, pp->io_base);
> +			ret = devm_pci_remap_iospace(dev, win->res,
> +						     pp->io_base);
>  			if (ret) {
>  				dev_warn(dev, "Error %d: failed to map resource %pR\n",
>  					 ret, win->res);
> Index: pci/drivers/pci/controller/pci-aardvark.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pci-aardvark.c
> +++ pci/drivers/pci/controller/pci-aardvark.c
> @@ -849,7 +849,7 @@ static int advk_pcie_parse_request_of_pc
>  					     0,	0xF8000000, 0,
>  					     lower_32_bits(res->start),
>  					     OB_PCIE_IO);
> -			err = pci_remap_iospace(res, iobase);
> +			err = devm_pci_remap_iospace(dev, res, iobase);
>  			if (err) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 err, res);
> Index: pci/drivers/pci/controller/pci-ftpci100.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pci-ftpci100.c
> +++ pci/drivers/pci/controller/pci-ftpci100.c
> @@ -501,7 +501,7 @@ static int faraday_pci_probe(struct plat
>  				dev_err(dev, "illegal IO mem size\n");
>  				return -EINVAL;
>  			}
> -			ret = pci_remap_iospace(io, io_base);
> +			ret = devm_pci_remap_iospace(dev, io, io_base);
>  			if (ret) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 ret, io);
> Index: pci/drivers/pci/controller/pci-v3-semi.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pci-v3-semi.c
> +++ pci/drivers/pci/controller/pci-v3-semi.c
> @@ -537,7 +537,7 @@ static int v3_pci_setup_resource(struct
>  		v3->io_bus_addr = io->start - win->offset;
>  		dev_dbg(dev, "I/O window %pR, bus addr %pap\n",
>  			io, &v3->io_bus_addr);
> -		ret = pci_remap_iospace(io, io_base);
> +		ret = devm_pci_remap_iospace(dev, io, io_base);
>  		if (ret) {
>  			dev_warn(dev,
>  				 "error %d: failed to map resource %pR\n",
> Index: pci/drivers/pci/controller/pci-versatile.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pci-versatile.c
> +++ pci/drivers/pci/controller/pci-versatile.c
> @@ -82,7 +82,7 @@ static int versatile_pci_parse_request_o
>  
>  		switch (resource_type(res)) {
>  		case IORESOURCE_IO:
> -			err = pci_remap_iospace(res, iobase);
> +			err = devm_pci_remap_iospace(dev, res, iobase);
>  			if (err) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 err, res);
> Index: pci/drivers/pci/controller/pci-xgene.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pci-xgene.c
> +++ pci/drivers/pci/controller/pci-xgene.c
> @@ -423,7 +423,7 @@ static int xgene_pcie_map_ranges(struct
>  		case IORESOURCE_IO:
>  			xgene_pcie_setup_ob_reg(port, res, OMR3BARL, io_base,
>  						res->start - window->offset);
> -			ret = pci_remap_iospace(res, io_base);
> +			ret = devm_pci_remap_iospace(dev, res, io_base);
>  			if (ret < 0)
>  				return ret;
>  			break;
> Index: pci/drivers/pci/controller/pcie-mediatek.c
> ===================================================================
> --- pci.orig/drivers/pci/controller/pcie-mediatek.c
> +++ pci/drivers/pci/controller/pcie-mediatek.c
> @@ -1109,7 +1109,7 @@ static int mtk_pcie_request_resources(st
>  	if (err < 0)
>  		return err;
>  
> -	pci_remap_iospace(&pcie->pio, pcie->io.start);
> +	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
>  
>  	return 0;
>  }
> Index: pci/drivers/pci/of.c
> ===================================================================
> --- pci.orig/drivers/pci/of.c
> +++ pci/drivers/pci/of.c
> @@ -612,7 +612,7 @@ int pci_parse_request_of_pci_ranges(stru
>  
>  		switch (resource_type(res)) {
>  		case IORESOURCE_IO:
> -			err = pci_remap_iospace(res, iobase);
> +			err = devm_pci_remap_iospace(dev, res, iobase);
>  			if (err) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 err, res);
> Index: pci/drivers/pci/pci.c
> ===================================================================
> --- pci.orig/drivers/pci/pci.c
> +++ pci/drivers/pci/pci.c
> @@ -3579,6 +3579,44 @@ void pci_unmap_iospace(struct resource *
>  }
>  EXPORT_SYMBOL(pci_unmap_iospace);
>  
> +static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
> +{
> +	struct resource **res = ptr;
> +
> +	pci_unmap_iospace(*res);
> +}
> +
> +/**
> + * devm_pci_remap_iospace - Managed pci_remap_iospace()
> + * @dev: Generic device to remap IO address for
> + * @res: Resource describing the I/O space
> + * @phys_addr: physical address of range to be mapped
> + *
> + * Managed pci_remap_iospace().  Map is automatically unmapped on driver
> + * detach.
> + */
> +int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
> +			   phys_addr_t phys_addr)
> +{
> +	const struct resource **ptr;
> +	int error;
> +
> +	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	error = pci_remap_iospace(res, phys_addr);
> +	if (error) {
> +		devres_free(ptr);
> +	} else	{
> +		*ptr = res;
> +		devres_add(dev, ptr);
> +	}
> +
> +	return error;
> +}
> +EXPORT_SYMBOL(devm_pci_remap_iospace);
> +
>  /**
>   * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
>   * @dev: Generic device to remap IO address for
> Index: pci/include/linux/pci.h
> ===================================================================
> --- pci.orig/include/linux/pci.h
> +++ pci/include/linux/pci.h
> @@ -1240,6 +1240,8 @@ int pci_register_io_range(struct fwnode_
>  unsigned long pci_address_to_pio(phys_addr_t addr);
>  phys_addr_t pci_pio_to_address(unsigned long pio);
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> +int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
> +			   phys_addr_t phys_addr);
>  void pci_unmap_iospace(struct resource *res);
>  void __iomem *devm_pci_remap_cfgspace(struct device *dev,
>  				      resource_size_t offset,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
