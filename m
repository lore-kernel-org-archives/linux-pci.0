Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33663 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbIIPLc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 11:11:32 -0400
Date: Wed, 9 Sep 2015 17:11:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Global lock for PCI configuration accesses
Message-ID: <20150909151126.GA1366@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There's currently an issue with PCI configuration space accesses on
Tegra. The PCI host controller driver's ->map_bus() implementation
remaps I/O memory on-demand to avoid potentially wasting 256 MiB of
virtual address space. The reason why this is done is because the
mapping isn't compatible with ECAM and the extended register number
is encoded in the uppermost 4 bits. This means that if we want to
address the configuration space for a single bus we already need to
map 256 MiB of memory, even if only 1 MiB is really used.

tegra_pcie_bus_alloc() is therefore used to stitch together a 1 MiB
block of virtual addresses per bus made up of 16 64 KiB chunks each
so that only what's really needed is mapped.

That function gets called the first time a PCI configuration access
is performed on a bus. The code calls functions that may sleep, and
that causes problems because the PCI configuration space accessors
are called with the global pci_lock held. This works in practice
but it blows up when lockdep is enabled.

I remember coding up a fix for this using the ARM/PCI ->add_bus()
callbacks at one point and then forgetting about it. When I wanted
to revive that patch a little while ago I noticed that ->add_bus()
is now gone.

What I'm asking myself now is how to fix this. I suppose it'd be
possible to bring back ->add_bus(), though I suspect there were good
reasons to remove it (portability?). Another possible fix would be
to get rid of the spinlock protecting these accesses. It seems to me
like it's not really necessary in the majority of cases. For drivers
that do a simple readl() or writel() on some memory-mapped I/O the
lock doesn't protect anything.

Then again, there are a lot of pci_ops implementations in the tree,
and simply removing the global lock seems like it'd have a good chance
of breaking things for somebody.

So short of auditing all pci_ops implementations and pushing the lock
down into drivers, does anyone have any good ideas on how to fix this?

Thanks,
Thierry

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV8EwaAAoJEN0jrNd/PrOhiBUP/iSQz2ZknwLaWP9vDMeq01hQ
/mUoyA5+iX2b/m+WCuQQwCMneIOEcT+cBHiJ1SAodisK9CxqABEZM1EqM8wO/Qjr
KbRE8ePOWAHkrhihE84G1YIi8LNH7ZNhXB4g5DtzLUvwJ8/jFiDWmfZp+ixdt4zx
ayUr1nKrZrXrQ494R7p83BLUQqHHNB2rqvgiohnzECNY2VFkoXMzfc6y9iz0C+Xl
k1k7PDs+FW6Oy6xLKPvWUi0LA4cmdwiZdiobL1VQpIbHxao+HM2YkBzY7NGO/tL/
dYWPJ/2VmCG+Q6ttGbC/aX88rEyq3Fi4EwkUXwh8yl1YqnUGr6nfsQ4y3oJTN0Vp
mfQVIFXbYvaKOns6sL9FWUM6Yyu5m5KOdWgWLPt6m7y8Dn9b9dPZfJhDMfJSOmzw
kvjM8CvFp+//y63YDTNHVJowN7z8x1vBa0lHiChbogzZ7gR3HBUSU7kImZIqS6kM
/Czhqs3IVjXJPPlUIKeX07EGI5eliTSTuHS+zGRjOSgu4qz7/FgOLAUiWgHyTIUJ
i0poDDepxDUvck7GvWFUtMoBvmDdbo+gdnz82igGrH0kXrlKIsMctOG1xwHBsJxq
hELAPMFDv2m0jizFtwONsyG9pgxqmkjqCG+szwg8p9Je1MdfHxR8eGZB6rhWtc0U
ue8tXG3iu11EzitDVJuo
=JIxf
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
