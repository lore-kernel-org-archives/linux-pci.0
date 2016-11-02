Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756336AbcKBQxn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Nov 2016 12:53:43 -0400
Date: Wed, 2 Nov 2016 11:53:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Duc Dang <dhdang@apm.com>
Cc: Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
        patches <patches@apm.com>
Subject: Re: [RFC PATCH v2 1/1] PCI/ACPI: xgene: Add ECAM quirk for X-Gene
 PCIe controller
Message-ID: <20161102165329.GB10528@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921212258.GE20006@localhost>
 <ff2976e86b4990fba80544e9916a85361afcc237.1477443743.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff2976e86b4990fba80544e9916a85361afcc237.1477443743.git.dhdang@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Duc,

On Tue, Oct 25, 2016 at 06:24:32PM -0700, Duc Dang wrote:
> PCIe controllers in X-Gene SoCs is not ECAM compliant: software
> needs to configure additional controller's register to address
> device at bus:dev:function.
> 
> This patch depends on "ECAM quirks handling for ARM64 platforms"
> series (http://www.spinics.net/lists/arm-kernel/msg530692.html,
> the series was also modified by Bjorn) to address the limitation
> above for X-Gene PCIe controller.
> 
> The quirk will only be applied for X-Gene PCIe MCFG table with
> OEM revison 1, 2, 3 or 4 (PCIe controller v1 and v2 on X-Gene SoCs).

The quirks here contain some hard-coded address space consumed by
ECAM.  The ECAM quirk itself is not a generic description of that
address space in the sense of a PCI BAR or an ACPI _CRS method, i.e.,
the quirk description is not enough to keep other parts of the kernel
from treating the address space as "available".

Can you add a note here in the changelog about how you are describing
this space generically?  The standard solution is a PNP0C02 device
with _CRS that describes it.

It would be ideal if you could open a bugzilla at bugzilla.kernel.org
and attach there a dmesg log, /proc/iomem contents, and DSDT.  This
would show both the generic PNP0C02 piece and the ECAM quirk piece.

BTW, I did refresh and re-push the pci/ecam-v6 branch where I'm
collecting this stuff, so if you want to rebase your patch on top of
that and test it, that would be great.

> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---
> v2 changes:
> 	1. Get rid of pci-xgene-ecam.c file and fold quirk code into pci-xgene.c
> 	2. Redefine fixup array for X-Gene
> 	3. Use devm_ioremap_resource to map csr_base
> 
>  drivers/acpi/pci_mcfg.c      |  30 ++++++++
>  drivers/pci/host/pci-xgene.c | 165 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci-ecam.h     |   5 ++
>  3 files changed, 197 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index bb2c508..9dfc937 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -96,6 +96,36 @@ struct mcfg_fixup {
>  	THUNDER_ECAM_MCFG(2, 12),
>  	THUNDER_ECAM_MCFG(2, 13),
>  #endif
> +#ifdef CONFIG_PCI_XGENE
> +#define XGENE_V1_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v1_pcie_ecam_ops }
> +#define XGENE_V2_1_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
> +		&xgene_v2_1_pcie_ecam_ops }
> +#define XGENE_V2_2_ECAM_MCFG(rev, seg) \
> +	{"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \
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
>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index 1de23d7..d6aa642 100644
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
> @@ -64,6 +66,7 @@
>  /* PCIe IP version */
>  #define XGENE_PCIE_IP_VER_UNKN		0
>  #define XGENE_PCIE_IP_VER_1		1
> +#define XGENE_PCIE_IP_VER_2		2
>  
>  struct xgene_pcie_port {
>  	struct device_node	*node;
> @@ -97,7 +100,15 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
>   */
>  static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>  {
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
>  	if (bus->number >= (bus->primary + 1))
>  		return port->cfg_base + AXI_EP_CFG_ACCESS;
> @@ -111,10 +122,18 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
>   */
>  static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
>  {
> -	struct xgene_pcie_port *port = bus->sysdata;
> +	struct pci_config_window *cfg;
> +	struct xgene_pcie_port *port;
>  	unsigned int b, d, f;
>  	u32 rtdid_val = 0;
>  
> +	if (acpi_disabled)
> +		port = bus->sysdata;
> +	else {
> +		cfg = bus->sysdata;
> +		port = cfg->priv;
> +	}
> +
>  	b = bus->number;
>  	d = PCI_SLOT(devfn);
>  	f = PCI_FUNC(devfn);
> @@ -158,7 +177,15 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>  static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  				    int where, int size, u32 *val)
>  {
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
>  	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
>  	    PCIBIOS_SUCCESSFUL)
> @@ -189,6 +216,138 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>  	.write = pci_generic_config_write32,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static struct resource xgene_v1_csr_res[] = {
> +	[0] = DEFINE_RES_MEM(0x1f2b0000UL, SZ_64K),
> +	[1] = DEFINE_RES_MEM(0x1f2c0000UL, SZ_64K),
> +	[2] = DEFINE_RES_MEM(0x1f2d0000UL, SZ_64K),
> +	[3] = DEFINE_RES_MEM(0x1f500000UL, SZ_64K),
> +	[4] = DEFINE_RES_MEM(0x1f510000UL, SZ_64K),
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
> +	.bus_shift      = 16,
> +	.init           = xgene_v1_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +
> +static struct resource xgene_v2_1_csr_res[] = {
> +	[0] = DEFINE_RES_MEM(0x1f2b0000UL, SZ_64K),
> +	[1] = DEFINE_RES_MEM(0x1f2c0000UL, SZ_64K),
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
> +	.bus_shift      = 16,
> +	.init           = xgene_v2_1_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +
> +static struct resource xgene_v2_2_csr_res[] = {
> +	[0] = DEFINE_RES_MEM(0x1f2b0000UL, SZ_64K),
> +	[1] = DEFINE_RES_MEM(0x1f500000UL, SZ_64K),
> +	[2] = DEFINE_RES_MEM(0x1f2d0000UL, SZ_64K),
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
> +	.bus_shift      = 16,
> +	.init           = xgene_v2_2_pcie_ecam_init,
> +	.pci_ops        = {
> +		.map_bus        = xgene_pcie_map_bus,
> +		.read           = xgene_pcie_config_read32,
> +		.write          = pci_generic_config_write,
> +	}
> +};
> +#endif
> +
>  static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
>  				  u32 flags, u64 size)
>  {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 35f0e81..40da3e7 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -65,6 +65,11 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  #ifdef CONFIG_PCI_HOST_THUNDER_ECAM
>  extern struct pci_ecam_ops pci_thunder_ecam_ops;
>  #endif
> +#ifdef CONFIG_PCI_XGENE
> +extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops;
> +extern struct pci_ecam_ops xgene_v2_1_pcie_ecam_ops;
> +extern struct pci_ecam_ops xgene_v2_2_pcie_ecam_ops;
> +#endif
>  
>  #ifdef CONFIG_PCI_HOST_GENERIC
>  /* for DT-based PCI controllers that support ECAM */
> -- 
> 1.9.1
> 
