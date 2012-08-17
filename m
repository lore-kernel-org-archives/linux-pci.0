Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55336 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2HQVH2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 17:07:28 -0400
Date: Fri, 17 Aug 2012 23:07:18 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
[...]
> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> > affect you?  I think we would still have to change some __inits to
> > __devinit, including pcibios_update_irq(), but it might be more
> > manageable.
>=20
> You said that depending on HOTPLUG wouldn't be enough because it would
> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> theoretically possible to build a kernel without HOTPLUG but have the
> enumeration start after init because of deferred probing. Those cases
> won't work if we keep __init or __devinit respectively, right?

Another possibility would be to make PCI select HOTPLUG or depend on it.
That way it would be made sure that __devinit wouldn't cause all the
functions to be discarded after init.

Also, using PCI without HOTPLUG is sort of contradictory.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLrKGAAoJEN0jrNd/PrOhCdcP/3uQiMNPZuOMfFpouaXem6qS
Wo1nLtGkeLLjvRY5jv38voix7MRxeJIkKW1v7YCeuCj5+RjzCO6o+0u+qHS0jZKp
tku2SYP2h12v6p0yIZijyR+ebgPvKOSrBLN2R4IT4487teBeW1dLoyZ3O5QInjOh
BtKwUcXkCDRKGLsBDK1wg+wqe2qlb/tXL7Dc+pn7RdI2l6R69b3rxmPqsDUL2p6f
/wpzcf+2zwNCQnhgHHaYqB/IKfHb0WbZmM/U71JuaowmvLRQu0Eb9UH2qHpJ5stY
UTbDIsMRiXacDvKrFiVYJ4coCY7WrWB1CCvnObVTsru5Fc4E62y3Px99m4yHCzxP
KmW/t0Srf4D5YVwyWmEK83WzGyZOol8cAJfc7Y7gCUJ8zagfaPlX9VXlkfKkgadM
uh4n/2kLnmduituVlEOsbPw8gMwLkflUJIxPSwyNrpkJeWvT2wDakGSrGt/uQ8MW
LKISwrvGXos+cZkyR6HLcJMfgq+LO4AbDvQwRWKur3XkNL0yJBrOByWy3+baZ+Ti
QA1OXc3Sbt5ojAB24bO8c+RGpdhitK8gHI5nJHDQ7Go6IdtQmjykt6dLBQlnBgD6
WT6KBuWtPn1Kmx/ztYG2Zsihz22+uJttHZWSv8yp+rCi1U3FRAjWDlXeVXJxqgMg
yLEUd6DMr7bX7GHD1Jls
=VgbU
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
