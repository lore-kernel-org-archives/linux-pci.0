Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Mar 2013 08:58:10 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] PCI: Introduce MSI chip infrastructure
Message-ID: <20130325075810.GA28935@avionic-0098.mockup.avionic-design.de>
References: <1363942307-9327-1-git-send-email-thierry.reding@avionic-design.de>
 <20130322093027.GA521@arm.com>
 <20130324120649.6fb8c05d@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <20130324120649.6fb8c05d@skate>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2013 at 12:06:49PM +0100, Thomas Petazzoni wrote:
> Andrew, Thierry,
>=20
> On Fri, 22 Mar 2013 09:30:27 +0000, Andrew Murray wrote:
>=20
> > I think this could work well. In the future if the use of an independen=
t MSI
> > controller is required, then new DT bindings for host-bridges could use
> > phandles to reference independent MSI controllers as their providers of
> > MSIs. I guess this functionality can be built on top of what you have p=
roposed
> > later as the need arises.
>=20
> On Marvell HW (at least Armada 370/XP), MSIs are handled by the
> main interrupt controller directly, or more precisely, managing the
> MSIs requires fiddling with registers that are part of the interrupt
> controller registers, and not part of the PCIe controller registers.
>=20
> Basically, when a MSI interrupt is raised, it corresponds to IRQ 1 on
> the main interrupt controller. Then, one has to read a register of the
> main interrupt controller to find out which MSI interrupt was actually
> triggered. So in our case, the MSI irq_chip really belongs to the
> interrupt controller driver, and not the PCIe driver. Also, the
> physical address to be added in the 'struct msi_msg' is the physical
> address of an interrupt controller register.
>=20
> Therefore, I'm not sure how to do the interaction between the PCIe
> driver and the interrupt controller driver.
>=20
> Suggestions?

That sounds very much like one of the use-cases that were discussed. The
easiest solution would probably be to add an API to look up an MSI chip
=66rom a DT phandle, so that the PCIe controller's device node could have
it as a property, somewhat like this:

	msi: interrupt-controller {
	};

	pcie-controller {
		...
		marvell,msi =3D <&msi>;
		...
	};

Then add some basic infrastructure to register the MSI chip with a
global list, call that from the interrupt controller initialization:

	...
	msi_chip_add(&msi);
	...

And finally look it up from the PCIe controller driver:

	node =3D of_parse_phandle(dev->of_node, "marvell,msi", 0);
	if (node)
		msi =3D of_find_msi_chip_by_node(node);

That's roughly what other subsystems do. I wrote something similar once
for backlight devices, though the registration step (msi_chip_add)
wasn't necessary there since backlight devices all go into a common
struct class so class_find_device() can be used instead of going through
a separate registry.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRUAOSAAoJEN0jrNd/PrOhMRIP/3zEoTUVOhwS+EJ7Nnnilzdn
qak5GSuFY93eZl26ZHzDBf5U53IasA5Aq2ILtZa4PXgvNM9/Yh3166YDIdozts7M
d57/s145FAATymkxBpvlp+dIXaDPkO2SjEsCdDoxFl+ioSgjBW9L6/1XhxG/4V43
pT3i6CImVNaxGI8ET47wylyUwT8cvMC78loRwiYQIaLQUYXX5Z/eIzFUKh/Sl9lK
3qhjehSOFoGLnfAZCWobNsZSb8WUtbWUTHyfzoZlEn+45s0SHMEDofhORX8ZA4P+
Gz0UoE1NEkVc5KW+MasKTKpDDAuUbD9OyRgzBlM8lwYeOof7/TY9iZusx1RBEFJV
4luO+vxJlXyOKBRmIPzLMQFza/yYrzxPn+ZtYr2CZmq9bbIm/eQhU0WO0dL+V26g
r1OYPCxbg2vYAaGPMMMXENi1VE1KNKeKyBNN4vl3Txsw3qG4rlbn34vyIXfWaU7w
QaaxCwHNYhGpV9EAomuyhKo1XwYoQxnIjii5p2FV092qGjoZmKCoWaV80El8QS5J
GRDE/0rlkk0VjzioLO6r84H6V4Z/yUnHgsTuAQvcqriQ+B9HYIb1c3Rmlq/4GanJ
mtEbD+hvz1xU1eEQJqwV3NCYZddrwFfY+UVYSmDNkyUgSMAfYiAhW5bbxPLCtEUy
/BANZTD2emlFgi51biw6
=zQii
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
