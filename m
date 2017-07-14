Return-Path: <SRS0=gi0B=6R=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=gi0B=6R=redhat.com=alex.williamson@kernel.org>
Date: Fri, 14 Jul 2017 08:43:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas
 <helgaas@kernel.org>, Daniel Axtens <dja@axtens.net>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Liuxinliang
 (Matthew Liu)" <z.liuxinliang@hisilicon.com>, Rongrong Zou
 <zourongrong@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
Message-ID: <20170714084318.6042e8ad@w520.home>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
References: <20170712050811.3620-1-dja@axtens.net>
	<20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
	<EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
	<20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
	<20170713151146.53e9644c@w520.home>
	<1499980882.2865.65.camel@kernel.crashing.org>
	<EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, 14 Jul 2017 12:26:05 +0000
Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:

> Hi Ben, Alex
>=20
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: 13 July 2017 22:21
> > To: Alex Williamson; Bjorn Helgaas
> > Cc: Gabriele Paoloni; Daniel Axtens; linux-pci@vger.kernel.org;
> > Liuxinliang (Matthew Liu); Rongrong Zou; Catalin Marinas; Will Deacon;
> > linux-arm-kernel@lists.infradead.org; David Airlie; Daniel Vetter
> > Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a
> > misbehaving HiSilicon bridge
> >=20
> > On Thu, 2017-07-13 at 15:11 -0600, Alex Williamson wrote: =20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > -=C2=A0=C2=A0=C2=A0if (vga_default =3D=3D NULL &&
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((vgadev->owns & VGA_RSRC_L=
EGACY_MASK) =3D=3D =20
> > VGA_RSRC_LEGACY_MASK)) { =20
> > > > > +=C2=A0=C2=A0=C2=A0if (vga_default =3D=3D NULL) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0vgaarb_info(&pdev->dev, "setting as boot VGA =20
> > device\n"); =20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0vga_set_default_device(pdev);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} =20
> > >
> > >
> > > "Legacy" is the breadcrumb we use to try to pick the same device for
> > > default VGA as the system firmware used as the boot VGA.=C2=A0 There =
can =20
> > be =20
> > > multiple VGA devices in the system, the change above would simply =20
> > make =20
> > > the first discovered device be the default VGA.=C2=A0 That would brea=
k =20
> > many, =20
> > > many systems.=C2=A0 If legacy VGA ranges mean nothing on ARM64, then =
=20
> > follow =20
> > > the powerpc lead and make an arch quirk that simply selects the first
> > > enabled VGA device as the default.=C2=A0 VGA routing is part of the P=
CI =20
> > spec =20
> > > though, so the default of selecting the device with routing enabled
> > > makes sense.=C2=A0 Thanks, =20
> >=20
> > "Legacy" there iirc also means that it has decoding enabled at boot. If
> > you pick the first one you may pick a device that doesn't and hasn't
> > been initialized by any driver (good old BIOS-initialized text mode). =
=20
>=20
> Right so effectively if there is a legacy dev we should pick that up;
> however what about the following code:
>=20
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 92f1452..ab3ad9a 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -1424,6 +1424,14 @@ static int __init vga_arb_device_init(void)
> =20
>  	list_for_each_entry(vgadev, &vga_list, list) {
>  		struct device *dev =3D &vgadev->pdev->dev;
> +
> +		/* if no legacy device has been set as default VGA
> +		 * device, just pick up the first one in the list */
> +		if (vga_default =3D=3D NULL) {
> +			vgaarb_info(dev, "setting as boot VGA device\n");
> +			vga_set_default_device(vgadev->pdev);
> +		}
> +
>  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  		/*
>  		 * Override vga_arbiter_add_pci_device()'s I/O based detection=20
>=20
> Above after we have filled the list of VGA devices by iterating over all
> PCI devices we check if no legacy one has been set as default VGA device
> yet: therefore we set the first VGA device in the list as default one...
>=20
> Do you think it would work?

I'd suggest at least looking for an enabled device as fixup_vga() does,
perhaps that would even be enough to remove that arch quirk.  Thanks,

Alex
