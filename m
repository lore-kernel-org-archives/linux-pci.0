Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 2 Dec 2016 11:36:33 +0000
From: Graeme Gregory <gg@slimlogic.co.uk>
To: Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 1/1] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
Message-ID: <20161202113633.GD1115@linaro-xps13.localdomain>
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, Mark Salter <msalter@redhat.com>,
 patches <patches@apm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Masters <jcm@redhat.com>,
 Tomasz Nowicki <tn@semihalf.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 06:27:07PM -0800, Duc Dang wrote:
> PCIe controllers in X-Gene SoCs is not ECAM compliant: software
> needs to configure additional controller's register to address
> device at bus:dev:function.
> 
> The quirk will discover controller MMIO register space and configure
> controller registers to select and address the target secondary device.
> 
> The quirk will only be applied for X-Gene PCIe MCFG table with
> OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Tested on our Linaro moonshot

Tested-by: Graeme Gregory <graeme.gregory@linaro.org>

Thanks


> ---
> v4:
>   - Rebase on top of pci/ecam tree
>   - Introduce xgene_get_csr_resource to discover MMIO register space
>   (per Mark's test code).
>   - Refactor .init functions for pci_ecam_ops to reuse common code
>   - Introduce pcie_bus_to_port to extract X-Gene 'port' information
>   from 'bus' device.
>   - Kconfig/Makefile changes to only compile required code for ACPI
> v3:
>   - Rebase on top of pci/ecam-v6 tree.
>   - Use DEFINE_RES_MEM_NAMED to declare controller register space
>   with name "PCIe CSR"
> v2:
>   RFC v2: https://patchwork.ozlabs.org/patch/686846/
> v1:
>   RFC v1: https://patchwork.kernel.org/patch/9337115/
> ---
>  drivers/acpi/pci_mcfg.c      |  25 +++++++++
>  drivers/pci/host/Kconfig     |   4 +-
>  drivers/pci/host/Makefile    |   2 +-
>  drivers/pci/host/pci-xgene.c | 127 ++++++++++++++++++++++++++++++++++++++++---
>  include/linux/pci-ecam.h     |   2 +
>  5 files changed, 150 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index d34d196..7319188 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -108,6 +108,31 @@ struct mcfg_fixup {
>  	THUNDER_ECAM_QUIRK(2, 11),
>  	THUNDER_ECAM_QUIRK(2, 12),
>  	THUNDER_ECAM_QUIRK(2, 13),
> +
> +#define XGENE_V1_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v1_pcie_ecam_ops }
> +#define XGENE_V2_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v2_pcie_ecam_ops }
> +	/* X-Gene SoC with v1 PCIe controller */
> +	XGENE_V1_ECAM_MCFG(1, 0),
> +	XGENE_V1_ECAM_MCFG(1, 1),
> +	XGENE_V1_ECAM_MCFG(1, 2),
> +	XGENE_V1_ECAM_MCFG(1, 3),
> +	XGENE_V1_ECAM_MCFG(1, 4),
> +	XGENE_V1_ECAM_MCFG(2, 0),
> +	XGENE_V1_ECAM_MCFG(2, 1),
> +	XGENE_V1_ECAM_MCFG(2, 2),
> +	XGENE_V1_ECAM_MCFG(2, 3),
> +	XGENE_V1_ECAM_MCFG(2, 4),
> +	/* X-Gene SoC with v2.1 PCIe controller */
> +	XGENE_V2_ECAM_MCFG(3, 0),
> +	XGENE_V2_ECAM_MCFG(3, 1),
> +	/* X-Gene SoC with v2.2 PCIe controller */
> +	XGENE_V2_ECAM_MCFG(4, 0),
> +	XGENE_V2_ECAM_MCFG(4, 1),
> +	XGENE_V2_ECAM_MCFG(4, 2),
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c983892..1fb5518 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -133,8 +133,8 @@ config PCIE_XILINX
>  
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
> -	depends on ARCH_XGENE
> -	depends on OF
> +	depends on ARM64
> +	depends on OF || (ACPI && PCI_QUIRKS)
>  	select PCIEPORTBUS
>  	help
>  	  Say Y here if you want internal PCI support on APM X-Gene SoC.
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 639494a..6cc84b4 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
> -obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
> +obj-$(CONFIG_ARM64) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 1de23d7..6edcac7 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -27,6 +27,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -64,7 +66,9 @@
>  /* PCIe IP version */
>  #define XGENE_PCIE_IP_VER_UNKN		0
>  #define XGENE_PCIE_IP_VER_1		1
> +#define XGENE_PCIE_IP_VER_2		2
>  
> +#if defined(CONFIG_PCI_XGENE) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>  struct xgene_pcie_port {
>  	struct device_node	*node;
>  	struct device		*dev;
> @@ -91,13 +95,24 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
>  	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
>  }
>  
> +static inline struct xgene_pcie_port *pcie_bus_to_port(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg;
> +
> +	if (acpi_disabled)
> +		return (struct xgene_pcie_port *)(bus->sysdata);
> +
> +	cfg = bus->sysdata;
> +	return (struct xgene_pcie_port *)(cfg->priv);
> +}
> +
>  /*
>   * When the address bit [17:16] is 2'b01, the Configuration access will be
>   * treated as Type 1 and it will be forwarded to external PCIe device.
>   */
>  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
>  
>  	if (bus->number >= (bus->primary + 1))
>  		return port->cfg_base + AXI_EP_CFG_ACCESS;
> @@ -111,7 +126,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>   */
>  static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
>  	unsigned int b, d, f;
>  	u32 rtdid_val = 0;
>  
> @@ -158,7 +173,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  				    int where, int size, u32 *val)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct xgene_pcie_port *port = pcie_bus_to_port(bus);
>  
>  	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
>  	    PCIBIOS_SUCCESSFUL)
> @@ -182,13 +197,104 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
> +#endif
>  
> -static struct pci_ops xgene_pcie_ops = {
> -	.map_bus = xgene_pcie_map_bus,
> -	.read = xgene_pcie_config_read32,
> -	.write = pci_generic_config_write32,
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +static int xgene_get_csr_resource(struct acpi_device *adev,
> +				  struct resource *res)
> +{
> +	struct device *dev = &adev->dev;
> +	struct resource_entry *entry;
> +	struct list_head list;
> +	unsigned long flags;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&list);
> +	flags = IORESOURCE_MEM;
> +	ret = acpi_dev_get_resources(adev, &list,
> +				     acpi_dev_filter_resource_type_cb,
> +				     (void *) flags);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to parse _CRS method, error code %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	if (ret == 0) {
> +		dev_err(dev, "no IO and memory resources present in _CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	entry = list_first_entry(&list, struct resource_entry, node);
> +	*res = *entry->res;
> +	acpi_dev_free_resource_list(&list);
> +	return 0;
> +}
> +
> +static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
> +{
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct device *dev = cfg->parent;
> +	struct xgene_pcie_port *port;
> +	struct resource csr;
> +	int ret;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	ret = xgene_get_csr_resource(adev, &csr);
> +	if (ret) {
> +		dev_err(dev, "can't get CSR resource\n");
> +		kfree(port);
> +		return ret;
> +	}
> +	port->csr_base = devm_ioremap_resource(dev, &csr);
> +	if (IS_ERR(port->csr_base)) {
> +		kfree(port);
> +		return -ENOMEM;
> +	}
> +
> +	port->cfg_base = cfg->win;
> +	port->version = ipversion;
> +
> +	cfg->priv = port;
> +
> +	return 0;
> +}
> +
> +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> +{
> +	return xgene_pcie_ecam_init(cfg, XGENE_PCIE_IP_VER_1);
> +}
> +
> +struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
> +	.bus_shift      = 16,
> +	.init           = xgene_v1_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +
> +static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
> +{
> +	return xgene_pcie_ecam_init(cfg, XGENE_PCIE_IP_VER_2);
> +}
> +
> +struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
> +	.bus_shift      = 16,
> +	.init           = xgene_v2_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
>  };
> +#endif
>  
> +#if defined(CONFIG_PCI_XGENE)
>  static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
>  				  u32 flags, u64 size)
>  {
> @@ -521,6 +627,12 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
>  	return 0;
>  }
>  
> +static struct pci_ops xgene_pcie_ops = {
> +	.map_bus = xgene_pcie_map_bus,
> +	.read = xgene_pcie_config_read32,
> +	.write = pci_generic_config_write32,
> +};
> +
>  static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -591,3 +703,4 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>  	.probe = xgene_pcie_probe_bridge,
>  };
>  builtin_platform_driver(xgene_pcie_driver);
> +#endif
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 00eb8eb..f0d2b94 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -64,6 +64,8 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
>  extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
>  extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> +extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
> +extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>  #endif
>  
>  #ifdef CONFIG_PCI_HOST_GENERIC
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
