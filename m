Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab3CGTtk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 14:49:40 -0500
Date: Thu, 7 Mar 2013 20:48:30 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
In-Reply-To: <20130307174955.GC20840@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2013 at 10:49:55AM -0700, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2013 at 09:08:32AM +0100, Thierry Reding wrote:
[...]
> > > Both have various problems, but I think I prefer the first one as it
> > > doesn't conflate the contoller registers and host apertures in a
> > > single ranges..
> >=20
> > I think a better alternative would be (and this matches what Thomas has
> > said elsewhere) to use something like the first alternative but move the
> > regs property into the pcie@0,X nodes. That would save us from having to
> > index a property in the parent. At least from a DT point of view I find
> > that to be a more consistent representation.
>=20
> You are thinking a new property 'host-controller-regs' or the like?

Well, something shorter would be nice, but that's the general idea, yes.
As I mentioned before, for Tegra these registers aren't actually any
controller specific registers but rather a window to access the PCI
configuration space for the root ports.

Going via the FPCI mapping of the configuration space doesn't generate
transactions on bus 0, which is why there are extra windows for each
root port. That's why I was arguing about reusing the reg property in
the first place because it actually represents the configuration space.

But this is likely to be unique to Tegra and Marvell hardware doesn't
behave this way, but instead needs the registers for a different
purpose. Something like host-controller-regs might be more appropriate.

> > However that would probably not work out-of-the-box with the current OF
> > core because of_address_to_resource() won't know how to find the new
> > property. The assigned-addresses alternative seems to be the only one
> > that would work on the current OF core and achieve proper address
> > translation. But it doesn't seem like a good solution either since it
> > repurposes the meaning of the property and therefore isn't any better
> > than encoding the same information in the reg property.
>=20
> Except that reg is specifically not supposed to be handling CPU bus
> addresses and assigned-addresses is.
>=20
> Adding a hidden non-standard BAR to model the hidden non-standard
> memory region associated with the bridge is a stretch, but it is not a
> very big stretch...
>=20
> In any event, regs should not be used, and something needs to be
> decided!

I don't think assigned-addresses is a good fit either. The PCI binding
document is equally specific about it as it is about the reg property.
So in my opinion a separate property would be a better choice. The only
big obstacle is that it needs to be somehow hooked up with the OF core
so that proper address translation can be performed.

One possible solution that wouldn't be too hard to implement is to
provide a new function (say of_get_named_address()) similar to
of_get_address() which doesn't get the name of the register property
=66rom the struct of_bus but from a parameter and call that function from
another new function similar to of_address_to_resource() that also gets
the property name from a parameter. I can't think of a better name for
the latter than of_named_address_to_resource(), which is rather long.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROO8OAAoJEN0jrNd/PrOhpW8QAKJ61emotDiguOToXF+JbFVn
5m6xNsd73+CQuqWIxfKYC0foakdfPponseQ0Wx+wGGHrzmgylSjS1swwt5SkdJ+T
bAbNyxd/W6k1vhv5h+d1mjWy+13kU24Y7z3euZ5dgJvQGyzYe7i3ylvkVBJmqQhw
kQNuCVDvZENMHeYyhlxKCDmGVqA4aWcSxsKGZ9Y2bDbP2sSqrhNx2yrhFUx/5D3/
9onDK+D1V4Ny7IYaGLNYejtXgA+LpYSLVfyE3TAkIBRlVnGcjZpri0reAM5DyLj0
vsq/Ict5peW0knF1f6HkoDBqRw+ILLpW2qoYAfp5octzjF6MHDindSeymkzTh9D1
u/mFpj68jDqrBbDhm1HfzuMiZfMvgsAmKj5K01EoNnSRjCye47kVss1mELZKj5GP
FaY9AQIfjV6kJ9tsib3yoGLc8hnn+8C+VsRQsrNo37/sHQjaADlvxNO68TaPnN6M
XI7/2Omb3S3XWXqFzkW5OEORdGe7TnFPc2JhVLu/MEUy+6U6QxcIRa1n7aJqOt+J
WLCvcjsuoHQn5GQCABwgPV6XxpaU/jaRVH+Fd3X5TLTt66KFUggIrA/7Xcb6+A99
vS4TFxRT4YTssH2XclmcEEYjBGjGratmWI89rjUYuT8V/F7lFLhb28KzAkIdWO2k
Feu3j1YGfxHEL6C/wgzB
=VU03
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
