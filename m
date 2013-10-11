Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:1028 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab3JKC3K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 22:29:10 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Marek Vasut <marex@denx.de>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Subject: RE: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Fri, 11 Oct 2013 02:29:05 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40A1F3@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <201310110413.02354.marex@denx.de> <201310110418.56460.marex@denx.de>
In-Reply-To: <201310110418.56460.marex@denx.de>
Content-Type: multipart/mixed;
	boundary="_002_0E83723C55F66F43A6041464FE31119D40A1F3039SN2MPN1011039d_"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--_002_0E83723C55F66F43A6041464FE31119D40A1F3039SN2MPN1011039d_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marek:
In order to setup the irq properly when the PCIe switch is used.
Did you update the map_irq function in pcie_designware.c driver?
Here is the patch used by me when I trying to bring up the PCIe switch at m=
y side.
Patch is attached.


Best Regards
Richard Zhu


-----Original Message-----
From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.o=
rg] On Behalf Of Marek Vasut
Sent: Friday, October 11, 2013 10:19 AM
To: Bjorn Helgaas
Cc: Zhu Richard-R65037; linux-arm-kernel@lists.infradead.org; Shawn Guo; li=
nux-pci@vger.kernel.org; tharvey@gateworks.com; Frank Li; Sean Cross; Sasch=
a Hauer; Yinghai Lu
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q

Hi,

> Hi Bjorn,
>=20
> > On Thu, Oct 10, 2013 at 11:39 AM, Marek Vasut <marex@denx.de> wrote:
> > > Hi Bjorn,
> > >=20
> > >> [+cc Yinghai]
> > >>=20
> > >> On Thu, Oct 10, 2013 at 9:58 AM, Marek Vasut <marex@denx.de> wrote:
> > >> >> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrot=
e:
> > >> > I tried you suggestion, this is what I got now (and with V7 of=20
> > >> > the
> > >> > patches):
> > >> >=20
> > >> > Note that my topology is:=20
> > >> > rootport->2_port_switch->ethernet_chip , the other port of the swi=
tch is not used .
> > >> >=20
> > >> > imx6q-pcie 1ffc000.pcie: phy link never came up
>=20
> After discussing with Tim a little, looks like a clock bit was=20
> missing. The above line was the cause of all the issues. Now I can=20
> probe the bus, but I still need more patches:
>=20
> This dirty patch here limits the PCIe operation to GEN1 only. It's=20
> based on this Freescale patch [1]. Without this change, the PCIe=20
> switch is not detected. Any idea why? (I also had to increase the PHY=20
> startup delay to get GEN1 going).
>=20
> [1]
> https://www.osadl.org/monitoring/patches/r8s7/1342-ENGR00180230-MX6-PC
> IE-
> enlarge-the-eye-diagram-and-fo.patch
>=20
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c=20
> index 32b30ca..df2838b 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -330,13 +330,16 @@ static void imx6_pcie_host_init(struct pcie_port=20
> *pp)
>=20
>         dw_pcie_setup_rc(pp);
>=20
> +// Enable GEN1
> +writel(((readl(pp->dbi_base + 0x7c) & 0xfffffff0) | 0x1),=20
> +pp->dbi_base +
> 0x7c); +
>         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>                         IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>=20
>         while (!dw_pcie_link_up(pp)) {
>                 usleep_range(100, 1000);
>                 count++;
> -               if (count >=3D 10) {
> +               if (count >=3D 200) {
>                         dev_err(pp->dev, "phy link never came up\n");
>                         dev_dbg(pp->dev,
>                                 "DEBUG_R0: 0x%08x, DEBUG_R1:=20
> 0x%08x\n",
>=20

The lspci now also looks much better.

~ # lspci
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0604: 12d8:2303
02:01.0 Class 0604: 12d8:2303
02:02.0 Class 0604: 12d8:2303
03:00.0 Class 0200: 8086:1531

And so does the probe log (but the pcieport failure still persists):

PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000] pci_bus 0000:00: ro=
ot bus resource [mem 0x01000000-0x01efffff] pci_bus 0000:00: No busn resour=
ce found for root bus, will use [bus 00-ff] pci_bus 0000:00: scanning bus p=
ci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 pci 0000:00:00.0: reg 0=
x10: [mem 0x00000000-0x000fffff] pci 0000:00:00.0: reg 0x38: [mem 0x0000000=
0-0x0000ffff pref] pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x5c p=
ci 0000:00:00.0: supports D1 pci 0000:00:00.0: PME# supported from D0 D1 D3=
hot D3cold pci 0000:00:00.0: PME# disabled pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled pci 0000:00:00.0: scanning =
[bus 01-01] behind bridge, pass 0 pci 0000:00:00.0: scanning [bus 00-00] be=
hind bridge, pass 1 pci_bus 0000:01: scanning bus pci 0000:01:00.0: [12d8:2=
303] type 01 class 0x060400 pci 0000:01:00.0: calling pci_fixup_ide_bases+0=
x0/0x5c pci 0000:01:00.0: supports D1 D2 pci 0000:01:00.0: PME# supported f=
rom D0 D1 D2 D3hot D3cold pci 0000:01:00.0: PME# disabled pci_bus 0000:01: =
fixups for bus
PCI: bus1: Fast back to back transfers disabled pci 0000:01:00.0: scanning =
[bus 00-00] behind bridge, pass 0 pci 0000:01:00.0: bridge configuration in=
valid ([bus 00-00]), reconfiguring pci 0000:01:00.0: scanning [bus 00-00] b=
ehind bridge, pass 1 pci_bus 0000:02: scanning bus pci 0000:02:01.0: [12d8:=
2303] type 01 class 0x060400 pci 0000:02:01.0: calling pci_fixup_ide_bases+=
0x0/0x5c pci 0000:02:01.0: supports D1 D2 pci 0000:02:01.0: PME# supported =
from D0 D1 D2 D3hot D3cold pci 0000:02:01.0: PME# disabled pci 0000:02:02.0=
: [12d8:2303] type 01 class 0x060400 pci 0000:02:02.0: calling pci_fixup_id=
e_bases+0x0/0x5c pci 0000:02:02.0: supports D1 D2 pci 0000:02:02.0: PME# su=
pported from D0 D1 D2 D3hot D3cold pci 0000:02:02.0: PME# disabled pci_bus =
0000:02: fixups for bus
PCI: bus2: Fast back to back transfers disabled pci 0000:02:01.0: scanning =
[bus 03-03] behind bridge, pass 0 pci 0000:02:02.0: scanning [bus 04-04] be=
hind bridge, pass 0 pci 0000:02:01.0: scanning [bus 00-00] behind bridge, p=
ass 1 pci_bus 0000:03: scanning bus pci 0000:03:00.0: [8086:1531] type 00 c=
lass 0x020000 pci 0000:03:00.0: reg 0x10: [mem 0x01000000-0x017fffff] pci 0=
000:03:00.0: reg 0x18: [io  0x1000-0x101f] pci 0000:03:00.0: reg 0x1c: [mem=
 0x01800000-0x01803fff] pci 0000:03:00.0: calling pci_fixup_ide_bases+0x0/0=
x5c pci 0000:03:00.0: PME# supported from D0 D3hot D3cold pci 0000:03:00.0:=
 PME# disabled pci_bus 0000:03: fixups for bus
PCI: bus3: Fast back to back transfers disabled pci_bus 0000:03: bus scan r=
eturning with max=3D03 pci_bus 0000:03: busn_res: [bus 03-ff] end is update=
d to 03 pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1 pci_bu=
s 0000:04: scanning bus pci_bus 0000:04: fixups for bus
PCI: bus4: Fast back to back transfers enabled pci_bus 0000:04: bus scan re=
turning with max=3D04 pci_bus 0000:04: busn_res: [bus 04-ff] end is updated=
 to 04 pci_bus 0000:02: bus scan returning with max=3D04 pci_bus 0000:02: b=
usn_res: [bus 02-ff] end is updated to 04 pci_bus 0000:01: bus scan returni=
ng with max=3D04 pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 0=
4 pci_bus 0000:00: bus scan returning with max=3D04 pci_bus 0000:00: busn_r=
es: [bus 00-ff] end is updated to 04
PCI: Device 0000:00:00.0 not available because of resource collisions
pcieport: probe of 0000:00:00.0 failed with error -22
PCI: Device 0000:00:00.0 not available because of resource collisions pci 0=
000:00:00.0: Error enabling bridge (-22), continuing
PCI: enabling device 0000:01:00.0 (0140 -> 0143) pcieport 0000:01:00.0: ena=
bling bus mastering
PCI: Device 0000:00:00.0 not available because of resource collisions pci 0=
000:00:00.0: Error enabling bridge (-22), continuing
PCI: Device 0000:00:00.0 not available because of resource collisions pci 0=
000:00:00.0: Error enabling bridge (-22), continuing pci 0000:03:00.0: call=
ing quirk_e100_interrupt+0x0/0x20c pci 0000:00:00.0: fixup irq: got 155 pci=
 0000:00:00.0: assigning IRQ 155 pcieport 0000:01:00.0: fixup irq: got 0 pc=
ieport 0000:01:00.0: assigning IRQ 00 pcieport 0000:02:01.0: fixup irq: got=
 0 pcieport 0000:02:01.0: assigning IRQ 00 pcieport 0000:02:02.0: fixup irq=
: got 0 pcieport 0000:02:02.0: assigning IRQ 00 pci 0000:03:00.0: fixup irq=
: got 155 pci 0000:03:00.0: assigning IRQ 155 pci 0000:00:00.0: BAR 8: assi=
gned [mem 0x01000000-0x01bfffff] pci 0000:00:00.0: BAR 0: assigned [mem 0x0=
1c00000-0x01cfffff] pci 0000:00:00.0: BAR 0: set to [mem 0x01c00000-0x01cff=
fff] (PCI address [0x1c00000-0x1c
fffff])
pci 0000:00:00.0: BAR 6: assigned [mem 0x01d00000-0x01d0ffff pref] pci 0000=
:00:00.0: BAR 7: assigned [io  0x1000-0x1fff] pcieport 0000:01:00.0: BAR 8:=
 assigned [mem 0x01000000-0x01bfffff] pcieport 0000:01:00.0: BAR 7: assigne=
d [io  0x1000-0x1fff] pcieport 0000:02:01.0: BAR 8: assigned [mem 0x0100000=
0-0x01bfffff] pcieport 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff] pc=
i 0000:03:00.0: BAR 0: assigned [mem 0x01000000-0x017fffff] pci 0000:03:00.=
0: BAR 0: set to [mem 0x01000000-0x017fffff] (PCI address
[0x1000000-0x17
fffff])
pci 0000:03:00.0: BAR 3: assigned [mem 0x01800000-0x01803fff] pci 0000:03:0=
0.0: BAR 3: set to [mem 0x01800000-0x01803fff] (PCI address
[0x1800000-0x18
03fff])
pci 0000:03:00.0: BAR 2: assigned [io  0x1000-0x101f] pci 0000:03:00.0: BAR=
 2: set to [io  0x1000-0x101f] (PCI address
[0x1000-0x101f])
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
pci 0000:00:00.0: PCI bridge to [bus 01-04]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x01000000-0x01bfffff]
pci_bus 0000:00: resource 4 [io  0x1000-0x10000] pci_bus 0000:00: resource =
5 [mem 0x01000000-0x01efffff] pci_bus 0000:01: resource 0 [io  0x1000-0x1ff=
f] pci_bus 0000:01: resource 1 [mem 0x01000000-0x01bfffff] pci_bus 0000:02:=
 resource 0 [io  0x1000-0x1fff] pci_bus 0000:02: resource 1 [mem 0x01000000=
-0x01bfffff] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff] pci_bus 0000:0=
3: resource 1 [mem 0x01000000-0x01bfffff]

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in the=
 body of a message to majordomo@vger.kernel.org More majordomo info at  htt=
p://vger.kernel.org/majordomo-info.html


--_002_0E83723C55F66F43A6041464FE31119D40A1F3039SN2MPN1011039d_
Content-Type: application/octet-stream;
	name="0001-pcie-correct-the-irq-map-when-pcie-switch-is-used.patch"
Content-Description: 0001-pcie-correct-the-irq-map-when-pcie-switch-is-used.patch
Content-Disposition: attachment;
	filename="0001-pcie-correct-the-irq-map-when-pcie-switch-is-used.patch";
	size=1068; creation-date="Fri, 11 Oct 2013 02:28:28 GMT";
	modification-date="Fri, 11 Oct 2013 02:16:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NzkxNDAzOTUwMDUwZDc5ZGUxNmM3ZWZjYmRhNWI0MzU2ZGUzYzhmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIFpodSA8cjY1MDM3QGZyZWVzY2FsZS5jb20+CkRh
dGU6IFR1ZSwgOCBPY3QgMjAxMyAxMDoyMDo0NiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHBjaWU6
IGNvcnJlY3QgdGhlIGlycSBtYXAgd2hlbiBwY2llIHN3aXRjaCBpcyB1c2VkCgpjb3JyZWN0IHRo
ZSBpcnEgbWFwIHdoZW4gcGNpZSBzd2l0Y2ggaXMgdXNlZCwgb3RoZXJ3aXNlCnRoZSBwY2llIGVw
IHBvcHVsYXRkIG9uIHRoZSBzd2l0Y2ggd291bGRuJ3QgZ2V0IHRoZQpjb3JyZWN0IElOVHguCgpT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8cjY1MDM3QGZyZWVzY2FsZS5jb20+Ci0tLQogZHJp
dmVycy9wY2kvaG9zdC9wY2llLWRlc2lnbndhcmUuYyB8ICAgIDggKysrKysrKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2hvc3QvcGNpZS1kZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaWUt
ZGVzaWdud2FyZS5jCmluZGV4IDJiNWNlODAuLjNiZmQzYzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
cGNpL2hvc3QvcGNpZS1kZXNpZ253YXJlLmMKKysrIGIvZHJpdmVycy9wY2kvaG9zdC9wY2llLWRl
c2lnbndhcmUuYwpAQCAtNDY0LDcgKzQ2NCwxMyBAQCBpbnQgZHdfcGNpZV9tYXBfaXJxKGNvbnN0
IHN0cnVjdCBwY2lfZGV2ICpkZXYsIHU4IHNsb3QsIHU4IHBpbikKIHsKIAlzdHJ1Y3QgcGNpZV9w
b3J0ICpwcCA9IHN5c190b19wY2llKGRldi0+YnVzLT5zeXNkYXRhKTsKIAotCXJldHVybiBwcC0+
aXJxOworCXN3aXRjaCAocGluKSB7CisJY2FzZSAxOiByZXR1cm4gcHAtPmlycTsKKwljYXNlIDI6
IHJldHVybiBwcC0+aXJxIC0gMTsKKwljYXNlIDM6IHJldHVybiBwcC0+aXJxIC0gMjsKKwljYXNl
IDQ6IHJldHVybiBwcC0+aXJxIC0gMzsKKwlkZWZhdWx0OiByZXR1cm4gLTE7CisJfQogfQogCiBz
dGF0aWMgc3RydWN0IGh3X3BjaSBkd19wY2kgPSB7Ci0tIAoxLjcuMQoK

--_002_0E83723C55F66F43A6041464FE31119D40A1F3039SN2MPN1011039d_--
