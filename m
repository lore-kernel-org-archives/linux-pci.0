Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbeIEUs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 16:48:28 -0400
Message-ID: <b2120f18825daa4a239ffba0f84a5a5909c1cc7b.camel@redhat.com>
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
From: Doug Ledford <dledford@redhat.com>
To: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date: Wed, 05 Sep 2018 12:17:31 -0400
In-Reply-To: <20180905160805.5680-3-okaya@kernel.org>
References: <20180905160805.5680-1-okaya@kernel.org>
         <20180905160805.5680-3-okaya@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CR5DpawcNvjqx0eQtLq2"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-CR5DpawcNvjqx0eQtLq2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-09-05 at 16:08 +0000, Sinan Kaya wrote:
> pci_reset_bus() is being called from the probe context and causes
> a deadlock since pci_reset_bus() also tries to obtain kernel lock.
>=20
> Use __pci_reset_function_locked() that provides locking guarantees.
>=20
> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200985
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Acked-by: Doug Ledford <dledford@redhat.com>

> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hf=
i1/pcie.c
> index eec83757d55f..13162289b748 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -900,7 +900,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>  	 * delay after a reset is required.  Per spec requirements,
>  	 * the link is either working or not after that point.
>  	 */
> -	return pci_reset_bus(dev);
> +	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
>  }
> =20
>  /*

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-CR5DpawcNvjqx0eQtLq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAluQAZsACgkQuCajMw5X
L9300w//ehn0MjJ1csiTvcJ0dOvZ4TGB1aRv6Ppd6W+0FN9PtK0MXUx4h4pvQ4cP
XJL6WjVs8dGShTYrl/NMPwHQmRRJt5HGP2TNyamDC+/1T8HEl4sHv3OiE1YzkpjB
eFnOT29y51Ay/PT5vJIHuta4/oPWIgjRuH5Vyxj0z14L0nH9bpCqsi9iuIIdCWzK
BBnlkodlSQ+UzhdthOZusS2smTJEvNSnsRWpiuDVOT7++fBPT65VsZEEx3Dswv7/
FrO1a71wAZXT2wwvbHSy7/Q3BHnspnEqNvFrTS6/q0/Bl0S87CE2J2CAY/ubE3T8
pJZRSAvrbZL965+rK8BLAT9eDveZ5uJGXS3hmC3xlne0vPOwat+4j4rz0IUzwdtd
7GWtd9XEx52hezUbD/wSY5gdETa+Y9W5RwwmmjfAvP3+vHC+lrzfIcKEonPwX/fq
uOD33e4DJOcqYDJ8KX+ZU1WR8+opMxbXxW9k/Jw6y4OoE0tz/QwGUurasaeYx9q2
pljgMICrkc3aC5kk1GWSRZXnSjwjiFUOa5yIyybhLXmdqmzGmzEYF4iLvp4ypkrm
R8bgs7iGRBbflRg2NZVop1l3olYksi12Ef0YCFb5Rl76ZZ84/XCc3gDo5fO5UYrM
nQfpWpMxgEB8AbLOhBrdO6gLygwqTCSNDgVyGnQfw6uSr8jcowk=
=imxV
-----END PGP SIGNATURE-----

--=-CR5DpawcNvjqx0eQtLq2--
