Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49841 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755292Ab2HTHQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 03:16:53 -0400
Date: Mon, 20 Aug 2012 09:16:41 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120820071641.GA4083@avionic-0098.mockup.avionic-design.de>
References: <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
 <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
 <20120820053036.GA23166@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
In-Reply-To: <20120820053036.GA23166@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2012 at 10:30:36PM -0700, Greg KH wrote:
> On Fri, Aug 17, 2012 at 11:32:47PM +0200, Thierry Reding wrote:
> > On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
> > > <thierry.reding@avionic-design.de> wrote:
> > > > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> > > >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> > > > [...]
> > > >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would =
that
> > > >> > affect you?  I think we would still have to change some __inits =
to
> > > >> > __devinit, including pcibios_update_irq(), but it might be more
> > > >> > manageable.
> > > >>
> > > >> You said that depending on HOTPLUG wouldn't be enough because it w=
ould
> > > >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also i=
t is
> > > >> theoretically possible to build a kernel without HOTPLUG but have =
the
> > > >> enumeration start after init because of deferred probing. Those ca=
ses
> > > >> won't work if we keep __init or __devinit respectively, right?
> > > >
> > > > Another possibility would be to make PCI select HOTPLUG or depend o=
n it.
> > > > That way it would be made sure that __devinit wouldn't cause all the
> > > > functions to be discarded after init.
> > >=20
> > > There's been some discussion recently about whether CONFIG_HOTPLUG is
> > > worth keeping any more, but nothing's been resolved yet.  If we did
> > > decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
> > > just remove all the __devinit annotations because they'd be
> > > superfluous.
> >=20
> > I've missed that discussion. Can you point me to it?
>=20
> It's pretty much just me saying the whole thing is a mess, causes
> problems, and really doesn't solve any memory usage issues.  Ideally we
> should just:
> 	- remove CONFIG_HOTPLUG and assume it is enabled
> 	- because of that, we can delete the large majority of the
> 	  __dev* markings
>=20
> The memory savings these days are so tiny, if at all, and everyone,
> including me, gets it wrong all the time.
>=20
> As we pretty much allow anything to be disabled/enabled at any point in
> time after boot, we are all running systems that rely on CONFIG_HOTPLUG
> anyway.  To find a static system that doesn't need it is quite rare from
> what I have found.

I've been reading through the thread it seems like the consensus is to
just drop it. Though there seems to be lacking a formal decision.

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQMeRZAAoJEN0jrNd/PrOhpR4P/A3x3bRrhHIXloLCiFItBcT4
lYrtqz9XIg28IjUtDvdKeoppngU9LW9Lc58nzkJY+TMyCXOh5vGCPphk1wuCV6mP
rs87YwSkfL7PCunHGcEI5WHTpFkkbGr8x4iwbltRCLOHWOwge1L0Xl0foUX0lhKW
wDo5OpyEAar0z9JWDX2olGfb9TZz9ALTEwKhxGqM6XTQcJZo4UPc5MmFQUUk4Qs6
FU9hk6Dz8qWA/EYTRRqGqtuindEsrWn5JixVYYQ3lhwPvavHVVXE7DP8/Dm+GtBo
fpticf4E4+pPHqxzV+38yL0l+pNxv72WAYfPwZBfZEEXvnnn6TXvf6uqHFOubaDS
wtf+Cw8XlVFzcScmhdprIpRIaoPayWOaCPnPibP9WcrOBGSIy2T5mRTefQeJ0dTJ
u/P2TPDoOTQWEAIS1eMmKka/HLmIf6jc712IGq5MnVWd00Xg0jMNRoJTbgTUzFNc
uQZofe/JB+eD4VDtMkLEy/b8aN5AjS7JxoJmpjzeT4ujazpTCe+AdvP00ZePXCkb
GMBaiif2yvdG6MjBehI1Z/GDTfozht0D33EmqYq9Dv2aNNEk+OgaWh9tLhPySwtm
8rql8uD74sIP97qs1OBzLWTdscDSTyLG1fk9xGnJuKx5T+3VeywYCUXIH+HzRgyT
zWWEBgWRwO7oBrtDgGsA
=P4Dy
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
