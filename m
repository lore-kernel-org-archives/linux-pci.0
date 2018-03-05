Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 5 Mar 2018 15:47:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: Question about a quirky (DesignWare) PCIe RC in Allwinner H6
Message-ID: <20180305214718.GC255556@bhelgaas-glaptop.roam.corp.google.com>
References: <1520261458.33502.10.camel@aosc.io>
MIME-Version: 1.0
In-Reply-To: <1520261458.33502.10.camel@aosc.io>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:50:58PM +0800, Icenowy Zheng wrote:
> Hi everyone,
> 
> I'm trying to implement a driver for the quirky (DW) PCIe RC in the
> Allwinner H6 SoC.
> 
> The quirk is that only the "dbi" space is always mapped, but at the
> same time only 64KiB of other spaces (config, downstream IO and non-
> prefetchable memory) are accessible. To access a certain address the
> high 16-bit of the address (all bus addresses in H6 SoC are 32-bit
> despite the CPU is 64-bit) needs to be written into the
> PCIE_ADDR_PAGE_CFG register (a vendor-defined register in DBI space).
> So the access to these spaces cannot be processed correctly with just
> readl/writel, as the existing code does.
> 
> Is it possible to workaround this in the PCI subsystem of Linux?
> 
> (I have thought a workaround that only maps the current accessible
> 64KiB with the MMU, and when accessing the non-accessible part, catch
> the page fault and re-setup the map to the new 64KiB page. But surely
> it will kill the performance.)

If you only need to write to PCIE_ADDR_PAGE_CFG for *config* accesses,
this should be easy.  All config accesses go through wrappers
(pci_read_config_word(), etc) and several host bridge drivers have to
update a register with parts of the config address, e.g.,
advk_pcie_rd_conf(), mvebu_pcie_hw_rd_conf().

It sounds like you also need to update PCIE_ADDR_PAGE_CFG for I/O port
accesses.  I/O port accesses do go through a wrapper (inb(), etc), so
it might be possible in principle to intercept these, although much
more difficult than config accesses, because the config accesses are
already set up with per-host bridge hooks, while the I/O port
accessors are mostly per-arch.

But if you have to update PCIE_ADDR_PAGE_CFG for memory accesses,
that's really a problem because drivers are allowed to essentially
read a memory BAR, convert that bus address to a CPU physical memory
address, ioremap() it, then directly access the PCIe memory with loads
and stores.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
