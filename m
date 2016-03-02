Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54108 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982AbcCBT4i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Mar 2016 14:56:38 -0500
Date: Wed, 2 Mar 2016 13:56:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
Message-ID: <20160302195634.GA19223@localhost>
References: <56D5E3DF.9030906@tekno-soft.it>
 <56D71F27.7070708@tekno-soft.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D71F27.7070708@tekno-soft.it>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Richard, Lucas]

On Wed, Mar 02, 2016 at 06:13:11PM +0100, Roberto Fichera wrote:
> On 03/01/2016 07:47 PM, Roberto Fichera wrote:
> 
> Sorry guy if I push a little bit about this, I've added some debugging code regarding my issue:
> 
> [    0.557268] imx6q-pcie 1ffc000.pcie: phy link never came up
> [    0.557290] imx6q-pcie 1ffc000.pcie: LTSSM current state: 0x3 (S_POLL_COMPLIANCE)
> [    0.557304] imx6q-pcie 1ffc000.pcie: PIPE transmit K indication: 1
> [    0.557318] imx6q-pcie 1ffc000.pcie: PIPE Transmit data: 0x4abc
> [    0.557332] imx6q-pcie 1ffc000.pcie: Receiver is receiving logical idle: no
> [    0.557345] imx6q-pcie 1ffc000.pcie: Second symbol is also idle (16-bit PHY interface only): no
> [    0.557360] imx6q-pcie 1ffc000.pcie: Currently receiving k237 (PAD) in place of link number: no
> [    0.557372] imx6q-pcie 1ffc000.pcie: Currently receiving k237 (PAD) in place of lane number: no
> [    0.557385] imx6q-pcie 1ffc000.pcie: Link control bits advertised by link partner: 0xa
> [    0.557398] imx6q-pcie 1ffc000.pcie: Receiver detected lane reversal: no
> [    0.557410] imx6q-pcie 1ffc000.pcie: TS2 training sequence received: no
> [    0.557422] imx6q-pcie 1ffc000.pcie: TS1 training sequence received: no
> [    0.557434] imx6q-pcie 1ffc000.pcie: Receiver reports skip reception: no
> [    0.557446] imx6q-pcie 1ffc000.pcie: LTSSM reports PHY link up: no
> [    0.557460] imx6q-pcie 1ffc000.pcie: A skip ordered set has been transmitted: no
> [    0.557474] imx6q-pcie 1ffc000.pcie: Link number advertised/confirmed by link partner: 68
> [    0.557487] imx6q-pcie 1ffc000.pcie: Application request to initiate training reset: no
> [    0.557500] imx6q-pcie 1ffc000.pcie: PIPE transmit compliance request: no
> [    0.557512] imx6q-pcie 1ffc000.pcie: PIPE transmit electrical idle request: no
> [    0.557524] imx6q-pcie 1ffc000.pcie: PIPE receiver detect/loopback request: no
> [    0.557536] imx6q-pcie 1ffc000.pcie: LTSSM-negotiated link reset: yes
> [    0.557547] imx6q-pcie 1ffc000.pcie: LTSSM testing for polarity reversal: no
> [    0.557559] imx6q-pcie 1ffc000.pcie: LTSSM performing link training: no
> [    0.557572] imx6q-pcie 1ffc000.pcie: LTSSM in DISABLE state; link inoperable: no
> [    0.557583] imx6q-pcie 1ffc000.pcie: Scrambling disabled for the link: no
> [    0.558156] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.558179] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.558197] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
> [    0.558212] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.558226] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> [    0.558346] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    0.558468] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.558510] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    0.558708] pci 0000:00:00.0: supports D1
> [    0.558727] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.559495] PCI: bus0: Fast back to back transfers disabled
> [    0.559834] PCI: bus1: Fast back to back transfers enabled
> [    0.559997] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> [    0.560025] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> [    0.560047] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.560812] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    0.560837] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> 
> Any idea what's going on?
> 
> Thanks in advance,
> Roberto Fichera.
> 
> > Hi There,
> >
> > Working on a custom iMX6q board I'm getting a PCIe phy link never came up, even if uboot seems detecting
> > everything ok. My DTS is enabling PCIe with
> >
> > &pcie {
> >     pinctrl-names = "default";
> >     pinctrl-0 = <&pinctrl_pcie_reset>;
> >     reset-gpio = <&gpio7 12 0>;
> >     status = "okay";
> > };
> >
> > The PCIe is connected to a PCIe-to-PCI TI XIO2001. The XIO2001 power is controlled by GPIO_9 and 
> > the corresponding fixed regulator is set as
> >
> > 		reg_pcie: regulator@4 {
> > 			compatible = "regulator-fixed";
> > 			reg = <4>;
> > 			pinctrl-names = "default";
> > 			pinctrl-0 = <&pinctrl_pcie_reg>;
> > 			regulator-name = "MPCIE_3V3";
> > 			regulator-min-microvolt = <3300000>;
> > 			regulator-max-microvolt = <3300000>;
> > 			gpio = <&gpio1 9 0>;
> > 			regulator-always-on;
> > 			enable-active-high;
> > 		};
> >
> > so I'd like to know if there is any other special setup to do in order to get it to work on a v4.4.x kernel.
> > Or anyway how to debug it.
> >
> > Any suggestion?
> >
> > Thanks in advance,
> > Roberto Fichera.
> >
> > U-Boot 2014.04-imx_v2014.04_3.14.38_6qp_beta+g6e9282c (Feb 15 2016 - 10:02:31)
> >
> > CPU:   Freescale i.MX6Q rev1.5 at 792 MHz
> > CPU:   Temperature 35 C, calibration data: 0x5664d569
> > Reset cause: POR
> > Board: Janas iMX6Q (ID:e315c064140749d4)
> > I2C:   ready
> > DRAM:  2 GiB
> > MMC:   FSL_SDHC: 0, FSL_SDHC: 1
> > *** Warning - bad CRC, using default environment
> >
> >   00:01.0     - 16c3:abcd - Bridge device
> >    01:00.0    - 104c:8240 - Bridge device
> >     02:04.0   - 1397:08b4 - Network controller
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Found PFUZE100! deviceid=10,revid=21
> > mmc1(part 0) is current device
> > Net:   FEC [PRIME]
> > Warning: failed to set MAC address
> >
> > Normal Boot
> > ....
> > ....
> > [    0.236141] PCI host bridge /soc/pcie@0x01000000 ranges:
> > [    0.236162]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> > [    0.236213]   err 0x01f00000..0x01f7ffff -> 0x01f00000
> > [    0.236250]    IO 0x01f80000..0x01f8ffff -> 0x00000000
> > [    0.236330]   MEM 0x01000000..0x01efffff -> 0x01000000
> > -->>> [    0.546690] imx6q-pcie 1ffc000.pcie: phy link never came up
> > [    0.547263] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > [    0.547287] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.547304] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
> > [    0.547321] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.547335] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> > [    0.548608] PCI: bus0: Fast back to back transfers disabled
> > [    0.548950] PCI: bus1: Fast back to back transfers enabled
> > [    0.549107] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> > [    0.549137] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> > [    0.549159] pci 0000:00:00.0: PCI bridge to [bus 01]
> > [    0.549945] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> > ...
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
