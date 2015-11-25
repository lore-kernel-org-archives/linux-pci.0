Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Nov 2015 11:06:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder
 fixed BARs.
Message-ID: <20151125170652.GC1380@localhost>
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Mon, Sep 28, 2015 at 05:56:24PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Early versions of the Cavium Thunder CN88XX processor are missing
> Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
> by the on-SoC hardware blocks.
> 
> Add config access functions that synthesize the missing EA
> capabilities for versions that are missing that information.  Since
> this is a little hacky, gate the inclusion of the code with a new
> Kconfig variable.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

What about this one?  Do we still need it?  This version looks like it
still has some debug code and it feels like a lot of hard-coding of
config offsets; it'd be nice if it could be more table-driven.  But
maybe this isn't needed anymore anyway.

Bjorn

> ---
> 
> As suggested by Bjorn Helgaas...  It is RFC at this point, but this is
> working well for me.
> 
> Depends on:
> 
> https://lkml.org/lkml/2015/9/28/796
> 
>  drivers/pci/host/Kconfig                  |   9 +
>  drivers/pci/host/Makefile                 |   1 +
>  drivers/pci/host/pci-host-generic.c       |  22 ++-
>  drivers/pci/host/thunder_ecam_config_io.c | 273 ++++++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/host/thunder_ecam_config_io.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d5e58ba..9f3a9cd 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -58,6 +58,15 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
>  
> +config PCI_HOST_THUNDER
> +	bool "Extensions to Generic PCI host controller for Cavium Thunder"
> +	depends on PCI_HOST_GENERIC && ARM64
> +	help
> +	  Say Y here to enable PCI config access methods needed by
> +	  CN88XX Cavium Thunder SoCs.  The access is standard ECAM,
> +	  but Enhanced Allocation (EA) capability structures are
> +	  synthesized for on-SoC devices with fixed BARs.
> +
>  config PCIE_SPEAR13XX
>  	bool "STMicroelectronics SPEAr PCIe controller"
>  	depends on ARCH_SPEAR13XX
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 140d66f..8b77d62 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>  obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
> +obj-$(CONFIG_PCI_HOST_THUNDER) += thunder_ecam_config_io.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 6f12830..64558e5 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -91,6 +91,21 @@ static struct gen_pci_cfg_bus_ops gen_pci_cfg_ecam_bus_ops = {
>  	}
>  };
>  
> +#ifdef CONFIG_PCI_HOST_THUNDER
> +int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
> +			     int where, int size, u32 *val);
> +int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
> +			     int where, int size, u32 val);
> +static struct gen_pci_cfg_bus_ops gen_pci_cfg_thunder_ecam_bus_ops = {
> +	.bus_shift	= 20,
> +	.ops		= {
> +		.map_bus	= gen_pci_map_cfg_bus_ecam,
> +		.read		= thunder_ecam_config_read,
> +		.write		= thunder_ecam_config_write,
> +	}
> +};
> +#endif
> +
>  static void __iomem *gen_pci_map_cfg_bus_thunder_pem(struct pci_bus *bus,
>  						     unsigned int devfn,
>  						     int where)
> @@ -108,6 +123,7 @@ static void __iomem *gen_pci_map_cfg_bus_thunder_pem(struct pci_bus *bus,
>  	return pci->cfg.win[idx] + ((devfn << 16) | where);
>  }
>  
> +#ifdef CONFIG_PCI_HOST_THUNDER
>  static struct gen_pci_cfg_bus_ops gen_pci_cfg_thunder_pem_bus_ops = {
>  	.bus_shift	= 24,
>  	.ops		= {
> @@ -116,6 +132,7 @@ static struct gen_pci_cfg_bus_ops gen_pci_cfg_thunder_pem_bus_ops = {
>  		.write		= pci_generic_config_write,
>  	}
>  };
> +#endif
>  
>  static const struct of_device_id gen_pci_of_match[] = {
>  	{ .compatible = "pci-host-cam-generic",
> @@ -126,7 +143,10 @@ static const struct of_device_id gen_pci_of_match[] = {
>  
>  	{ .compatible = "cavium,pci-host-thunder-pem",
>  	  .data = &gen_pci_cfg_thunder_pem_bus_ops },
> -
> +#ifdef CONFIG_PCI_HOST_THUNDER
> +	{ .compatible = "cavium,pci-host-thunder-ecam",
> +	  .data = &gen_pci_cfg_thunder_ecam_bus_ops },
> +#endif
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, gen_pci_of_match);
> diff --git a/drivers/pci/host/thunder_ecam_config_io.c b/drivers/pci/host/thunder_ecam_config_io.c
> new file mode 100644
> index 0000000..58c3109
> --- /dev/null
> +++ b/drivers/pci/host/thunder_ecam_config_io.c
> @@ -0,0 +1,273 @@
> +/*
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2015 Cavium, Inc.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/ioport.h>
> +#include <linux/printk.h>
> +
> +static void set_val(u32 v, int where, int size, u32 *val)
> +{
> +	int shift = (where & 3) * 8;
> +
> +	pr_debug("set_val %04x: %08x\n", (unsigned)(where & ~3), v);
> +	v >>= shift;
> +	if (size == 1)
> +		v &= 0xff;
> +	else if (size == 2)
> +		v &= 0xffff;
> +	*val = v;
> +}
> +
> +static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
> +			 unsigned int devfn, int where, int size, u32 *val)
> +{
> +	void __iomem *addr;
> +	u32 v;
> +	/*
> +	 * Each entry is 16-byte aligned bits[2,3] select which word
> +	 * in the entry
> +	 */
> +	int where_a = where & 0xc;
> +
> +	if (where_a == 0) {
> +		set_val(e0, where, size, val);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +	if (where_a == 0x4) {
> +		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
> +		if (!addr) {
> +			*val = ~0;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +		v = readl(addr);
> +		v &= ~0xf;
> +		v |= 2; /* EA entry-1. Base-L */
> +		set_val(v, where, size, val);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +	if (where_a == 0x8) {
> +		u32 barl_orig;
> +		u32 barl_rb;
> +
> +		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
> +		if (!addr) {
> +			*val = ~0;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +		barl_orig = readl(addr + 0);
> +		writel(0xffffffff, addr + 0);
> +		barl_rb = readl(addr + 0);
> +		writel(barl_orig, addr + 0);
> +		/* zeros in unsettable bits. */
> +		v = ~barl_rb & ~3;
> +		v |= 0xc; /* EA entry-2. Offset-L */
> +		set_val(v, where, size, val);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +	if (where_a == 0xc) {
> +		addr = bus->ops->map_bus(bus, devfn, bar + 4); /* BAR 1 */
> +		if (!addr) {
> +			*val = ~0;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +		v = readl(addr); /* EA entry-3. Base-H */
> +		set_val(v, where, size, val);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
> +			      int where, int size, u32 val)
> +{
> +	/*
> +	 * All BARs have fixed addresses, ignore BAR writes so they
> +	 * don't get corrupted.
> +	 */
> +	if ((where >= 0x10 && where < 0x2c) || (where >= 0x1a4 && where < 0x1bc))
> +		/* BAR or SRIOV BAR */
> +		return PCIBIOS_SUCCESSFUL;
> +
> +	return pci_generic_config_write(bus, devfn, where, size, val);
> +}
> +
> +int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
> +			     int where, int size, u32 *val)
> +{
> +	u32 v;
> +	u32 vendor_device;
> +	void __iomem *addr;
> +	int cfg_type;
> +	int where_a = where & ~3;
> +
> +	/*
> +	 * All BARs have fixed addresses specified by the EA
> +	 * capability, they must return zero on read.
> +	 */
> +	if ((where >= 0x10 && where < 0x2c) || (where >= 0x1a4 && where < 0x1bc)) {
> +		/* BAR or SRIOV BAR */
> +		*val = 0;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	addr = bus->ops->map_bus(bus, devfn, 0);
> +	if (!addr) {
> +		*val = ~0;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	vendor_device = readl(addr);
> +	if (vendor_device == 0xffffffff)
> +		goto no_emulation;
> +
> +	addr = bus->ops->map_bus(bus, devfn, 8);
> +	if (!addr) {
> +		*val = ~0;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	v = readl(addr);
> +	if (v == 0xffffffff)
> +		goto no_emulation;
> +
> +	if ((v & 0xff) < 8) {
> +		pr_debug("%04x:%04x - Fix pass#: %08x, where: %03x, devfn: %03x\n",
> +			 vendor_device & 0xffff, vendor_device >> 16, v, (unsigned) where, devfn);
> +		/* pass 1.x*/
> +	} else {
> +		pr_debug("%04x:%04x - OK pass#: %08x, devfn: %03x\n",
> +			 vendor_device & 0xffff, vendor_device >> 16, v, devfn);
> +		goto no_emulation;
> +	}
> +
> +	addr = bus->ops->map_bus(bus, devfn, 0xc);
> +	if (!addr) {
> +		*val = ~0;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	v = readl(addr);
> +	/* Check for non type-00 header. */
> +	cfg_type = (v >> 16) & 0x7f;
> +	if (cfg_type == 0) {
> +		bool has_msix;
> +		bool is_nic = (vendor_device == 0xa01e177d);
> +		bool is_tns = (vendor_device == 0xa01f177d);
> +
> +		addr = bus->ops->map_bus(bus, devfn, 0x70);
> +		if (!addr) {
> +			*val = ~0;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +		/* E_CAP */
> +		v = readl(addr);
> +		has_msix = (v & 0xff00) != 0;
> +
> +		if (!has_msix && where_a == 0x70) {
> +			v |= 0xbc00; /* next capability is EA at 0xbc */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xb0) {
> +			addr = bus->ops->map_bus(bus, devfn, where_a);
> +			if (!addr) {
> +				*val = ~0;
> +				return PCIBIOS_DEVICE_NOT_FOUND;
> +			}
> +			v = readl(addr);
> +			if (v & 0xff00)
> +				pr_err("Bad MSIX cap header: %08x\n", v);
> +			v |= 0xbc00; /* next capability is EA at 0xbc */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xbc) {
> +			if (is_nic)
> +				v = 0x40014; /* EA last in chain, 4 entries. */
> +			else if (is_tns)
> +				v = 0x40014; /* EA last in chain, 3 entries. */
> +			else if (has_msix)
> +				v = 0x20014; /* EA last in chain, 2 entries. */
> +			else
> +				v = 0x10014; /* EA last in chain, 1 entry. */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a >= 0xc0 && where_a < 0xd0)
> +			return handle_ea_bar(0x80ff0003, /* EA entry-0. PP=0, BAR0 Size:3 */
> +					     0x10, bus, devfn, where, size, val);
> +		if (where_a >= 0xd0 && where_a < 0xe0 && has_msix)
> +			return handle_ea_bar(0x80ff0043, /* EA entry-1. PP=0, BAR4 Size:3 */
> +					     0x20, bus, devfn, where, size, val);
> +		if (where_a >= 0xe0 && where_a < 0xf0 && is_tns)
> +			return handle_ea_bar(0x80ff0023, /* EA entry-2. PP=0, BAR2, Size:3 */
> +					     0x18, bus, devfn, where, size, val);
> +		if (where_a >= 0xe0 && where_a < 0xf0 && is_nic)
> +			return handle_ea_bar(0x80ff0493, /* EA entry-2. PP=4, VF_BAR0 (9), Size:3 */
> +					     0x1a4, bus, devfn, where, size, val);
> +		if (where_a >= 0xf0 && where_a < 0x100 && is_nic)
> +			return handle_ea_bar(0x80ff04d3, /* EA entry-3. PP=4, VF_BAR4 (d), Size:3 */
> +					     0x1b4, bus, devfn, where, size, val);
> +	} else if (cfg_type == 1) {
> +		if (where_a == 0x70) {
> +			addr = bus->ops->map_bus(bus, devfn, where_a);
> +			if (!addr) {
> +				*val = ~0;
> +				return PCIBIOS_DEVICE_NOT_FOUND;
> +			}
> +			v = readl(addr);
> +			if (v & 0xff00)
> +				pr_err("Bad PCIe cap header: %08x\n", v);
> +			v |= 0xbc00; /* next capability is EA at 0xbc */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xbc) {
> +			v = 0x10014; /* EA last in chain, 1 entry. */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xc0) {
> +			v = 0x0101; /* subordinate:secondary = 1:1 */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xc4) {
> +			v = 0x80ff0564; /* Enabled, not-Write, SP=ff, PP=05, BEI=6, ES=4 */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xc8) {
> +			v = 0x00000002; /* Base-L 64-bit */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xcc) {
> +			v = 0xfffffffe; /* MaxOffset-L 64-bit */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xd0) {
> +			if (devfn == 8)
> +				v = 0x000087e0; /* RSL Base-H */
> +			else
> +				v = 0x00008430; /* NIC Base-H */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +		if (where_a == 0xd4) {
> +			v = 0x0000000f; /* MaxOffset-H */
> +			set_val(v, where, size, val);
> +			return PCIBIOS_SUCCESSFUL;
> +		}
> +
> +	}
> +no_emulation:
> +	return pci_generic_config_read(bus, devfn, where, size, val);
> +}
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
