Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46547 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbdBCUvc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 15:51:32 -0500
Date: Fri, 3 Feb 2017 21:51:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: v4.10-rc6 boot regression on Intel desktop, does not boot after
 cold boots, boots after reboot
Message-ID: <20170203205129.GA3791@amd>
References: <20170203190414.GA3701@amd>
 <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <Pine.LNX.4.44L0.1702031415140.1794-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hmm. I moved keyboard between USB ports, and now 4.10-rc6 no longer
> > boots. v4.6 works ok. Let me try with keyboard unplugged... no, I
> > could not get it to work. I believe v4.9 and some v4.10-rc's worked,
> > but I'll have to double check.
>=20
> But all the kernel versions worked when the keyboard was plugged into
> its original USB port?

Aha. So it looks difference is probably in "where is keyboard plugged
in" but in "reboot" vs. "cold boot". I did not do a cold boot in quite
a while :-(.

Booting to grub, then hitting ctrl-alt-del is enough to make it work. Ouch.

It happens with current Linus' tree.

"usbcore.nousb usbcore.nousb=3D1" on kernel command line does not
help. So maybe it is not USB after all. (Sorry).

> Last message I can see on console is something like:
>
> pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000=
dffff]

If I do the reboot dance with 4.10-rc6, messages around the hang are:

[    0.281948] RPC: Registered named UNIX socket transport module.
[    0.282009] RPC: Registered udp transport module.
[    0.282068] RPC: Registered tcp transport module.
[    0.282126] RPC: Registered tcp NFSv4.1 backchannel transport
module.
[    0.282205] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.316266] PCI: CLS 64 bytes, default 64
[    0.316330] PCI-DMA: Using software bounce buffering for IO
(SWIOTLB)
[    0.316395] software IO TLB [mem 0xb987e000-0xbd87e000] (64MB)
mapped at [ffff8800b987e000-ffff8800bd87dfff]
[    0.317912] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.318646] workingset: timestamp_bits=3D62 max_order=3D20
bucket_order=3D0

So I guess this is something with PCI subsystem?

Ideas welcome...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliU7VEACgkQMOfwapXb+vKoNQCgl9llWEYKIiIBJpCDzK6AJnoy
6vIAoIA9e2k9rYUvKzB6gR2RkYGvxRXG
=6VFX
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
