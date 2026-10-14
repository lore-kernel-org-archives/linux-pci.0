Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246534A49A5
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012031; cv=none; b=CamNPAysrXikcDWjeLRrGEiJTWTHOI2Sz+pJxVEA3rhJJgXmvbZhqkZAyvN5mk7fOWS3opy0MpQ6LqJpZQqWtUT1/4d5ngoVL5Rwnvy3I8g6nxrMeQx/mX34HjQ0my3KAtE0RG/ehzKmf7c5qaK2/ZKvYIuPhAZSm1l15c9P/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012031; c=relaxed/simple;
	bh=G5fHeiHrpOk2vfvskk98XxNTZrpPOhyutiQiQa8eWkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwBvXTopat9YHidkDZnpE46rYocYqEZsbNJI2kd6kvB0/GpWRramrC0PiaZVqOIzb7khTn4U0L5LWvTzKa8a7g8fgO4p7RY7cwZ7MFPeasfBoC0qNTdcIOKUL0sYKYNrPBBRkBVjcnSwXHnN0RmWYMZrg7BulWUgp7EpqYT0LAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0d3adUG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0d3adUG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a061a13884so38879875e9.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012026; x=1792616826; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5fHeiHrpOk2vfvskk98XxNTZrpPOhyutiQiQa8eWkg=;
        b=N0d3adUGbgSQdaGhhpa5kkdhZi54EnRGUxO3dt99xX4lIRQhPC5j4/4WSR8+ptQgEg
         tOm0G/xGNmaTbSB/cPOTHl3VaC/5dpzY2ubRQTo0iCtZqwohYI1tIRLeJaUXXdIVPxRs
         Xg1S8a8jDSenl504aFsFtUap+HtVxr6p1nfUS81MFO6T3ESf8qYDVbIpo/jCTnaUgZGW
         7LmTFRaASkVfNwV9jFlNtf9nURwEAKFp9Wa9T5IL7xiEvcWyR5q5Vd08jZI97yxvwylD
         7/MMvZ+eGAapYj4+P/nQEjo7dPXYeubbNstDxZN0ElWp/gj60GZoCPTge2SWE8rFzPQn
         K/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012026; x=1792616826;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G5fHeiHrpOk2vfvskk98XxNTZrpPOhyutiQiQa8eWkg=;
        b=pbAj2HtHoH4w4cV+w/5QRKTY14UfxpZAZXSoKqvN0peYdYiKRrbiBHqFgmW3VZJUOa
         MVrxrctLqjZtqiPSdK4/08pFQjsEaisCGE9xJN8yMnEKNbtN2dopN5a9HsYr1TNiyK2r
         MjPBb9qzbwFA5La08+ZaLasfXcxvaPUBCKZreK+VOqwBoPv/ZYE6MIQ+O2zRoTl0uPRt
         V4DGqCR68bFQO3lkTJdEwqDpdlsHqG9Fq1tTpEAh6cQHwFtTxoO0sW5Sl6rFqQMgF75e
         Sfz1XeygonVac9nOaVgAIMRjgtsAO4w/zw6yBFf2WZrJR8519OSPlITzq8NQZ1B0XQcK
         o70g==
X-Forwarded-Encrypted: i=1; AKwUvByQtK3MJYNgw/a7MzsMsSCOoNQmIZ5ruFKHbeSfpRDCRkAb+V/KOqNpN+v/rmBiBMOk+wzDqHpcGCc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOTxeshPWqt2aIvogvQe9tzrcH9mHWW3UcgT+0W9nA4NFmHrLv
	Hk+PrS5vO4wccdOt76hy4qFmmjqheWqip2S8jBjDNYvDY+VOrpIR1tKO
X-Gm-Gg: AYBFou2YEnSwHKq/ZivzT65S6m43dldfr26Z4bd6jk4lIQW9ngzDrTbe4TBts+smFqJ
	3m04N3o/hlWDAgLiPiBsYveApd6IsmILmvO2mzcAdq40sDGxM0GjJTqmek/KSWNeECsd6kF9aJD
	9Qpl7HZOTu3dDSIew0TgSIzLeiIYRV8eAXVWm+QBeju/8Or1OKbJti5bnHat5dk7zfnALbs+xdw
	msQSJ9OfvuLOL/TzQlCeuFpJ2m7CId2ZsQ9fEvHvd1LJ6sKHRrygtPLu/ZNpYaz2MAZpTXHJTBm
	tFUIClFYWk91rVDjPucIpywNh2pLcVqNMmLHM+cuCs4IXzbw2IfLdxaFMoQcPFEx8zdcHQmUC/B
	GuTO4UBLazN5cqvyzORVgkJKgWizx5vmQmIZdyF8C5t8kYeEp3Xhosr3OWvrgHt0cWFZKL97ZHC
	Ux2a7g25C2P20pxKneJqTNDtRIQq5Z9qWNbCteNoM7M/5Z06LIX3u/9YHagXyzANNCTYtYrnAPO
	kkuMFUANFCGMLMHBcQyLbPyxB0iqSIuHcSTAhPAsDV0ROKuHyoncACC5sWkaA==
X-Received: by 2002:a05:600c:a088:b0:4a0:2644:80db with SMTP id 5b1f17b1804b1-4a18e4d55a2mr331849525e9.35.1792012025838;
        Wed, 14 Oct 2026 14:07:05 -0700 (PDT)
Received: from silicon.doe.home (91.141.74.240.wireless.dyn.drei.com. [91.141.74.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd68dce7sm8179535e9.3.2026.10.14.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:07:04 -0700 (PDT)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, krzk@kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject:
 Re: [PATCH v2 13/24] PCI: dwc: Add ZTE ZX279128S host controller driver
Date: Wed, 14 Oct 2026 23:06:57 +0200
Message-ID: <1wUqZrTnSiGMTyqeA30cyw@gmail.com>
In-Reply-To: <20261014131954.GA1623979@bhelgaas>
References: <20261014131954.GA1623979@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartzLu3b8EiSJuMDdR1hVgfBw";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPartzLu3b8EiSJuMDdR1hVgfBw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Date: Wed, 14 Oct 2026 23:06:57 +0200
Message-ID: <1wUqZrTnSiGMTyqeA30cyw@gmail.com>
In-Reply-To: <20261014131954.GA1623979@bhelgaas>
References: <20261014131954.GA1623979@bhelgaas>
MIME-Version: 1.0

Hi,

This is mostly a reply for Navid, not Bjorn, but since the topic of=20
capitalization came up=20

Am Mittwoch, 14. Oktober 2026, 15:19:54 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb=20
Bjorn Helgaas:
> Capitalization of "zx279128s" here (menu item, help text, comment
> below) should probably match the commit log and marketing materials
> for this SoC.
>=20
> The config symbol should use the same tag as the subject line.
> PCIE_ZX279128S might be too specific if more SoCs might share this
> driver.

=46or my little pet chip I decided to keep the letters lowercase because th=
e SoC=20
name is borderline unreadable. At least zx297520v3 has some minor visual=20
distinction whereas ZX297520V3 does not. If somebody had asked me why I wou=
ld=20
have said the above and that Linux generally uses snake_case not CamelCase.

So I'd suggest to zse zx279128s rather than ZX279128S unless the symbol is=
=20
capitalized anyway.

Now just wait for the zx234502 charger and zx234290 PMIC...
=20
--nextPartzLu3b8EiSJuMDdR1hVgfBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmrP7vEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMywyAAoJED0TvMhUTxoihqoP/2vakcsfXpu+Ci+GS+WV
e7rBcoFUyeSymrqBIbFTVnyAjrjc8gPnoJsgGCeYhjKPqMuHfgoic0eVqtS4cMq8
BHExipQPVyxZO6NW0HMfIEhbII9WDqdctyOcuy2GSedoIMJzIPWMXpMnX46JyKOB
1MBV8Q/S8GWhnhk1T/KCKwkaSoSZJHhoiw/lo5o8F+P8I9dcp7ZrxHx5adGFs+fe
UNcC27+Sp3EVDpBFGm2+6CCGXA0d/Qo7Uk5ty7NM0+HSJXcALpE+7LaJiI/86tTw
Vt3hTnzzG0eN0Tip7+9uRebVf+Qs9c7bfw8Sul479iAAxyG9Z6P3HOWpFb+w8yED
YOClg/A/MOekZBJXb7IYLXV4ENzO3pDqoKI2X8UX8lkNhHQsQzT1ZNHyMTMrvbbk
EaRsivRO0CHD9AAX5PlqzJCpNKNEexkpzqkIN9cCBDl0OcY/Lcx0YT2Zo0F0bY0J
9K8/B9tRssVA56pmeoMY4Yf9cOGXFBOUXiNhJloY/r4pNYA8dCp68WWAB/pVxfGJ
qKiMZAcpZ7oUuw4ShbC4SufoVUrsvcxNWwuuNex2mpLspZCO70Dpy/Vlxs6KAQb7
Dsyp9HyIVZq21HsJ67gfF1MMRcEKqg/zJPA+6PpI9QwuLB9kJFmh5dH/oSd+HJsK
q2rJ6y1sOhtsWG3VBwTYdMBy
=fL1G
-----END PGP SIGNATURE-----

--nextPartzLu3b8EiSJuMDdR1hVgfBw--



