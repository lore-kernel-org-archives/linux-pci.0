Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34972 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcDKKXb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 06:23:31 -0400
Date: Mon, 11 Apr 2016 12:23:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160411102327.GA17743@ulmo.ba.sec>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <20160408164814.GB15034@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <20160408164814.GB15034@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 11:48:14AM -0500, Bjorn Helgaas wrote:
> Hi Thierry,
>=20
> On Fri, Apr 08, 2016 at 06:13:13PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Changes to the pad controller device tree binding=20
>=20
> Is there a commit we can reference for this pad controller binding
> change?  If so, I can fold it in.

It hasn't been merged yet. Technically this patch is a prerequisite for
getting the new binding merged. And there's a specific order that needs
to be observed for this not to regress (albeit only temporarily).

The correct sequence for merging this would be:

	1) XUSB pad controller binding & driver updates
	2) PCI driver updates
	3) DT changes that implement the new binding

Because of the above I'd prefer to merge everything through the Tegra
tree. If that's okay with you, I can provide stable branches once its
all in place for you to merge back into the PCI tree.

> Is there a benefit to keeping this binding patch separate from the
> corresponding driver patch?  It seems like it'd nice to have a
> connection between them.  (Sorry, I'm sure I've asked this before,
> but I can't remember the answer.)

I've seen both approaches applied. I think separate patches is (or was?)
preferred because eventually the DT bindings were supposed to get moved
to a separate repository. Having separate patches would make the
transition easier by making it possible to cherry-pick between trees.

Thierry

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXC3scAAoJEN0jrNd/PrOhVnoQAJQawbj9su8FAjoJiaLXV+qw
SlKUEiJrqe5UNOKDFG682fHscmFkONiM+tLxwvy0zLVmkkvxXUo//jHD0lNJvyt2
GM0TJDCgCow7pZiWAv54wROyaJvvRpNrRZIErBO/sYjZJQlopdW6iKxS6zqAzJo4
3mMV5wmrXnxNkjPR5Ah7PjX9E/HU/9LwgQhUbKCRfczH616htE6MU30XevNrtp/0
3gcLVwXIH5jMcw8hACsb+gUlFHvtwDJogjqYqx9TkVThOrH+rRnmfn6KmP8s12Pn
thFZKARcyiCuW0VY3Roz8X8Q3JR9W0xYodzqAXXwEMnOALZewodV4NrO54eq6VWV
uQzIlz/EQfWV41nPCsCBKnkOi0+gYm0GYdokrMSwY59bazdhZfDqB+reDcf8DTga
tftp+91kzC7/Vr+L+9Str2V9Z8qcu+3cWCBP5vhv4Czea9ShU+yFZaoD9Z6fvB07
jLsh8IGqwcJm5TIUcVlkMh6xnKY3GMoAcnGN1v7YHw3M2hlk2BGs+KqkvZzD9AiU
c1dHnRV1p5EPpF/me/ucx3tNBAKHrxrV2wor/9h+c0Puy/PQBrkD79fbVajdmVoQ
h7/SsdslZaKGOmrePKUZJ26Xr6KAkvt29zM6Sl8TtbQcEuF0bS29osYprpNTpLzG
y3pSYkJ7argu7KfzHelp
=85h5
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
