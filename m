Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FD383C93
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350356; cv=none; b=CekT2+UncH1kHlu47ZqDqh1UYPkVeYa9MZLn3rlJWEI8GMcVcEr6n0bnDvFEFNAemM3T8BizrTn+d+p9jkk1OALqpV0EpHrL+YrG3OjblF2vteipcEB3bSPFrzk+vTUe0D4BJtTXQiOQ9SxpbbBXxWOGRkHX6CZ1384nMSmWmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350356; c=relaxed/simple;
	bh=/1x4coy+EhRxr4G74Byh3jOJGsE6QncBFV+p/Hi25m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXIXQA3/ZP9cA/oQAYe5gH129q0rw876uudJNrBwB0z5KqCPI3ayaaaP/yJvMTg97+0F3dKFDlMPFcqKnuTa0OwMjOnnwJxgduY3rRa92N+xlw9uObsggUfHBN0sb1nMHmkbs2nDgpGtWRr4BRD30+MyU2d56DeDM1xPvk3TnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCpNOv5A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCpNOv5A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso68247685e9.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350352; x=1779955152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
        b=tCpNOv5A8HdCnQTC2YO6ZmPUIap2OWuVg6KtEdVlpXcpKiO/YpeIEsNE09QOC0vPcp
         mbkj5o0ucQMdZBIgSSBrhyC/5QY7B47hG7LDVU9TFDXSzpHKknB4pvMZaTz13AtS7g8D
         BDej5suWOmQEY1V2jTm/nLuzsxDmemRcGY3F3BsoCEQm3TZqKL7//xBS/cYch4hNkR+L
         s3pr2Vw+4nE0uzPECzfz3ZBPiU7WNMyEj6Xu711+lGijH909MMqqhvwK7DJhjsS/BZfo
         9CNxpVPVl792FLvzHh6sTfal8LBre/LuucO8+uBxwPHGogDvoGMGQWWey9guSQZqvaI8
         OArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350352; x=1779955152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfHyghQkuGkWqA8eUzVzPKJ2kyI5blFU5Z3V4gExrrw=;
        b=gdYxcYB/SarJG4Ku+ydlRtoH5GIeVMQTG3JYQiSshnJxTmnOMiDW4fKa2fQT15F/4I
         I8rLZnMMhSO2x5os8idAs/WekBlAsuFOsiigTmeram+w0IPmVs2LJgbItFSqqXA/5wLU
         mpPq3sLle4YLYnSRxQZqFPdKDx54BaEvWM9plkMHpHy9Nq6liLehLQfzsBSYiNgFE6h9
         NYHPGTT3R37DX+GTO4NqpOWeiZfiIP8kI19GO7MWx2yB9/KsYaratvTtH5VWEMEEoWvp
         1O878+ArAgnvQbiNIx6SGpnZhYWlohyL7ZM3zUnTCrTf9MPXrNfvzbOo1+0LHFmoHMS5
         CUIA==
X-Forwarded-Encrypted: i=1; AFNElJ/stWxnartZTjaPYx0lko2AXVORA3BFwQfdCGlTXjvhtvrpiq9LVAkdOCoDgup9BK8IFI+BWRMgL8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQ+L4mqcdAcooULf73liP/EUzaEc/yHyxOl5vw4K//tm4tQTn
	BwSi13GT7TcfDOxpJ6whkqP/ltLAS7mT9+CFkJFlJ8am4oSy9mJMiqPL
X-Gm-Gg: Acq92OFJUih3Z2BE0rh8hkEb1OHoPaSyQz5GZHE0+qPLKzwZzhQViM1PSlLE6D+9GBx
	GjqQO8N2tcAmfvlPaq/qPu/AZRoRB43oPBPsZ7nzDbAQ2jGgjv/zNcmSYefWO/k8D2cted7Ha+N
	qu0voaiNv7wGoEbvn/0MaQsTLCzdzgKHDN6AREMv6iUUA1hSqFHWgDyyAQhpqhxrWoIZQyZF0fc
	ltLzCqRBdZIrvDmU2fgzcahXBSpFzepx8umkoY2m9g3ciLIbMDiScW94uFA8d1pZslSgvLMi1Cn
	m1EgejGvx//8dTbCs1+q4mFr46fu4TapMKe7Eq+oaonvSbQHa+yDBMjCnjL23Dsp33/c0rgrE7T
	eSW0lS5Ct2XWFdIelnZN0FssmdbPNsg4IlgAy4DzEi2J3QcdgQoFpMXyjEd2kYBlPpz68TUaYk9
	GoqedwRiKsNh7TTL/XIV+1T8OFzsoDK0T8hi5sO8qoBPs0DiLwJwSw8RYLyMFhbp1RWlcsciEjr
	ZT48LpNn220XA==
X-Received: by 2002:a05:600c:30d3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-4903605d86bmr12514805e9.9.1779350351689;
        Thu, 21 May 2026 00:59:11 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490387d16basm5521255e9.35.2026.05.21.00.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:59:09 -0700 (PDT)
Date: Thu, 21 May 2026 09:59:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
Message-ID: <ag67FStKnQcvNOrP@orome>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4bqtknoba4e2ooc"
Content-Disposition: inline
In-Reply-To: <20260506-pmc-v1-6-a6de5da7216b@nvidia.com>


--o4bqtknoba4e2ooc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
MIME-Version: 1.0

On Wed, May 06, 2026 at 03:41:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Mathias, Greg,

can you ack this so I can pick it up into the Tegra tree for simple
dependency resolution?

Thanks,
Thierry

--o4bqtknoba4e2ooc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOu0oACgkQ3SOs138+
s6HRkRAAqo5/UZ1fUVfF67PnLxU9m4v7JcLF4Ytf/Z7v087AEjfB1FXekO/SfEUl
dvex3+uqG9CIaSIQtQ8rxWgfEyOZeFirJloIENzJtaXACdsld465AHpQKBNbI5xU
/euNFiOwGTIgOHGhhxAIurS7F5Ag0WgWOTDN2uBlYGiDeuZShkW3Ek3M1WHSF2ey
Ai6uDC6tf03sgZla9uXS+eOZHkVaTx9pRDE1oxxHHLMtwgfkkl9BEHKxJ4ZqTYk8
6G5Bdz88LVtn4VWK2v/B+E6LiY5FJWuS2bM0PeRI2KpkB3F1jUy0rnC3OjdcMBjE
zyezSJsdMXkgODfA1zpIjGaAWjJ/wkU3ptsQ2EHq2+uTAji5OBUP/fquL+uOI+xH
WIHngd8r7BaBvygQpvVPl3YAC26qyRDmRqptWTXY/uISmcwmRZ6BaQTBsx1WOPmM
mFdZE0rVwRSfMws0GpPu6Atz++gerVHz/2EAFKPrntor6zUjSTbF3B42XCtIwpyO
T1Wmpfdvpt02fe1SjJvhkFCHzCv2sHvUqshC79KoN0gavq9732DOpJdn8aN8YTfe
GK4ekoKpjRZr5MUhTWGmRL0wrDNysBgOur97daSMrtrJNs+s8wlXA+9CP9nyICzs
2bbPfHWWQ78FiSSH8IOW/xAAFxM7aEh2UcHuajcX9pBLFwOnveo=
=ByYw
-----END PGP SIGNATURE-----

--o4bqtknoba4e2ooc--
