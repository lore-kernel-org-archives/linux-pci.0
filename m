Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: David Daney <ddaney.cavm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 5/5] PCI: Add host drivers for Cavium ThunderX processors.
Date: Fri, 17 Jul 2015 14:12:15 +0200
Message-ID: <3909080.h1jF0cZoik@wuerfel>
In-Reply-To: <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com> <1436979285-8177-6-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 15 July 2015 09:54:45 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Please describe here in what way is this incompatible with SBSA.
>From earlier discussions I had expected ThunderX to be SBSA compliant,
so I'm a bit surprised to see a PCI hack now.

> +#define THUNDER_SLI_S2M_REG_ACC_BASE	0x874001000000ull
> +
> +#define THUNDER_GIC			0x801000000000ull
> +#define THUNDER_GICD_SETSPI_NSR		0x801000000040ull
> +#define THUNDER_GICD_CLRSPI_NSR		0x801000000048ull
> +

All I/O addresses must come from DT.

> +#define THUNDER_GSER_PCIE_MASK		0x01
> +
> +#define PEM_CTL_STATUS	0x000
> +#define PEM_RD_CFG	0x030
> +#define P2N_BAR0_START	0x080
> +#define P2N_BAR1_START	0x088
> +#define P2N_BAR2_START	0x090
> +#define BAR_CTL		0x0a8
> +#define BAR2_MASK	0x0b0
> +#define BAR1_INDEX	0x100
> +#define PEM_CFG		0x410
> +#define PEM_ON		0x420
> +
> +struct thunder_pem {
> +	struct list_head list; /* on thunder_pem_buses */
> +	bool		connected;
> +	unsigned int	id;
> +	unsigned int	sli;
> +	unsigned int	sli_group;
> +	unsigned int	node;
> +	u64		sli_window_base;
> +	void __iomem	*bar0;
> +	void __iomem	*bar4;
> +	void __iomem	*sli_s2m;
> +	void __iomem	*cfgregion;
> +	struct pci_bus	*bus;
> +	int		vwire_irqs[4];
> +	u32		vwire_data[4];
> +};
> +
> +static LIST_HEAD(thunder_pem_buses);

Please kill off global lists like this and use the driver
model abstractions we have.

> +static u64 slix_s2m_reg_val(unsigned mac, enum slix_s2m_ctype ctype,
> +			    bool merge, bool relaxed, bool snoop, u32 ba_msb)
> +{
> +	u64 v;
> +
> +	v = (u64)(mac % 3) << 49;
> +	v |= (u64)ctype << 53;
> +	if (!merge)
> +		v |= 1ull << 48;
> +	if (relaxed)
> +		v |= 5ull << 40;
> +	if (!snoop)
> +		v |= 5ull << 41;
> +	v |= (u64)ba_msb;
> +
> +	return v;
> +}

Please add a comment to explain why these registers have to be
configured at runtime. Are you working around broken bootloaders,
or does the configuration depend on the connected PCI devices?

> +static int thunder_pem_read_config(struct pci_bus *bus, unsigned int devfn,
> +				   int reg, int size, u32 *val)
> +{
> +	void __iomem *addr;
> +	struct thunder_pem *pem = bus->sysdata;
> +	unsigned int busnr = bus->number;
> +
> +	if (busnr > 255 || devfn > 255 || reg > 4095)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	addr = pem->cfgregion + ((busnr << 24)  | (devfn << 16) | reg);

This looks like ECAM. Could you use the standard accessors?

> +
> +static int thunder_pem_pci_probe(struct pci_dev *pdev,
> +				 const struct pci_device_id *ent)
> +{
> +	struct thunder_pem *pem;
> +	resource_size_t bar0_start;
> +	u64 regval;
> +	u64 sliaddr, pciaddr;
> +	u32 cfgval;
> +	int primary_bus;
> +	int i;
> +	int ret = 0;
> +	struct resource *res;
> +	LIST_HEAD(resources);
> +
> +	set_pcibios_add_device(thunder_pem_pcibios_add_device);

This looks awful. I don't know who introduced the set_pcibios_add_device
interface, but we should not have something like that. In particular,
it seem wrong for a PCI device driver to add that.

What exactly is the pem? Is that an incompatible replacement of the
normal PCIe port devices?

> +
> +	bar0_start = pci_resource_start(pdev, 0);
> +	pem->node = (bar0_start >> 44) & 3;
> +	pem->id = ((bar0_start >> 24) & 7) + (6 * pem->node);
> +	pem->sli = pem->id % 3;
> +	pem->sli_group = (pem->id / 3) % 2;
> +	pem->sli_window_base = 0x880000000000ull | (((u64)pem->node) << 44) | ((u64)pem->sli_group << 40);
> +	pem->sli_window_base += 0x4000000000 * pem->sli;

What is this computation?

> +	udelay(1000);

This is awfully long for a delay. Please try to avoid it or at least turn it
into a sleeping wait.

> +	res->start = primary_bus;
> +	res->end = 255;
> +	res->flags = IORESOURCE_BUS;
> +	pci_add_resource(&resources, res);

What is this about? You have a PCI device that itself has 255 buses underneath it?

> +static int __init thunder_pcie_init(void)
> +{
> +	int ret;
> +
> +	ret = pci_register_driver(&thunder_pem_driver);
> +
> +	return ret;
> +}
> +module_init(thunder_pcie_init);
> +
> +static void __exit thunder_pcie_exit(void)
> +{
> +	pci_unregister_driver(&thunder_pem_driver);
> +}

module_pci_driver() ?

> +
> +#define PCI_DEVICE_ID_THUNDER_BRIDGE	0xa002
> +
> +#define THUNDER_PCIE_BUS_SHIFT		20
> +#define THUNDER_PCIE_DEV_SHIFT		15
> +#define THUNDER_PCIE_FUNC_SHIFT		12

ECAM?

> +#define THUNDER_ECAM0_CFG_BASE		0x848000000000
> +#define THUNDER_ECAM1_CFG_BASE		0x849000000000
> +#define THUNDER_ECAM2_CFG_BASE		0x84a000000000
> +#define THUNDER_ECAM3_CFG_BASE		0x84b000000000
> +#define THUNDER_ECAM4_CFG_BASE		0x948000000000
> +#define THUNDER_ECAM5_CFG_BASE		0x949000000000
> +#define THUNDER_ECAM6_CFG_BASE		0x94a000000000
> +#define THUNDER_ECAM7_CFG_BASE		0x94b000000000

-> DT

> +/*
> + * All PCIe devices in Thunder have fixed resources, shouldn't be reassigned.
> + * Also claim the device's valid resources to set 'res->parent' hierarchy.
> + */
> +static void pci_dev_resource_fixup(struct pci_dev *dev)
> +{
> +	struct resource *res;
> +	int resno;
> +
> +	/*
> +	 * If the ECAM is not yet probed, we must be in a virtual
> +	 * machine.  In that case, don't mark things as
> +	 * IORESOURCE_PCI_FIXED
> +	 */
> +	if (!atomic_read(&thunder_pcie_ecam_probed))
> +		return;
> +
> +	for (resno = 0; resno < PCI_NUM_RESOURCES; resno++)
> +		dev->resource[resno].flags |= IORESOURCE_PCI_FIXED;

Just list the resources as fixed in DT and kill this function.

If that doesn't work, it's a bug in the PCI core code.

> +
> +static int thunder_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
> +				int reg, int size, u32 *val)
> +{
> +	struct thunder_pcie *pcie = bus->sysdata;
> +	void __iomem *addr;
> +	unsigned int busnr = bus->number;
> +
> +	if (busnr > 255 || devfn > 255 || reg > 4095)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	addr = thunder_pcie_get_cfg_addr(pcie, busnr, devfn, reg);

ECAM again?

> +static int thunder_pcie_msi_enable(struct thunder_pcie *pcie,
> +					struct pci_bus *bus)
> +{
> +	struct device_node *msi_node;
> +
> +	msi_node = of_parse_phandle(pcie->node, "msi-parent", 0);
> +	if (!msi_node)
> +		return -ENODEV;
> +
> +	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
> +	if (!pcie->msi)
> +		return -ENODEV;
> +
> +	pcie->msi->dev = pcie->dev;
> +	bus->msi = pcie->msi;
> +
> +	return 0;
> +}

This should really be done in the core code, so we don't have to duplicate
it to each driver.

> +
> +static void thunder_pcie_config(struct thunder_pcie *pcie, u64 addr)
> +{
> +	atomic_set(&thunder_pcie_ecam_probed, 1);
> +	set_its_pci_requester_id(thunder_pci_requester_id);
> +
> +	pcie->valid = true;
> +
> +	switch (addr) {
> +	case THUNDER_ECAM0_CFG_BASE:
> +		pcie->ecam = 0;
> +		break;
> +	case THUNDER_ECAM1_CFG_BASE:
> +		pcie->ecam = 1;
> +		break;
> +	case THUNDER_ECAM2_CFG_BASE:
> +		pcie->ecam = 2;
> +		break;
> +	case THUNDER_ECAM3_CFG_BASE:
> +		pcie->ecam = 3;
> +		break;
> +	case THUNDER_ECAM4_CFG_BASE:
> +		pcie->ecam = 4;
> +		break;
> +	case THUNDER_ECAM5_CFG_BASE:
> +		pcie->ecam = 5;
> +		break;
> +	case THUNDER_ECAM6_CFG_BASE:
> +		pcie->ecam = 6;
> +		break;
> +	case THUNDER_ECAM7_CFG_BASE:
> +		pcie->ecam = 7;
> +		break;
> +	default:
> +		pcie->valid = false;
> +		break;
> +	}
> +}

You don't even seem to use the "ecam" numbers, and the "valid" part
looks pointless: if the device is listed by firmware, you should
assume that it is valid.

> +#ifdef CONFIG_ACPI
> +
> +static int
> +thunder_mmcfg_read_config(struct pci_mmcfg_region *cfg, unsigned int busnr,
> +			unsigned int devfn, int reg, int len, u32 *value)
> +{

Just drop the ACPI part: if the device is not compatible with the
normal ACPI probing method and the PCI definition and with SBSA,
then we can't really support it on ACPI based systems.

	Arnd
