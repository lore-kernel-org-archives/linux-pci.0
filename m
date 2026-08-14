Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209594457C5
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713937; cv=none; b=FYcsUlWPmV724wxyNQZOmELMUI5f68nqOoEDlXSHrpmYNnkJBAz+gzHT6r+85NUupcowuUulHeaGuNmi5xwnINxue1wO84yCjSSD2tztLDAbQFGX1GPidn0Lt1/ZoFfoVQhQCM0S9FDZFHHuy4COxr3+HkwOGlTR/QHflTYhycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713937; c=relaxed/simple;
	bh=wMEaVxlhuns8hkig2UsUJQAIUbQ2e1I1Zup33AB/514=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAGQwxcE9sDsZvlfT19TB6c4PT2RopkDtovIfGutBQTrIC/+xJFHNL4B8EGSEP5+FtkqnN2TFbo1/TQFY3GkIXEL/rRvztqKHceRvb5KPr3LhOwGN3ITmZRlOZVqYV9dMawXVYJ9j6NvLKPFce6XIjJjM0wCbRsc8esG5mMhzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Er12y8V5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Er12y8V5"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso147599766b.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786713934; x=1787318734; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wMEaVxlhuns8hkig2UsUJQAIUbQ2e1I1Zup33AB/514=;
        b=Er12y8V5oqdgVr/2GdYlKvJqKemoSHlpkVoEx7rMl4fmbPjqspYLNvAeUq3J040r63
         EHqRLgdCkJa2Gk+t1WIHKn+kQ8Owgu5wmHh7FF2RqYZ2dxQL2VB5Hj5KX2W2IVjWxwDG
         FyT48J6JoANv1nbOHjumD6vZgrrcMp35JtFGrG27FsZj2YjRBANRWyLejOu4ViLPWHsP
         aQZw9eoMCWP5UJB7qOW2BScWzHMTMOz40DeNahWoNdpSk6ws1qEZFC0oDdFNZHlk5/2d
         oDQYB0P7YCTmz8mGIhvcMvddmGoOm7kk/oDp5ko3nIWcWkU5c9RB+6o6N74NQs+n3JR0
         rkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786713934; x=1787318734;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMEaVxlhuns8hkig2UsUJQAIUbQ2e1I1Zup33AB/514=;
        b=oiJOx5p94DuGvBvRov8WxFZZs09Xfw8Ssr4pAnQbquXdE51q7H+yS2KaE0nUihe+re
         L0x/layuCuf+ui9ibv41+HX6pSG+jWOOA3l7RG1icLQLuTVA70V/VvTfpasI1BqNjS4+
         y2SFibXRZOMXMrnRj/xaYACEugFwzhGP5ee10K2qATEcZfp0LL9ex7cO9hpEX6uBk3J0
         kyc+ccYZygI1MJ7x0SCPAId1HHoUSSf4F+KJGUdIHv38xoSO6ZSAZc+EFKoI03q2t4GI
         vaf6ZIsuwWJ2BlTyp4va0Zn0QkhJzNlHi1itbObtwLmTYo1y8JnhFe6GCOA0P4CY0RPO
         cLjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6MfuyBIOe3u4pHcRk5jV2KpYJbkNYGpIxBFPy/UP7yyUNBDLrGE4/spGRTVmoTETLhWOWUWTWlt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2MtOb2QODeMiMomldYMeu0EOK1Rr+jzYCfGm3NCUSjKZNc86
	g+SklrJP861vLpr6aKx0zGIqSEGisL9tFNKW9IUrg12HzbeAh4hnmaEI9ExPFZ293jA=
X-Gm-Gg: AR+sD12yHrO72TMyKuf19QQRjy+jmaWpwQSgRggd+B9OWDYfSKWsnIbP/x0icqGth5Y
	vVwUJPLbkuDoAEWE52SIcmM/1FuY+IDmF2nXIhUwBeXXie1uA+4ByUD/9BGONNdqFriMreG29E3
	qz6kZ/Vocgv5Z88sdSd1kLXXY5iqX8ehHmqTYy2cq6LH+0ew+jpax3BPWNhQIHBWgcdAtwU0uCr
	lCjBCWVsioCSQYS91c33TqNmr6VBpgg1/NL6jtoqJk9kZti/bxv2JAsGylvMM4erBKW0/T0W0ds
	B2dAhW1exY07zUztboz18nF7C3qhCllKRHnFpMAxXaWVxKxsvM7NzqjoaKX4hvJYW3aq0IahwsR
	5t6ys8a1IT/Jjp3y9TiQYxbod2ZbqYFn+rAOoL844ToAJBx2z87EDnkMsLyCZG+973Ffj4Gw9MG
	YlxM5uAGxQRjVSXBsyp1CZmijgkwJjMnzsmkoHHXYw0PIxdwMj/K+eTyCJt3sSoEGE5iA2uT7UH
	19HPddiMiyAXZPpvjBYE+ovCE7PIn3qSlbawZcpqxHPSyzMcS85Fsm4o0k+eNKErGLSNwTMKDfV
	64Noera5ZvaSKg==
X-Received: by 2002:a17:906:fe43:b0:c1c:5c90:1bad with SMTP id a640c23a62f3a-c212a154559mr268829266b.14.1786713934359;
        Fri, 14 Aug 2026 06:25:34 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c212339636fsm104236366b.2.2026.08.14.06.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:25:34 -0700 (PDT)
Message-ID: <4b7ee4e9-7a38-401d-9b9e-371173e8165c@suse.com>
Date: Fri, 14 Aug 2026 15:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/pcifront: Fix PCI device reference leak in AER
 handling
To: Ruoyu Wang <ruoyuw560@gmail.com>, xen-devel@lists.xenproject.org
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813153138.3953222-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260813153138.3953222-1-ruoyuw560@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QkHGccM4PCCVbRXCFyU4NGNi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QkHGccM4PCCVbRXCFyU4NGNi
Content-Type: multipart/mixed; boundary="------------IAEm0KX69fq5JmryQhnoqDqx";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>, xen-devel@lists.xenproject.org
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4b7ee4e9-7a38-401d-9b9e-371173e8165c@suse.com>
Subject: Re: [PATCH] xen/pcifront: Fix PCI device reference leak in AER
 handling
References: <20260813153138.3953222-1-ruoyuw560@gmail.com>
In-Reply-To: <20260813153138.3953222-1-ruoyuw560@gmail.com>

--------------IAEm0KX69fq5JmryQhnoqDqx
Content-Type: multipart/mixed; boundary="------------e6EjXp9l0KI8S0BNgoOoL0MO"

--------------e6EjXp9l0KI8S0BNgoOoL0MO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDguMjYgMTc6MzEsIFJ1b3l1IFdhbmcgd3JvdGU6DQo+IHBjaV9nZXRfZG9tYWlu
X2J1c19hbmRfc2xvdCgpIGluY3JlbWVudHMgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiB0aGUN
Cj4gcmV0dXJuZWQgUENJIGRldmljZS4gcGNpZnJvbnRfY29tbW9uX3Byb2Nlc3MoKSBkcm9w
cyB0aGF0IHJlZmVyZW5jZSBvbmx5DQo+IHdoZW4gdGhlIGRldmljZSBvciBpdHMgZHJpdmVy
IGlzIG1pc3NpbmcuIEFsbCBwYXRocyBmb3IgYSBib3VuZCBkZXZpY2UNCj4gZWl0aGVyIHJl
dHVybiBkaXJlY3RseSBhZnRlciBpbnZva2luZyBhbiBlcnJvciByZWNvdmVyeSBjYWxsYmFj
ayBvciBmYWxsDQo+IHRocm91Z2ggd2l0aG91dCBjYWxsaW5nIHBjaV9kZXZfcHV0KCkuIENv
bnNlcXVlbnRseSwgZWFjaCBBRVIgcmVxdWVzdCBmb3INCj4gYSBib3VuZCBkZXZpY2UgbGVh
a3MgYSByZWZlcmVuY2UgYW5kIGNhbiBrZWVwIHRoZSBkZXZpY2UgYWxsb2NhdGVkIGFmdGVy
DQo+IHJlbW92YWwuDQo+IA0KPiBTdG9yZSB0aGUgY2FsbGJhY2sgcmVzdWx0LCByZWxlYXNl
IHRoZSByZWZlcmVuY2UgYWZ0ZXIgY2FsbGJhY2sgZGlzcGF0Y2gsDQo+IGFuZCB0aGVuIHJl
dHVybiB0aGUgcmVzdWx0LiBUaGlzIGtlZXBzIHRoZSBkZXZpY2UgYWxpdmUgd2hpbGUgaXRz
IGNhbGxiYWNrDQo+IHJ1bnMgYW5kIGJhbGFuY2VzIHRoZSBsb29rdXAgb24gZXZlcnkgc3Vj
Y2Vzc2Z1bCBwYXRoLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgYSBzdGF0aWMg
YW5hbHlzaXMgY2hlY2tlciBhbmQgY29uZmlybWVkIGJ5IG1hbnVhbA0KPiBzb3VyY2UgcmV2
aWV3Lg0KPiANCj4gRml4ZXM6IDk1NmE5MjAyY2QxMiAoInhlbi1wY2lmcm9udDogWGVuIFBD
SSBmcm9udGVuZCBkcml2ZXIuIikNCj4gU2lnbmVkLW9mZi1ieTogUnVveXUgV2FuZyA8cnVv
eXV3NTYwQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9z
c0BzdXNlLmNvbT4NCg0KDQpKdWVyZ2VuDQo=
--------------e6EjXp9l0KI8S0BNgoOoL0MO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------e6EjXp9l0KI8S0BNgoOoL0MO--

--------------IAEm0KX69fq5JmryQhnoqDqx--

--------------QkHGccM4PCCVbRXCFyU4NGNi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmp/F00FAwAAAAAACgkQsN6d1ii/Ey9I
yQgAju8yaOfqsyi6C4ahXULTuTk5AvglXAwL3z2+BD8jSyFkX5+zN4N4izExwQt85obHCcFRbKzL
jWuvSaIC5NR4v1YJDydGZeDdiR2wP4C0XTHEafps/quX58OkLOqVCnz61J7KPpaZAKWicUmtdTUX
3QDbVRjsiz4qpUe31kxlN8nNi33KZ7WM1BNHcg4wDVjTnIErTjQ3Nw8+X3/ErTexNcBxPO3Ed8JP
ErYudznnqO8oCXz5jRhA5YK/r6OsKu7kj8z7Vh/SqumIVzxGN5EoNVe4D2PPa5wsW7WBYSZJrbe/
YtGFT5Q4mYvLHSby4wBM2CGl1aSDTNkcdhiGZ2j5Ag==
=sLha
-----END PGP SIGNATURE-----

--------------QkHGccM4PCCVbRXCFyU4NGNi--
