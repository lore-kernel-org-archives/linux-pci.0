Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:58769 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdFFIDD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2017 04:03:03 -0400
From: <Narendra.K@dell.com>
Cc: <x86@kernel.org>, <linux-pci@vger.kernel.org>,
        <Jordan.Hargrave@dell.com>, <Shyam.Iyer@dell.com>,
        <bhelgaas@google.com>, <Narendra.K@dell.com>
To: <jdelvare@suse.de>
Subject: RE: dmi type 0xB1 record - unknown flag
Date: Tue, 6 Jun 2017 08:02:40 +0000
Message-ID: <1d8d53bdb9e94e7d8ec89a79e99d4cdd@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
 <20170602161311.27eab72d@endymion>
In-Reply-To: <20170602161311.27eab72d@endymion>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jean Delvare [mailto:jdelvare@suse.de]
> Sent: Friday, June 2, 2017 7:43 PM
> To: K, Narendra <Narendra_K@Dell.com>
> Cc: x86@kernel.org; linux-pci@vger.kernel.org; Hargrave, Jordan
> <Jordan_Hargrave@Dell.com>; Iyer, Shyam <Shyam_Iyer@Dell.com>;
> bhelgaas@google.com
> Subject: Re: dmi type 0xB1 record - unknown flag

[...]
> > The value 0x00 is not a valid value. When the flag is 0x00, the sort me=
thod
> will be the default that is decided by the kernel.
>=20
> How can it be invalid? I have DMI dumps of several Dell systems with a ty=
pe
> 0xB1 DMI structure, with value 0x00 for these bits. If Dell ships such sy=
stems,
> then this is valid by definition.
>=20
> > There is no additional handling required for such a system.
>=20
> I don't understand the complexity of the code. There are 4 possible value=
s
> for these bits, the code treats all of them differently:
> * 0x01, you set smbios_type_b1_flag to 1 and this later triggers a call
>   to set_bf_sort().
> * 0x02, you set smbios_type_b1_flag to 2 but this has no effect.
> * 0x00, you print a rather cryptic info message which serves no purpose.
> * 0x03, you do nothing.
>=20
> On top of that, I can't see the value of the intermediate variable
> smbios_type_b1_flag. The only situations where it would make a difference
> is if multiple type 0xB1 structures with conflicting information were pre=
sent;
> but I don't think this is supposed to happen in the first place.
>=20
> Lastly I'm not sure why you continue processing the list of DMI matches,
> when smbios_type_b1_flag =3D=3D 1, and stop processing it if not.
> This seems needlessly inconsistent.
>=20
> I think the whole thing can be simplified like this:
>=20
> From: Jean Delvare <jdelvare@suse.de>
> Subject: x86/PCI: Simplify Dell DMI B1 quirk
>=20
> No need for such convoluted code, when all we need is to call one functio=
n in
> one specific case.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  arch/x86/pci/common.c |   27 +++++----------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
>=20
> --- linux-4.11.orig/arch/x86/pci/common.c	2017-05-01
> 04:47:48.000000000 +0200
> +++ linux-4.11/arch/x86/pci/common.c	2017-06-02 16:04:05.737889598 +0200
> @@ -24,7 +24,6 @@ unsigned int pci_probe =3D PCI_PROBE_BIOS
>=20
>  unsigned int pci_early_dump_regs;
>  static int pci_bf_sort;
> -static int smbios_type_b1_flag;
>  int pci_routeirq;
>  int noioapicquirk;
>  #ifdef CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
> @@ -197,34 +196,18 @@ static int __init set_bf_sort(const stru  static vo=
id
> __init read_dmi_type_b1(const struct dmi_header *dm,
>  				    void *private_data)
>  {
> -	u8 *d =3D (u8 *)dm + 4;
> +	u8 *data =3D (u8 *)dm + 4;
>=20
>  	if (dm->type !=3D 0xB1)
>  		return;
> -	switch (((*(u32 *)d) >> 9) & 0x03) {
> -	case 0x00:
> -		printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n");
> -		break;
> -	case 0x01: /* set pci=3Dbfsort */
> -		smbios_type_b1_flag =3D 1;
> -		break;
> -	case 0x02: /* do not set pci=3Dbfsort */
> -		smbios_type_b1_flag =3D 2;
> -		break;
> -	default:
> -		break;
> -	}
> +	if ((((*(u32 *)data) >> 9) & 0x03) =3D=3D 0x01)
> +		set_bf_sort((const struct dmi_system_id *)private_data);
>  }
>=20
>  static int __init find_sort_method(const struct dmi_system_id *d)  {
> -	dmi_walk(read_dmi_type_b1, NULL);
> -
> -	if (smbios_type_b1_flag =3D=3D 1) {
> -		set_bf_sort(d);
> -		return 0;
> -	}
> -	return -1;
> +	dmi_walk(read_dmi_type_b1, (void *)d);
> +	return 0;
>  }
>=20
>  /*
>=20
> What do you think?

Hi Jean,

Thank you for reviewing and providing feedback. We will look into this and =
provide feedback.

With regards,
Narendra K
