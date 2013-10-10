Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36111 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754686Ab3JJMP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 08:15:27 -0400
Message-ID: <1381407317.2788.102.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH] PCI: Avoid initialize MSI/MSIX if device power state !=
 PCI_D0
From: Ben Hutchings <ben@decadent.org.uk>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>
Date: Thu, 10 Oct 2013 13:15:17 +0100
In-Reply-To: <1381393916-12268-1-git-send-email-wangyijing@huawei.com>
References: <1381393916-12268-1-git-send-email-wangyijing@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FB6cqArrSBqQmG37ZI1k"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-FB6cqArrSBqQmG37ZI1k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2013-10-10 at 16:31 +0800, Yijing Wang wrote:
> Currently, if device power state !=3D PCI_D0, we still initialize
> device MSI/MSIX, but we won't write the MSI message to device
> MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
> registers properly, but pci_enable_msi() or pci_enable_msix()
> return success, and even these registers will never be updated later.
> So I think it should return error if device power state !=3D PCI_D0.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d5f90d6..eb502f6 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -308,9 +308,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_=
msg *msg)
> =20
>  void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
> -	if (entry->dev->current_state !=3D PCI_D0) {
> -		/* Don't touch the hardware now */
> -	} else if (entry->msi_attrib.is_msix) {
> +	if (entry->msi_attrib.is_msix) {
[...]

As I said before, this function was being called to change IRQ
affinities during suspend/resume at a point when most PCI devices were
in D3.  If that is no longer the case then this change is probably OK.
Otherwise you should not touch this function.

Ben.

--=20
Ben Hutchings
A free society is one where it is safe to be unpopular. - Adlai Stevenson

--=-FB6cqArrSBqQmG37ZI1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUlaaVee/yOyVhhEJAQoScxAArnL+XkLc8/hfv/E0pVxlYLaTCQi/K1dI
dOS/pd0twQfMx4V7FoeD2qbfHY22Myv/KZ5W3djgf3eJUYgC93+M1CDpg9Wqw96Z
qEtz7edhs4MDwjbX6BUFnAYpocqhY9RXYvMTGkHYvtOew3Ld/NFV2GlCNFB75Wx9
xg8ZOuSMw6xBmD3JOSonp49C0Ro3rXmEY38bj4nlUVDUGfIzfPCcPMu5m0ZcXkBC
37cHTMuUfoRTMXtLk+ZNvBSjjRo4ea7CEDpXXNIPxAEYG8aYhdlvEjRUBhHeCAKn
7A4Np6mTf0q59NDDrmS8Gdiyp7aQdOj9kHl6IFqP5hL6r+CoFKuxOcaEBh3fmXTw
2tkIcM5yveMK3W7wNuufyvAso/Bh/L4KG5nmsGNUSmdin1rfeyEUjFqjcqUrjg5I
DB3HoRe0nyPFbuVkhmukbhBQAIgafQKY6P1PakfTv4xVScdjTMQV6X+Gb4T5hEOH
78gsgeAEJb4hWg2tDl/XNuKXd4dQE3Hu6tGFjX+Sv7x5/rUqD+pgSk5uFLU/YrpK
Ir0mACaHBdxgdLuZFLX6S7hiG5HIRsYLQ7L5MqsQ8kPHNdNIaznhnHueOXLB7+QG
85lJ6rYyFyQFu1ioRV5nADSOQqLns0hDIYqbJm5ba52F3VckmEfALPWBi5MgR72w
JyzAvezZiSc=
=ErBv
-----END PGP SIGNATURE-----

--=-FB6cqArrSBqQmG37ZI1k--
