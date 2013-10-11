Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56137 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab3JKCS6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 22:18:58 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Fri, 11 Oct 2013 04:18:56 +0200
Cc: "Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com> <201310110413.02354.marex@denx.de>
In-Reply-To: <201310110413.02354.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310110418.56460.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> Hi Bjorn,
> 
> > On Thu, Oct 10, 2013 at 11:39 AM, Marek Vasut <marex@denx.de> wrote:
> > > Hi Bjorn,
> > > 
> > >> [+cc Yinghai]
> > >> 
> > >> On Thu, Oct 10, 2013 at 9:58 AM, Marek Vasut <marex@denx.de> wrote:
> > >> >> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:
> > >> > I tried you suggestion, this is what I got now (and with V7 of the
> > >> > patches):
> > >> > 
> > >> > Note that my topology is: rootport->2_port_switch->ethernet_chip ,
> > >> > the other port of the switch is not used .
> > >> > 
> > >> > imx6q-pcie 1ffc000.pcie: phy link never came up
> 
> After discussing with Tim a little, looks like a clock bit was missing. The
> above line was the cause of all the issues. Now I can probe the bus, but I
> still need more patches:
> 
> This dirty patch here limits the PCIe operation to GEN1 only. It's based on
> this Freescale patch [1]. Without this change, the PCIe switch is not
> detected. Any idea why? (I also had to increase the PHY startup delay to
> get GEN1 going).
> 
> [1]
> https://www.osadl.org/monitoring/patches/r8s7/1342-ENGR00180230-MX6-PCIE-
> enlarge-the-eye-diagram-and-fo.patch
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 32b30ca..df2838b 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -330,13 +330,16 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
> 
>         dw_pcie_setup_rc(pp);
> 
> +// Enable GEN1
> +writel(((readl(pp->dbi_base + 0x7c) & 0xfffffff0) | 0x1), pp->dbi_base +
> 0x7c); +
>         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>                         IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> 
>         while (!dw_pcie_link_up(pp)) {
>                 usleep_range(100, 1000);
>                 count++;
> -               if (count >= 10) {
> +               if (count >= 200) {
>                         dev_err(pp->dev, "phy link never came up\n");
>                         dev_dbg(pp->dev,
>                                 "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> 

The lspci now also looks much better.

~ # lspci 
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0604: 12d8:2303
02:01.0 Class 0604: 12d8:2303
02:02.0 Class 0604: 12d8:2303
03:00.0 Class 0200: 8086:1531

And so does the probe log (but the pcieport failure still persists):

PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [12d8:2303] type 01 class 0x060400
pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci_bus 0000:01: fixups for bus
PCI: bus1: Fast back to back transfers disabled
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:02: scanning bus
pci 0000:02:01.0: [12d8:2303] type 01 class 0x060400
pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:02:01.0: supports D1 D2
pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:01.0: PME# disabled
pci 0000:02:02.0: [12d8:2303] type 01 class 0x060400
pci 0000:02:02.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:02:02.0: supports D1 D2
pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:02.0: PME# disabled
pci_bus 0000:02: fixups for bus
PCI: bus2: Fast back to back transfers disabled
pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
pci 0000:02:02.0: scanning [bus 04-04] behind bridge, pass 0
pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:03: scanning bus
pci 0000:03:00.0: [8086:1531] type 00 class 0x020000
pci 0000:03:00.0: reg 0x10: [mem 0x01000000-0x017fffff]
pci 0000:03:00.0: reg 0x18: [io  0x1000-0x101f]
pci 0000:03:00.0: reg 0x1c: [mem 0x01800000-0x01803fff]
pci 0000:03:00.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci_bus 0000:03: fixups for bus
PCI: bus3: Fast back to back transfers disabled
pci_bus 0000:03: bus scan returning with max=03
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:04: scanning bus
pci_bus 0000:04: fixups for bus
PCI: bus4: Fast back to back transfers enabled
pci_bus 0000:04: bus scan returning with max=04
pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
pci_bus 0000:02: bus scan returning with max=04
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 04
pci_bus 0000:01: bus scan returning with max=04
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 04
pci_bus 0000:00: bus scan returning with max=04
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 04
PCI: Device 0000:00:00.0 not available because of resource collisions
pcieport: probe of 0000:00:00.0 failed with error -22
PCI: Device 0000:00:00.0 not available because of resource collisions
pci 0000:00:00.0: Error enabling bridge (-22), continuing
PCI: enabling device 0000:01:00.0 (0140 -> 0143)
pcieport 0000:01:00.0: enabling bus mastering
PCI: Device 0000:00:00.0 not available because of resource collisions
pci 0000:00:00.0: Error enabling bridge (-22), continuing
PCI: Device 0000:00:00.0 not available because of resource collisions
pci 0000:00:00.0: Error enabling bridge (-22), continuing
pci 0000:03:00.0: calling quirk_e100_interrupt+0x0/0x20c
pci 0000:00:00.0: fixup irq: got 155
pci 0000:00:00.0: assigning IRQ 155
pcieport 0000:01:00.0: fixup irq: got 0
pcieport 0000:01:00.0: assigning IRQ 00
pcieport 0000:02:01.0: fixup irq: got 0
pcieport 0000:02:01.0: assigning IRQ 00
pcieport 0000:02:02.0: fixup irq: got 0
pcieport 0000:02:02.0: assigning IRQ 00
pci 0000:03:00.0: fixup irq: got 155
pci 0000:03:00.0: assigning IRQ 155
pci 0000:00:00.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
pci 0000:00:00.0: BAR 0: assigned [mem 0x01c00000-0x01cfffff]
pci 0000:00:00.0: BAR 0: set to [mem 0x01c00000-0x01cfffff] (PCI address 
[0x1c00000-0x1c
fffff])
pci 0000:00:00.0: BAR 6: assigned [mem 0x01d00000-0x01d0ffff pref]
pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pcieport 0000:01:00.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
pcieport 0000:01:00.0: BAR 7: assigned [io  0x1000-0x1fff]
pcieport 0000:02:01.0: BAR 8: assigned [mem 0x01000000-0x01bfffff]
pcieport 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:03:00.0: BAR 0: assigned [mem 0x01000000-0x017fffff]
pci 0000:03:00.0: BAR 0: set to [mem 0x01000000-0x017fffff] (PCI address 
[0x1000000-0x17
fffff])
pci 0000:03:00.0: BAR 3: assigned [mem 0x01800000-0x01803fff]
pci 0000:03:00.0: BAR 3: set to [mem 0x01800000-0x01803fff] (PCI address 
[0x1800000-0x18
03fff])
pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f]
pci 0000:03:00.0: BAR 2: set to [io  0x1000-0x101f] (PCI address 
[0x1000-0x101f])
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
pci_bus 0000:00: resource 4 [io  0x1000-0x10000]
pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:01: resource 1 [mem 0x01000000-0x01bfffff]
pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:02: resource 1 [mem 0x01000000-0x01bfffff]
pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:03: resource 1 [mem 0x01000000-0x01bfffff]

Best regards,
Marek Vasut
