Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174640;
	b=hvBeKLugZHrzog0S6tanABQ6VN3VOal+R2MTWIyhfhfBS4dEFuOsHvLuvc4EDEC7C7G8
	 sI1suvPxXYzaa3eWktmUioD8ii1k/sLc+U8pRUFO+/3LZwAlkmtAa7zfcuksptl/Oso8S
	 2B9j4qPotXdKjhtTWmtqbT0lzm7xpGayqLcSr5DmQ5UWDaXyCfU84ZgbjSkpNcpVq8cM/
	 nwxugfGXOYjdvYjGU7rhhbbGEuHEgcKLtQYE8HhkOEDPkReHSDiCc8CzjU4mqFHm0kUIK
	 5J41bq76u65cRo96CkCp1S+vnj01B3fwWjhTOtTEJkyJfnU1LW5N/vX2dbrzuPjfAwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cmUygOtzVQYGYmoDrp60NTGZ/egBDRJwiYY9TeXBYAA=;
	b=lVoEW2zhmGhUYbnJkny1RRX+egKfpjlnNx0kDPW8YdrAd6JGqYrSyMepDavy2rEHW5dy
	 plxwh7XO7q3fhcX1OiqHPSp/wxNZpNcdl5ETdbl2l5JLe7Au9PLUIx4eWv1hEbwhDmJ0e
	 TmvlFjirS/OCHUmqe03Fr7tcpvXub1dhHSN1VbnQMV46bl4Nztk3sCBZ83BHmkz53WLZt
	 GkQZvasydKCvwPadHfFAW49CNCmOLtYEPTHfDqOgczwl8Cb5V8rOzNGQqvp5yi9QcT/6M
	 Bu3yDhBxnTzXzXK74R/c0KDy96c+iNpjFIte64MmXhWh2ER0UG9H48J13skafNEcnrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VeacjZeX;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13F606A31E
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 08:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B13F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VeacjZeX
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a208d93758so6376165e9.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793174637; x=1793779437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cmUygOtzVQYGYmoDrp60NTGZ/egBDRJwiYY9TeXBYAA=;
        b=VeacjZeXZ2H13/shN5QKdF0Sxcnm9lpHBcpJfpiq/VZZCzVqilfmiMnO6yd9HPmtP8
         TlP7YPN/+pGErIJoG9jZhviV59zAjTP3slB4ZYlffC2y4ybUKnDtr8VDEBowp1/236dz
         41VKts/axq7MozBdQ1YY2hKuPYsWiXs8pAQof3scRBNPlVaD+qoHb8JXzNRQjfvCr75b
         eBgkGWDxzyyYqgqqf32SsbL+4S69QKep2J7ckixHRyauW04C4j2WRVVeZugAz2hZXeqh
         j/n/IfrenSmA+1cUAixL8t72OKzbOqwY1WpyqJttvkxGfBv2p0MVLHQftbPotHpD4HrN
         s3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793174637; x=1793779437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmUygOtzVQYGYmoDrp60NTGZ/egBDRJwiYY9TeXBYAA=;
        b=LtY4cjvYLUkQNNx0S0hDF8lBMHL7y4gjT1AGbDschlKoC0xwBT+R/mnGgqv3J79szI
         YnUmc+YYWV18Gx3yQOnHkTqsQnprPSCfbjQ2XJPc2/fO5oMx2ilXSDMCwnPnFlD1Fnrw
         pl2j6BNnlZxcpsVGPJ1GqCGvZBFUmNZJpIppeMNF+rCzTFF2yvJYyEtbB1FSfWtWqwEA
         OW7wlr5Z/rbKIOXYa7YoTSc6xfG4WvHxo3AwVkIUtVdbjVUkbuBKw8NFIyYkZy/yZYvE
         /4N31g9LTDTlesyRYL0jcn0lYeHXdKVl+lysP6JAi8OVvMvbTloom1aH28QcPZSQ/r6W
         zbZw==
X-Forwarded-Encrypted: i=1; AKwUvBxKAszuCHEhyMqOphe4FRRBImH8aaH7Yal2hx+cUScf52N6oA1PCsDxKby8FoviQRTc2lsowJuzcuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI50KBzQgednW/l74eW3vNZIfhCgs3JXbTmElTB0b02A8l5arRx
	GeE2y35DOD8iIJvMweBBZQ7+UQNEkmoYFTH/6YikNd0v2V6lq9rIAzet77I50btnn0w=
X-Gm-Gg: AYBFou0mtWToi/1yfqF7GESpafOwpUv2IWQrI/Kswx4Ypr5Ha0Zy0fwXCUVxwkzslNR
	8uy5seS5AeGNlnMPpf+TpUYFN/zFJvFUCAC4vdppdhDvvzcI/pf5MAxnC6HAJ+ZQM1KJpm68pql
	SOydc8xOO3AumRTOf5q9a695rOIPkXKYxWcZ46DJHlccue3N1C7+T76jo549Tsne1dn38ydT+mH
	EF2irw+PhO316mHzkH+t++6fvOchx/cYqQ+8KipaUaLSpQ3mVPDtiwc4BNb+emNWJA5h2QfzhJT
	vvtILHnK5msATwR8vASlMIzTV+jWluQDX7qoUGZCqdelg/UMROK/l8fTdux8ejRuG9WxCFAj1Gm
	LUsLF6P1KxbvKM0mmleBgd/7qv1F9JRqi6eKcaZxL4wjnXbcs5YVI97KrMMnB41Zy7OdqID/2zc
	m5DDSVQZKvypdX0F/nZF3/y0lGN1ertHfsB/9fSspGsAC/ES+zk9awPtT9ntwiVpfZFyu4ziAgv
	OQswnKSvd8c8iSGLhj5I/YJvs9oR4dHfa22YBI6GIy5HBP/hsB4pJeBNJRwhNHLFLLDPcytTQY2
	i+/unMbXgHNXqCRe3uEtV16Y4pZX4nuWjarCq4OIl1gfGrVMTx+xIumKTQElcpI7aQ3rF5B2jSx
	yRxrbnfcaOEjWAlY=
X-Received: by 2002:a05:600c:c117:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4a9672030cbmr23350005e9.22.1793174637584;
        Wed, 28 Oct 2026 01:03:57 -0700 (PDT)
Received: from localhost (p200300f65f19a904c16506b94501b867.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c165:6b9:4501:b867])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a97bf5d6besm25792835e9.4.2026.10.28.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:03:56 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:03:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
Message-ID: <auGsNgw50hDIdm3R@monoceros>
References: <20260908070031.32833-1-kmehltretter@gmail.com>
 <87h5jq8gia.fsf@trenco.lwn.net>
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
	protocol="application/pgp-signature"; boundary="oh5zvfs3ycvvg6bf"
Content-Disposition: inline
In-Reply-To: <87h5jq8gia.fsf@trenco.lwn.net>


--oh5zvfs3ycvvg6bf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
MIME-Version: 1.0

Hello Karl,

On Tue, Sep 15, 2026 at 01:24:29PM -0600, Jonathan Corbet wrote:
> Karl Mehltretter <kmehltretter@gmail.com> writes:
> > Most structs that were defined in <linux/mod_devicetable.h> before were
> > moved to a bus specific header. Follow the movement to get the struct's
> > documentation back.
> >
> > For the list of device ids in basics.rst use an explicit list of all the
> > headers that have kernel-doc annotations and that are not described
> > elsewhere (i.e. pci and mei_cl). <linux/device-id/acpi.h> is left out on
> > purpose, ACPI_DEVICE_CLASS() is not a device id struct.
> >
> > Also repair the referencing in the zh_CN translation of pci.rst and
> > don't duplicate `struct mei_cl_device_id`.
>=20
> This one adds some new build warnings:
>=20
>   Documentation/translations/zh_CN/PCI/pci:98: ./include/linux/pci.h:3: W=
ARNING: Duplicate C declaration, also defined at PCI/pci:3.
>   Declaration is '.. c:struct:: pci_driver'. [duplicate_declaration.c]
>   kernel/Documentation/translations/zh_CN/PCI/pci:106: ./include/linux/de=
vice-id/pci.h:3: WARNING: Duplicate C declaration, also defined at PCI/pci:=
3.
>   Declaration is '.. c:struct:: pci_device_id'. [duplicate_declaration.c]

Do you intend to address this?

Best regards
Uwe

--oh5zvfs3ycvvg6bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrhrGcACgkQj4D7WH0S
/k77+AgAlbsTSlbn2W+qPf7ANkGol57boWPL2S0I72TOezIPXND8DYud1c7YRtKB
PhpKb65OvxBNMec8fqyAFR6akXoak+b0LjgivWXWCOLrQOVwd96tYscMz9T9Zo5a
iRhWUg++SffuMe29/9xFDsjM8JgReW0CUhMfsySfbQm/TSFEl5H+4cCJJsGGtfL3
D1yiIWAQh24ef4OCHJjVjXkWufmtZitqRhecerzr0XU23WE5HyloUqa5j9rMKkiL
0zhPpQMkyPgmas+RNzxq8PVExFJdmjzr8D2BSNitOhQYuzUl762KznuCur+bCurI
6r+fdfpC0jZ68DsEx6a7fNVLvdalZg==
=tz1o
-----END PGP SIGNATURE-----

--oh5zvfs3ycvvg6bf--
