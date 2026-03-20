Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF84324707;
	Fri, 20 Mar 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999245; cv=none; b=lJkzFHQBbhSDq01lDXnXjKiSllYo8HCG+5P+ii7Bf2KQMcaN/uQ85D8Mpt+lkmjebmOqPGoEFe+VrWw67pT+9k0gmolMJGX/S7goi4tZNrCoZevwLGlV7n7iSZIoArfOJ1knhTz051NJYyxrIgAw39mbUoRRLLPRIkMXljGL8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999245; c=relaxed/simple;
	bh=ZqkdnmTr1RZKGIn9zMFMXeAOkaFBOBOUV0NLFYqppZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMl9fPYb/kErDM9N2M8+iM9OiMFLar0m4ymvs6+RUPjMqT76IqIDx3V8GmzL34AYAV9OvoU1eBxhKG2Bn0OMSBgBDTzKJtGtiQs3qqrpUBCIV14NC3wh6x1SyEPIJmPTsKFByoUDeXJJL3T7BMl4riKobAfgLTLDK31LSR4PXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkjECuPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkjECuPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD606C4CEF7;
	Fri, 20 Mar 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773999244;
	bh=ZqkdnmTr1RZKGIn9zMFMXeAOkaFBOBOUV0NLFYqppZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkjECuPHSOpDPaarB14JUOSxmgPZ8aX3os78DzPr0Uva4fDvHhYYP0NIJhJsDk7RQ
	 7msxtgW216AoTLDQ8JJ02j2HPNzeVBhjAtUsThrF/gYwrAQ255jozPVUHcXdUt9RxE
	 ax0a9HpwNfvVAH4ALHU3BhUKc/CNX05YBGu3RSOLFVPKMnJ8uTDegmfOibOWDvko73
	 r8EuqwYYwvsVE9o5lZ33MY0NvC3wP+eC0z7Yq3ykAe3efujQy8RP/XJvUKs1Df3eo7
	 HTZ6uGHtyqTxJr27oQjdyU9Wf7jVSK1IjGdxw9oOagDdK1bpm6kTgtkcaIWVBU65wV
	 pzQI1JAUu3FMA==
Date: Fri, 20 Mar 2026 10:34:01 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/5] soc/tegra: Update BPMP ABI header
Message-ID: <ab0T_0Pyio2SYrzq@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-2-thierry.reding@kernel.org>
 <435095b4-ce29-4c8a-9f63-300ff94e419a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kxa3sapo22qfnnf"
Content-Disposition: inline
In-Reply-To: <435095b4-ce29-4c8a-9f63-300ff94e419a@kernel.org>


--7kxa3sapo22qfnnf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] soc/tegra: Update BPMP ABI header
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 05:15:56PM +0100, Krzysztof Kozlowski wrote:
> On 19/03/2026 17:01, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > This update primarily adds various new commands and MRQs for Tegra264,
> > but also contains a few new annotations and fixes.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  include/soc/tegra/bpmp-abi.h | 4565 +++++++++++++++++++++++++++-------
> >  1 file changed, 3671 insertions(+), 894 deletions(-)
> >=20
> > diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
> > index 39bb3f87e28d..6cf6442395f1 100644
> > --- a/include/soc/tegra/bpmp-abi.h
> > +++ b/include/soc/tegra/bpmp-abi.h
> > @@ -1,6 +1,6 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> >  /*
> > - * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
> > + * SPDX-FileCopyrightText: Copyright (c) 2014-2025, NVIDIA CORPORATION=
=2E  All rights reserved.
>=20
> You just replaced correct syntax with discouraged (as in not welcomed
> upstream) SPDX tag.

Fair enough, I'm dropping the tag. I didn't know it was actively
discouraged and I don't see this documented anywhere. I suppose I should
go and drop similar tags from various other sources. Looks like we've
been introducing this recently for Tegra.

Thierry

--7kxa3sapo22qfnnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9FIUACgkQ3SOs138+
s6EYsA//SNNKlRe3t3SUPX3spNqirFTfAQhpfnmouSK5Aw36bpy3uwHdQn6nuuPB
20T7Q7bM32A3yvXhg+r+3T+oN/cxlNR8k0sge1KJJzF0SQ5+nMcseeqTa/6K8a0a
y20jWBXRYOb88BmdK4prkqwIk6s9hgiiBrTvqZ4ULuOsplWH0BfiqNvLCZ8aTWZL
uqiqGNGaPN2b0G/g4HOsB898aC6LOwvTwKKDgxYLsHCxUlGzdHKgbGODEC3XBguu
/qHx0Ca33yT0CZa+s2pJUzc4lEOi0jIMZ482ioGuPrRFJ3+SA67dUyPxyzAK+wz9
7WlD0psL8gHmMrjAa+PXFnR/xy5AfbFJG3e/eD+jQnliQDgGbakI0OkctcGIryAq
vqjASYw6r7krihG3m0nT+Wc8e4pe/0/HiHVIBibaNZdYJ7wiRts6gHOp1HuapH+z
S/JHbf6O7s1hh37c9+7vzKQ5wDJhVlS/QEvDrlBGfNpVkEDFrVZbAbZCH+cVdi8E
Z9rMCI7BT/f5JINh2aQkNHHELUfmq8BVfVSYc6UB6Ttk/IIOAW6s5VCJ0LRPWnzp
p/oypDG0ZFeCCFDUZfKWqf3fVei9YaUtOaSPrE2R9A+DVbPwMThNu5SvsPRm3BiJ
FEMTJ/2m5kmWquwGni5fnsNdZ5CZiRYIKsRDwScH1dLqDv5Pv+A=
=SVZO
-----END PGP SIGNATURE-----

--7kxa3sapo22qfnnf--
