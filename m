Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFB3E49E7;
	Mon, 27 Jul 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171469; cv=none; b=Z3xagsEzQv8JvinpVisztRT6nxBTCAIfO1W39GcsNY4mhR2xZi4HHhlDH5kuSupEEteOqL6bxpDUjmoh6aoKImqladRDY6kHjtvMEdq3v6sOembEK3K5aiC8MyPVKt5LnYGF3Q0t7I9b9EZcnBKmQcJPoTyuCrTUMwkyYiHILLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171469; c=relaxed/simple;
	bh=idLRbI0kjZo/5BZRbumG/KBORxaTgltxNxBmeX1H14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqJjoFioVwPTVFG1N1iE1pH57yZfhDNZZdz8A7SNlXK++SjhZkAG/o2D5Qid9mwosFc1Gd6MhrvURDWZf8JvNuYhrOsKHpGkWeJMj8TeyzSmMtFVm36yahes/3FrP7jzD4RyNkp4clOdgxU1M//F9v56CqiOy9EdeF7eDSJxNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtWtp0Qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtWtp0Qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E21F00A3A;
	Mon, 27 Jul 2026 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171466;
	bh=vUeETdewGzTzosWBl64Brxz8J13qLh0qw1UKG/YNmws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PtWtp0QwY/LCxBLAuEqQWN4TBlga4X9EvuTI7qYelC+UP4BuTLXZgTHux+Pgs2avc
	 rIMM95jge9Sn5yinMnGU9iIFNk3P4/83Nbsj855mjpxfJyWvM8BmTSA4W/HdOcLyq3
	 sn+QLe8r1u/GCs+E9/XmzeY9vk4zuptbcp6CxORU8jglLLKcfp6ES5GVWdq4EfLiag
	 WGkZkP/wYsvXao2ktTjjOX2cDws4Tw4rLgqeaX7kaAd2Xl6ki/d2U/FblAWf7C4pkj
	 RFQNDPDAFe7IuAf+Z3mMrv9hDZL6w+7MerH7gcbZqqkxhYGEGZOeQpTr6LxYxAFKVe
	 vrT5vez35c7Cw==
Date: Mon, 27 Jul 2026 18:57:44 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Message-ID: <ameNj2Gh8mgqL7kB@orome>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
 <20260716171946.E85D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4j6b53jvscoulwol"
Content-Disposition: inline
In-Reply-To: <20260716171946.E85D71F000E9@smtp.kernel.org>


--4j6b53jvscoulwol
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Thu, Jul 16, 2026 at 05:19:46PM +0000, sashiko-bot@kernel.org wrote:
[...]
> > +	}
> > +
> > +	/* sanity check that programmed ranges match what's in DT */
> > +	if (!tegra264_pcie_check_ranges(pdev)) {
> > +		err =3D -EINVAL;
> > +		goto err_put_pm;
> > +	}
> > +
> > +	pcie->cfg =3D pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_o=
ps);
> > +	if (IS_ERR(pcie->cfg)) {
> > +		err =3D dev_err_probe(dev, PTR_ERR(pcie->cfg),
> > +				    "failed to create ECAM\n");
> > +		goto err_put_pm;
> > +	}
> > +
> > +	bridge->ops =3D (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> > +	bridge->sysdata =3D pcie->cfg;
> > +	pcie->ecam =3D pcie->cfg->win;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> [Severity: High]
> Can this assignment cause an out-of-bounds heap read on 32-bit platforms?
>=20
> If the driver is compiled on a 32-bit architecture (e.g. via COMPILE_TEST)
> where per_bus_mapping is true, the pci_config_window->win union aliases t=
he
> dynamically allocated cfg->winp array pointer.
>=20
> When the driver later dereferences pcie->ecam using readw() in
> tegra264_pcie_link_up():
>=20
>     u16 value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
>=20
> It will read from the heap array pointer instead of mapped I/O memory,
> resulting in a crash or garbage read.

For the record: no I don't think this is ever going to happen. Yes, if
you build the driver on 32-bit ARM it might generate code that is wrong,
but that code will also never run because Tegra264 is only 64-bit ARM.

Thierry

--4j6b53jvscoulwol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpnjgUACgkQ3SOs138+
s6HceQ/9Hgi0ouKCuPVhDZwnsqoCrczbLoQxK2GI05yJ5XMT95Mi0fhsWcBQmGKd
BUJM5baIRhP0cnfBOJu7VddYgMZIfMcJ4p23Q3LBpBuv6OSvHbPDVNtB4Ddp89Dl
VfPvrAk1bBtM3K+MF0jLG/YGGlFMSSU0tI8tGgg0smORP0oaVB7p64WVpVrrM4bo
G3Vh+0PeqeKXIShuy7RKRuFPVs9MLGRScWbYFJWDvRahwXsGiZ6gixD/tmF3mVAA
Bi/QnIQnpbSXBewkmfjtSZVb73+3MvJVpEl/B56uqaJ8FJ0i0Diym7XBuxnTzOmt
cDpkOWanyY+9VJUNqd0wI0OZDqmR8U69LZZKFgOuc2o4Mb2CzfhpTQuZUa/jRVGx
tFweNsLQkLcskDcWbz2GPN80Bnu1sNXhIZjI70W6C1uUKY+wEoBVWP+mGvFGL5T5
CCKG14fsdjT5b9rzOAn+EFLIy5f7b6o+RYFNLR6oWBnN6M5ercXYqEKThiFnjGfY
Zu96Ivw1cTaPxW1OhoxbdC2jGJNw39hbuMl0Cg2StaPOWruskdgARMVj09sHkgnz
QdH1p+kSUl4UBVo9gmnkBB+QHx2Zr8QIi39LZYx74cOF/afkHOb1nZVfJ7bJXA49
ik85BUSKrgB0V4Be/WJsBgq5pfa2hvUbrW6TLwa5c+Nh4qsVzqk=
=XNy/
-----END PGP SIGNATURE-----

--4j6b53jvscoulwol--
