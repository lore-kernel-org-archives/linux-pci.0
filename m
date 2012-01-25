Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:37936 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751419Ab2AYVIm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2012 16:08:42 -0500
Date: Wed, 25 Jan 2012 13:08:36 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/PCI: build amd_bus.o only when
 CONFIG_AMD_NB=y
Message-ID: <20120125130836.22450527@jbarnes-desktop>
In-Reply-To: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com>
References: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/M0rohDEMJfmL6usVLFDp4.K"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/M0rohDEMJfmL6usVLFDp4.K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Jan 2012 15:43:49 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> We only need amd_bus.o for AMD systems with PCI.  arch/x86/pci/Makefile
> already depends on CONFIG_PCI=3Dy, so this patch just adds the dependency
> on CONFIG_AMD_NB.
>=20
> CC: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/pci/Makefile |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
> index 6b8759f..d24d3da 100644
> --- a/arch/x86/pci/Makefile
> +++ b/arch/x86/pci/Makefile
> @@ -18,8 +18,9 @@ obj-$(CONFIG_X86_NUMAQ)		+=3D numaq_32.o
>  obj-$(CONFIG_X86_MRST)		+=3D mrst.o
> =20
>  obj-y				+=3D common.o early.o
> -obj-y				+=3D amd_bus.o bus_numa.o
> +obj-y				+=3D bus_numa.o
> =20
> +obj-$(CONFIG_AMD_NB)		+=3D amd_bus.o
>  obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+=3D broadcom_bus.o
> =20
>  ifeq ($(CONFIG_PCI_DEBUG),y)

Arg sorry guys I've been totally swamped since sending in the pull
req.  I'll do a review & merge pass on the outstanding stuff tomorrow.

Thanks for your patience.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/M0rohDEMJfmL6usVLFDp4.K
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPIG9UAAoJEIEoDkX4Qk9hkKEQAJti2NLFZVADpp6X0JFfHQgA
EYUIJFK8itsm+kLqZ+pLNrxUJIkxYenoDtNkHxcUcMtGdUjfpR3lquY83VflLt2+
RE96F6+XpHllyodlPHDAjJuqtbvbhq+PxFRkZnVdpt/zkCtzjSkmSqd0dzURP4sC
nHrtFtfcORaHTl2YzPqZauPkYCsDUlt6VaNWjeYrrQGoXzoz2/GoP7NEfkuZ45hN
K03je8tfGRJkm2tCpK1ITbrz2EJVKcFZH3yX6lJC8OkfcL/dKd54ouEGDKau6VbY
64BmEtaWae5Q07SxhecJ1lXhRuil6by6jICIxb6Sjc61DN6o8FcX/akOoIEt955j
ycFP/IOwN/CkMQXmdk9BdvSsXadE7ukBj83cqDeNTvHF/iVXwlVbmChsIsuGjOK4
wWT5FWQaThocrcV/rDlNqDjiY15lch/a1qOLb6kBepia5REkHd18X1PNSoqVJD7t
QYBQXJGODQV0URYfZcOsty8yRQNDILuj6KmGOjTFFhnJklsC1xCiKjb3KUb9cq9C
HOwmwej+AGpH8JMZyVAsYLzctOikcWXqeDMT3Hn5ocgWaiSNvl0/PRx9nEimnbzD
pPYwUWFlrSzk4d39LkdpOPsXb4vg1ocZyD0jivtsWfPrmY8an0g0vV+BDFgFVuk2
Qdj8hGQk0dg7RbXBjOBn
=3CmU
-----END PGP SIGNATURE-----

--Sig_/M0rohDEMJfmL6usVLFDp4.K--
