Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49031 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752572Ab2JIAXB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 20:23:01 -0400
Message-ID: <1349742167.6336.3.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [stable] PCI: acpiphp: check whether _ADR evaluation succeeded
From: Ben Hutchings <ben@decadent.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Date: Tue, 09 Oct 2012 01:22:47 +0100
In-Reply-To: <CAErSpo5WymA1qf_mL4F_VYeNt0Ed5EY0RHW4ts76DLbipLp8pQ@mail.gmail.com>
References: <1349643467.16173.148.camel@deadeye.wl.decadent.org.uk>
	 <20121008162830.GA1307@kroah.com>
	 <CAErSpo5WymA1qf_mL4F_VYeNt0Ed5EY0RHW4ts76DLbipLp8pQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5hJ4YfPHUCwgGohI2Vkk"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-5hJ4YfPHUCwgGohI2Vkk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-10-08 at 10:37 -0600, Bjorn Helgaas wrote:
> On Mon, Oct 8, 2012 at 10:28 AM, Greg KH <greg@kroah.com> wrote:
> > On Sun, Oct 07, 2012 at 09:57:47PM +0100, Ben Hutchings wrote:
> >> Based on <https://bugzilla.kernel.org/show_bug.cgi?id=3D46481>, the
> >> following commit should be cherry-picked for stable series < 3.6:
> >>
> >> commit dfb117b3e50c52c7b3416db4a4569224b8db80bb
> >> Author: Bjorn Helgaas <bhelgaas@google.com>
> >> Date:   Wed Jun 20 16:18:29 2012 -0600
> >>
> >>     PCI: acpiphp: check whether _ADR evaluation succeeded
> >>
> >> It applies cleanly to 3.2.y and presumably also to later stable
> >> branches.  I've attached a version that applies to 2.6.32.y and 3.0.y,
> >> and presumably also to the intermediate stable branches.  Only 3.2.y h=
as
> >> actually been tested with this, though.
> >
> > Thanks, now applied.
>=20
> Has anybody looked deeper to see exactly *how* this patch fixes the
> problem?  The original reports were oopses caused by dereferencing bad
> pointers in DRM, and it's not obvious to me how this patch is
> connected to those.

Oh, I completely missed the oops log.  Yes, it does look like there's
another more serious bug still to be fixed in 3.2.y (maybe in DRM, maybe
not).

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, about L-Space IRC channel #afp

--=-5hJ4YfPHUCwgGohI2Vkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUHNuV+e/yOyVhhEJAQpWPxAAxY2i2m0VEzPW1XI4nkQM/ucWID+WPS6O
i0UtDJmA3J3nrTIc6BWMpgiSrB1LE7l4oX+jHlRFX2csi/5K378hTAWVhHddZgRg
DmPGR1lrol0bTr/judpY7bl1U3SA8VE4hvS0pibmlTxmOAkDZjJIGYyekAV/w5ty
ElTi+7hQDrPb2g61oDLQJL6lE3gmt98uIsYjZOOy8Rp0E8JLcTl/458jcg4SWQ68
uRH6QgZaUnmWtFj8Yso2BJIfHgV8PTRhXlStQcI6jwq9djH7es0LpSkcVBfK3tET
Qn2Zw/w16WzCEYkyGCqSFG43p2QBFlDdHb76fCYQJPN23JIDS5QMXaOZ35ovVqlV
p3AnLpM8I6jY7k8oC+rb7sJpUt4chgOe1UsEv3CBAS3gd6FSJOhiHBX1P7NT9CMa
bv/0Ehb1EX2GoIcjcxEA1tu5V888zavsvnblHP3/eZ8Ik31S5aI/SblAZ03zQe3W
OAZu4H1xGfxrmPqhnnM6IEX1wFJdomwXqg+k1wCFSo1gLum1zopw7XxQMmIJ1rY2
bdAGtzXIHFpZIbLeav9iqei4KQHV93cEBzdJaNDaq587/BzIiuCplfx0oG4WuIkt
IN/ukmjpDoYiIOyKoGv8kE386bZES/UWTyhix/XoRqyn+J767G52hkXileVQAUV0
D+HvzyKcdas=
=cvjq
-----END PGP SIGNATURE-----

--=-5hJ4YfPHUCwgGohI2Vkk--
