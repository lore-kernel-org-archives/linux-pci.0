Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:49820 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbaGIA5k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Jul 2014 20:57:40 -0400
Date: Wed, 9 Jul 2014 10:57:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, jg1.han@samsung.com,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: PCI: designware: Use IS_ENABLED()
Message-ID: <20140709105731.1b3e2bbe@canb.auug.org.au>
In-Reply-To: <1403104613-9867-1-git-send-email-festevam@gmail.com>
References: <1403104613-9867-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//CoW=X6kusitOXWo57OopAs"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_//CoW=X6kusitOXWo57OopAs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

[I noticed this in the pci tree in linux-next this morning]

On Wed, 18 Jun 2014 12:16:53 -0300 Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> We can get rid of the 'ifdef' by using the IS_ENABLED() macro.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Mohit Kumar <mohit.kumar@st.com>
>=20
> ---
> drivers/pci/host/pcie-designware.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-d=
esignware.c
> index 1eaf4df3..dc842fd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> =20
>  	pci_common_init_dev(pp->dev, &dw_pci);
>  	pci_assign_unassigned_resources();
> -#ifdef CONFIG_PCI_DOMAINS
> -	dw_pci.domain++;
> -#endif
> +	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
> +		dw_pci.domain++;
> =20
>  	return 0;
>  }

Will this actually compile if CONFIG_PCI_DOMAINS is disabled, since the
"domains" field of dw_pci does not even exist in that case (it is
ifdeffed out in arch/arm/include/asm/mach/pci.h)?  Even if it works
with newer compilers, will it work with older ones i.e. how new does
the compiler have to be to elide the code before noticing that
"domains" does not exist?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_//CoW=X6kusitOXWo57OopAs
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJTvJOAAAoJEMDTa8Ir7ZwVo8UQAI74s0GS4zgDzN/Z4UerhhId
4KILzBigEkBzKojW63eRf53foZ4zg0qzojMF4+QYevFOf8BKO3SNHAwHqQXunHEF
k9/tsPcUv5dAt50yl2Q5uVkgOezpxka/TIt7QMjYCrRobt/3plcCUYWcM/4mZUc2
acui1dSSFLCspYFx5TLkV0+8wcyVdy7v/5BqJp07xAA9qMiD0v2XMK0sPkmHk6cc
i1aOmCago6DEO5ZULJA07yeXnOVDuyp3WKLCT+V3tHu70hHTfwCUuHjsfj623Vtn
LOzO6a/Z12mezS5WvxU8mBp75yVygZFlS9wzwjW6I3GMaDaHWku+pF6CO95dlY0K
9pSoo3eUVZVdPf+ukRNuSV1G3dXlsI2NsSLCMfSSIOK9Z/KIkKvR7jHImRshPDNV
ypd2r4eLA+nWgp8by2B+oEZFRLiKBwpaiAnkNyoOqmA+mm0vCijqesl5PTMpyxBY
QVXKI63pFA8jDCwwup6W0Yku3g+O7VRYMhd9ut2ADAu95aoj+t6vOIKOkiC9Y+Rr
OJjAlsi0eLbH1ngzm9Ll1fNjCSAHJ2Ck+moGFC4p24W5dtlNmudvuujalMkc/44C
mgU86EB59g7xp1twXZXL8qF0prDadB6K3uTc61RhMj7Ajooyw/2X0YLSe8f5sQR8
si6MvUAjj+jnof4qz+sf
=6h/7
-----END PGP SIGNATURE-----

--Sig_//CoW=X6kusitOXWo57OopAs--
