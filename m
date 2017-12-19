Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Dec 2017 10:48:47 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v5 15/18] PCI: dwc: Make cpu_addr_fixup take struct
 dw_pcie as argument
Message-ID: <20171219104847.GB18921@red-moon>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-16-niklas.cassel@axis.com>
 <20171218181058.GC8157@red-moon>
 <20171218211542.GA17166@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218211542.GA17166@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 10:15:43PM +0100, Niklas Cassel wrote:
> On Mon, Dec 18, 2017 at 06:10:58PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Nov 20, 2017 at 02:32:18PM +0100, Niklas Cassel wrote:
> > > There is no need to hard code the cpu to bus address fixup mask.
> > 
> > There is no need or hardcoding it is broken ? There is a difference
> > between those two.
> 
> Well, both :P
> 
> The current hardcoding for ARTPEC-6: GENMASK(27, 0), is wrong.
> Hardcoding the correct mask GENMASK(28, 0) would be sufficient
> for ARTPEC-6.
> 
> However, the ARTPEC-7 is a 32-bit CPU (without LPAE), but has
> a 64-bit bus. So the ARTPEC-7 can have more devices than fits
> in the 32-bit range, therefore a lookup table is placed between
> the bus and the CPU, so you can choose what devices to map.
> This mapping, which decides what devices to map, is currently
> done at boot via devicetree.
> So, on ARTPEC-7, it is not possible to hardcode a CPU_TO_BUS
> mask, since the PCIe controller's address is only known via DT.
> 
> Having a hardcoded value is arguably wrong. It should probably
> have been a DT property called something like "cpu-bus-fixup-mask".
> However, this property is not needed since we already have
> pp->cfg0_base and ep->phys_base, which is derived from already
> existing DT properties.
> 
> By using pp->cfg0_base and ep->phys_base, we avoid hardcoding a mask
> in the driver. This should work for ARTPEC-6, DRA7xx and ARTPEC-7.
> I have not changed the code in DRA7xx though, since their existing
> code works, but if they want, they could use the same logic as
> artpec6_pcie_cpu_addr_fixup, and thus remove their hardcoded mask.
> 
> > 
> > > The PCIe controller has a global address on the AXI bus, however,
> > > from the perspective of the PCIe controller, its base starts at 0x0,
> > > so the local address is 0x0. To get the bus address, simply subtract
> > > the global address from the cpu address. The global address is taken
> > > from device tree.
> > 
> > I do not understand this paragraph, I would kindly ask you and Kishon to
> > explain please this patch and
> > 
> > commit a660083eb06c ("PCI: dwc: designware: Add new *ops* for CPU addr
> > fixup")
> > 
> > What the cpu_addr_fixup() hook is supposed to do ? And what does the
> > "addr_space" property represent ?
> 
> The ARTPEC-6 and DRA7xx SoCs both has an interconnect configured is a way
> where the local address of the PCIe controller is 0x0.
> 
> For ARTPEC-6 the global address of the PCIe controller is 0xf8050000,
> so if the CPU writes to address 0xf8050008, from the perspective of the
> PCIe controller, it will see a write to address 0x8.
> 
> This is normally not a problem, but when reading/writing from an endpoint,
> we go via the outbound iATU. The outbound iATU has to be programmed with
> a base address (reads/writes in the range [base address + limit] will be
> subject to translation).
> 
> However, since the address the PCIe controller sees, in reality is
> "0xf8050000 + the address the PCIe controller sees", we need to subtract
> the global address before programming the base address in the outbound
> iATU.
> 
> Kishon explains the same thing in commit f4c55c5a3f7f68c0.
> 
> For this patch, I tried make the commit message understandable,
> without going into too much detail, but there is probably still
> room for improvement.
> 
> > 
> > > Also for ARTPEC-7, hard coding the cpu to bus address fixup mask is
> > > not possible, since it uses a High Address Bits Look Up Table, which
> > > means that it can, at runtime, map the PCIe window to an arbitrary
> > > address in the 32-bit address space.
> > 
> > But you are not changing the ARTPEC-7 mechanism, are you ? I do not
> > understand this paragraph - I see no change for ARTPEC-7 in this patch.
> 
> Hopefully this is clarified by the comments above.
> 
> > 
> > > This also fixes a bug for ARTPEC-6, where the cpu to bus address
> > > fixup mask previously was off by one (GENMASK(27, 0), rather than
> > > GENMASK(28, 0)). This is another reason to calculate the mask by
> > > using values from device tree.
> > 
> > What this patch does (and how the cpu_addr_fixup() mechanism works)
> > is not clear to me, please explain, we can rewrite the commit log
> > with a clear explanation then.
> 
> Hopefully this is clarified by the comments above.

It is, thank you - it would be good to convert this thread into commit
log format, you can send it as an update to this patch.

Thanks,
Lorenzo
