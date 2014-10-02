Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:52446 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbaJBBsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 21:48:54 -0400
Date: Thu, 2 Oct 2014 11:48:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@ozlabs.org,
	Dave Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
	Anton Blanchard <anton@au1.ibm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/4] pci/msi: Move "no_64bit_msi" flag from powerpc
 to generic pci_dev
Message-ID: <20141002114847.2967dbea@canb.auug.org.au>
In-Reply-To: <1412210012.4285.250.camel@pasglop>
References: <1412048401.4285.128.camel@pasglop>
	<CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
	<CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
	<1412108504.4285.155.camel@pasglop>
	<CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
	<1412110946.4285.158.camel@pasglop>
	<CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
	<1412112324.4285.160.camel@pasglop>
	<1412210012.4285.250.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tSa/.JO.llxM4bktpSnyOZd"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/tSa/.JO.llxM4bktpSnyOZd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 02 Oct 2014 10:33:32 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -269,10 +269,7 @@ EXPORT_SYMBOL(pcibus_to_node);
> =20
>  static void quirk_radeon_32bit_msi(struct pci_dev *dev)
>  {
> -	struct pci_dn *pdn =3D pci_get_pdn(dev);
> -
> -	if (pdn)
> -		pdn->force_32bit_msi =3D true;
> +	dev->no_64bit_msi =3D true;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_ms=
i);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_ms=
i);
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -331,6 +331,7 @@ struct pci_dev {
>  	unsigned int	is_added:1;
>  	unsigned int	is_busmaster:1; /* device is busmaster */
>  	unsigned int	no_msi:1;	/* device may not use msi */
> +	unsigned int    no_64bit_msi:1;	/* Device has broken 64-bit MSIs */
>  	unsigned int	block_cfg_access:1;	/* config space access is blocked */
>  	unsigned int	broken_parity_status:1;	/* Device generates false positive=
 parity */
>  	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting varia=
nt */

You really should not be assigning "true" to a single bit field ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/tSa/.JO.llxM4bktpSnyOZd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJULK8DAAoJEMDTa8Ir7ZwVPT0P/iowtMbEPYPvJvhLDskGeILd
SDKakktLmhqITuoBbaJvWhv6/pcGvawXCTxxq3NxxIdwNmYGKWXC/oBtAATC9hIR
EzmBw+gRYYb7rRhPOemRBGg0y7mFuyeD7oeo/H/CQYzviDSdtZNn9O01XqPx/bxz
5Zc5WvJMbfRddSgRoOuWkFLLPoPzLE7/kf3JONiYNoHUuhOx1OQEuVGve4eupt46
pdQHqLl/vIOM26uFmCAIhY80dinPXozrl7CMTcRfg2EZ3ggheoQvJXlQVj2YRnPH
ALBQ35UBImi/H8nol7JmPo3b3l2EzJ3v7/HTGrON43F67zDYFYXjEYaxbLNBZJhW
yW7VeL55GuTxPF6AZnZkRhq0XBwC9FaPwvHoTfjTjSVE4mYydwYn1W5jrG1PJXsU
HHUQB+T7irdQeWvOJ6YxA40wKUNXl7sjIO3k8bXb0omytIN67ft9JRBJMWh/jHaE
XDWLscAvzQ/y0ULzz/W43FfbkDcIOUofOqtgVkk0UMJIo3ZVm91J5kQs93d2gqiP
/0pJsUOfNKqFbyFsZGj/kSmucRy8jQ7Ulivehp3DkLIPJin63W9RcjrBAQY0pl/I
Ah0j6TkDML8sF7psiKYEEInyaZH8oRzmaaaUC4i6ULdbb0JtRlZ30Z3G56Ckn5bD
1YWgABKX/7JnpXiEqNKp
=Q0Fr
-----END PGP SIGNATURE-----

--Sig_/tSa/.JO.llxM4bktpSnyOZd--
