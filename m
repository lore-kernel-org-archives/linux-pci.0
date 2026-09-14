Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380743E07D;
	Mon, 14 Sep 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395549; cv=none; b=bWP1rTl04bUzELTWhM3FMdR0eLhOX12pNo3UNFQuoQv7Qrh/mQvPVzLIt7iswN/ueVJ0SMNe+D/kyu022SxWrRgL8vKLoMx+8ceWzw/3RSU5kZPyvFFoc9k/agXQWHfsAMNzvzOirMDEoMaZvrOokMwXm5x2wkDcLf0K94JC36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395549; c=relaxed/simple;
	bh=EzqTXa7SaP6NeF5INJbdyRyJ6ujCTw8f2qQUFmbo6tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAfU1Gih9wMiD5h1qU9zru9ZMG8nAeMOV8MXA02odd/DKGUtcjR8+D3bRR/YjUB3RogkkY3uzF3isvtrjGG/F4NEtG5thFiX95+2/74bWz3F2NTqtg2u6f87nUDl4sgvNFXUC6qmis3yx4oMV9MPebN9Gq8yV5kbj8J8v1Et8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyc2avyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyc2avyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9CE1F000FF;
	Mon, 14 Sep 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395546;
	bh=EzqTXa7SaP6NeF5INJbdyRyJ6ujCTw8f2qQUFmbo6tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyc2avyMIFArIMKLwC2glg4o43iPhaFEvJ6FrMWl5Cz9T9xmTqAbw+KoHYQ5l7X28
	 H3Ib2I+Awwyr8cLwPYMqkM1vwYds/6UojyWhymHftXA/VrkKTYPsg+sXjMf92cPY+e
	 GJZLUQzYI+PN9z00pByHDos6YGL8XR9M5OgmJeoZhRQY+cuRMlQPIAnFZB5NkqrUCE
	 Ngw6zbc5FSuw7ysfRaMI8PJxOSKMI9rcyH+dIXjO6WcnshwORkLUEEDevOLu8ocCZO
	 zyPktlcHqbl7cwE5SnNgQFE69nYNdMhkxvkSGjOE7jxX7xcA1asVIOAsUKoPqUHOTA
	 yuG5nslDD65ew==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EF06B1AC52F1; Mon, 14 Sep 2026 15:19:00 +0100 (BST)
Date: Mon, 14 Sep 2026 15:19:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: soc@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alexander Clouter <alex@digriz.org.uk>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 04/14] ARM: orion/dove/mv78xx0: remove all board files
Message-ID: <aqgCVDFsGOlGcryz@sirena.co.uk>
References: <20260914140821.1805449-1-arnd@kernel.org>
 <20260914140821.1805449-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1qyGSh2F9CZZuB0W"
Content-Disposition: inline
In-Reply-To: <20260914140821.1805449-5-arnd@kernel.org>
X-Cookie: My vaseline is RUNNING...


--1qyGSh2F9CZZuB0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 04:08:06PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The 'orion' platform is the predecessor to what linux now calls the
> 'mvebu' line of Marvell SoCs, and originally covered orion5x,
> mv78xx0, kirkwood, dove and a few others that do not have any
> upstream support at the moment.

Acked-by: Mark Brown <broonie@kernel.org>

--1qyGSh2F9CZZuB0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqoAlQACgkQJNaLcl1U
h9CoPwf+KNO70g+VRPu8p6pEZepGMgHnp0dH5l2DSpZ2Bs2z5OKSbKQ/h9GMf4X2
p9wqQKJMbRANOK/JnmEgdPFl0zRKjJA+I+4TkACtrQ+841E4a6caZZXXZc319FCU
Awaq/STGzAh+dNEN6p0hiqizuhRr6lWT/3RSyoMrrqEUPSDvoT37wpdO9lnZaPOS
+V6xcrMG+hsm/ZkRfPC63kCVIEepUUoQKX2F+7OsxSLyJNn7blpJQGKltCzNZiqU
d+QGgMod0xSRxbG8WSAGSU09gHudtBroQW/CARCHxg8ueXn2+uqbjx71BVQYP/Kf
c33KOIIwJQ02h1nO/yQgMmQpWEg7PQ==
=jVPv
-----END PGP SIGNATURE-----

--1qyGSh2F9CZZuB0W--
