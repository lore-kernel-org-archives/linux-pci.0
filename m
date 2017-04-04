Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34906 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdDDJR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 05:17:29 -0400
Received: by mail-oi0-f53.google.com with SMTP id f193so155774414oib.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2017 02:17:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFChf7Kw5ighAMXD08tf9+jNNdkORzumGL2hO=OBO27qiaL1-g@mail.gmail.com>
References: <CAFChf7Kw5ighAMXD08tf9+jNNdkORzumGL2hO=OBO27qiaL1-g@mail.gmail.com>
From: Mattias Barthel <mattiasbarthel@gmail.com>
Date: Tue, 4 Apr 2017 11:17:28 +0200
Message-ID: <CAFChf7J7fuFtaHH1LOGypsvB140m+b4Ymb2U0Yx-++tOGVa+gg@mail.gmail.com>
Subject: Re: IMX6SX PCIe speed change test upon link establishment
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello again,

I have read the speed change part in the reference manual briefly.
(IMX6SXRM.pdf).


46.12.31 Gen2 Control Register (PCIE_PL_G2CR).
Bit 17
Directed Speed Change
Indicates to the LTSSM whether or not to initiate a speed change to Gen2.

46.3.10.2 Speed Changing
If bit 17 =C3=ACDirected Speed Change=C3=AC of the Gen2 Control Register is=
 set
to '1', then the
LTSSM will initiate a speed change after the link is initialized. The
default value of this
register is the '1' .

The speed change test in 4.8 kernel pci-imx6.c code:
#define PORT_LOGIC_SPEED_CHANGE (0x1 << 17)

static int imx6_pcie_wait_for_speed_change(struct pcie_port *pp)
{
u32 tmp;
unsigned int retries;

for (retries =3D 0; retries < 200; retries++) {
tmp =3D readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
/* Test if the speed change finished. */
if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
return 0;
usleep_range(100, 1000);
}

dev_err(pp->dev, "Speed change timeout\n");
return -EINVAL;
}

There is actually nothing in the manual saying that Directed Speed
Change of the Gen2 register is a two way register bit. (Both control
and status).
So consequentially, this bit will never de-assert and there will
always be a "Speed change timeout".


Regards,

Mattias


On Wed, Mar 29, 2017 at 3:42 PM, Mattias Barthel
<mattiasbarthel@gmail.com> wrote:
> Hi,
>
> I am working with bringing PCIe support to 4.8.
> I have ported the pci phy regulator via power domain from 4.1.15_2.0.0
> to  4.8. (4.8 what I was told to use by my company but I will probably
> port this to 4.9 too).
>
> The pci_imx6 driver is now loading and the link seems to come up after
> some tweaks.
> The link start in the 4.8 is a bit different than in 4.1,
> For example the speed change test is erroneous in 4.1 since it checks
> for count =3D=3D 0 but since count is postdecremented it will become -1
> before the check. So the speed change failure will never be detected.
>
> tmp =3D readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> tmp |=3D PORT_LOGIC_SPEED_CHANGE;
> writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>
> count =3D 2000;
> while (count--) {
> tmp =3D readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> /* Test if the speed change finished. */
> if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
> break;
> udelay(10);
> }
>
> I found a discussion regarding the speed change test upon link establishm=
ent:
> https://patchwork.kernel.org/patch/6458251/
>
> How important is this speed change test for link establishments?
>
> Here follows some output from pci loading in 4.8:
>
> smartoptics-dcp:~# dmesg | grep -i pci
> PCI: CLS 0 bytes, default 64
> imx6_pcie_probe
> OF: PCI: host bridge /soc/pcie@0x08000000 ranges:
> OF: PCI:   No bus range found for /soc/pcie@0x08000000, using [bus 00-ff]
> OF: PCI:    IO 0x08f80000..0x08f8ffff -> 0x00000000
> OF: PCI:   MEM 0x08000000..0x08efffff -> 0x08000000
> imx6q-pcie 8ffc000.pcie: link up
> imx6q-pcie 8ffc000.pcie: link up
> imx6q-pcie 8ffc000.pcie: Link up, Gen1
> imx6q-pcie 8ffc000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x08000000-0x08efffff]
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:01:00.0: [8086:08b1] type 00 class 0x028000
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> PCI: bus1: Fast back to back transfers disabled
> pci 0000:00:00.0: BAR 0: assigned [mem 0x08000000-0x080fffff]
> pci 0000:00:00.0: BAR 8: assigned [mem 0x08100000-0x081fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x08200000-0x0820ffff pref]
> pci 0000:01:00.0: BAR 0: assigned [mem 0x08100000-0x08101fff 64bit]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [mem 0x08100000-0x081fffff]
> pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> pci 0000:01:00.0: Signaling PME through PCIe PME inblock ubiblock0_10:
> created from ubi0:10(rootfs1)
> terrupt
> pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loaded
> aer 0000:00:00.0:pcie002: service driver aer loaded
>
> smartoptics-dcp:~# lspci
> 00:00.0 Class 0604: 16c3:abcd
> 01:00.0 Class 0280: 8086:08b1
>
>
>
> Regards,
>
> Mattias
>
> --
> Mattias Barthel



--=20
Mattias Barthel
