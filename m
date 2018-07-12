Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 12 Jul 2018 14:58:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
Message-ID: <20180712195802.GC28466@bhelgaas-glaptop.roam.corp.google.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
 <20180629092231.32207-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180629092231.32207-2-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Simon Horman <horms@verge.net.au>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 Ray Jui <ray.jui@broadcom.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ley Foon Tan <lftan@altera.com>,
 Zachary Zhang <zhangzg@marvell.com>, Wilson Ding <dingwei@marvell.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ray since he's doing something similar for iProc,
     Ley Foon & Simon for a possible Altera & R-Car bug]

On Fri, Jun 29, 2018 at 11:22:29AM +0200, Thomas Petazzoni wrote:
> Some PCI host controllers do not expose at the hardware level a root
> port PCI bridge. Due to this, the Marvell Armada 370/38x/XP PCI
> controller driver (pci-mvebu) emulates a root port PCI bridge, and
> uses that to (among other things=E0) dynamically create the memory
> windows that correspond to the PCI MEM and I/O regions.
> =

> Since we now need to add a very similar logic for the Marvell Armada
> 37xx PCI controller driver (pci-aardvark), instead of duplicating the
> code, we create in this commit a common logic called pci-sw-bridge.
> =

> The idea of this logic is to emulate a root port PCI bridge by
> providing configuration space read/write operations, and faking behind
> the scenes the configuration space of a PCI bridge. A PCI host
> controller driver simply has to call pci_sw_bridge_read() and
> pci_sw_bridge_write() to read/write the configuration space of the
> bridge.

These systems must actually have a Root Port (there's obviously a Port
that originates the link), but it's not visible in a spec-compliant
way.  So this is basically a wrapper that translates accesses to
standard config space into the vendor-specific registers.

Since there really *is* a hardware bridge but it just doesn't have the
interface we expect, "sw_bridge" doesn't feel like quite the right
name for it.  Maybe something related to adapter/emulation/interface/...?

There are several drivers that do this, and it would be really cool to
have them all do it in a similar way.  I found at least these:

  hv_pcifront_read_config()
  mvebu_pcie_rd_conf()
  thunder_ecam_config_read()
  thunder_pem_config_read()
  xgene_pcie_config_read32()
  iproc_pcie_config_read32()
  rcar_pcie_read_conf()

I *really* like the fact that your accessors use the normal register
names, e.g., PCI_EXP_DEVCAP instead of PCISWCAP_EXP_DEVCAP.  That's
huge for greppability.

> By default, the PCI bridge configuration space is simply emulated by a
> chunk of memory, but the PCI host controller can override the behavior
> of the read and write operations on a per-register basis to do
> additional actions if needed.
> =

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/pci/Kconfig           |   3 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/pci-sw-bridge.c   | 149 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/pci-sw-bridge.h | 125 +++++++++++++++++++++++++++++++++++

Could this go in drivers/pci instead of include/linux?  I'd prefer to
hide it inside the PCI core if that's possible.

> + * Should be called by the PCI controller driver when reading the PCI
> + * configuration space of the fake bridge. It will call back the
> + * ->ops->read_base or ->ops->read_pcie operations.
> + */
> +int pci_sw_bridge_read(struct pci_sw_bridge *bridge, int where,
> +		       int size, u32 *value)

We don't really have a strong convention about the names of config
accessors: *_rd_conf(), *_read_config(), *config_read() are all used.
Maybe we could at least include "conf" to connect this with config
space as opposed to MMIO space.

> +{
> +	int ret;
> +	int reg =3D where & ~3;
> +
> +	if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_END) {
> +		*value =3D 0;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	if (!bridge->has_pcie && reg >=3D PCI_BRIDGE_CONF_END) {
> +		*value =3D 0;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	if (bridge->has_pcie && reg >=3D PCI_CAP_PCIE_START) {
> +		reg -=3D PCI_CAP_PCIE_START;
> +
> +		if (bridge->ops->read_pcie)
> +			ret =3D bridge->ops->read_pcie(bridge, reg, value);
> +		else
> +			ret =3D PCI_SW_BRIDGE_NOT_HANDLED;
> +
> +		if (ret =3D=3D PCI_SW_BRIDGE_NOT_HANDLED)
> +			*value =3D *((u32*) &bridge->pcie_conf + reg / 4);
> +	} else {
> +		if (bridge->ops->read_base)
> +			ret =3D bridge->ops->read_base(bridge, reg, value);
> +		else
> +			ret =3D PCI_SW_BRIDGE_NOT_HANDLED;
> +
> +		if (ret =3D=3D PCI_SW_BRIDGE_NOT_HANDLED)
> +			*value =3D *((u32*) &bridge->conf + reg / 4);

I'm not sure about this part, where the config space that's not
handled by the bridge's ops ends up just being RAM that's readable and
writable with no effect on the hardware.  That seems a little
counter-intuitive.  I think dropping writes and reading zeroes would
simplify my mental model.

> +	}
> +
> +	if (size =3D=3D 1)
> +		*value =3D (*value >> (8 * (where & 3))) & 0xff;
> +	else if (size =3D=3D 2)
> +		*value =3D (*value >> (8 * (where & 3))) & 0xffff;
> +	else if (size !=3D 4)
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

This isn't directly related to your patches, but this is a common
pattern with some variations between drivers, which makes me wonder
whether there are bugs lurking.  These use "where & 3" for size 2:

  advk_pcie_rd_conf()
  mtk_pcie_hw_rd_cfg()
  pci_generic_config_read32()

But these use "where & 2":

  _altera_pcie_cfg_read()
  rcar_pcie_read_conf()

I *think* this means that unaligned 2-byte config reads on Altera and
R-Car will return incorrect data.  In both cases, the actual read seen
by the hardware is a 32-bit read, but I think we extract the wrong 16
bits from that result.

I wonder if there's a way to use a common helper function to do this.

> +	return PCIBIOS_SUCCESSFUL;
> +}

> +	/*
> +	 * Called when writing to the regular PCI bridge configuration
> +	 * space. old is the current value, new is the new value being
> +	 * written, and mask indicates which parts of the value are
> +	 * being changed.
> +	 */
> +	void (*write_base)(struct pci_sw_bridge *bridge, int reg,
> +			   u32 old, u32 new, u32 mask);
> +
> +	/*
> +	 * Same as ->read_base(), except it is for reading from the
> +	 * PCIe capability configuration space.

I think you mean "->write_base(), except it is for writing to"

> +	 */
> +	void (*write_pcie)(struct pci_sw_bridge *bridge, int reg,
> +			   u32 old, u32 new, u32 mask);
> +};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
