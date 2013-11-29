Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:63138 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462Ab3K2NqV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 08:46:21 -0500
Date: Fri, 29 Nov 2013 14:45:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, linux-pci@vger.kernel.org,
	pdeschrijver@nvidia.com, dri-devel@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-tegra@vger.kernel.org,
	Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
	treding@nvidia.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/31] ARM: tegra: pass reset to
 tegra_powergate_sequence_power_up()
Message-ID: <20131129134532.GX22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-11-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LmcuB6YxSMQAV95c"
In-Reply-To: <1384548866-13141-11-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--LmcuB6YxSMQAV95c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:05PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.

Ah, there it is!

Reviewed-by: Thierry Reding <treding@nvidia.com>

--LmcuB6YxSMQAV95c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmJp8AAoJEN0jrNd/PrOhy14QALrsY7dwnZpJ63zB6CiW8NFa
50ezzjvVgNQn6NQ2RyWcma7wmGzmy6yCHCqqg/qNXmXDNYAFQrEQY6D+Ug0ldRSs
/586EhsMmUNoHKsB671WJkex7Cyz5XUqRVnhe0mjzdo3UxQdDgmofYbFAHMPPhRk
OpJM4FkgPR0Yiyr7fFjxgdcgvlDsJ//hVgznVtpjvkW+vCCCEfhOjiT00CqKhVDl
wuD/JcABzxojyG1t4ghJYgVS0ONatHiu7PFfe9nBjJjY18laePvOb63FIUzwxcDE
pz2Ao9WNs1x8MSs5q8MBsisxNRV73HhBIFJu0Qj56skk4WQ0/tJr2pE0C5IDusRi
egBJqb40UIeCt5twVgEeupJr9osSkMjnw0VgUdw79MRy9eQrxb2jy7fy4s2g7BIV
bsGiXASNBUJG6EnwY0HT3Q/srNn15al2bNcirffhBEd/eCx28eJr9oLfGa1FUbBw
Gtbfxkpn6wupAMlhLQxTEtNeIMr22a2gfyJq++ndBWl2G1GnA1EndVYRBuhnx0UW
a0HAXCk1EZ6BDN6d72kJL7vSKMqpof6Bo4zCQhvfI/EzvbLq4NvYzTzonTk/1Mwm
t8EHYx8I2bU2YBxVauQyIErPEnDsVNU+UmH6kV++u5Thxxoem+I3uv1lKeO3X316
5NkUND125vNPg5nB6hkN
=oU8J
-----END PGP SIGNATURE-----

--LmcuB6YxSMQAV95c--
