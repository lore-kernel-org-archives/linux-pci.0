Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEB3C7DF0
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444939; cv=none; b=HnCQEtLHKFEohyiznabrniAjKYkEMnjoOLE/xaj2/dM3NplJ39cAn4giG2cDHvQzuAxkEibMgjih1L9312W9EWu4RR1NkAUGz1qHmBjkRj4UsFsF+JGLudA9g0xqdRSwjnHfT92+unfJSdl7KgS5utXxBHgWnL0VpzgWIPo8+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444939; c=relaxed/simple;
	bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSpWA7eRhfCmE22rSEaoY/eflx5GySjiq5BvnirI/sfl2aRy6330eYXPx4TUOpRnHb40G68ednOwhmHUTCB13O2Ze9FqG9dXC14ElZmo5b5RwzNUt/NOM4NiotHu9mUJRkXHHh/1GtO4wWS35J19Kquf4LEnVWJVK2myYzN6nQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3xQEC3n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3xQEC3n"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so40056295e9.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444936; x=1780049736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
        b=T3xQEC3nEmnuLNZ3gZBTSC6yv6J03YL5MQt5irY5+v0SH1VGr2ThripFTNPGJzedAy
         1NBFLUpwv/1+E5Er5joEdIxPy32+FRJHLV5Sa27SYP3SzRSDbQcj0XQzOxfQACrQqL5O
         9B0NVhsHm2ZWwdr2mgqHeHKPxK9sSEphmgbk43ut5rXFH4bPIuqWsGm2UaddkUVcHpxO
         sB9CchfsQaVOCQzcTWgOexjNztzauzE5fj+CjuW9PgT3QedCCzSCy7aXY+V+PnSAG7Qw
         YKrrI8mT+KjHtdr0lP2oZklUNhqKn8WudBpWzJUBepA9VX0wjBrT+Fk9qblPZhIpkF6y
         KMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444936; x=1780049736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFoNmBbf70FRqGV5pmUwMEHTZE5OKrs8CbDRqYE1oiQ=;
        b=AVxjVoPsDZVidbOcGyOSaC23yj6Y+HFVG2/9XOkkL8zmWf0iXsog+GSdRmNjPnFKsh
         obkI2sqqwSexBBx9K6EeMlEbW9OJ20FIniErhVcX13Jd7ZGJyFK0cQ6AYOW2J9pO8I79
         373FX9Y4RubFk+1DFBK7Vsh1CToUU1uOiwEaC4lYLnWmh+iA1I4UivO3Scyt/hiCoWfi
         oQC2271ZxcspdThQYq5wM7bfo3I5XCkPJIWTOpG2SL3le1hkJgJYkt0kQc+biB5hy09X
         b/hAWc4ENygln+jVH5ikPbNzq7ZFdp0pKJEDMZDKvxGogE+BH1V2JBEZdPg3joVNKcoW
         nCAA==
X-Forwarded-Encrypted: i=1; AFNElJ9/K8o4prFJPe6GLdLzkCk6YGKG8oCs6joxsX7GH5gMxPaX+p0Vyz8gZ+q2ly1ELabd/XXuKKBvoJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZM3jjZOCN8sCK0Qobw7110/VY2cyG/SD8YtFZPBO4O4npho5G
	S00p12i9Q4o7aV/vBgBJHD2a6EvOx9uYAjtJ1lMuJS4sZTKfkeo4qhKA
X-Gm-Gg: Acq92OHdVPOqiX6NGk4DQPbioUlFHAV8Z+cGKYZHBk3XI6jOj1qi/HyDElh3fEkD9vY
	p38VyAF2lnnRky47QSdyUMiYGjbRUVRey1GxZLKGyw8aXFvAyfT9gf0WzBYk3yJ/VxSPiWNv409
	jk9CK5wbOo1F+dXMdkEZTF/n931OGTolxEGd9ZuAusliSYeOpli8z5a2Tx84BazlxY+sji3hwi+
	GxfWqHmuLQK9EHkVHg8DO5g+BrUmtt67LymwADV0q1reAi9ETU2YcvKoiY7wEFAzmCAk4ql4y73
	3LnuH3afIbpuXa19AluswIjC1pJFfuH+JK0TsULKINCl9m28Jx/pfO484V/Ie0Qu9wBxTh9v5m8
	XhfkgR0U5Djv4SGr2cAcExtMi/o7lYstBZoEIXT6I/OXQuJURQ+s/izvKE8RUlkSU3Ek4/fiRnB
	thoWC+wzyEPUnrOAW0sj8s1/aSjeqmofK8cLbU5pahhmB9qf8YQvgivBo/JLgFFen8GBpbWY59y
	O4kJ9R/Ooqezd3bZdqhP2bh
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490426b0c92mr24655565e9.16.1779444935807;
        Fri, 22 May 2026 03:15:35 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm30624875e9.6.2026.05.22.03.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:15:29 -0700 (PDT)
Date: Fri, 22 May 2026 12:15:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ahAst802sjuJr7-l@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
 <ag67dmFtSDBC6aPK@orome>
 <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtz3f4pwlb7uchwq"
Content-Disposition: inline
In-Reply-To: <f08c6164-78d4-4c79-b4d9-d7e883e5a0c0@kernel.org>


--qtz3f4pwlb7uchwq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Thu, May 21, 2026 at 04:04:28PM +0200, Danilo Krummrich wrote:
> On 5/21/26 10:00 AM, Thierry Reding wrote:
> > would any of you mind giving an Acked-by so I can pick this up into the
> > Tegra tree with the rest of the series?
> Sorry, I thought I already replied to this.
>=20
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

Thierry

--qtz3f4pwlb7uchwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQLL0ACgkQ3SOs138+
s6G6mg//ZTSVOV0O5XnlSqUo1fdyiV44Qxo3ysbWUv2+O3w+r5WwMjgdyUM9yAbS
cdsRz3LHOAYcXBxYZhtdkLh5KhhvjdkUk4e1fdo/5QSGjRPARHPS3bQAZbnpZy46
tWvdiKwj2fM2rZ5JQHvYEjGCSQ9hGa/9Ri3OnGti51rcUbCJhJS/J1KgyJ/UOmyn
ZKLr/2FfTbmC8w0Ukki+CV3d4JV/pxY1UNjyt7x568o6JlebDPK6M7PKMI/IM6GW
fHt0U+f335ljan2LD8HZfSia4sa2nZJnbJDtIEj1ov6suhrowY9Mne4JQTEwjuLX
db6abSI9ox3O3vkx7Zd1G795TZUWTXKlw2SHr5vMyOBXhJHtipm7y0bAwj4ZJiAp
5ghmBQzl9HdBVy8x8x8SjmVCygxrt2rOVocYDG1/Uc5DSZWa8aa3VQJMK6WZy9gB
9G47X1VZPs9B/KeqE5TWRwB05OHuLeCIVQz8Nd06DjN0IEUStecgDWXm0bs4UNWZ
zMwz/HPgK4zp59HRlVqgoYRNrIRXCd5wmz5t+JdqDwbytna2YVTV7u/3FOGgn/rD
HgxwYqtJsO3KosQ3UN/HKPoEk67noCBWMrSzZbwFhw/DziZwEn4mr+slHKizUvrF
40Ir94vEC6DhMDCNJClxmU6S9zhRoKUOqW3FLyPgC1Ghfp5RQrQ=
=MZIt
-----END PGP SIGNATURE-----

--qtz3f4pwlb7uchwq--
