Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: Question about a quirky (DesignWare) PCIe RC in Allwinner H6
To: Icenowy Zheng <icenowy@aosc.io>, Bjorn Helgaas <helgaas@kernel.org>
References: <1520261458.33502.10.camel@aosc.io>
 <20180305214718.GC255556@bhelgaas-glaptop.roam.corp.google.com>
 <1520308623.33502.13.camel@aosc.io>
 <20180306233832.GC33706@bhelgaas-glaptop.roam.corp.google.com>
 <1520488103.13063.1.camel@aosc.io>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <bd1b5f52-27db-d323-bde5-926be66e7f58@sigmadesigns.com>
Date: Thu, 8 Mar 2018 12:55:03 +0100
MIME-Version: 1.0
In-Reply-To: <1520488103.13063.1.camel@aosc.io>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Jingoo Han <jingoohan1@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08/03/2018 06:48, Icenowy Zheng wrote:

> I'm trying to implement a driver for the quirky (DW) PCIe RC in the
> Allwinner H6 SoC.
> 
> The quirk is that only the "dbi" space is always mapped, but at the 
> same time only 64KiB of other spaces (config, downstream IO and non- 
> prefetchable memory) are accessible. To access a certain address the 
> high 16-bit of the address (all bus addresses in H6 SoC are 32- bit 
> despite the CPU is 64-bit) needs to be written into the 
> PCIE_ADDR_PAGE_CFG register (a vendor-defined register in DBI 
> space). So the access to these spaces cannot be processed correctly 
> with just readl/writel, as the existing code does.
> 
> Is it possible to workaround this in the PCI subsystem of Linux?

I didn't think anyone would come up with something more broken
than tango's PCIe host bridge...

It's hard to understand what's going on inside the minds of these
HW devs. I mean, if the steps required are

	WRITE MAGIC CONFIG REG
	READ/WRITE ADDRESS REG

then the whole operation is clearly not atomic, and bad things happen
when 2+ operations race.

Do they think in terms of single core systems with non-multitasking OS?
Probably not.

Maybe they think it is not a problem to wrap the operation using a
mutex? I'll confess I have no idea how bad that is for performance.
However, that is not an option in Linux, because mem space accesses
are just plain mmio accesses, and it's not possible to rewrite the
drivers, even as an out-of-tree patch.

I suppose it could be possible to make the first write "magic" in the
sense that it could "lock" the bus until the second access is performed?
Sort of like an implicit HW mutex. Actually, tango has explicit HW
mutexes that work along these lines.

> (I have thought a workaround that only maps the current accessible 
> 64KiB with the MMU, and when accessing the non-accessible part, 
> catch the page fault and re-setup the map to the new 64KiB page. But 
> surely it will kill the performance.)

The implementation might be non-trivial, as well.

> [tango is] still less quirky than Allwinner H6 PCIe. It's only a
> config/MMIO mux on tango; however on H6 PCIe both config space and
> MMIO space are splitted to many pages. So on H6 if no solution is
> worked out, it will not be unreliable -- it will be unusable
> instead.

I have only limited experience, but it seems that many useful PCIe
adapters require only very little mem address space.

For example, the USB3 PCIe adapter I tested my implementation with
requires only 8 KB.

01:00.0 USB controller: Renesas Technology Corp. uPD720201 USB 3.0 Host Controller (rev 03) (prog-if 30 [XHCI])
        Flags: fast devsel
        Memory at 50400000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Latency Tolerance Reporting


Same thing for the following WiFi adapter.

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev bb)
        Subsystem: Intel Corporation Dual Band Wireless-AC 7260
        Flags: fast devsel, IRQ 22
        Memory at 50400000 (64-bit, non-prefetchable) [disabled] [size=8K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 48-51-b7-ff-ff-84-69-26
        Capabilities: [14c] Latency Tolerance Reporting
        Capabilities: [154] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>


Maybe you can decide that you will support only 64 KB?

Regards.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
