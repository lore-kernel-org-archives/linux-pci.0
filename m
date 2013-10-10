Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36180 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076Ab3JJMpt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 08:45:49 -0400
Message-ID: <1381409146.2788.116.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH -v2] PCI: Avoid initialize MSI/MSIX if device power
 state != PCI_D0
From: Ben Hutchings <ben@decadent.org.uk>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>
Date: Thu, 10 Oct 2013 13:45:46 +0100
In-Reply-To: <1381408907-11724-1-git-send-email-wangyijing@huawei.com>
References: <1381408907-11724-1-git-send-email-wangyijing@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4xwHkuiIyoieXllTkiVy"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-4xwHkuiIyoieXllTkiVy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2013-10-10 at 20:41 +0800, Yijing Wang wrote:
> Currently, if device power state !=3D PCI_D0, we still initialize
> device MSI/MSIX, but we won't write the MSI message to device
> MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
> registers properly, but pci_enable_msi() or pci_enable_msix()
> return success, and even these registers will never be updated later.
> So I think it should return error if device power state !=3D PCI_D0.
>=20
> ---
>=20
> v1->v2: keep __write_msi_msg() function device power state statement,
> 	    because Ben Hutchings point out this function may be called
> 		during device in D3 state to set irq affinity. We should not
> 		touch that.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

S-o-b needs to be above the first '---' but perhaps Bjorn can fix that
up before applying.

Acked-by: Ben Hutchings <bhutchings@solarflare.com>

> ---
>  drivers/pci/msi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..604265c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -831,7 +831,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigne=
d int nvec)
>  	int status, maxvec;
>  	u16 msgctl;
> =20
> -	if (!dev->msi_cap)
> +	if (!dev->msi_cap || dev->current_state !=3D PCI_D0)
>  		return -EINVAL;
> =20
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
> @@ -862,7 +862,7 @@ int pci_enable_msi_block_auto(struct pci_dev *dev, un=
signed int *maxvec)
>  	int ret, nvec;
>  	u16 msgctl;
> =20
> -	if (!dev->msi_cap)
> +	if (!dev->msi_cap || dev->current_state !=3D PCI_D0)
>  		return -EINVAL;
> =20
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
> @@ -955,7 +955,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_=
entry *entries, int nvec)
>  	int status, nr_entries;
>  	int i, j;
> =20
> -	if (!entries || !dev->msix_cap)
> +	if (!entries || !dev->msix_cap || dev->current_state !=3D PCI_D0)
>  		return -EINVAL;
> =20
>  	status =3D pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);

--=20
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson

--=-4xwHkuiIyoieXllTkiVy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUlaheue/yOyVhhEJAQpilw/9HUA4VwcfhiW+defMU/0RS26dRcmH7zAb
WbPALvlUdmF08n61PZNK8q1AD/0trFEM/GHejUMMx9+pjaivenXcKxpnFNUyiFNK
EfmMLbOr8yC1AXFqucNfTZj6guV9sgFuHgH8z4VVyVfBbvL7neuohjBBQMQjb6Sm
/h5e+qmQ5ydCWffRWhRPpcUKFzp/Rs5npVH7BVeuPrurdEHCNJBVBIJXzGFeXpEW
Lt+ydRmMaYvlF0rZQ0Zr/jXuhYcP5JvNjBEFrqVLrHBR3tDD5/MbnrOe+f2TAQPY
xyEkIh0hZ+86u1FrRqzC1hggq8Da7ZQed7z0O0Aid79jBlNnIwk04nS5djMUe9ZT
svWl9yqZrLqp3tkAIcKibtZej3DZJv3y5n/VfSkgOQ2vuo2TA4gsqamYcG79+f6L
xC2n+XJsQX7O1KIbxUwgAYqWIEcIOq775Fy6CGq4jZCugaDpDZHmY/2bNPybKLsO
QJnXlnjAIZ++BpfOH3yQRD0oYTeuOo8uzNyNmiBYqp/seHJY8gnkI/MkMQjMJALq
6XX27RP9A2D+a0X4h7EvdMWVjf+DQgawVhXRGe1f1AiGWXRep6dAXG6eEANVppWX
9wFWlXiZgGptvp+QaluSY0A2w8PLJomGQJt+7LTFaWH+XtY9TxRFch/6FC0wVdtg
CudsUmO+NfY=
=ZTU7
-----END PGP SIGNATURE-----

--=-4xwHkuiIyoieXllTkiVy--
