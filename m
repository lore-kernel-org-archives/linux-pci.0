Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Feb 2017 18:59:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>,
        torvalds@linux-foundation.org
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170214175956.GA3587@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
 <20170203205129.GA3791@amd>
 <20170203211854.GA3697@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <20170203211854.GA3697@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > > > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > > > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > > > but I'll have to double check.
> > >=20
> > > But all the kernel versions worked when the keyboard was plugged into
> > > its original USB port?
> >=20
> > Aha. So it looks difference is probably in "where is keyboard plugged
> > in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
> > a while :-(.
> >=20
> > Booting to grub, then hitting ctrl-alt-del is enough to make it work. O=
uch.
> >=20
> > It happens with current Linus' tree.
>=20
> v4.10-rc6-feb3 : broken
> v4.9 : ok
> (v4.6 : ok)

Hmm. It hangs during PCI fixups, and it hangs in v4.10-rc8, too.  =20

With debug patch below, I get

=2E..1d.7: PCI fixup... pass 2
=2E..1d.7: PCI fixup... pass 3
=2E..1d.7: PCI fixup... pass 3 done

=2E..followed by hang. So yes, it looks USB related.

(Sometimes it hangs with some kind backtrace involving secondary CPU
startup, unfortunately useful info is off screen at that point).

Any ideas?
								Pavel

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1800bef..060ad79 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3510,6 +3510,8 @@ void pci_fixup_device(enum pci_fixup_pass pass, struc=
t pci_dev *dev)
 {
 	struct pci_fixup *start, *end;
=20
+	dev_info(&dev->dev, "PCI fixup device %p, pass %d\n", dev, pass);
+
 	switch (pass) {
 	case pci_fixup_early:
 		start =3D __start_pci_fixups_early;
@@ -3558,6 +3560,7 @@ void pci_fixup_device(enum pci_fixup_pass pass, struc=
t pci_dev *dev)
 		return;
 	}
 	pci_do_fixups(dev, start, end);
+	dev_info(&dev->dev, "PCI fixup device %p, pass %d, done\n", dev, pass);
 }
 EXPORT_SYMBOL(pci_fixup_device);
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlijRZwACgkQMOfwapXb+vIY2wCgw2rAfUT02tdsxE6WYjvajJ/Z
I3cAn1aVUXRAFQvCSbcb58BvEVB1hObZ
=HBNY
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
