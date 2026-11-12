Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511836;
	b=IMsI1O+4P5w8BjqKixVCImjFRWc9amImpIADMJRWYfDsoFTzSZY/q87rJFsY7Bwm0C1s
	 jNV9mTOedbMs+iCmCjOP+o73ktOpsRrke8DSNAHZ+xp9cwVqY1UxMN+ETvyIsR83ggFkm
	 zJ/f1WFF5A6pp08b+ilNE/jMCEYnTUiy37525oaIN/RldSevEHSzmMXOrKSGDh8/aTrHI
	 GLFy1Nf/42lnBfjqGWbqsc48zZ99GvHb4d8zK2IMIdNAMUONx7CGAroNuPz91P4g9mMTI
	 ytDzixH0I8zN1GhCJpkuY4GGvd6VI88DzAvyXVVzOwQiJBwTbJlLecIjr0EWEU8B7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511836;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=J3WxrQRGopNDU66vbcWMRObNcRT1gSGY3aYp/KopfOU=;
	b=GT2arF3gNypCmnvQJm46SGmRexlNVfNdSnr40Cxx+Re97KHb5H3Acj6kqHU9MKCJxW5j
	 HqnTF6owXw1rMOjW+PbY9PTz2yMFO9cSspQmvJjrFFRJBbpzZ7ZjIC9r++vuo3yBVWbWE
	 Og7apCy0nrF8CgoQYsK5IFR5v1J6g2oxchQfgq6L5rEace4S8h5JTxjNP4AOokczQM4gh
	 cRi1V2Ma8AwhUCZjrBBo9/bx9fB2pL9WD5rfZElV6XxZTQ6y47G7ERkTGvGi41YgQYm5F
	 q3+I8xkz18NPhhxEUclpOJq4YnOuw6yyW6LKsCQBqTnyfEoWO7OCk5e/zqcbk+9ThLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=EPf93kMG;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BE606A334
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 19:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 393BE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=EPf93kMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=J3Wx
	rQRGopNDU66vbcWMRObNcRT1gSGY3aYp/KopfOU=; b=EPf93kMGjdHYDb6ulCsz
	OO7qAQJ66lftMg0xsz8cBWhV2jTm/17pGA2NJ5MdqAz3wMBs70btO3zMea17M7qi
	6IdXnY5wN9nVHU6/gw4w4XXRz2hOzuPzdgyVTI6b28DWa1uwTZJ2+jBMPaQYKTg8
	I6bnjRtpvtsKpCil9mtAQwl6VTZEoD+70JqQZ1bM8wuTqQ3qPjkc5vx4nE1jeQ2j
	DkIXK0eLG5/UZ2DlPX4cMGhVeGbqmBf1BvT16rra1wRVt6glP0crIJtvxj6ONeRD
	JiM2s/jevkvLUNMBxMOW7ZblgKN8I9uDqGgFf/M+2xEYhNbGfgjUziw9M7tMqAH+
	Rw==
Received: (qmail 1105692 invoked from network); 12 Nov 2026 20:30:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Nov 2026 20:30:31 +0100
X-UD-Smtp-Session: l3s3148p1@cQQ3WBlgEu4ujnsG
Date: Thu, 12 Nov 2026 20:30:30 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
Message-ID: <avYT0qDVAq1tItKK@shikoro>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
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
	protocol="application/pgp-signature"; boundary="RyV85lgRIjw+KpUK"
Content-Disposition: inline
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>

--RyV85lgRIjw+KpUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 09:50:11AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Series adds hotplug support for the rzg3s-host driver. This is a
> continuation of the series John posted initially at [1]. Along with it,
> prerequisites fixes and cleanup patches were added.
>=20
> Series was tested on RZ/G3S and RZ/G3E boards by generating consecutive
> link down/up events. The RZ/G3S has an I2C device which, depending on
> the way it is programmed, it controls the state of the PCIe link. The
> board has 3 PCIe interface: PCIE_SLOT, M.2 Key E, M.2 Key B. The
> following script was executed for ~9 hours:
>=20
> #!/bin/sh
>=20
> echo performance > /sys/module/pcie_aspm/parameters/policy
>=20
> while :; do
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xd # Link up: M.2 Key B (NVMe Transcend)
>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xb # Link up: M.2 Key E (WiFi AX200)
> done

Tested with my G3S board and physical plug/unplug as well as the script
above:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--RyV85lgRIjw+KpUK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr2E9IACgkQFA3kzBSg
Kbb9ahAAsiV3mOdb9EPgFqVKtBzJhk5UdZS9yZMihnc+JVJujGlgMFqiU8GR0oBh
ond+Tq2lWvTyjg+djRVpCnpVx+/BLj3uxXDDzovHHF4GOs8HDJOQWohkFIi8FQsa
uNJ6l+07jkzKUtlKisuq9Lutf8tDbsIJqqhotVQI0ygmb3OfNELN+qfaMmZu5Cba
SN54mh3ocjhC5ERBSCXtGhnBO2Z2livPjVIV5bV67aF+GW/C4ZqhEwfXLR5jzujg
4hiqWZEfxCjfE7pfY/5UD8apUyltuiWC6yt45HdkHiAgb+V8yPIpP4nlRUTpBQWi
gqGC2wlHbEbLiPjpbXzzLUvUcDBbI2JLeeSQ6YQn9RoeyzPKIBZU77m7VPulZUpR
ANCP7ewI6RL33OT3W/g4eARXHivJpeI5bTgieJeBYrAcmwJSC/PNxY+UkD89YwYS
sVLvniCV469iOP10iiUjYnAtai2qAvhR+7cCLy6CAPWDNBgJPEAt4oRjLlSBXpeM
64GIzxYmQ+pyKnHwAoDUCRfixNGdydDFsCTfFM8u5mdJ6eZNm0gPMGsNOgkC08Wx
RSVoiaOvdWLdupIgnl5IavCUljvzZtZPAHcBubspk1ZAzVgIT0uA4cCv8f4ICW5F
kCAST8oFakSg1onGjQlVJbJjkQQKxRmEYaWx875+8jXncxo5EqM=
=34Oe
-----END PGP SIGNATURE-----

--RyV85lgRIjw+KpUK--
