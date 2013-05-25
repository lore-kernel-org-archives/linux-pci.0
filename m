Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:53113 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab3EYLRl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 07:17:41 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so5131338pbc.26
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2013 04:17:40 -0700 (PDT)
Date: Sat, 25 May 2013 19:17:31 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liu Jiang <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: unset the resource if we can't get the correct
 CPU address
Message-ID: <20130525111731.GA20718@pek-khao-d1.corp.ad.wrs.com>
References: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
 <1368536876-27307-3-git-send-email-haokexin@gmail.com>
 <519506BF.3010400@gmail.com>
 <20130517021128.GB13975@pek-khao-d1.corp.ad.wrs.com>
 <519643E8.3020102@gmail.com>
 <20130519022445.GA25698@pek-khao-d1.corp.ad.wrs.com>
 <CAErSpo6vTqgN3MFZ9TmAzHHhnzP5bUip=G=djd80RE-7upJ+gA@mail.gmail.com>
 <20130524025424.GC23166@pek-khao-d1.corp.ad.wrs.com>
 <CAErSpo5Wzy5wHn4CAfD2HjRZ3dv3To+u=pRAvjC8DaMpR03LFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
In-Reply-To: <CAErSpo5Wzy5wHn4CAfD2HjRZ3dv3To+u=pRAvjC8DaMpR03LFg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 11:13:41AM -0600, Bjorn Helgaas wrote:
> On Thu, May 23, 2013 at 8:54 PM, Kevin Hao <haokexin@gmail.com> wrote:
> > On Thu, May 23, 2013 at 02:22:58PM -0600, Bjorn Helgaas wrote:
> >> On Sat, May 18, 2013 at 8:24 PM, Kevin Hao <haokexin@gmail.com> wrote:
> >> > On Fri, May 17, 2013 at 10:51:20PM +0800, Liu Jiang wrote:

<snip>

> >         Region 0: bus address at a0000000 (64-bit, non-prefetchable) [s=
ize=3D128]
>=20
> Your dmesg log show this:
>=20
> pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus
> address [0xe0000000-0xffffffff])
> pci 0000:01:00.0: reg 10: [mem 0xa0000000-0xa000007f 64bit]
>=20
> There are two ways this could happen:
>=20
>   1) The BAR contained 0xe0000000 and we translated it to a legal
> resource value of 0xa0000000, or
>   2) The BAR contained 0xa0000000, we found no matching host bridge
> window, and we assumed an offset of zero and again translated it to a
> resource value of 0xa0000000.
>=20
> There's no information to distinguish these (lspci shows resource
> values, not bus addresses, by default), but in your case, it must be
> 2), based on the fact that the device doesn't work unless we reassign
> the BAR.  When we reassign it, we apply the translation and compute a
> BAR value in the [0xe0000000-0xffffffff] range, which *does* work.

You are absolutely right. :-)

>=20
> We should be able to detect this problem even without assuming we know
> about all the host bridge windows.  The bus-to-resource conversion
> should be invertible.  In case 2), bus_to_resource(0xa0000000) gave us
> 0xa0000000, but resource_to_bus(0xa0000000) will give us 0xe0000000,
> so we won't get back what we started with.
>=20
> I think I'd rather use this strategy than changing
> pcibios_bus_to_resource().

Sounds reasonable. I will respin a patch to use this method.

>  I would also put a note in dmesg about the
> fact that we're throwing away the BAR value put there by firmware (and
> why), just for future debugging efforts.

Will add.

>  Would you mind also
> splitting the "move the pcibios_bus_to_resource() call out of the
> if/else wrap" change into its own tiny patch since it's a separate
> logical change?

Sure.

Thanks,
Kevin

>=20
> Bjorn
>=20
> > In the current kernel, the pci host bridge use the following address re=
gions:
> >   pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus a=
ddress [0xe0000000-0xffffffff])
> >
> > And no reassign for device 0000:01:00.0.
> >
> > With my fix, the device 0000:01:00.0 is reassigned with the correct bus=
 address:
> >   pci_bus 0000:00: root bus resource [mem 0xa0000000-0xbfffffff] (bus a=
ddress [0xe0000000-0xffffffff])
> >   pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa007ffff pref]
> >   pci 0000:01:00.0: BAR 2: assigned [mem 0xa0080000-0xa0083fff 64bit]
> >   pci 0000:01:00.0: BAR 0: assigned [mem 0xa0084000-0xa008407f 64bit]
> >
> > As you can see in the current kernel the pci subsystem doesn't detect
> > this wrong bus address and don't try a reassign what it should do.
> > My patches is trying to fix this issue.
> >
> > Thanks,
> > Kevin
> >>
> >> Bjorn

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRoJ3LAAoJEJNY7TDerrFxlgcH/1pGrsq9Z53uouueKKHsgBSn
e+a3+kqbmfAu8dABPc/XZZ1L1okIleLscM7doLDGvz1xmrY8SCminbvX/smh/kQj
6M2atUGbP/AlEQbCU6+NpPC061u3gKvGCvbKSh6a6RVzixSxB5NLOb/yaohKms6A
ru0R86c6CuuQqy43tbkatXYtFBCDgeReB7rEcJoqENAfxp6xAwvEMCzmKaj++X6H
302iLb72z8LT4ZJtP3kk0OZmF5LbGuXg1Y+ggZe5RSoYvZBjsgBNcoTsHNZr1UBa
lUGCFqYZ+6tXIEDtmEuScffN86GetC9Q2vxHvX4m0IhFM3l0238MrKq4YcF0Klk=
=SXVg
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
