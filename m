Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55935 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2HQVcw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 17:32:52 -0400
Date: Fri, 17 Aug 2012 23:32:47 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> > [...]
> >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> >> > affect you?  I think we would still have to change some __inits to
> >> > __devinit, including pcibios_update_irq(), but it might be more
> >> > manageable.
> >>
> >> You said that depending on HOTPLUG wouldn't be enough because it would
> >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> >> theoretically possible to build a kernel without HOTPLUG but have the
> >> enumeration start after init because of deferred probing. Those cases
> >> won't work if we keep __init or __devinit respectively, right?
> >
> > Another possibility would be to make PCI select HOTPLUG or depend on it.
> > That way it would be made sure that __devinit wouldn't cause all the
> > functions to be discarded after init.
>=20
> There's been some discussion recently about whether CONFIG_HOTPLUG is
> worth keeping any more, but nothing's been resolved yet.  If we did
> decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
> just remove all the __devinit annotations because they'd be
> superfluous.

I've missed that discussion. Can you point me to it?

> > Also, using PCI without HOTPLUG is sort of contradictory.
>=20
> I'm not sure I follow this one.  I can easily imagine embedded systems
> that use PCI internally but have no slots or connectors, so there's no
> possibility of anything changing.

Contradictory was probably the wrong word. What I meant to say was that
for systems that use PCI it probably wouldn't hurt to enable HOTPLUG as
well. That would sort of go with what you said above, regarding the
removal of HOTPLUG altogether.

Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLrh/AAoJEN0jrNd/PrOh3tgQALYNMSOVoqKR0VO+N4jmx8pz
wtJfWRZrxMOqtxs/5vLdVNR3YyXVbvWth6UfTWasHjDnLsnpHXuz9hvPbyQZ1K10
Ti+cYnz+w3n47fg9hO4F/aQxHAv3Ugnf7o6jdzMEDovpRZcko+ST/3eAjja44ErG
kd6wgUtNPeLZepmGq8hOaWKqmTE5/ll5fasK3+KHKJ7NZFZ0NzTxKRixe/DO3CZ4
NPUDuRPpsw3mGgFyZ9s5d8hJ3tUzuhXX8M3GEDpZzMIzd2EfZ9FqLiw7MzBB6vp3
19epPv8XaDSbA4dz7Mcy/9csGOguHAjsdi+quJrcTTfKXy8ad9cjFhl7Baaw9jya
NSWBWRtWq/itwbCOeFCGBDq8KBCR4fZF9o9imqLpQgJIrIyUbzVXO+C37H60PbaH
OIOzWkCY4wOl12kOaAgaoCKsHr9w69xrhN58qdRQAVB9PX7PLmiddu0oOdk7xpJO
dMSs2kQR/sLeOoDQXoJL66Nf6wbAMQZmy8r6yVBijhlCsbhxkIc9QquoOrqm4tii
neaTdMj1HNszPrcW2/Q5gzdYquzTI79HSryxkxquRXwLZDhcIGajYbFIwVdTmbkF
6RE9H6XjZXMnawDIvR+8rkgh6yDDMhrcdyt8SfuxkT4D1PGdpWL4D2zV1O+Zg0eq
unIBDvNJSUYSwpMmevKM
=rWb7
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
