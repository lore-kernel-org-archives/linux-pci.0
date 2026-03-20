Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E731F994;
	Fri, 20 Mar 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003940; cv=none; b=XhULFf6aWCHPhVnbVuiv4KiHg/ARwNYIB5UurbyzthenOJDeH3MH1EckQDvyeFs4e+6Zl+5Qln4P+nLHuVIr7sBhqsvmeK8kmu53TdSnle65ILyHqWwJspGeisvvfou0/V/a04GABaq0GpL/0vw+MZRBdFyfP4yVEgmigpphS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003940; c=relaxed/simple;
	bh=nWnGcx4oZnKCFiRxJG4rnPGbEnFPVvJfKZJowNAm2nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYgoNVRZSOQjDD/ShFU6W5vGQrtQ3/6bh3MpgBIFVqR35v0tpbcW2xVGRQVeYrFRfJ+M2qMBE+g0uGjRFf99hxO92+62zkPn+fuXn31AUECgT6+1UBK59o9nQm3j+DCBvjxthRBqjOSbSDDpR/uHs0qkYJnsqFbOfjR1jcGUWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tavyppr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tavyppr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2836C4CEF7;
	Fri, 20 Mar 2026 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003940;
	bh=nWnGcx4oZnKCFiRxJG4rnPGbEnFPVvJfKZJowNAm2nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tavyppr4S4D6vcQiDqcUZ4Nby0+YRCYfYd1t63E9f3gq7wQad7gCb2Fo+Kdu9qojg
	 hSVOLpaSCxPJr/mprYMcgPOWC0D6fouOMxHWnaQ/O9YhsdAciShgtJXnZfovtUCGwp
	 AkIgAF2AqM4+Cw5dffHEN3hhBvs6YL2ZzZrnN2KUEB3EY/FFv9/1w9gJZMTx4cpQ05
	 nQHPPrskUGOgPPs5xdREPg2IoVUjq8t9xdtKJLIOP+0CbxK41QLy7jraucEcNrgz/K
	 urrhQIu5+JTcRTQB07fgEmWSEqDug3yqRyLPt/wrCmkz9HRnLp6jl1kRhU0MWWhDHI
	 rBhcdYVUHoFyw==
Date: Fri, 20 Mar 2026 11:52:17 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/5] soc/tegra: Update BPMP ABI header
Message-ID: <ab0kVVacojo8SLfw@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-2-thierry.reding@kernel.org>
 <435095b4-ce29-4c8a-9f63-300ff94e419a@kernel.org>
 <ab0T_0Pyio2SYrzq@orome>
 <1357d59f-7c38-4de0-9cc8-b40be3d7ce5b@kernel.org>
 <e238644c-132a-43fc-b735-70f04ef3f212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2g6mysymwufbfqc"
Content-Disposition: inline
In-Reply-To: <e238644c-132a-43fc-b735-70f04ef3f212@kernel.org>


--u2g6mysymwufbfqc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] soc/tegra: Update BPMP ABI header
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 10:49:43AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2026 10:44, Krzysztof Kozlowski wrote:
> > On 20/03/2026 10:34, Thierry Reding wrote:
> >> On Thu, Mar 19, 2026 at 05:15:56PM +0100, Krzysztof Kozlowski wrote:
> >>> On 19/03/2026 17:01, Thierry Reding wrote:
> >>>> From: Thierry Reding <treding@nvidia.com>
> >>>>
> >>>> This update primarily adds various new commands and MRQs for Tegra26=
4,
> >>>> but also contains a few new annotations and fixes.
> >>>>
> >>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>>> ---
> >>>>  include/soc/tegra/bpmp-abi.h | 4565 +++++++++++++++++++++++++++----=
---
> >>>>  1 file changed, 3671 insertions(+), 894 deletions(-)
> >>>>
> >>>> diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-a=
bi.h
> >>>> index 39bb3f87e28d..6cf6442395f1 100644
> >>>> --- a/include/soc/tegra/bpmp-abi.h
> >>>> +++ b/include/soc/tegra/bpmp-abi.h
> >>>> @@ -1,6 +1,6 @@
> >>>> -/* SPDX-License-Identifier: GPL-2.0-only */
> >>>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>=20
> I missed this part here - that's license change. This has like 10
> different authors, so you must be explicit about it in commit msg and
> you must get their acks.

I'm not a lawyer, but any non-NVIDIA contributions to this file were a
license header changes by Thomas and typofixes by a random assortment of
people. I don't think any of those changes qualify as copyrightable or
licensable.

> >>>>  /*
> >>>> - * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserve=
d.
> >>>> + * SPDX-FileCopyrightText: Copyright (c) 2014-2025, NVIDIA CORPORAT=
ION.  All rights reserved.
> >>>
> >>> You just replaced correct syntax with discouraged (as in not welcomed
> >>> upstream) SPDX tag.
> >>
> >> Fair enough, I'm dropping the tag. I didn't know it was actively
> >> discouraged and I don't see this documented anywhere. I suppose I shou=
ld
> >=20
> > I am trying to get it somehow documented as permissive, v4 is waiting
> > for some time.
> >=20
>=20
> ... feel free to encourage/review my change to get the tag officially
> supported.

I've never thought about it much, but now that I have I almost prefer
the variant without the tag. I guess if there were a usecase where
people wanted to extract the copyright from kernel sources for some
reason it might make some sense, though given the state of the kernel
that would require an awful lot of churn and it'd probably be easier
to just extract the data using regular expressions.

Thierry

--u2g6mysymwufbfqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9Jt4ACgkQ3SOs138+
s6HXbRAAtrPOD82LCq07sw+Q1GXYfZtRDw7vInR2rPZX50qjyTEBVTcSKQz3UceZ
aFcEjI7l2tQ0IwDsW9VOAzjvob46Rik4NVVczCmwjsJcReXXmqQ6NLLWU6wG48QF
CuRhOFtnIDJ/UrY2c5AaCsi8XL4Upw6FizGy9Bte6Z+6iA5YTIRqnnrvzu37fcO6
FA+zZti7M+wnM8uHqlzceG+mz3vZff2yNm/WLnm1JOrd8CNKMEiuznw+bB+DQW1+
08I39eBhdHrpxLMfkfdI99TcgzJSGxtwcGwh4UgoeE52mnvG3eea41E75u9EJDbS
/32wM0BlrxRJvIJPb1TFNWke2jD28oV+rEnILi+mLXUs2WaRrunTIFPRh2c+1PeI
P1LE/cbsSwJr9CrroE1V2dMN0HfLhkasN6EaZ+vO031b9vTsDRITmFJwLr3cgrWy
OHmQ8BYtwYV0cLvVv5abXP22q4oFi2mf3B6Q7cmVI5fVDGR5pKBLHTOXEdlofKAe
DS+NmDDDJ2O9l0SHcIVBOmuBFQNs+7bRhIuHJaWNyJScQsElpgXB7SZ9Kn/KX63y
/lkaHFZYDTRoCsa/pLo9fQjc4ouTUaOCy3KZyzKZ+BN1/yQg1lSdUZoEllsfvQ19
nZJL+vzVVRV6u5ZRFcna+AgH0U33dZ5KdtSZplAINhscuS1tlHM=
=wYkc
-----END PGP SIGNATURE-----

--u2g6mysymwufbfqc--
