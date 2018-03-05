Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1520261458.33502.10.camel@aosc.io>
Subject: Question about a quirky (DesignWare) PCIe RC in Allwinner H6
From: Icenowy Zheng <icenowy@aosc.io>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai
 <wens@csie.org>, Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han
 <jingoohan1@gmail.com>
Date: Mon, 05 Mar 2018 22:50:58 +0800
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

I'm trying to implement a driver for the quirky (DW) PCIe RC in the
Allwinner H6 SoC.

The quirk is that only the "dbi" space is always mapped, but at the
same time only 64KiB of other spaces (config, downstream IO and non-
prefetchable memory) are accessible. To access a certain address the
high 16-bit of the address (all bus addresses in H6 SoC are 32-bit
despite the CPU is 64-bit) needs to be written into the
PCIE_ADDR_PAGE_CFG register (a vendor-defined register in DBI space).
So the access to these spaces cannot be processed correctly with just
readl/writel, as the existing code does.

Is it possible to workaround this in the PCI subsystem of Linux?

(I have thought a workaround that only maps the current accessible
64KiB with the MMU, and when accessing the non-accessible part, catch
the page fault and re-setup the map to the new 64KiB page. But surely
it will kill the performance.)

Thanks,
Icenowy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
