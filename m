Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612B3A380E
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350463; cv=none; b=o2pXu01byEquwg1pQ9ldKnbuHrhj8kvPRcxnbZXST7k9wPmvdAjLOeBCB0HUZhG7jy5ExJmi871BRSXPRNom+Q/O+n5liaOeN+rbAgaHl28Tk3wD407AMvBtr1gU/bt81cY7zKbHD2JU5cGY/PRjmIDTTSwXE5Rp6qiI8goivig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350463; c=relaxed/simple;
	bh=jyOUkIh5U4Jq5jhU7z2i3GFpsJ91ALGPm6dGho+irzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCp5qYlbPM0bq5WoKlpyQd1Rp3sZy5pxBxXEuc8W52AX7HYiQrNmGm3jtJtPXT3OnQ8oCtbK5r6mTOBWC4LBaeFUmN+QMdporAFEx39QLJ/ck9FLpkh2pDzDCGMYsyOyfzPVBbk6sjqnX4I6Q5f4ercf4C7yYAidyRGAfIwOOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMYd3tnK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMYd3tnK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso63513435e9.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350460; x=1779955260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
        b=sMYd3tnKcixc4TQcryuXFsHJHHcf6Rck+SESZmpGXrAsI7x6Z8YAzIEuesmeeZSryR
         rv8lxPh+8AvXyiFUneEmdvJjki/F/v0XYqMjTjaCA3YHFLog5JsgCW70d9L1+Htwj7v0
         LIhzZUWIbTFwtMKwkRifQCpWRWO/yxvD6s3+mddwcwPmNoxwHVGIV6rNXYVYczWQErJf
         kMUeUUGNqu8/NfAm0AVSneG4DYz0UY0FoVCVqsid//QwJEUji4u645frM/CNr8ru+lXn
         aekcWnb6S1iucm4Ch8ycW55uP9VeNRPwCf1uGCWBSNmarlp1zVfOXogZl3C2eJ2Uzv8z
         4ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350460; x=1779955260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAGm6nF0wdUN0d2423OYPWZUGqBbg4/Jc7nYqxEaHM8=;
        b=rNGlkoAlD3J+jR4Ihc1n1rAY8OxfkEceiqD3OtZahgw1JWopUlhFhc2XWYMKV8dVMc
         39+gaY7K+t4t2tlKhDDB8wVC9NVy5ytKeFerBa46AL6kfHZOFQmMkZN/XSWBPf+oaupO
         GzgXLgcjmLzdB1c/6is2tA96KfRn0AhMlT23vdDL4kNM4vajjWygEEbzIfykqC4aLOCw
         SHYCltoEMwr0N2e1vnP96PSOPELsBvuSMIHGmgp57ENtzUtIGVat4IQOeBIhOGyIJRsy
         eawTRyVz/8L33NgWtdtsw36aLBN+QNhHNiDBZDAoU8osANjL8zXHqrRaAaCDq/hlejTC
         pUHw==
X-Forwarded-Encrypted: i=1; AFNElJ9YNAxJ72fyUDOMZZQC2NlmaEFXyclrz5nrSlnB2SUyacE6LJiHZKHOa3qzF+eqsJlN5UuaNo9ISFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymKZq7C65YsqQYe8ZNotwgIw3ujSA5aPvw82qsZ94JYoxiTobh
	PqJTWQ2r8U8/9eUrRa/hoGiw0BzEoXn8fSKOw3VvGlmBhoCBq+i3Ze1V
X-Gm-Gg: Acq92OFx5KyOH7nR5jSOMBEIrs2OYKe6+bGRTFvjlXZ8/wkMDD9WfvkQuq/Ry/E6X8a
	I8rPki0NvM7V1w3U5u1EX7VDuW/TX/l+AJy3p/TmJ7QNzx0ZY7+ZYqdCv+J4nFQcFo1xfBtqDZc
	d+0Y+sJO6qr3Io18EvBPK40h+LB0EcpO8qNgtCS+/JIN2RmS2Fk2KikoPzcaOIgX57TS/9/q9HF
	k1TondnVhfnmQtwChSgzY5lXMtynTsrcdxQRYiy6WnNUf2Y7y9JUdsp9aHRzPb8v3n8AhHvDWl8
	Tna3fIS7XxGWUY8oTGu8Ifqu4LyIGWIElqTMVA2aMYtVlB9jek1zGBrWP6i3tQd8K+rvzuvTT+0
	20mN3NlwzKTrBb48vBrfOtYu/YckfO78V5975fRFXPj51zYti9LRyzKSpkCcOXL11cvjxbWiKo5
	+0OnA07aq6pMUsqodFgON//9sVr5XUQIL5Roz9ME8bU37Xg279WxF+y+RPOWo/vMxxPW/wVJkFV
	1KVdoVyoKmysVUnoNROMCGv
X-Received: by 2002:a05:6000:4027:b0:45e:a0ab:8bc9 with SMTP id ffacd0b85a97d-45ea3dead2amr2513624f8f.41.1779350445635;
        Thu, 21 May 2026 01:00:45 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7dd9e6sm857662f8f.16.2026.05.21.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:00:44 -0700 (PDT)
Date: Thu, 21 May 2026 10:00:41 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
Message-ID: <ag67dmFtSDBC6aPK@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oal4jl4ykfwr5c4"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-2-a6de5da7216b@nvidia.com>


--5oal4jl4ykfwr5c4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/9] drm/nouveau: tegra: Explicitly specify PMC instance
 to use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:53PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  | 2 ++
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Danilo, Lyude, Maarten,

would any of you mind giving an Acked-by so I can pick this up into the
Tegra tree with the rest of the series?

Thanks,
Thierry

--5oal4jl4ykfwr5c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu6kACgkQ3SOs138+
s6FK8BAAgs0A7wFYJOVZxTTW6MNa4zXSjm64uXobpTYaWzKll6wOHDvn6C9dcp/v
MLtSLfP1p1SW/dO74lgYcFcwNaDIZdDsJZmNba+3Jf6PpFLkFdvor5IxklQDCq7p
CTff6BCXl8nTZkHm57wdzn9MMiduUUlKEc1foNpP34dKfb148QjLYdxi/2hFY/ap
VNo3Lr54eMkr3RXicgdgDHq5TXk2gKfSdy+Tve1QiUcemkc36olxR3tcgVSLxPJC
Q66EiKj9g3bjK+fEzB7hA/GeAQOfpuUIObaCdcASbPeCBTyZJY23WbYAF5XMMRDs
LjCs2r/E0EtZLwKY0NGBEZjwzWxF8PddUoqi3TngTTfv/EJ4qx3QzqvAf2DIVKsA
xJgxWd1rDD2HclOQ4GojKyO7CYLt4Xa8hWXPt4V7ajU03l8bOCvKOBNmg6hRD5jp
vHxVRmM/KOteKe7c9VJCMmxmo1oi9lE3e6BCB/VAGm7tzXHK9/43ug3tlh4A4Yk/
ad3eKm3kJxNa4FvJor3dadP6+6C0HUwZkk40TGgkYubsdPfR2kyGI3YZlr1J7cBI
jdRqcYoo/S+HmsreQgBpPXcTUhKqLsTU9/eqQ7V+9SItN6mvX8pPWmUaf+UexFht
1fkm9VtVD/H5bQ0QeOiRpJMXOe/ozNGH0hUKOEywfy7W8syQACc=
=YTdM
-----END PGP SIGNATURE-----

--5oal4jl4ykfwr5c4--
