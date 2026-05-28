Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAD3321D4;
	Thu, 28 May 2026 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950652; cv=none; b=Ln0x8XDWP6LItz0LNv7qQ+cFGQYNiD9SQOZ0JYIZzRM3OvwyvHP11J7k0FGRQXs/W33xduX3bmNUbArm4rGdnNMSxLvDyah9f7XVojd9fnup9gh33HzdLaNT3p2trM3+WlHjIeKVW2gKs+O9qVw+LTrUzOmbnFYIR+O+Ypv4TWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950652; c=relaxed/simple;
	bh=CmoccOtHd/HuFqbzqIM8b0j+gcLsc4s2zkjBXEQGNPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozt++HhU/Ypq4AnxKnxTxhH8tAaZnHJl0kY9Ayqwuap7ZTLSxdqm4JiX7oNt1aBPwoZEifjI27ZXIDx+DUygikkfwP9RViSPlwb6g6qixazybfOGVGHYQgNJJOeC5RmlTHhVjymTyo2uRRkkVdX1An0hfyQlIea3xqw/oMu5ZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMf+bZHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMf+bZHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14A1F00A3A;
	Thu, 28 May 2026 06:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779950650;
	bh=8uOQcDGbXZlb6q8u3GvJiWkXjn3EaSa5gllpC9TQbrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DMf+bZHrQTcd9uXj5YaqJ2NMKllNWB6er4xNsT03rFDsQLoZ/iEIAYctOP1m4jqhp
	 Cp1mby8xWctFOfyvR/sLyQugVI1nbSEOPIYlnLcNqgnEos7+ymmVccpbPl75Mns///
	 9GVqaoiK5KY7cJy8ON7ZUGyJR47SQoRcIKt4GvDfy0cbfp/8jGRbyQz2GRGD7NCdms
	 Lu8UkXAG7SAVhN+ZHb2df7AjXVXzmgiPqKXeVjlCB9/ijtB9DtTLSB9XUdkKzL806h
	 1KVouHE54G5rUEvNLIAQ2vf8UyV7AuT3uX/km/qBCRdx3umAiCYj2ztZ0uiZJ2fRor
	 7TQu1CQzBGjKQ==
Date: Thu, 28 May 2026 08:44:07 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Message-ID: <ahfj-uhNTlk-byvU@orome>
References: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
 <20260526-tegra264-pcie-v5-2-84a813b979d7@nvidia.com>
 <ahV_r6NJWnmJptT2@wunner.de>
 <ahanoZgDwq3v6x8M@orome>
 <ahcob7HMbyGvFgxc@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uc3lgg4pj4krpin7"
Content-Disposition: inline
In-Reply-To: <ahcob7HMbyGvFgxc@wunner.de>


--uc3lgg4pj4krpin7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
MIME-Version: 1.0

On Wed, May 27, 2026 at 07:22:55PM +0200, Lukas Wunner wrote:
> On Wed, May 27, 2026 at 10:28:51AM +0200, Thierry Reding wrote:
> > On Tue, May 26, 2026 at 01:10:39PM +0200, Lukas Wunner wrote:
> > > On Tue, May 26, 2026 at 10:53:11AM +0200, Thierry Reding wrote:
> > > > Instead of defining the wait values for each driver, use common val=
ues
> > > > defined in the core pci.h header file. Note that most drivers don't=
 use
> > > > the millisecond waits, but rather usleep_range(), so add these comm=
only
> > > > used values to the header so that all drivers can use them.
> > >=20
> > > Hm, why not just replace usleep_range() with msleep() and use the exi=
sting
> > > macro instead of defining new ones?
> >=20
> > I'm trying to somewhat unify the implementations across drivers without
> > changing behaviour. I don't have a way of testing any of these drivers,
> > so keeping the existing implementation and just switching out the symbol
> > seemed like a good compromise.
>=20
> It looks like the code was copy-pasted from one driver to the next
> and I applaud every effort to deduplicate, unify and simplify things.
>=20
> I don't quite see how using msleep() instead of usleep_range()
> should result in breakage.  The drivers are just polling for
> link up for an amount of time and as long as you're not decreasing
> that amount, everything ought to be fine.  Moving to msleep()
> should never decrease the amount.
>=20
> > Then again, I count 2 drivers (in linux-next) that use the existing
> > PCIE_LINK_WAIT_SLEEP_MS, one of which multiplies by MILLI to get at the
> > US version (so it could easily be converted to the US_MIN version). Only
> > pcie-designware.c uses msleep() with PCIE_LINK_WAIT_SLEEP_MS, so it is
> > clearly the outlier.
>=20
> Konrad Dybcio went ahead and replaced usleep_range() with msleep()
> in that driver, kudos to him.  Cf. b262518262f5 ("PCI: dwc: Use msleep()
> in dw_pcie_wait_for_link()").  If you could just carry over that change
> to the other drivers that would be great.

Alright, I see you really don't like usleep_range(), so msleep() it'll
be.

Thierry

--uc3lgg4pj4krpin7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoX5DcACgkQ3SOs138+
s6H9qQ/9FvVWlaICBU/gs8tDIB7XU9zULjHm6whhbpBn3uuDB6PqFKfGbFmLL5ch
lDezqyqIUjvskd88UahBE3f5AnEFDrqK9AstxY2VQn8/Iu60WsLlU578H2vGxshG
nCDRQZW2pQ5d85TaWhYZwOnSM0rFCbmhlPeiI1EiSuGyPDp/7IpIi3p2LC/IERee
LCmtj4bW6zQMPU6kXjJI8SfGcD67YkJHmTKPmuhcqeG6ni27BPXEJ/kzz2BfQ+1c
OdCJElFdOUtLONNLUeK5gEetp9VV1SOeZ4urDMJLG12RkP8++ql3rs/jvl8wlkGK
RFbCzXsV91mi11beDpSR8MSNew80qXMZ+qZO+VTqGv5fcRCqmoKo2t4GzQ+AB1zj
nRxWk6QeB0+yzVUyetGjuSzMMo7pzgEOcBQ0UgJam58kk7Sgz9dej1VR2//8GLbR
bkZw5uvmRtdJ0MGsQyDxgnGpZUaFLqxvomlRt3rMF9d43fU+viuHUHe0qAMLV4O0
EXnwmEjVqZMOqi9gbEt38d8lk5AhgC9RilRlG8/gzQNF4agL6U1S4cD5WVzrLzjV
TTMydaK+xfTTcCrHsSrrq0c3AzQng0TR12M5DzPGNq1gENxVYL2VQ5W3zBPMKiSl
X06TvyKmS6rpAK8F7Bm+4BG44Bd7QrqbKbtixgWNN33xe45+td8=
=0mcj
-----END PGP SIGNATURE-----

--uc3lgg4pj4krpin7--
