Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CF3BFACB
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607301; cv=none; b=B3JeNP747kMf6fUs5DA6dvN1crQ0VEUPxpWfVvQMQvBo5AQ+VWYITDfGZzotO17m7cFyFrFhIJeeeKBwRn8Wsxbc5v3qfAdzCvdiqNyd9CAxYPhh26jtlPEVMnh3hiGQ7jBDAT9eHEgOEhNLSbzCuULgxkVJC/QRm5djmyst/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607301; c=relaxed/simple;
	bh=YBXAo6X+FgRsRbnvQYwXf6sxV3/zDU7IVdXqxa9lUvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/+GTmfwfi/KtxCl7j8xn0PvgcdS9YHLVETOyiK1t1jHY/MDY18n2cZWIXUUEjRSC7Qqyx/w1B0V/fvAJ1sFJ/xsEDwwacLjjNKip+88uzxlQKqRvB4bEwjDv6gdpufGDt7ckDMCGot22Mlt0Zq/93cjxQd7/k06zsHa+zLcbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dZd0mKg8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dZd0mKg8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495590dde14so26765595e9.0
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788607295; x=1789212095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qNp3/xxedzUk8nrqDnTl7Nzha/3pMiPjAKKXlTQyTxo=;
        b=dZd0mKg8h7NVHF45TKXHJKpkOfbvDm5yCMsf3tbfdfK6M8ktzMFSRhjtrrXD6kxvYm
         1Rx8cs1dpV8Ad4VOUaBkzqrd2wfeuA2pp4mhc/SRfBZBsFskXKQyQ69xuJgJRfAcSYjg
         iCJor+bmSXCdzRtJplT0cnw153eib/g9WBD0YM8Sg8Qrop9O4/Nu90+BfAa9PxXFUcOm
         xDAkyQ1fJSLxpM7wR6D39/BS8EJyLyKJi88WkiXAaeWiodzPQIvddaWlSw/IwiNIm4Xz
         wvFG6IgRA/FzSlSA0/JxDPAsTTlORDC/76HsxGlBNEsGMcqF2m5MZ6LPOVLy0qDcPwFZ
         9d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607295; x=1789212095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qNp3/xxedzUk8nrqDnTl7Nzha/3pMiPjAKKXlTQyTxo=;
        b=sqDstUE3obmh+gfmo+Ih5WDPikbat1KSibtgOxitiKnGSvvlgjnHh94OeYgGj8FiPp
         njhPcuX3v+MrBJVbDoPp9M3mxxLwMz/fgmSaEPRJVHqEXcCmGDtdPS+0KeScTJ4GHoEw
         gWjUOXTl53sxqCK3qOSQm+131NmMv4BfXYW+TZ3jtzm2ED93EJnIP1VRbhcyX07+7Hwj
         BmhXyXEHNA6rk7FNm8duSDCxUQCXP7X4x4+agC0ijtlNR5cImRS3gl4bm7b3FL8YudY5
         XBwofkkWh/lDeWU8KJ9k1qjrA75udtN14vzD4wIwqq4UN/mdpOJB2qijZubdklMXUUoE
         Ensw==
X-Forwarded-Encrypted: i=1; AKwUvBzbYS/8hZWTsBOVu678j+SYXxAOLQl70lPVSre5gDWADINEOW+LLyS9pogYKmO7rFHdx3Uj2oMZqsM=@vger.kernel.org
X-Gm-Message-State: AFuF++m5o63s78ZoJUAwZstdn1UrRxdpKOCu9JR8wc/zUEPCFLH96Gcd
	CiQbXDff6paeNB1Pq7NUPe7Q2kkiY8aekc+adMP/AA9tb+vmzbOnKVfFp6iEtw5bQRQ=
X-Gm-Gg: AYBFou34VtlBSFm562kJtMleAta5y8VrHoduBmI8PflRHOX3eBwIwsyHTlugrdm6YtY
	5HOzorHAEaZoNhQNOGhCUNEPRtrqBbdek4pPUUKhwYPU/zcZkn68dypkhauKbhrqmgQvMrofHPQ
	RIMqwAdK3atDcos8WSoexVgFbft/O21JvJuBxvyhYmGtDjkzo0yI5jpZ46aAENZY95FyOCR5hFq
	K7Z/Ymmq25r7o7kHgzHv1TATX9pz1/SNK6vIZMT+EQjntkMSgOfSgMGTF53R9aoHpFQgdTPJta6
	DgJWeoLmc73zacN/zFaM+ksUtwNbhoSbGuv+zHZByQkN2L4ZRoSD8P+Gt8XOeNYk1q5pLXdfT63
	sY5OAtcp0j55tT9bUjxSkwBJx/RTElkh1SaOXnE8v+tbtZF6mk5XD/eRtTLTDBmpfPGf0Q98GiG
	sFQKy4HiL3Z35sKyl5fgq6MR66IESZ4fC7OAQmsdc3+pZpHG4kGPML8381OQ2wDg1MeUzBeOYnk
	8Vh0w==
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr195801445e9.4.1788607295265;
        Sat, 05 Sep 2026 04:21:35 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49d084d62b0sm3656995e9.2.2026.09.05.04.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 04:21:34 -0700 (PDT)
Date: Sat, 5 Sep 2026 13:21:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: PCI: Point the pci_device_id kernel-doc
 at device-id/pci.h
Message-ID: <apv6yQ1U-HhNglyV@monoceros>
References: <20260905084916.40196-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zbu3z3ocjd6m4xtu"
Content-Disposition: inline
In-Reply-To: <20260905084916.40196-1-kmehltretter@gmail.com>


--zbu3z3ocjd6m4xtu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Documentation: PCI: Point the pci_device_id kernel-doc
 at device-id/pci.h
MIME-Version: 1.0

Hello Karl,

On Sat, Sep 05, 2026 at 10:49:16AM +0200, Karl Mehltretter wrote:
> pci.rst pulls the description of struct pci_device_id from
> include/linux/mod_devicetable.h. Commit ad428f5811bd
> ("mod_devicetable.h: Split into per subsystem headers") moved the
> structure and its kernel-doc comment to include/linux/device-id/pci.h.
> Since then the directive finds nothing and the rendered page no longer
> shows the structure.
>=20
> Point the directive at the new header.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/PCI/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index be35e9a1ee75..71c42b0bfa8b 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -84,7 +84,7 @@ initialization with a pointer to a structure describing=
 the driver
>  The ID table is an array of ``struct pci_device_id`` entries ending with=
 an
>  all-zero entry.  Definitions with static const are generally preferred.
> =20
> -.. kernel-doc:: include/linux/mod_devicetable.h
> +.. kernel-doc:: include/linux/device-id/pci.h
>     :functions: pci_device_id
> =20
>  Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set=
 up

there is prior art that can be found at
https://lore.kernel.org/all/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.178334=
9758.git.ukleinek@kernel.org/.
My patch is more complete, but I didn't respin yet to address Randy's
feedback and so it wasn't picked up yet.

If you want to take over caring for this patch that would be very
welcome, there are too many open threads in my mailbox and I'm happy to
be able to close that one.

Best regards
Uwe

--zbu3z3ocjd6m4xtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqb+zkACgkQj4D7WH0S
/k7BRggAsL6XKZ7KcpoHaZTbEXsVy9y9uzc9908uC5QqxX7b7ymECOYzZrFnGdhm
GJmJ38TlFT4vi45GP/UYGI26m38phCC77pkh1qvjv6gpF5jPgua7qgADMIca6+dk
FG+N/1g7Tk35A+ZuQdKbfLQJTs7/Em2OfIvIIHElUq8qYhJOImnpC5hecRnBJygj
WuibK6f+5NlXFz6m28cgzb6uqPvuf6NTCbn5bDGrt/1brAYSSm4Pj84Wc+fWz1l5
P3ajyep66LzLljrx+T+xBZ8qDgE8bHZ7H77m4LWzWmNOgOyyoUK63v4aQdkwErM0
kqSsETRSIJPwll2XReU3382w5w/7eg==
=+L2D
-----END PGP SIGNATURE-----

--zbu3z3ocjd6m4xtu--
