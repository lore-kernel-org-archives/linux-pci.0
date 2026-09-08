Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144214E66B8
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860760; cv=none; b=mB2H9lKFLmD8oEJd7OIlFo+dTGrpE/MfOKXH58lBV+Mn11SUlcXUdjdPATULUGhbXKKU54AZ56XNmWU6vsAsWmMcJ/EBzykie5a6FRPql2wVfjNOTav8i0nNr/mLlRMj9OIjrcXzMIZWBQvqiWCFeuTT4gBP65E68TSP0DFOaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860760; c=relaxed/simple;
	bh=G44DxRMCSfchDoDxEWvMl+JE8jqtlWlGW22zD22lDQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/WYri2roJiPb7rK6xsM8ssOl521w4yCk6T0naWG37tqkgLomY3TJ1MkfY2ZYe3rTGzBMBNj0q9QMVuFnniYZs29Z3mhW+zjUMngmhnfUMSaAx7JksJD2Cd8It+FJm9x09GEWUWcdvdrstWXbboMEycsDzwKBgY0RebEd3fKyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=e7YDPNss; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="e7YDPNss"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso47906265e9.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788860755; x=1789465555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wl0avOHzFae6yeME6k9M5ir8m7lNuNYJR44ZHmJ09/E=;
        b=e7YDPNsshs7TQMtCzlsQZJAmj7Hfq+ayxy4Dx8E/yRFluokz8tUlVz1cfHHer5m2Ox
         FS6bCv62whU8Yn0EF+H2Q6dK68yvp/PcF9Pag4yCdNLQR5iSOCay9XYOwqjQI8ZljZEQ
         9t6fNtWecrXIorLw7l+KJIhGTACRzRR73B1YiuyfpFOno/whtsnWh5CUJt4J/5eG9BIN
         iXcbJTZbFkrAIg5PbjqtegcanidY31PEGNfjXDsaMvY4TlxBEGp27NKQ5a/Yd7hz+YOh
         iMCBwJ4y35q9lZ0rJ0qbbcSdXerVs8LUQiebfCTwerTwr7mVskbsIHVodp/QBhH5vwEk
         D9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860755; x=1789465555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wl0avOHzFae6yeME6k9M5ir8m7lNuNYJR44ZHmJ09/E=;
        b=jLWQc8mKwuLarcTok+RAp4tOJDPPBfCxx4rlHlq3AIx3Egg5BbIFh6b596YYLYdrui
         rd9g2fIFdcdZly8ABXa+UU/ZZmJGN8ba4Gq7fX4G8L61gUIa1JRsw3kQYtQR1pK7Qjyo
         Ici9dRNfGq4j306sUlzQ/yBYGhLBuwQbquWt2tEZWd69oHU7ulhsr5kUqFSmRAIpgjCC
         V9qSIIhm3K+IqD4klatwZt9WTyPyuJTkISI7eSMumSgumuLsnuzTvltbdYfRNTu+25DB
         eQi1lYgKQdgpgZxaA1EYUSRe/VEmNIc8O/CRI1dnCUC8bGGvmJ01BIZGcGj/M/Lsr+Tf
         eoSw==
X-Forwarded-Encrypted: i=1; AKwUvBw1AxUO9XFNGp1DDzMqW/v6vvHZc+KPzhju8rVeMdn7eBPVpnPQW8Kl4KjkUNAE4gFzFVf2XDxIskc=@vger.kernel.org
X-Gm-Message-State: AFuF++m1LZPjmSyxujvWgBbRruneYx34N/nMPXqqbpl6+8Vv//8CujeC
	Of1eH0l8k60ylEj+0s02Gl/GlOnTURi7gAiakceWiVBDY/9ltr+yzkybmYpxqpVTqeM=
X-Gm-Gg: AYBFou3l0KZ5XCYEJTNoqfVA1UTRTMFx3pObtK/jQRPCIClk5dwX8Cw7jdQHIyBPi1Q
	/3h692n8oHluL31zVTfiep/GhuAVx7SBYwWnHszV1DhAqGXIJclHnxnhkZ+H2IX9OkGX8ZfAILi
	UoVIX6qgFulQZ0Vow7OontXdldyr4am+TKrZ0kPMTjhPdpaTBRTxuS6gaZuYSTK1y78Bh0O52iI
	e6voVB3LwDOSsXM2NgdeS1BRx5jRRPjFWv0j5ZffQUJWr5vmsHCSYLjqRt6O/jgsOplZMcfwc5N
	Cdb9Wxw4JM634UrTAh2QFOiVk10ay1Xm0KNX5MI8zXF+D4PgUJvyTj7bm+UTAT+yaUzeZb8m+J3
	viGPyw3ggUNu7X9jzgXljlFN3874Vyfr+Hauc4y9NJjf/x3Kzwt2cOov5W61m9gNZyQC5CpCik+
	RCaDAQO+8BAHhLbKtZk5ivLgJL3a1WyhH3rYwMRyZ50nkx/LN04axkoD7gBXHiRozX2PbuFovZd
	kM0Kz74sQXEgAnY6lDxo8qcwYf3m1A9NyvxvJmmnOcZLJV4of8=
X-Received: by 2002:a05:600c:4714:b0:49d:462:6eda with SMTP id 5b1f17b1804b1-49d04627387mr181766045e9.28.1788860755049;
        Tue, 08 Sep 2026 02:45:55 -0700 (PDT)
Received: from localhost (p200300f65f19a904516ed84e8e7b3ca0.dip0.t-ipconnect.de. [2003:f6:5f19:a904:516e:d84e:8e7b:3ca0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cf755c22esm381511115e9.0.2026.09.08.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:45:54 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:45:52 +0200
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
Message-ID: <ap_ZJ2jeeNjt5efL@monoceros>
References: <20260908070031.32833-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cp3al62w6dmuwvcj"
Content-Disposition: inline
In-Reply-To: <20260908070031.32833-1-kmehltretter@gmail.com>


--cp3al62w6dmuwvcj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
MIME-Version: 1.0

Hello Karl,

On Tue, Sep 08, 2026 at 09:00:31AM +0200, Karl Mehltretter wrote:
> From: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com>
>=20
> Most structs that were defined in <linux/mod_devicetable.h> before were
> moved to a bus specific header. Follow the movement to get the struct's
> documentation back.
>=20
> For the list of device ids in basics.rst use an explicit list of all the
> headers that have kernel-doc annotations and that are not described
> elsewhere (i.e. pci and mei_cl). <linux/device-id/acpi.h> is left out on
> purpose, ACPI_DEVICE_CLASS() is not a device id struct.
>=20
> Also repair the referencing in the zh_CN translation of pci.rst and
> don't duplicate `struct mei_cl_device_id`.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> [Karl Mehltretter: use the :file: role in pcmcia/driver.rst, say why
>  acpi.h is left out]
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks for picking that up, very appreciated!

Best regards
Uwe

--cp3al62w6dmuwvcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqf2U4ACgkQj4D7WH0S
/k7OVQf+IlKONDaaztlIwfKaa0tzBz113Wbuwo/LTE9M5Uj8sB6TEzOpdW6kLfYy
/Ff3VZKsMFI23/pBXI6ChqLnre5R88st2b25kIGSVNR/HQdBhb9tDb/+FqGmg3Xe
FtlnJTfXZQSpofT+HFWdjX/JjJSS2ORm1wEV3FS0jBcsWbJX69KYp2OVihcQk7Kw
qv8nvMC4wSPu5pxAaY+b5/ub1LcdOzLaaEPJ11X7mU5dG0MrmzE4brRg0jJ+5yEC
7N7762W0cab51/ZYW9ozmDOsYYWRoINBEuSrfjbKZeDumE3hnD8qRWW/OW9IsvPb
Au1Jzkj1/mkoW7XHNi5yrAXXHy6wew==
=27sS
-----END PGP SIGNATURE-----

--cp3al62w6dmuwvcj--
