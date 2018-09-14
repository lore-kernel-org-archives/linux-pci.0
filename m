Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 14 Sep 2018 15:38:49 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCHv2 1/3] PCI: Introduce PCI bridge emulated config space
 common logic
Message-ID: <20180914143849.GC30658@n2100.armlinux.org.uk>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20180912154831.2220-2-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 05:48:29PM +0200, Thomas Petazzoni wrote:
> Some PCI host controllers do not expose a configuration space for the
> root port PCI bridge. Due to this, the Marvell Armada 370/38x/XP PCI
> controller driver (pci-mvebu) emulates a root port PCI bridge
> configuration space, and uses that to (among other things) dynamically
> create the memory windows that correspond to the PCI MEM and I/O
> regions.
> 
> Since we now need to add a very similar logic for the Marvell Armada
> 37xx PCI controller driver (pci-aardvark), instead of duplicating the
> code, we create in this commit a common logic called pci-bridge-emul.
> 
> The idea of this logic is to emulate a root port PCI bridge
> configuration space by providing configuration space read/write
> operations, and faking behind the scenes the configuration space of a
> PCI bridge. A PCI host controller driver simply has to call
> pci_bridge_emul_conf_read() and pci_bridge_emul_conf_write() to
> read/write the configuration space of the bridge.
> 
> By default, the PCI bridge configuration space is simply emulated by a
> chunk of memory, but the PCI host controller can override the behavior
> of the read and write operations on a per-register basis to do
> additional actions if needed. We take care of complying with the
> behavior of the PCI configuration space registers in terms of bits
> that are read-write, read-only, reserved and write-1-to-clear.

Thanks, for the patch.  I don't see anything technically wrong from
a PCIe device behaviour point of view, although I haven't compared
the behaviour tables with the specs.

Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
