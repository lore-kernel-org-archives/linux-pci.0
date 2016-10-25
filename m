Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-de.keymile.com ([195.8.104.250]:48171 "EHLO
        mail-de.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758770AbcJYMiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2016 08:38:05 -0400
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Device tree nodes for devices behind a PCIe switch
Message-ID: <90e305c7-be1f-8c37-f489-0701de697de4@keymile.com>
Date: Tue, 25 Oct 2016 14:32:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

We have a board that embeds an FPGA with multiple functions (MFD driver) that is
connected to the the PCIe bus with a PCIe switch (more precisely PLX/Avago's
8714), since we have several PCIe devices on the board.

The MFD driver that I have written and tested on the development boards relies
on a device tree node to configure the several "sub-devices" embedded in the
FPGA. On the testing setup, this was pretty simple since the CPU dev board has
no PCIe switch and when I connect the FPGA dev board on the PCI of the CPU dev
board here is what I get:

> root@192:~# lspci
> 0000:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0820 (rev 11)
> 0001:02:00.0 PCI bridge: Freescale Semiconductor Inc Device 0820 (rev 11)
> 0001:03:00.0 Unassigned class [ff00]: Altera Corporation Device 006d (rev 01)
> 0002:04:00.0 PCI bridge: Freescale Semiconductor Inc Device 0820 (rev 11)
> 0003:06:00.0 PCI bridge: Freescale Semiconductor Inc Device 0820 (rev 11)
> root@192:~# lspci -t
> -+-[0003:06]---00.0-[07]--
>  +-[0002:04]---00.0-[05]--
>  +-[0001:02]---00.0-[03]----00.0
>  \-[0000:00]---00.0-[01]--

The Altera FPGA is "directly connected" to the root of the PCIe.

With this device tree node for the corresponding PCIe bus, the pci_dev gets the
femt of_node assigned and I can work with it in the MFD driver.

> pci1: pcie@ffe250000 {
> 		pcie@0 {
> 			femt {
> 				/* 0001:03:00.0 -> domain:bus:device.fn
> 				 * reg must be npt000ss bbbbbbbb dddddfff rrrrrrrr
> 				 * according to http://sametwice.com/of_pci_bus_address
> 				 */
> 				reg = <0x00030000 0 0 0 0>;
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 				gpio@100 {
> 					compatible = "keymile,femt-gpio";
> 					reg = <0x100 20>;
> 					gpio-controller;
> 					#gpio-cells = <2>;
> 				};
> 				gpio@180 {
> 					compatible = "keymile,femt-gpio";
> 					reg = <0x180 20>;
> 					gpio-controller;
> 					#gpio-cells = <2>;
> 				};
> 			};
> 		};
> 	};

On our board, the PCIe switch raises the complexity by a level and I cannot get
the femt of_node to assigned to the corresponding pci_device. By debugging a
little bit I have found out that the pci_set_of_node() call from
pci_scan_device() directly returns because there is no of_node for the bus the
FPGA is on.

Based on this I have tried to add the busses created by the PLX bridge to my
device tree.

Here are my lspci outputs:

> root@kmcent2:~# lspci -t
> -[0000:00]---00.0-[01-06]----00.0-[02-06]--+-01.0-[03]----00.0
>                                            +-02.0-[04]--
>                                            +-03.0-[05]----00.0
>                                            \-04.0-[06]----00.0
> root@kmcent2:~# lspci
> 00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0821 (rev 11)
> 01:00.0 PCI bridge: PLX Technology, Inc. Device 8714 (rev ab)
> 02:01.0 PCI bridge: PLX Technology, Inc. Device 8714 (rev ab)
> 02:02.0 PCI bridge: PLX Technology, Inc. Device 8714 (rev ab)
> 02:03.0 PCI bridge: PLX Technology, Inc. Device 8714 (rev ab)
> 02:04.0 PCI bridge: PLX Technology, Inc. Device 8714 (rev ab)
> 03:00.0 Ethernet controller: Marvell Technology Group Ltd. Device fc00
> 05:00.0 Unassigned class [ff00]: Altera Corporation Device 006d (rev 01)
> 06:00.0 Bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev ab)

And here is my attempt at describing it in the device tree:

> 	pci0: pcie@ffe240000 {
> 		reg = <0xf 0xfe240000 0 0x10000>;
> 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
> 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
> 		pcie@0 {
> 			/* 00:00.0 root fsl cpu */
> 			ranges = <0x02000000 0 0xe0000000
> 				  0x02000000 0 0xe0000000
> 				  0 0x20000000
> 
> 				  0x01000000 0 0x00000000
> 				  0x01000000 0 0x00000000
> 				  0 0x00010000>;
> 			bridge@2,3 {
> 				/* 02:03.0 bridge PLX */
> 				reg = <0x00021100 0 0 0 0>;
> 				#address-cells = <3>;
> 				#size-cells = <2>;
> 				bridge@5,0 {
> 					/* 05:00.0 bridge PLX */
> 					reg = <0x00050000 0 0 0 0>;
> 					#address-cells = <3>;
> 					#size-cells = <2>;
> 					femt {
> 						/* 00:00.0 FPGA */
> 						reg = <0x00000000 0 0 0 0>;
> 						#address-cells = <1>;
> 						#size-cells = <1>;
> 						interrupts = <0>;
> 						gpio@100 {
> 							compatible = "keymile,femt-gpio";
> 							reg = <0x100 20>;
> 							gpio-controller;
> 							#gpio-cells = <2>;
> 						};
> 						gpio@180 {
> 							compatible = "keymile,femt-gpio";
> 							reg = <0x180 20>;
> 							gpio-controller;
> 							#gpio-cells = <2>;
> 						};
> 					};
> 				};
> 			};
> 		};
> 	};

Is it really necessary to rebuild all this hierarchy in the device tree or have
I missed something that would allow me to get rid of this complex description of
the whole PCIe bus in the device tree ? PCIe is dynamic and can be enumerated
and it would be great to have an easier way to "link" an of_node to certain pci_dev.

If there is no other way than the complete description in the device tree, any
suggestion about what is wrong in my above device tree attempt ? Am I missing
one "intermediate" bus level ?

Valentin
