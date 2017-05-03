Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 3 May 2017 11:34:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC/RFT PATCH 00/18] PCI: ARM/ARM64: remove pci_fixup_irqs()
 usage
Message-ID: <20170503103456.GC10800@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170427200635.GA6563@ulmo.ba.sec>
MIME-Version: 1.0
In-Reply-To: <20170427200635.GA6563@ulmo.ba.sec>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 27, 2017 at 10:06:35PM +0200, Thierry Reding wrote:
> On Wed, Apr 26, 2017 at 12:17:51PM +0100, Lorenzo Pieralisi wrote:
> > Current pci_fixup_irqs() usage on ARM/ARM64 host controller drivers is
> > flawed in that pci_fixup_irqs() allocates IRQs for all PCI devices present
> > in a system; those PCI devices possibly belong to different PCI bus trees
> > (and possibly rooted at different host bridges) and may well be enabled
> > (ie probed and bound to a driver) by the time pci_fixup_irqs() is called
> > when probing a given host bridge driver.
> > 
> > Furthermore, current kernel code relying on pci_fixup_irqs() to
> > assign legacy PCI IRQs to devices does not work at all for
> > hotplugged devices in that the code carrying out the IRQ fixup
> > is called at host bridge driver probe time, which just cannot take
> > into account devices hotplugged after system has booted.
> > 
> > By leveraging Matthew Minter's patch series (and its purpose):
> > 
> > http://lkml.kernel.org/r/1445576642-29624-2-git-send-email-matt@masarand.com
> > 
> > this series[1] adds IRQs mapping and swizzling primitives to
> > the struct pci_host_bridge which allows IRQs to be allocated for
> > for a device at probe time with host bridge specific functions,
> > fixing the aforementioned limitations.
> > 
> > Current series remove pci_fixup_irqs() usage on ARM/ARM64; removal
> > can be extended to other architectures provided the IRQs map/swizzle
> > functions are set-up properly in the respective host bridges
> > set-up/probe paths.
> > 
> > Tested on kvmtool with PCI host generic.
> 
> I've tested this on Jetson TX1 (though I need a small patch specific to
> Tegra on top to fix a preexisting issue) and things seem to be working
> normally.
> 
> The output of "lspci -v" is identical before and after applying the
> series (on top of next-20170427):
> 
> -sh-4.4# lspci -v
> 00:01.0 PCI bridge: NVIDIA Corporation Device 0fae (rev a1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 348
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00001000-00001fff [size=4K]
>         Memory behind bridge: 13000000-130fffff [size=1M]
>         Prefetchable memory behind bridge: 0000000020000000-00000000200fffff [size=1M]
>         Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
>         Capabilities: [48] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
>         Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
>         Capabilities: [80] Express Root Port (Slot+), MSI 00
>         Capabilities: [100] #00
>         Capabilities: [140] L1 PM Substates
>         Kernel driver in use: pcieport
> 
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 02)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>         Flags: bus master, fast devsel, latency 0, IRQ 349
>         I/O ports at 1000 [size=256]
>         Memory at 13000000 (64-bit, non-prefetchable) [size=4K]
>         Memory at 20000000 (64-bit, prefetchable) [size=64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 8d-08-00-00-68-4c-e0-00
>         Kernel driver in use: r8169
> 
> Note that the Realtek card is initialized by the r8169 driver and the
> network card is used to boot over NFS.
> 
> My understanding is that this is what's expected, so:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>

Hi Thierry,

thanks a lot, that's very appreciated, it is exactly what I need.

Please let me know if you have comments on the individual patches too.

Thanks !
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
