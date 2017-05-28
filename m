Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdE1K6P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 May 2017 06:58:15 -0400
Date: Sun, 28 May 2017 18:54:16 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Q] What about PCI mmio access alignment?
Message-ID: <20170528105415.GA17556@intel.com>
References: <20170525101256.GA12183@intel.com>
 <CAHp75VcfYuDAO-1e0VHOmeudS2dDti1FM8+N+gNVEux-D8PMUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <CAHp75VcfYuDAO-1e0VHOmeudS2dDti1FM8+N+gNVEux-D8PMUQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you. I have some experiment on my PC. The result is:
  o I always can get expected value if the unaligned access doesn't across a
    DWORD boundary, like readw(bar0+1). I suspect that the chipset should r=
ead
    a whole DWORD in behind. This may trigger unexpected behaviour on devic=
e.
  o If read across DWORD boundary, I get some intersting value, like
    readl(bar0+2). For some device, I get a cyclic shifted value of the fir=
st
    DWORD, while some device return all FF.

So my conclusion is that no unaligned access and at least access one DWORD =
size.

On Sat, May 27, 2017 at 06:32:48PM +0300, Andy Shevchenko wrote:
> On Thu, May 25, 2017 at 1:12 PM, Du, Changbin <changbin.du@intel.com> wro=
te:
> > I have a basic quesion about the alignment when access PCI bar mmio spa=
ce. Is
> > the address accessed must be DW aligned and count must be DW aligned?
>=20
> I guess the best answer is PCI architecture specification.
> Book I have nearby tells me IIDnMS that yes, you have to follow alignment.
>=20
> > As far as I know, The address field of TLB ignore lower 2 bits and the =
unit of
> > length field also is DW. So does it mean above question is Yes? Else wi=
ll CPU
> > handle unaligned access for mmio space?
>=20
> Here you perhaps meant the bus, not the CPU. PCI allows it as long as
> actual device allows it.
>=20
> (I recall patch series that tries to micro optimize PCI config space
> access by grouping some bytes into words or even dwords, and it was
> rejected).
>=20
> > I want to know wether below access illegal or not:
> >   - readb(bar0)
> >   - readb(bar0 + 1)
> >   - readl(bar0)
>=20
> It depends.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--=20
Thanks,
Changbin Du

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZKqxXAAoJEAanuZwLnPNUhD0IAKgiMbcU+LGtbAdEAypZACVt
bIFfNXE8WDWOCrSCJ3bxOnhkraiD9ZfE1tyyud/cldD/59fICbePSSp74Q+Q8j1w
OWI8JQNATi++NRNBUlF1ZLIOVsCpOblUQts2xkqdsSoWwRa6D22UGqoO8BxiaFam
NTQNrS/1SSYRHag77Ju+CvZegVobFlpPrOSCN2qXsydBdhMvYzsl+z3CVtTgHHeV
lWuWB9HovNz0zbhECU7u/gyUQ3wyKmkeSthoMDme+YERvsw2S5ZSQRayn4kPnL+c
jc6nmbTCWljWAuBa8ZVEUGABv1306dNcRLGYUu4WIy8FGGIUH5DNCdJWg8Ftwqc=
=+BDH
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
