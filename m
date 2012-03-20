Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:52206 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752067Ab2CTRmm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 13:42:42 -0400
Date: Tue, 20 Mar 2012 10:42:21 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI core support for bus-to-resource offsets
 (fixes)
Message-ID: <20120320104221.5104ba3a@jbarnes-desktop>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3vgGHNYG95f3Q8HskCmjztN"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/3vgGHNYG95f3Q8HskCmjztN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Mar 2012 17:47:53 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> This is a set of incremental fixes related to my recent "remove device
> resource fixups" series.
>=20
> These apply to 63ab387ca0, the current head of Jesse's linux-next branch.
> The result is the same as the updated patches I posted here:
>=20
>   git://github.com/bjorn-helgaas/linux.git pci-probe_only-and-offset-v3-5=
eb2c1f
>=20
> except that I removed the EN1K bridge I/O window rework, since it's not
> necessary for the merge window.

Finally applied to -next, thanks Bjorn.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/3vgGHNYG95f3Q8HskCmjztN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaMF9AAoJEIEoDkX4Qk9h1t8QALXQHqRoyKNQPb1BVb3Latm5
ICteTa8XYaIun6tsxDATXarsczZXgISeMKyf4Ig1NBzJ+7iV6sIk7t8oaUJiPqAM
ioShh+39Fh4B8Si68AsXUpX0qKasiR6X4+pIGeqTHJ7ZNRMnVbICXhTFdLz4s153
gqwapIaKrRXBBvLATz2oLUJ6gul/QjPhkJwfkf9ZYtKw7QC3v3L63ZO51bNgAhyx
mBPv1CjiDeKyNUzdtFr31/x2y0I59FcBXKFNaHJ6ygasNQ4Jd0uNKm0Z4Mub+pmP
jFoOBwwATd0njwHFzfSemGhswcPMa07k/dK1B4eMUCvWCRJStnjSITB29DGFhe6Z
tbUB2myGYB94CAOvcikAsGsjcJM/DmVZC1SwkEbY28LAgGRZNXF8RBC4uYrfD7LF
/px11VC7cC/4ZSv7HTBjOR8IuzgjH+mCfV6EArvxzJn07G3wf7ZpjczQ1FMdXNBF
rfmezVxo7cBhfFAKHL0rRP9tKekvC/DcLFav6c/SSvIUYqGC2qzWE3gUC8Ftxzht
Kj+oMTMuOpYJTa8KJ51JtHrdT9LjPZ0gqjczQ7+gd5IZ2Ou5hgEtkJUuFPJ3QLIj
1Xnvv6HUaBkRJqvFqfxPVW/DkmsgdB8ObfiDenAWyQv7CXjYJf9LR2squ60/Bp2+
DFnG7fgAKr/Ua1Ip80mU
=eqUo
-----END PGP SIGNATURE-----

--Sig_/3vgGHNYG95f3Q8HskCmjztN--
