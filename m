Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:54541 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751140Ab1LESVw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:21:52 -0500
Date: Mon, 5 Dec 2011 10:24:23 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: PRI/PASSID cleanup and fix
Message-ID: <20111205102423.476b7ce4@jbarnes-desktop>
In-Reply-To: <20111128104055.GI11876@amd.com>
References: <20111111170319.32668.48479.stgit@bling.home>
	<20111123104705.GC11876@amd.com>
	<20111123144510.56ff6d1d@jbarnes-desktop>
	<20111128104055.GI11876@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/T5RUGONncNLHnK9XpBg_vvN"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/T5RUGONncNLHnK9XpBg_vvN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Nov 2011 11:40:55 +0100
Joerg Roedel <joerg.roedel@amd.com> wrote:

> On Wed, Nov 23, 2011 at 02:45:10PM -0800, Jesse Barnes wrote:
> > On Wed, 23 Nov 2011 11:47:05 +0100
> > Joerg Roedel <joerg.roedel@amd.com> wrote:
> >=20
> > > On Fri, Nov 11, 2011 at 10:06:23AM -0700, Alex Williamson wrote:
> > > > Alex Williamson (2):
> > > >       PCI: More PRI/PASID cleanup
> > > >       PCI: Enable is not exposed as a PASID capability
> > >=20
> > > For both:
> > >=20
> > > Reviewed-by: Joerg Roedel <joerg.roedel@amd.com>
> > > Tested-by: Joerg Roedel <joerg.roedel@amd.com>
> >=20
> > Ok, thanks guys.  I'll queue these up after Thanksgiving.
> >=20
> > --=20
> > Jesse Barnes, Intel Open Source Technology Center
>=20
> Great. Can you provide a seperate branch with these changes that I can
> pull into my tree, please? I have upcoming changes that will conflict
> with these patches. And I would like to solve them before merge.

Ok, I pushed these to a 'pri-changes' branch, which is a superset of my
current linux-next branch.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/T5RUGONncNLHnK9XpBg_vvN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3QxXAAoJEIEoDkX4Qk9hBnwQAIiUBlknLHytvLdJAQfQXxF/
ikH239OpEpTYzaTxWIo7WI0MRuKOtfroMtZUXG/u0lo+vvF1d7bx9MfPdpSGUpzj
VQ18/kTLBnaqmKAeSX4rCaUI2bc5w00dJn0+UCW1tdDxJbYpwar1keNLxRSEULvJ
2Dj5Uo3zVtqe8Je3To8/6uAxq5vP0R7vm3DEo4MGhczT8Nr0vALk1WnZxSJRUK9M
CLIE6mHrkEQeAMkvbh7SW2vjSQIzPATiBjPg/cf0GVaTXv8EIuvvadFOaqlr3Ga4
qdMc866T5RPp8FigplDzf0UdgVd/c8DWlndz8glIBjYPaPqI5GsrsFIZMA+0SLVn
Kd/QyOjgN8ah19bNfiTG3pJ4ISN6aVPnvx4Nqkg5OFAvUMxbOO+CWcsDGVUmMnbx
E23GpIW4PRPw4gzBc6CWqt+oRz7/ZvkC2oyr8ue/ioXKMszI/EleYJm6fwkkg+ey
05FgYMiKLonpgG/XOZEZy6cTGVsTyJk3I6muQ62rtoG+Q/jYKFWKZa0szCtKH31N
D08uq1uMbkFgTHp2Rq4FkGuO3n2CrRmdFLxLwPImUJm8Uq7Rju/EpMkscoJzYEWI
ns7dmr1ZxEO8ECdsQcr50uxRNJTr8J6jVKx1yMO1lTGxCDXW0iKq/ixLPvJVP4J/
eqzAcVxxKFVYDHWXfVTE
=a5zJ
-----END PGP SIGNATURE-----

--Sig_/T5RUGONncNLHnK9XpBg_vvN--
