Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605237;
	b=I+T1nFGRR6O9uOK9+5pqvl6vrow8lapnYVkQ+rIbRsGeZ7U2Q4rTVu5Udm4UokkHzQgn
	 g1mmJTD8TFB4pl61Tg4Mvamr7EnqoiDNnKvk7gYclzw1MxKuwPudMtrYluaFgYz3oG9Y0
	 9ZCqR/VSQjXu0raKTme23otW/zVuUDs94NWcEk/lStKV3EgkxNUPzmSHr3iz4TujI14/1
	 z/VGYDHeh881wOjFlKbx8tY+2ZJ9x6gfUFzdipcIsm61yVubHVoIbMZs5YMRka3egR657
	 k0AtD1Vahvnb7HadrQPzzDcHZscSNQeOo7mKw8apPGOCE1gLmrZXKzFqF4swtxDNdrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605237;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=T2bfmfTVonHMt0v5AJiqh5Y6fVlqKVd5+FL2W2G2Mdg=;
	b=OmJydRcsf+rQl0XJelrHDGmXouF8OVvqXjGPfnAxa48tVgyeAj3VvqwkC1woB+RHNOzH
	 WnagYF7UxLmkk3A2G6scoQKE/9rIBWK5NvpRw67stC9LKRNHIs6y1NnDU2/H45E3vJdMH
	 KXCPnCxuB/fcX9ga7F0+gL1XxFgLNh7gyA5+b79obSC9Pz0Ghq8FxUeFFyefSlhuws7i3
	 MHrh2wEvpyjzkX/oQP6l1Th9res/vKnZXlNCmauxmzEY5+PCiOVH+AmWZODzMfAosotJH
	 7UcyRX4JqqMQyDh6CxCe2uN/AyoZPoQ5+lk4URLcYInxWvR/h7yK2Pv4SjADhxohXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=XhbtJ0RB;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A4606A327
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 07:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6A4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=XhbtJ0RB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=T2bf
	mfTVonHMt0v5AJiqh5Y6fVlqKVd5+FL2W2G2Mdg=; b=XhbtJ0RBIuOPALpr79Un
	Bc+yAjR7lv11ORP12EJ8MD1Tjq+b5vVLSc2QImX4QGp2us2GS3tPq8RFg9ZyPnLF
	My4NtQJ2veCzcWKnVr2+wfz7XnlLmqONJZbXN4ctre20206ewxwBUtb9w3pv+C7f
	XWZjumqw67hXwXtGifoTqpyMjNItfxfcfxI8LPHxaper4kuNZRFNeFaIKOCUGs4s
	xMjx0NWTllCvlq5s9PIfwK4v2ZAHkhxoG0NaZIesBzuuaDcdFH94cjxdmtOao1Ow
	PGmEEkJ2Pi72Z2JAZGMBa+LP5KM3dy94aKTMz/82EjM5NtZg/ZBnq5rvCTOZTsP8
	dQ==
Received: (qmail 1033440 invoked from network); 2 Nov 2026 08:40:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Nov 2026 08:40:31 +0100
X-UD-Smtp-Session: l3s3148p1@aaWnQkZfiprB0HFD
Date: Mon, 2 Nov 2026 09:40:30 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
Message-ID: <aug-aSh4MtHR0m7a@shikoro>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <atphAmy8ZIjY_JNC@ninjato>
 <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>
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
	protocol="application/pgp-signature"; boundary="UWEy+q2GwM1RTtG/"
Content-Disposition: inline
In-Reply-To: <f1df2818-be5c-4019-a86f-4e782a70d3fb@kernel.org>

--UWEy+q2GwM1RTtG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

> I currently can't reproduce this on my side. Do you remember if you execu=
ted
> the below command before your test:
>=20
> echo performance > /sys/module/pcie_aspm/parameters/policy

I don't really recall, but I'd guess I did not. Sadly, I can test again
only next week. But then, I'll do it and report back.

Happy hacking,

   Wolfram


--UWEy+q2GwM1RTtG/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmroPmoACgkQFA3kzBSg
KbYqfQ//aVYULKbkf/eGK0L8Y2/BFOX0TSgMTesZYIFqiXXyFfLd6j+UgYQUFj8J
4iq9K4cqVXafdh5NUW8EG0nxkXnHAnKbTCCYncCZvcrJq3w+AiJiU/ucx6LhFkfI
ZVxJHsWCtROGifv4ViRzZNwaCkl0PCtYCHC3d9MspaqlTchYkJ25qiryRgl63zCD
Xby/IA+OD3FC81ixrE45MB4jkVPVkDqv3peHgvy5CO7ghrZY0dfscQjmbo2SIifD
1ru4RT8UYKtCo+np9uDH4oEiibKVkhjt0VHgkIlVORtsiuQiBC/tAJ7LIPl8psgE
981YBaXZNUWlhA/YA6ciObyfO5kVurzSML3wHjyoPsTQU9FfjdrupDJXEiIf+KLQ
Vr6rUhISCJJi919e1DO/Wg07oqFpdqVNSIfQl6ri9gZk6a1uK9ROc3NrqTsjZSAz
rHSY5AwAFaAgLfR+CfDcjRi4uzpyGapCpRzF4gInmRAqHG4BLDc4s5fCEqVvDY2v
5KCNWQWf/x1NrUfTzyo9w3HolvuyroGVkiX9zmslkpxpjyabqt8ap0czmkf1LE8J
o49i7yAHT0kYjqvB/tdCIo1vTxc14CBp78wafmbqS412nkH++xN8ZExdAXK2wOPa
JhJ6toWtTcrS4DXTsDOMVCqWzgAJZymXu1uRHh55KK5TyBiqT54=
=rN3u
-----END PGP SIGNATURE-----

--UWEy+q2GwM1RTtG/--
