Return-Path: <SRS0=a4ji=XQ=redhat.com=msalter@kernel.org>
Return-Path: <SRS0=a4ji=XQ=redhat.com=msalter@kernel.org>
Message-ID: <1480604901.4751.17.camel@redhat.com>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
From: Mark Salter <msalter@redhat.com>
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi
 <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm
 <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Jon Masters <jcm@redhat.com>, Tomasz
 Nowicki <tn@semihalf.com>,
        patches <patches@apm.com>
Date: Thu, 01 Dec 2016 10:08:21 -0500
In-Reply-To: <1480549373-2123-1-git-send-email-dhdang@apm.com>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-11-30 at 15:42 -0800, Duc Dang wrote:
> PCIe controllers in X-Gene SoCs is not ECAM compliant: software
> needs to configure additional controller's register to address
> device at bus:dev:function.
> 
> The quirk will only be applied for X-Gene PCIe MCFG table with
> OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).
> 
> The quirk declares the X-Gene PCIe controller register space as 64KB
> fixed memory resource with name "PCIe CSR". This name will be showed
> next to the resource range in the output of "cat /proc/iomem".
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---
> v3:
>   - Rebase on top of pci/ecam-v6 tree.
>   - Use DEFINE_RES_MEM_NAMED to declare controller register space
>   with name "PCIe CSR"
> v2:
>   RFC v2: https://patchwork.ozlabs.org/patch/686846/
> v1:
>   RFC v1: https://patchwork.kernel.org/patch/9337115/
> 
>  drivers/acpi/pci_mcfg.c      |  31 ++++++++
>  drivers/pci/host/pci-xgene.c | 165 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci-ecam.h     |   7 ++
>  3 files changed, 200 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index ac21db3..eb6125b 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -57,6 +57,37 @@ struct mcfg_fixup {
>  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
> +
> +#ifdef CONFIG_PCI_XGENE
> +#define XGENE_V1_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v1_pcie_ecam_ops }
> +#define XGENE_V2_1_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v2_1_pcie_ecam_ops }
> +#define XGENE_V2_2_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v2_2_pcie_ecam_ops }
> +
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
> +	XGENE_V2_1_ECAM_MCFG(3, 0),
> +	XGENE_V2_1_ECAM_MCFG(3, 1),
> +	/* X-Gene SoC with v2.2 PCIe controller */
> +	XGENE_V2_2_ECAM_MCFG(4, 0),
> +	XGENE_V2_2_ECAM_MCFG(4, 1),
> +	XGENE_V2_2_ECAM_MCFG(4, 2),
> +#endif
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 1de23d7..43d7c69 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -27,6 +27,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> @@ -64,6 +66,7 @@
>  /* PCIe IP version */
>  #define XGENE_PCIE_IP_VER_UNKN		0
>  #define XGENE_PCIE_IP_VER_1		1
> +#define XGENE_PCIE_IP_VER_2		2
>  
>  struct xgene_pcie_port {
>  	struct device_node	*node;
> @@ -97,7 +100,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
>   */
>  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct pci_config_window *cfg;
> +	struct xgene_pcie_port *port;
> +
> +	if (acpi_disabled)
> +		port = bus->sysdata;
> +	else {
> +		cfg = bus->sysdata;
> +		port = cfg->priv;
> +	}
>  
>  	if (bus->number >= (bus->primary + 1))
>  		return port->cfg_base + AXI_EP_CFG_ACCESS;
> @@ -111,10 +122,18 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>   */
>  static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct pci_config_window *cfg;
> +	struct xgene_pcie_port *port;
>  	unsigned int b, d, f;
>  	u32 rtdid_val = 0;
>  
> +	if (acpi_disabled)
> +		port = bus->sysdata;
> +	else {
> +		cfg = bus->sysdata;
> +		port = cfg->priv;
> +	}
> +
>  	b = bus->number;
>  	d = PCI_SLOT(devfn);
>  	f = PCI_FUNC(devfn);
> @@ -158,7 +177,15 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  				    int where, int size, u32 *val)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct pci_config_window *cfg;
> +	struct xgene_pcie_port *port;
> +
> +	if (acpi_disabled)
> +		port = bus->sysdata;
> +	else {
> +		cfg = bus->sysdata;
> +		port = cfg->priv;
> +	}
>  
>  	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
>  	    PCIBIOS_SUCCESSFUL)
> @@ -189,6 +216,138 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  	.write = pci_generic_config_write32,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static struct resource xgene_v1_csr_res[] = {
> +	[0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> +	[1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> +	[2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> +	[3] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> +	[4] = DEFINE_RES_MEM_NAMED(0x1f510000UL, SZ_64K, "PCIe CSR"),
> +};
> +
> +static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
> +{
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct device *dev = cfg->parent;
> +	struct xgene_pcie_port *port;
> +	struct resource *csr;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	csr = &xgene_v1_csr_res[root->segment];

This hard-coded assumption that segment N uses controller N breaks
for m400 where segment 0 is using controller 3.

> +	port->csr_base = devm_ioremap_resource(dev, csr);
> +	if (IS_ERR(port->csr_base)) {
> +		kfree(port);
> +		return -ENOMEM;
> +	}
> +
> +	port->cfg_base = cfg->win;
> +	port->version = XGENE_PCIE_IP_VER_1;
> +
> +	cfg->priv = port;
> +
> +	return 0;
> +}
> +
> +struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
> +	.bus_shift      = 16,
> +	.init           = xgene_v1_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +
> +static struct resource xgene_v2_1_csr_res[] = {
> +	[0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> +	[1] = DEFINE_RES_MEM_NAMED(0x1f2c0000UL, SZ_64K, "PCIe CSR"),
> +};
> +
> +static int xgene_v2_1_pcie_ecam_init(struct pci_config_window *cfg)
> +{
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct device *dev = cfg->parent;
> +	struct xgene_pcie_port *port;
> +	struct resource *csr;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	csr = &xgene_v2_1_csr_res[root->segment];
> +	port->csr_base = devm_ioremap_resource(dev, csr);
> +	if (IS_ERR(port->csr_base)) {
> +		kfree(port);
> +		return -ENOMEM;
> +	}
> +
> +	port->cfg_base = cfg->win;
> +	port->version = XGENE_PCIE_IP_VER_2;
> +
> +	cfg->priv = port;
> +
> +	return 0;
> +}
> +
> +struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops = {
> +	.bus_shift      = 16,
> +	.init           = xgene_v2_1_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +
> +static struct resource xgene_v2_2_csr_res[] = {
> +	[0] = DEFINE_RES_MEM_NAMED(0x1f2b0000UL, SZ_64K, "PCIe CSR"),
> +	[1] = DEFINE_RES_MEM_NAMED(0x1f500000UL, SZ_64K, "PCIe CSR"),
> +	[2] = DEFINE_RES_MEM_NAMED(0x1f2d0000UL, SZ_64K, "PCIe CSR"),
> +};
> +
> +static int xgene_v2_2_pcie_ecam_init(struct pci_config_window *cfg)
> +{
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct device *dev = cfg->parent;
> +	struct xgene_pcie_port *port;
> +	struct resource *csr;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	csr = &xgene_v2_2_csr_res[root->segment];
> +	port->csr_base = devm_ioremap_resource(dev, csr);
> +	if (IS_ERR(port->csr_base)) {
> +		kfree(port);
> +		return -ENOMEM;
> +	}
> +
> +	port->cfg_base = cfg->win;
> +	port->version = XGENE_PCIE_IP_VER_2;
> +
> +	cfg->priv = port;
> +
> +	return 0;
> +}
> +
> +struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops = {
> +	.bus_shift      = 16,
> +	.init           = xgene_v2_2_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +#endif
> +
>  static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
>  				  u32 flags, u64 size)
>  {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index f5740b7..47ab947 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -62,6 +62,13 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  /* ops for buggy ECAM that supports only 32-bit accesses */
>  extern struct pci_ecam_ops pci_32b_ops;
>  
> +/* ECAM ops for known quirks */
> +#ifdef CONFIG_PCI_XGENE
> +extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops;
> +extern struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops;
> +extern struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops;
> +#endif
> +
>  #ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
>  int pci_host_common_probe(struct platform_device *pdev,
