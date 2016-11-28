Return-Path: <leedom@chelsio.com>
Return-Path: <leedom@chelsio.com>
From: Casey Leedom <leedom@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Netdev <netdev@vger.kernel.org>, "Santosh
 Rastapur" <santosh@chelsio.com>, Hariprasad S <hariprasad@chelsio.com>, Arjun
 V. <arjun@chelsio.com>
Subject: Re: [PATCH kernel v3] PCI: Enable access to custom VPD for Chelsio
 devices (cxgb3)
Date: Mon, 28 Nov 2016 22:38:08 +0000
Message-ID: <DM5PR12MB1786F2191D7B5E57707A2234C88A0@DM5PR12MB1786.namprd12.prod.outlook.com>
References: <1477292657-3021-1-git-send-email-aik@ozlabs.ru>,<20161123223558.GH16033@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161123223558.GH16033@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>





From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> on behalf=
 of Bjorn Helgaas <helgaas@kernel.org>
Sent: Wednesday, November 23, 2016 2:35 PM
To: Alexey Kardashevskiy
Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; Alexander Duyc=
k; Netdev; Santosh Rastapur
Subject: Re: [PATCH kernel v3] PCI: Enable access to custom VPD for Chelsio=
 devices (cxgb3)
=A0  =20
On Mon, Oct 24, 2016 at 06:04:17PM +1100, Alexey Kardashevskiy wrote:
> There is at least one Chelsio 10Gb card which uses VPD area to store
> some custom blocks (example below). However pci_vpd_size() returns
> the length of the first block only assuming that there can be only
> one VPD "End Tag" and VFIO blocks access beyond that offset
> (since 4e1a63555) which leads to the situation when the guest "cxgb3"
> driver fails to probe the device. The host system does not have this
> problem as the drives accesses the config space directly without
> pci_read_vpd()/...
>=20
> This adds a quirk to override the VPD size to a bigger value.
> The maximum size is taken from EEPROMSIZE in
> drivers/net/ethernet/chelsio/cxgb3/common.h. We do not read the tag
> as the cxgb3 driver does as the driver supports writing to EEPROM/VPD
> and when it writes, it only checks for 8192 bytes boundary. The quirk
> is registerted for all devices supported by the cxgb3 driver.
>=20
> This adds a quirk to the PCI layer (not to the cxgb3 driver) as
> the cxgb3 driver itself accesses VPD directly and the problem only exists
> with the vfio-pci driver (when cxgb3 is not running on the host and
> may not be even loaded) which blocks accesses beyond the first block
> of VPD data. However vfio-pci itself does not have quirks mechanism so
> we add it to PCI.
>=20
> This is the controller:
> Ethernet controller [0200]: Chelsio Communications Inc T310 10GbE Single =
Port Adapter [1425:0030]
>=20
> This is what I parsed from its vpd:
> =3D=3D=3D
> b'\x82*\x0010 Gigabit Ethernet-SR PCI Express Adapter\x90J\x00EC\x07D7680=
9 FN\x0746K'
>=A0 0000 Large item 42 bytes; name 0x2 Identifier String
>=A0=A0=A0=A0=A0=A0=A0 b'10 Gigabit Ethernet-SR PCI Express Adapter'
>=A0 002d Large item 74 bytes; name 0x10
>=A0=A0=A0=A0=A0=A0=A0 #00 [EC] len=3D7: b'D76809 '
>=A0=A0=A0=A0=A0=A0=A0 #0a [FN] len=3D7: b'46K7897'
>=A0=A0=A0=A0=A0=A0=A0 #14 [PN] len=3D7: b'46K7897'
>=A0=A0=A0=A0=A0=A0=A0 #1e [MN] len=3D4: b'1037'
>=A0=A0=A0=A0=A0=A0=A0 #25 [FC] len=3D4: b'5769'
>=A0=A0=A0=A0=A0=A0=A0 #2c [SN] len=3D12: b'YL102035603V'
>=A0=A0=A0=A0=A0=A0=A0 #3b [NA] len=3D12: b'00145E992ED1'
>=A0 007a Small item 1 bytes; name 0xf End Tag
>=20
>=A0 0c00 Large item 16 bytes; name 0x2 Identifier String
>=A0=A0=A0=A0=A0=A0=A0 b'S310E-SR-X=A0=A0=A0=A0=A0 '
>=A0 0c13 Large item 234 bytes; name 0x10
>=A0=A0=A0=A0=A0=A0=A0 #00 [PN] len=3D16: b'TBD=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #13 [EC] len=3D16: b'110107730D2=A0=A0=A0=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #26 [SN] len=3D16: b'97YL102035603V=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #39 [NA] len=3D12: b'00145E992ED1'
>=A0=A0=A0=A0=A0=A0=A0 #48 [V0] len=3D6: b'175000'
>=A0=A0=A0=A0=A0=A0=A0 #51 [V1] len=3D6: b'266666'
>=A0=A0=A0=A0=A0=A0=A0 #5a [V2] len=3D6: b'266666'
>=A0=A0=A0=A0=A0=A0=A0 #63 [V3] len=3D6: b'2000=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #6c [V4] len=3D2: b'1 '
>=A0=A0=A0=A0=A0=A0=A0 #71 [V5] len=3D6: b'c2=A0=A0=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #7a [V6] len=3D6: b'0=A0=A0=A0=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #83 [V7] len=3D2: b'1 '
>=A0=A0=A0=A0=A0=A0=A0 #88 [V8] len=3D2: b'0 '
>=A0=A0=A0=A0=A0=A0=A0 #8d [V9] len=3D2: b'0 '
>=A0=A0=A0=A0=A0=A0=A0 #92 [VA] len=3D2: b'0 '
>=A0=A0=A0=A0=A0=A0=A0 #97 [RV] len=3D80: b's\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00'...
>=A0 0d00 Large item 252 bytes; name 0x11
>=A0=A0=A0=A0=A0=A0=A0 #00 [VC] len=3D16: b'122310_1222 dp=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #13 [VD] len=3D16: b'610-0001-00 H1\x00\x00'
>=A0=A0=A0=A0=A0=A0=A0 #26 [VE] len=3D16: b'122310_1353 fp=A0 '
>=A0=A0=A0=A0=A0=A0=A0 #39 [VF] len=3D16: b'610-0001-00 H1\x00\x00'
>=A0=A0=A0=A0=A0=A0=A0 #4c [RW] len=3D173: b'\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00'...
>=A0 0dff Small item 0 bytes; name 0xf End Tag
>=20
> 10f3 Large item 13315 bytes; name 0x62
> !!! unknown item name 98: b'\xd0\x03\x00@`\x0c\x08\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00'
> =3D=3D=3D
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to pci/misc for v4.10, thanks, Alexey!

> ---
> Changes:
> v3:
> * unconditionally set VPD size to 8192
>=20
> v2:
> * used pci_set_vpd_size() helper
> * added explicit list of IDs from cxgb3 driver
> * added a note in the commit log why the quirk is not in cxgb3
> ---
>=A0 drivers/pci/quirks.c | 19 +++++++++++++++++++
>=A0 1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c232729..bc7c541 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3255,6 +3255,25 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_D=
EVICE_ID_INTEL_CACTUS_RIDGE_4C
>=A0 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_=
RIDGE,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 quir=
k_thunderbolt_hotplug_msi);
>=A0=20
> +static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
> +{
> +=A0=A0=A0=A0 pci_set_vpd_size(dev, 8192);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_exten=
d_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_exten=
d_vpd);
> +
>=A0 #ifdef CONFIG_ACPI
>=A0 /*
>=A0=A0 * Apple: Shutdown Cactus Ridge Thunderbolt controller.
> --=20
> 2.5.0.rc3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

  I'm sorry that I missed this when it went by.  Thanks for the work.

  I'm unfamiliar with the vfio-pci driver.  Would a similar quirk be
required for the adapters managed by cxgb4?  We've modified cxgb4
to call pci_set_vpd_size(), but you indicate that the "vfio-pci" driver
can try to access the PCI Device VPD area without a driver loaded.

Casey=
