Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 18 Sep 2018 17:17:45 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
Message-ID: <20180918161745.GB31440@e107981-ln.cambridge.arm.com>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Miqu??l Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 05:48:30PM +0200, Thomas Petazzoni wrote:
> This commit convers the pci-mvebu driver to use the recently

Nits:

s/convers/converts

Actually I would just write "Convert the pci-mvebu....".

I would drop "recently introduced", unless we can define a precise
commit when code was added so that it can actually be checked (I know
you can't since the relevant patch is part of this series and not in
the mainline yet).

Bjorn posted some guidelines that are helpful:

https://marc.info/?l=linux-pci&m=150905742808166&w=2

I can make these changes myself, no problem but please address Russell's
comment so that we can proceed.

Thanks,
Lorenzo

> introduced pci-bridge-emul logic, that helps emulating a root port PCI
> bridge configuration space.
> 
> It has been tested on Armada GP XP, with a E1000E NIC.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/controller/Kconfig     |   1 +
>  drivers/pci/controller/pci-mvebu.c | 375 +++++++++++--------------------------
>  2 files changed, 107 insertions(+), 269 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 028b287466fb..6d0f9930be7f 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -9,6 +9,7 @@ config PCI_MVEBU
>  	depends on MVEBU_MBUS
>  	depends on ARM
>  	depends on OF
> +	select PCI_BRIDGE_EMUL
>  
>  config PCI_AARDVARK
>  	bool "Aardvark PCIe controller"
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 50eb0729385b..f97f48cf2bf6 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  
>  #include "../pci.h"
> +#include "../pci-bridge-emul.h"
>  
>  /*
>   * PCIe unit register offsets.
> @@ -63,61 +64,6 @@
>  #define PCIE_DEBUG_CTRL         0x1a60
>  #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
>  
> -enum {
> -	PCISWCAP = PCI_BRIDGE_CONTROL + 2,
> -	PCISWCAP_EXP_LIST_ID	= PCISWCAP + PCI_CAP_LIST_ID,
> -	PCISWCAP_EXP_DEVCAP	= PCISWCAP + PCI_EXP_DEVCAP,
> -	PCISWCAP_EXP_DEVCTL	= PCISWCAP + PCI_EXP_DEVCTL,
> -	PCISWCAP_EXP_LNKCAP	= PCISWCAP + PCI_EXP_LNKCAP,
> -	PCISWCAP_EXP_LNKCTL	= PCISWCAP + PCI_EXP_LNKCTL,
> -	PCISWCAP_EXP_SLTCAP	= PCISWCAP + PCI_EXP_SLTCAP,
> -	PCISWCAP_EXP_SLTCTL	= PCISWCAP + PCI_EXP_SLTCTL,
> -	PCISWCAP_EXP_RTCTL	= PCISWCAP + PCI_EXP_RTCTL,
> -	PCISWCAP_EXP_RTSTA	= PCISWCAP + PCI_EXP_RTSTA,
> -	PCISWCAP_EXP_DEVCAP2	= PCISWCAP + PCI_EXP_DEVCAP2,
> -	PCISWCAP_EXP_DEVCTL2	= PCISWCAP + PCI_EXP_DEVCTL2,
> -	PCISWCAP_EXP_LNKCAP2	= PCISWCAP + PCI_EXP_LNKCAP2,
> -	PCISWCAP_EXP_LNKCTL2	= PCISWCAP + PCI_EXP_LNKCTL2,
> -	PCISWCAP_EXP_SLTCAP2	= PCISWCAP + PCI_EXP_SLTCAP2,
> -	PCISWCAP_EXP_SLTCTL2	= PCISWCAP + PCI_EXP_SLTCTL2,
> -};
> -
> -/* PCI configuration space of a PCI-to-PCI bridge */
> -struct mvebu_sw_pci_bridge {
> -	u16 vendor;
> -	u16 device;
> -	u16 command;
> -	u16 status;
> -	u16 class;
> -	u8 interface;
> -	u8 revision;
> -	u8 bist;
> -	u8 header_type;
> -	u8 latency_timer;
> -	u8 cache_line_size;
> -	u32 bar[2];
> -	u8 primary_bus;
> -	u8 secondary_bus;
> -	u8 subordinate_bus;
> -	u8 secondary_latency_timer;
> -	u8 iobase;
> -	u8 iolimit;
> -	u16 secondary_status;
> -	u16 membase;
> -	u16 memlimit;
> -	u16 iobaseupper;
> -	u16 iolimitupper;
> -	u32 romaddr;
> -	u8 intline;
> -	u8 intpin;
> -	u16 bridgectrl;
> -
> -	/* PCI express capability */
> -	u32 pcie_sltcap;
> -	u16 pcie_devctl;
> -	u16 pcie_rtctl;
> -};
> -
>  struct mvebu_pcie_port;
>  
>  /* Structure representing all PCIe interfaces */
> @@ -153,7 +99,7 @@ struct mvebu_pcie_port {
>  	struct clk *clk;
>  	struct gpio_desc *reset_gpio;
>  	char *reset_name;
> -	struct mvebu_sw_pci_bridge bridge;
> +	struct pci_bridge_emul bridge;
>  	struct device_node *dn;
>  	struct mvebu_pcie *pcie;
>  	struct mvebu_pcie_window memwin;
> @@ -415,11 +361,12 @@ static void mvebu_pcie_set_window(struct mvebu_pcie_port *port,
>  static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  {
>  	struct mvebu_pcie_window desired = {};
> +	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
>  
>  	/* Are the new iobase/iolimit values invalid? */
> -	if (port->bridge.iolimit < port->bridge.iobase ||
> -	    port->bridge.iolimitupper < port->bridge.iobaseupper ||
> -	    !(port->bridge.command & PCI_COMMAND_IO)) {
> +	if (conf->iolimit < conf->iobase ||
> +	    conf->iolimitupper < conf->iobaseupper ||
> +	    !(conf->command & PCI_COMMAND_IO)) {
>  		mvebu_pcie_set_window(port, port->io_target, port->io_attr,
>  				      &desired, &port->iowin);
>  		return;
> @@ -438,11 +385,11 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  	 * specifications. iobase is the bus address, port->iowin_base
>  	 * is the CPU address.
>  	 */
> -	desired.remap = ((port->bridge.iobase & 0xF0) << 8) |
> -			(port->bridge.iobaseupper << 16);
> +	desired.remap = ((conf->iobase & 0xF0) << 8) |
> +			(conf->iobaseupper << 16);
>  	desired.base = port->pcie->io.start + desired.remap;
> -	desired.size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> -			 (port->bridge.iolimitupper << 16)) -
> +	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
> +			 (conf->iolimitupper << 16)) -
>  			desired.remap) +
>  		       1;
>  
> @@ -453,10 +400,11 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>  static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  {
>  	struct mvebu_pcie_window desired = {.remap = MVEBU_MBUS_NO_REMAP};
> +	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
>  
>  	/* Are the new membase/memlimit values invalid? */
> -	if (port->bridge.memlimit < port->bridge.membase ||
> -	    !(port->bridge.command & PCI_COMMAND_MEMORY)) {
> +	if (conf->memlimit < conf->membase ||
> +	    !(conf->command & PCI_COMMAND_MEMORY)) {
>  		mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
>  				      &desired, &port->memwin);
>  		return;
> @@ -468,130 +416,34 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>  	 * window to setup, according to the PCI-to-PCI bridge
>  	 * specifications.
>  	 */
> -	desired.base = ((port->bridge.membase & 0xFFF0) << 16);
> -	desired.size = (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> +	desired.base = ((conf->membase & 0xFFF0) << 16);
> +	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
>  		       desired.base + 1;
>  
>  	mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
>  			      &port->memwin);
>  }
>  
> -/*
> - * Initialize the configuration space of the PCI-to-PCI bridge
> - * associated with the given PCIe interface.
> - */
> -static void mvebu_sw_pci_bridge_init(struct mvebu_pcie_port *port)
> +static pci_bridge_emul_read_status_t
> +mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> +				     int reg, u32 *value)
>  {
> -	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
> -
> -	memset(bridge, 0, sizeof(struct mvebu_sw_pci_bridge));
> -
> -	bridge->class = PCI_CLASS_BRIDGE_PCI;
> -	bridge->vendor = PCI_VENDOR_ID_MARVELL;
> -	bridge->device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
> -	bridge->revision = mvebu_readl(port, PCIE_DEV_REV_OFF) & 0xff;
> -	bridge->header_type = PCI_HEADER_TYPE_BRIDGE;
> -	bridge->cache_line_size = 0x10;
> -
> -	/* We support 32 bits I/O addressing */
> -	bridge->iobase = PCI_IO_RANGE_TYPE_32;
> -	bridge->iolimit = PCI_IO_RANGE_TYPE_32;
> -
> -	/* Add capabilities */
> -	bridge->status = PCI_STATUS_CAP_LIST;
> -}
> -
> -/*
> - * Read the configuration space of the PCI-to-PCI bridge associated to
> - * the given PCIe interface.
> - */
> -static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
> -				  unsigned int where, int size, u32 *value)
> -{
> -	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
> -
> -	switch (where & ~3) {
> -	case PCI_VENDOR_ID:
> -		*value = bridge->device << 16 | bridge->vendor;
> -		break;
> -
> -	case PCI_COMMAND:
> -		*value = bridge->command | bridge->status << 16;
> -		break;
> -
> -	case PCI_CLASS_REVISION:
> -		*value = bridge->class << 16 | bridge->interface << 8 |
> -			 bridge->revision;
> -		break;
> -
> -	case PCI_CACHE_LINE_SIZE:
> -		*value = bridge->bist << 24 | bridge->header_type << 16 |
> -			 bridge->latency_timer << 8 | bridge->cache_line_size;
> -		break;
> -
> -	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
> -		*value = bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4];
> -		break;
> -
> -	case PCI_PRIMARY_BUS:
> -		*value = (bridge->secondary_latency_timer << 24 |
> -			  bridge->subordinate_bus         << 16 |
> -			  bridge->secondary_bus           <<  8 |
> -			  bridge->primary_bus);
> -		break;
> -
> -	case PCI_IO_BASE:
> -		if (!mvebu_has_ioport(port))
> -			*value = bridge->secondary_status << 16;
> -		else
> -			*value = (bridge->secondary_status << 16 |
> -				  bridge->iolimit          <<  8 |
> -				  bridge->iobase);
> -		break;
> -
> -	case PCI_MEMORY_BASE:
> -		*value = (bridge->memlimit << 16 | bridge->membase);
> -		break;
> -
> -	case PCI_PREF_MEMORY_BASE:
> -		*value = 0;
> -		break;
> -
> -	case PCI_IO_BASE_UPPER16:
> -		*value = (bridge->iolimitupper << 16 | bridge->iobaseupper);
> -		break;
> -
> -	case PCI_CAPABILITY_LIST:
> -		*value = PCISWCAP;
> -		break;
> +	struct mvebu_pcie_port *port = bridge->data;
>  
> -	case PCI_ROM_ADDRESS1:
> -		*value = 0;
> -		break;
> -
> -	case PCI_INTERRUPT_LINE:
> -		/* LINE PIN MIN_GNT MAX_LAT */
> -		*value = 0;
> -		break;
> -
> -	case PCISWCAP_EXP_LIST_ID:
> -		/* Set PCIe v2, root port, slot support */
> -		*value = (PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
> -			  PCI_EXP_FLAGS_SLOT) << 16 | PCI_CAP_ID_EXP;
> -		break;
> -
> -	case PCISWCAP_EXP_DEVCAP:
> +	switch (reg) {
> +	case PCI_EXP_DEVCAP:
>  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCAP);
>  		break;
>  
> -	case PCISWCAP_EXP_DEVCTL:
> +	case PCI_EXP_DEVCTL:
>  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
>  				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
>  				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
> -		*value |= bridge->pcie_devctl;
> +		/* FIXME */
> +		*value |= bridge->pcie_conf.devctl;
>  		break;
>  
> -	case PCISWCAP_EXP_LNKCAP:
> +	case PCI_EXP_LNKCAP:
>  		/*
>  		 * PCIe requires the clock power management capability to be
>  		 * hard-wired to zero for downstream ports
> @@ -600,132 +452,88 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
>  			 ~PCI_EXP_LNKCAP_CLKPM;
>  		break;
>  
> -	case PCISWCAP_EXP_LNKCTL:
> +	case PCI_EXP_LNKCTL:
>  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
>  		break;
>  
> -	case PCISWCAP_EXP_SLTCAP:
> -		*value = bridge->pcie_sltcap;
> -		break;
> -
> -	case PCISWCAP_EXP_SLTCTL:
> +	case PCI_EXP_SLTCTL:
>  		*value = PCI_EXP_SLTSTA_PDS << 16;
>  		break;
>  
> -	case PCISWCAP_EXP_RTCTL:
> -		*value = bridge->pcie_rtctl;
> -		break;
> -
> -	case PCISWCAP_EXP_RTSTA:
> +	case PCI_EXP_RTSTA:
>  		*value = mvebu_readl(port, PCIE_RC_RTSTA);
>  		break;
>  
> -	/* PCIe requires the v2 fields to be hard-wired to zero */
> -	case PCISWCAP_EXP_DEVCAP2:
> -	case PCISWCAP_EXP_DEVCTL2:
> -	case PCISWCAP_EXP_LNKCAP2:
> -	case PCISWCAP_EXP_LNKCTL2:
> -	case PCISWCAP_EXP_SLTCAP2:
> -	case PCISWCAP_EXP_SLTCTL2:
>  	default:
> -		/*
> -		 * PCI defines configuration read accesses to reserved or
> -		 * unimplemented registers to read as zero and complete
> -		 * normally.
> -		 */
> -		*value = 0;
> -		return PCIBIOS_SUCCESSFUL;
> +		return PCI_BRIDGE_EMUL_NOT_HANDLED;
>  	}
>  
> -	if (size == 2)
> -		*value = (*value >> (8 * (where & 3))) & 0xffff;
> -	else if (size == 1)
> -		*value = (*value >> (8 * (where & 3))) & 0xff;
> -
> -	return PCIBIOS_SUCCESSFUL;
> +	return PCI_BRIDGE_EMUL_HANDLED;
>  }
>  
> -/* Write to the PCI-to-PCI bridge configuration space */
> -static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
> -				     unsigned int where, int size, u32 value)
> +static void
> +mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
> +				      int reg, u32 old, u32 new, u32 mask)
>  {
> -	struct mvebu_sw_pci_bridge *bridge = &port->bridge;
> -	u32 mask, reg;
> -	int err;
> -
> -	if (size == 4)
> -		mask = 0x0;
> -	else if (size == 2)
> -		mask = ~(0xffff << ((where & 3) * 8));
> -	else if (size == 1)
> -		mask = ~(0xff << ((where & 3) * 8));
> -	else
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	err = mvebu_sw_pci_bridge_read(port, where & ~3, 4, &reg);
> -	if (err)
> -		return err;
> -
> -	value = (reg & mask) | value << ((where & 3) * 8);
> +	struct mvebu_pcie_port *port = bridge->data;
> +	struct pci_bridge_emul_conf *conf = &bridge->conf;
>  
> -	switch (where & ~3) {
> +	switch (reg) {
>  	case PCI_COMMAND:
>  	{
> -		u32 old = bridge->command;
> -
>  		if (!mvebu_has_ioport(port))
> -			value &= ~PCI_COMMAND_IO;
> +			conf->command &= ~PCI_COMMAND_IO;
>  
> -		bridge->command = value & 0xffff;
> -		if ((old ^ bridge->command) & PCI_COMMAND_IO)
> +		if ((old ^ new) & PCI_COMMAND_IO)
>  			mvebu_pcie_handle_iobase_change(port);
> -		if ((old ^ bridge->command) & PCI_COMMAND_MEMORY)
> +		if ((old ^ new) & PCI_COMMAND_MEMORY)
>  			mvebu_pcie_handle_membase_change(port);
> -		break;
> -	}
>  
> -	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
> -		bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
>  		break;
> +	}
>  
>  	case PCI_IO_BASE:
>  		/*
> -		 * We also keep bit 1 set, it is a read-only bit that
> +		 * We keep bit 1 set, it is a read-only bit that
>  		 * indicates we support 32 bits addressing for the
>  		 * I/O
>  		 */
> -		bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
> -		bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
> +		conf->iobase |= PCI_IO_RANGE_TYPE_32;
> +		conf->iolimit |= PCI_IO_RANGE_TYPE_32;
>  		mvebu_pcie_handle_iobase_change(port);
>  		break;
>  
>  	case PCI_MEMORY_BASE:
> -		bridge->membase = value & 0xffff;
> -		bridge->memlimit = value >> 16;
>  		mvebu_pcie_handle_membase_change(port);
>  		break;
>  
>  	case PCI_IO_BASE_UPPER16:
> -		bridge->iobaseupper = value & 0xffff;
> -		bridge->iolimitupper = value >> 16;
>  		mvebu_pcie_handle_iobase_change(port);
>  		break;
>  
>  	case PCI_PRIMARY_BUS:
> -		bridge->primary_bus             = value & 0xff;
> -		bridge->secondary_bus           = (value >> 8) & 0xff;
> -		bridge->subordinate_bus         = (value >> 16) & 0xff;
> -		bridge->secondary_latency_timer = (value >> 24) & 0xff;
> -		mvebu_pcie_set_local_bus_nr(port, bridge->secondary_bus);
> +		mvebu_pcie_set_local_bus_nr(port, conf->secondary_bus);
>  		break;
>  
> -	case PCISWCAP_EXP_DEVCTL:
> +	default:
> +		break;
> +	}
> +}
> +
> +static void
> +mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
> +				      int reg, u32 old, u32 new, u32 mask)
> +{
> +	struct mvebu_pcie_port *port = bridge->data;
> +
> +	switch (reg) {
> +	case PCI_EXP_DEVCTL:
>  		/*
>  		 * Armada370 data says these bits must always
>  		 * be zero when in root complex mode.
>  		 */
> -		value &= ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
> -			   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
> +		new &= ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
> +			 PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
>  
>  		/*
>  		 * If the mask is 0xffff0000, then we only want to write
> @@ -733,20 +541,20 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>  		 * RW1C bits in the device status register.  Mask out the
>  		 * status register bits.
>  		 */
> -		if (mask == 0xffff0000)
> -			value &= 0xffff;
> +		if (new == 0xffff0000)
> +			new &= 0xffff;
>  
> -		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
> +		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL);
>  		break;
>  
> -	case PCISWCAP_EXP_LNKCTL:
> +	case PCI_EXP_LNKCTL:
>  		/*
>  		 * If we don't support CLKREQ, we must ensure that the
>  		 * CLKREQ enable bit always reads zero.  Since we haven't
>  		 * had this capability, and it's dependent on board wiring,
>  		 * disable it for the time being.
>  		 */
> -		value &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
> +		new &= ~PCI_EXP_LNKCTL_CLKREQ_EN;
>  
>  		/*
>  		 * If the mask is 0xffff0000, then we only want to write
> @@ -755,21 +563,48 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
>  		 * RW1C status register bits.
>  		 */
>  		if (mask == 0xffff0000)
> -			value &= ~((PCI_EXP_LNKSTA_LABS |
> -				    PCI_EXP_LNKSTA_LBMS) << 16);
> +			new &= ~((PCI_EXP_LNKSTA_LABS |
> +				  PCI_EXP_LNKSTA_LBMS) << 16);
>  
> -		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
> +		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
>  		break;
>  
> -	case PCISWCAP_EXP_RTSTA:
> -		mvebu_writel(port, value, PCIE_RC_RTSTA);
> +	case PCI_EXP_RTSTA:
> +		mvebu_writel(port, new, PCIE_RC_RTSTA);
>  		break;
> +	}
> +}
>  
> -	default:
> -		break;
> +struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
> +	.write_base = mvebu_pci_bridge_emul_base_conf_write,
> +	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
> +	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
> +};
> +
> +/*
> + * Initialize the configuration space of the PCI-to-PCI bridge
> + * associated with the given PCIe interface.
> + */
> +static void mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
> +{
> +	struct pci_bridge_emul *bridge = &port->bridge;
> +
> +	bridge->conf.vendor = PCI_VENDOR_ID_MARVELL;
> +	bridge->conf.device = mvebu_readl(port, PCIE_DEV_ID_OFF) >> 16;
> +	bridge->conf.class_revision =
> +		mvebu_readl(port, PCIE_DEV_REV_OFF) & 0xff;
> +
> +	if (mvebu_has_ioport(port)) {
> +		/* We support 32 bits I/O addressing */
> +		bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
> +		bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
>  	}
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	bridge->has_pcie = true;
> +	bridge->data = port;
> +	bridge->ops = &mvebu_pci_bridge_emul_ops;
> +
> +	pci_bridge_emul_init(bridge);
>  }
>  
>  static inline struct mvebu_pcie *sys_to_pcie(struct pci_sys_data *sys)
> @@ -789,8 +624,8 @@ static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
>  		if (bus->number == 0 && port->devfn == devfn)
>  			return port;
>  		if (bus->number != 0 &&
> -		    bus->number >= port->bridge.secondary_bus &&
> -		    bus->number <= port->bridge.subordinate_bus)
> +		    bus->number >= port->bridge.conf.secondary_bus &&
> +		    bus->number <= port->bridge.conf.subordinate_bus)
>  			return port;
>  	}
>  
> @@ -811,7 +646,8 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>  
>  	/* Access the emulated PCI-to-PCI bridge */
>  	if (bus->number == 0)
> -		return mvebu_sw_pci_bridge_write(port, where, size, val);
> +		return pci_bridge_emul_conf_write(&port->bridge, where,
> +						  size, val);
>  
>  	if (!mvebu_pcie_link_up(port))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -839,7 +675,8 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  
>  	/* Access the emulated PCI-to-PCI bridge */
>  	if (bus->number == 0)
> -		return mvebu_sw_pci_bridge_read(port, where, size, val);
> +		return pci_bridge_emul_conf_read(&port->bridge, where,
> +						 size, val);
>  
>  	if (!mvebu_pcie_link_up(port)) {
>  		*val = 0xffffffff;
> @@ -1253,7 +1090,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  
>  		mvebu_pcie_setup_hw(port);
>  		mvebu_pcie_set_local_dev_nr(port, 1);
> -		mvebu_sw_pci_bridge_init(port);
> +		mvebu_pci_bridge_emul_init(port);
>  	}
>  
>  	pcie->nports = i;
> -- 
> 2.14.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
