Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5483 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbaHJMpd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Aug 2014 08:45:33 -0400
Date: Sun, 10 Aug 2014 08:13:41 -0400
From: "Chen, Gong" <gong.chen@linux.intel.com>
To: bhelgaas@google.com, rdunlap@infradead.org, bp@alien8.de,
	tony.luck@intel.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] RAS, trace: Update error definition format
Message-ID: <20140810121341.GA9616@gchen.bj.intel.com>
References: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <1407313964-20794-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 04:32:40AM -0400, Chen, Gong wrote:
> Previous format definition uses MACRO BIT(...), which is not very
> maintainable. Use unified MACRO as substitution.
>=20
Hi, Bjorn

Any comments for this series?

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT52H1AAoJEI01n1+kOSLHuUYP/2tLitzy04zOlHf7drbOodqJ
C5FnQyPeoIakmlJJ72Qv/28eAsaHOb0YfVzd/KU58C0VpE2FbJAxFnqAE1G0lKQ8
odzTJ5RrexE9PPVunO5/EAdmWk+7AdCMa6y+6+WhY88GGlpcMJpGox+nqGeRrLA5
VV/EmfBKz70R1mb8B0GAtvXMMhY8WU1K/PH8PggXP9pBouiA2KstrywwewEg8ufm
nW/J4LSXIlT/R2VtxFcE5gyDwERihAEMF3AUqCvJGbsv8Z5gwkRPeHjjpJeKGaWA
jE0GPGKnVaDV847FIUZUV04DOmI4PSldSmqppReiEgIhA7CNH8GvNSZYruH7ukLX
GyzRY8uz4y8PBLEKQpld/QABDkKQziUtNrQLV1hKdWOxYkAgzuLwq7yRiRuZ++ye
MotFaR4DlJv7IJLUZnAtNyUvst5p7UzL36b4+WjR3rbHTzOaXR3r9grZ8zIkRXUi
+kTpciqkWn/At9xx8+gISZgzHkQMwxL90gSKRQ8l6jx+/dJIzgNZpOQOTyKvn7F6
6LJljfXggPDr9Pp/6PyIFSZ8IxxdlgB/HaDDvZ+39xTGy8XJGFaIpz3nJXOTEGMd
64kwsk8M2NszsTXPWpoKWly/UXMcYXYLmrtEIMQP8lr1kCATh2Sw/5cW2i70GfLE
YZxZPBYmaWZZgc9ev/48
=oTrb
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
