Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51547 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbaDQULo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 16:11:44 -0400
Message-ID: <53503577.1020809@pengutronix.de>
Date: Thu, 17 Apr 2014 22:11:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfgang Grandegger <wg@grandegger.com>
CC: Alexander Gordeev <agordeev@redhat.com>, linux-can@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Coverity CID 712278: c_can_pci_probe() doesn't check pci_enable_msi()
 return value
References: <CAErSpo4hujoq8Ni7sSrNQv61rf4Xz4s3GjYxNQR6TDLDm0N-Jw@mail.gmail.com>
In-Reply-To: <CAErSpo4hujoq8Ni7sSrNQv61rf4Xz4s3GjYxNQR6TDLDm0N-Jw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HtBa9ro3lce0XPLNlUrHVoSiMwPqoFTME"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HtBa9ro3lce0XPLNlUrHVoSiMwPqoFTME
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2014 06:53 PM, Bjorn Helgaas wrote:
> Coverity complains that c_can_pci_probe() calls pci_enable_msi()
> without checking the result:
>=20
>=20
> CID 712278 (#1 of 1): Unchecked return value (CHECKED_RETURN)
> 3. check_return: Calling pci_enable_msi_block without checking return
> value (as is done elsewhere 88 out of 105 times).
>  88        pci_enable_msi(pdev);
>=20
> This is CID 712278.

Thanks, I've applied Wolfgang's patch ("can: c_can_pci: enable PCI bus
master only for MSI"), which fixes this problem.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HtBa9ro3lce0XPLNlUrHVoSiMwPqoFTME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQNXcACgkQjTAFq1RaXHOkrACbBXeshhOVEv3QMHwTO5hdmznq
3GcAn3jNNsZiA7G8y7PjpUet+lLZBO2M
=d69i
-----END PGP SIGNATURE-----

--HtBa9ro3lce0XPLNlUrHVoSiMwPqoFTME--
