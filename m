Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42206 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755186AbbLGJZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2015 04:25:59 -0500
Message-ID: <1449480357.3118.3.camel@pengutronix.de>
Subject: Re: mx6: No bus range found
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Mon, 07 Dec 2015 10:25:57 +0100
In-Reply-To: <CAOMZO5AxaAr57pYpBEEgk5sm56ey3b60F2E0z2PgD1Z2g7Y_Sg@mail.gmail.com>
References: <CAOMZO5AxaAr57pYpBEEgk5sm56ey3b60F2E0z2PgD1Z2g7Y_Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Am Freitag, den 04.12.2015, 19:12 -0200 schrieb Fabio Estevam:
> Hi,
> 
> Booting linux-next 20151202 on a mx6qsabresd board with an Intel 7260
> Wifi PCI card connected I see:
> 
> [    0.255013] PCI host bridge /soc/pcie@0x01000000 ranges:
> [    0.255033]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> [    0.255085]   err 0x01f00000..0x01f7ffff -> 0x01f00000
> [    0.255123]    IO 0x01f80000..0x01f8ffff -> 0x00000000
> [    0.255202]   MEM 0x01000000..0x01efffff -> 0x01000000
> [    0.370288] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> [    0.370314] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.370333] pci_bus 0000:00: root bus resource [???
> 0x01f00000-0x01f7ffff flags 0x0]
> [    0.370349] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.370365] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> [    0.370488] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    0.370553] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.370590] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    0.370780] pci 0000:00:00.0: supports D1
> [    0.370797] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    0.371570] PCI: bus0: Fast back to back transfers disabled
> [    0.371989] pci 0000:01:00.0: [8086:08b1] type 00 class 0x028000
> [    0.372214] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> [    0.372747] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    0.386266] PCI: bus1: Fast back to back transfers disabled
> [    0.386498] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> [    0.386528] pci 0000:00:00.0: BAR 8: assigned [mem 0x01100000-0x011fffff]
> [    0.386548] pci 0000:00:00.0: BAR 6: assigned [mem
> 0x01200000-0x0120ffff pref]
> [    0.386573] pci 0000:01:00.0: BAR 0: assigned [mem
> 0x01100000-0x01101fff 64bit]
> [    0.386650] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.386672] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
> [    0.387370] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    0.387390] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    0.387413] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
> 
> Is there anything we should do to avoid the following messages?
> 
> [    0.255033]   No bus range found for /soc/pcie@0x01000000, using [bus 00-ff]
> 
This one is harmless as it defaults to the right configuration for a
single PCIe root.

> and
> 
> [    0.370333] pci_bus 0000:00: root bus resource [???
> 0x01f00000-0x01f7ffff flags 0x0
> 
This one is also harmless, as it is being ignored. But as it generates a
confusing "err 0x01f00000..0x01f7ffff -> 0x01f00000" above, there is
already a patch in Shawns tree to remove the bogus range from the DT to
get rid of this.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

