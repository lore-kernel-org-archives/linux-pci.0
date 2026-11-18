Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017080;
	b=cRARoG9EntFN6R2HXHKbwjxEYXFBMLzCMluPrQB/E2QqQjGrtM1DpE/OQRu83ok98dTA
	 Rarv7BjM/Lef4u4a7Tas7R8XHreJVO1/xYZw1I6z5T60VDSYWtT72SkQOUZldNOwG9fWv
	 tSJks4imGUtLH7sCw332QZHl0zGEs6HtYnqgDVi5/1TdGNm3AA8IqEsw4klKQgMp5QSni
	 GCrqpT2FlMKe+kFhr9xXiybVlX8XOEyECBJRWSxkLGnxxUA8QCKwzM/19sVUXo2qfZc03
	 oz77BD4r4dv8viSnuRL113CB6HpiahxHv1TmHk+j8H6DQ4ey6XhDY9czwvG7RB3D2iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qf8B0pWSRob2jQEYRVRkMJrJy+KCpepLoEzVzLVC7JQ=;
	b=QOSfveViYWNHvNbemtvLyDLJ3sMMr47LKMcTXdTnOInUXBSvL4yNhvxUGe176NhwM1vu
	 3taZk69svCq8BWzlvTxQ23Du/5YGVYM7EIPDrX+/tE08fefiAP1Od6jEmRf+Cj0UDOMop
	 3h/+l5QMFGoK344/mHmvGy6BbpTMUHC2AzGMxDLVUf9hLZgoHCTiNESbg5cxyPtUdwgmV
	 UJIJrmJt3APUrpc0a18OELsysDLz8YF+qIbkIoXqDwwwMyZlUc/kZIJp9585/qQiu6TVD
	 e3v+K1QtuKbPzktF/bkLimJs4tMVnT+l8EIxpD6YoltiH8g2tnS8QgtZeyXlfWWQWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhFZoIz5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F83606A332;
	Wed, 18 Nov 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhFZoIz5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8806E1F000C4;
	Wed, 18 Nov 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795017080;
	bh=qf8B0pWSRob2jQEYRVRkMJrJy+KCpepLoEzVzLVC7JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AhFZoIz5QPddGxQPSruoErjT8itmH040m+DxUw4Xf9wTElEkeOjtXi5Dz8iLlXf4l
	 7QZC56tdiGTXLqUQjQM26gTHFMKk1S8CKYdoLT9aHwZowMADj8kh0ga1IwlEsoaHGM
	 0UADq1Upe/15I96CG175mb9DwM3WKjZ8kcQCnFxtA+tJTN41+ICNOH+xKCFvK8P6En
	 jSVCE/UjgX5Q3/K5plWFDB26K4I/979XXfMQQ5kfh99EvS1MnfNeUL4hNDuAr2tFJd
	 +67kLMeYnEI14tgz1tVoyNdnjJht3qETjzczfA9NbUDFVGTdTYu11WcIh3qXkX+bpT
	 nu2LyjcOLO50A==
Date: Wed, 18 Nov 2026 15:51:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xincheng Ji <jixincheng@ultrarisc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linusw@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-clk@vger.kernel.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, Fei Chen <chenfei@ultrarisc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update UltraRISC driver maintainers
Message-ID: <20261118-unimpeded-swapping-6b1b3e5bebba@spud>
References: <20261116-ultrarisc-maintainer-v1-1-f58706ae438c@ultrarisc.com>
 <179501112283.639563.5233054429317576626.b4-review@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N/uanLs0bA0BfJcj"
Content-Disposition: inline
In-Reply-To: <179501112283.639563.5233054429317576626.b4-review@b4>

--N/uanLs0bA0BfJcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 03:12:02PM +0100, Jerome Brunet wrote:
> > Jia Wang and Xincheng Zhang have left UltraRISC and are no longer
> > maintaining its drivers. Jia's listed company email address is
> > no longer available.
> >=20
> > Replace Jia Wang with Xincheng Ji and add Fei Chen as a co-maintainer
> > for the DP1000 PCIe, clock, DWMAC and pinctrl drivers. Remove
> > Xincheng Zhang from the PCIe maintainer entry.
> >=20
> > Having two maintainers provides continuity for maintenance and
> > patch review when either maintainer is unavailable, as suggested
> > by Conor Dooley during the UltraRISC maintenance handover.
> >=20
> > Link: https://lore.kernel.org/all/20261112-legend-outcast-c2226b5e02a1@=
spud/
> >=20
> > Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
> > ---
> > Hi all,
> >=20
> > Jia Wang and Xincheng Zhang have left UltraRISC and no longer
> > maintain these drivers. Jia's listed company email address is
> > no longer available.
>=20
> Maintenance is not necessarily tied to an employer.

True, but if the people don't care enough to update their emails they
probably aren't that interested in staying involved...

> It would be better if the people removed could Ack the change, and let
> the community know they don't plan on being involved anymore.
>=20
> If they do not reply within a reasonable timeframe (a cycle maybe?) I gue=
ss
> you can remove them anyway.
>=20
> That does not prevent you from adding yourself in the meantime.
>=20
> I suppose this would go through a starfive/riscv tree ?

Sure, I can take it if the subsystem folk don't.

>=20
> For the clock:
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
>=20
> --=20
> Jerome
>=20

--N/uanLs0bA0BfJcj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3JbQAKCRB4tDGHoIJi
0qBxAQDnNYlzvCuzp3y54+YqWrqv9AdYL7pLR7wQG8oNc1UbhgD+MDe5Ob5AFsHw
x1lndPqct4ZQjA7FNv/bu6vHGgf/xgE=
=YLuJ
-----END PGP SIGNATURE-----

--N/uanLs0bA0BfJcj--
