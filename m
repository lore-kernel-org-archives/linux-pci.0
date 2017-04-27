Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 27 Apr 2017 11:40:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
Message-ID: <20170427104020.GA15685@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
 <20170426151257.GA4489@lunn.ch> <20170426161335.GA12240@red-moon>
 <20170426185348.GB14074@lunn.ch>
MIME-Version: 1.0
In-Reply-To: <20170426185348.GB14074@lunn.ch>
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
 Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Michal Simek <michal.simek@xilinx.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Apr 26, 2017 at 08:53:48PM +0200, Andrew Lunn wrote:
> > > Note that IRQ 12 has disappeared from Flags: on 0000:00:00.0.
> > 
> > Thank you for testing it, that's exactly what we need.
> > 
> > To check if the plumbing is working (ie to check I have not messed
> > up the bus scan API rework), mind testing the patch below please
> > and report back (it applies on top of this series) ?
> 
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0, IRQ 12
> 
> The interrupt is back with this patch.

Ok the IRQ allocation works then, the difference is when the mapping
is called, original patch series moves the IRQ allocation to device
probe time (that's why IRQ does not show up, there is no matching
driver in the kernel for the PCI device above), with the additional
patch the IRQ allocation is done when the PCI device is added.

It is a user visible change, not sure though if that's a real issue,
that's exactly the reason why I posted this series, to find out
and converge.

Thanks !
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
