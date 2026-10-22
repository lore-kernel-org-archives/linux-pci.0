Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696590;
	b=zcauUHtiJFKSQNxgLRKs5b1qQ42Jna/WxWXjw6XeHSaaEs0xJk9MsEYS+FMFuN0GCkd1
	 FtCH7r46wzVtzE5LalBRcezl/O02SbD+zxg8+cqSJpHo3pd4rvFeYnyHkXYEvHeVPYwTT
	 jqrLpz9EbCJ/zYm4mtBdxBhcA7AUMSHOPhNkMDQodxIi1WESuYQQL6UblWMlxBut9AUOE
	 JhrjvEh8/kTZE91sfqfK0FNNMFRrzJ3OWWPo/94QALU7lc8/ZfdBLrMpHoQtfSsvqxVuc
	 21MwUG2F+VjI9zM9gSqQArLJC5Zpc9vklXs7EveDKpOjI6S3x/XkRQ7/5UHMExL7OyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696590;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=worign4rstbwAXV4Bgti+MrdTiT6gtNxhhZE7rH+EtI=;
	b=sgga8Kf26Jcmrzy29oiMqI8rzarEcCpVOw0Whwf0/rloOKyc56Jpiysnw2XjOzzx4vjp
	 leWIOnnCKBiAR2qKjyEdEdluSivJcww3wgwM+uidrQG0VS6ORN/Q2UenEFpeZGixYVBzd
	 DloeT/VD/me4oHJJoClyadvWY9Y6XtmH/qo6s9KbZu2OPF/XM+xCYbgugIyca/nqJtMvK
	 afDRKj42pMn4nkWdSh4jsgI3m8NN38Dv0UCqDbHkQQavvs6gmDoAmTB8FJO6t3peXg4x4
	 R0yA1FmXWedDRI78QPq74LdCdlVDq00Hql+wPnHSXy2IxdBsKc0xYKls9JQdOLDtuRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bCnt7TT9;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF327606A322
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 19:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF327606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bCnt7TT9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wori
	gn4rstbwAXV4Bgti+MrdTiT6gtNxhhZE7rH+EtI=; b=bCnt7TT9ert32tXRWd8p
	vWHPz7UYsPjM0Hv2sizm5s0Gg3J8gT3tS/0xLufQdjp8XgA3yjQJXnaw0gI4/3S7
	7h/TwBT+22sAyEpp84mbXtRGt19gICHiQi1oWreGn3p44m7uT16UL1LpT7jGxlaa
	afYJW8Ckeu33yIshzsWDoP4IR/gDlfNbSOU4akCF1BkcRiVzMz0ifNge4vZUIIWO
	ReAesxGCTmy/5zrjJwLjcMkvdCgzInj7jLvFeLqSvbaxRTsI65Y5fNA3bjwqndjd
	afDhwTqDRTh0bNKiCNCQhK1A+LOEDLzkvEG9C1LwVS8JglgQIY16XL6ot2RKCxAc
	Zg==
Received: (qmail 1249909 invoked from network); 22 Oct 2026 21:16:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2026 21:16:23 +0200
X-UD-Smtp-Session: l3s3148p1@cd4Ks3JeDpAujns/
Date: Thu, 22 Oct 2026 21:16:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v7 00/14] PCI: rzg3s-host: Add PCIe hotplug support
Message-ID: <atphAmy8ZIjY_JNC@ninjato>
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
	protocol="application/pgp-signature"; boundary="Ow/o1bagopSaNDX2"
Content-Disposition: inline
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>

--Ow/o1bagopSaNDX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Claudiu,

>         i2cset -y 1 0x18 0xf4 0x8 # Link down
>         i2cset -y 1 0x18 0xf4 0xc # Link up: PCIE_SLOT (NVMe Micron)

So, I applied your patches on current -next and did the above.

During LinkUp the card (Renesas USB3 host controller) got correctly
re-initialized. Same for physical unplug/plug.

I don't know nothing about PCI, but I wondered about one thing: after
removal (both physically and via I2C), the card was still present in
/sys/bus/pci/devices. Is that expected?

Thanks and happy hacking,

   Wolfram


--Ow/o1bagopSaNDX2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmraYQMACgkQFA3kzBSg
KbZTrBAAjnY8NNyL5HwH91DskA4hX6y4V7+LCoo7rU++Z6JH9I0vvyhwOwrtdd1Z
DZwhZGMLooSQCG6nuEm+JsWwPUtlWBWULdL8LQkgLHiArPYzyfUGqy7kc9sNgcKQ
vXNToCw0Q5nQXAd6Vkg274EbgtPF9L6MVh+ZkUraMCrA0fkO4CpdKCozsmGdEaqp
u79HtHV3Pc8sfL2dCzFc49NY90NShQykan88ZXZaOhASOS+lEuwRU+rZ8cjV+Atc
M6CZtVE2qjdxVGTSmcN5MyezhfR0y2NOSc6dog1Mr4oWsuHye762gVgxzKrGR+c4
0aGqmmoQ1iAsp5pUumG2zt9SufI8b9/Ig1B789Nlnp/iPA/kBt3rEEAKYo3nxxjB
APayRljviwFErFkgZbAK99OC1F6c60jLdaLD+G0z9fkGbkYdFKngJf8vdtYW26Mc
XKmr3l+d8cHhMcyjD1E2T4c8WxcUj+kNwar5BO8LI0+I3JnAUx2Tihak/s8QrBFY
iikG8/GtgmeYxp2Cr2aK1fVN9nLNyQOTLQm8zP4r0hGTzzSpAb4ebd0y5mt/WNua
2hHaeEWB6O2g6oGRCtn937F7upXhZfJhZjLnoLctPH4chXW60NiK0rJcGJ/loepB
HV4itQoIYpCb8KQ9VsriQLUDFr/db0S9smuYOFZLDshcweCjHzg=
=7/Ow
-----END PGP SIGNATURE-----

--Ow/o1bagopSaNDX2--
