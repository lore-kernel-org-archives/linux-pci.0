Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99100438029;
	Fri, 28 Aug 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787919023; cv=none; b=RXFvc+4Qsn8HNwtkvEHscEQb1tFSIIoyUl5T9noZbIeYqeMBlUj2BVt3ka+QjKhHmzhYxjsO7Uj0c9KQ7JQhM5G5GkkVwjcPq1VrlBmJBnibn+8qdSI5mi174MMNhk7DzzLBVoMAA9jqu47VVoTM2RgnWtp3B3EZST6tbXk3Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787919023; c=relaxed/simple;
	bh=FL/MuJQbgtG0aDhZ6aKljyrFLOE7pumpiZchS8mf5M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIGFo7Ck7HGccx4a1qoLlF8xQUZLQC9KtzBUB+I4IjDhHL8uy5iDB0iZGFnf8Sj39ELkMcYG1C8c0UhR9PD1D2+oyNbf41FlqyYCpVYqLF+DgUBPYfvdp57Xo2nZGmqLE6jhYq2Xq74Fbc8kThcx63v2WAPc9Huta7rVq4b+YSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/g9g3ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/g9g3ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FA11F00A3F;
	Fri, 28 Aug 2026 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787919009;
	bh=1q+hHwlu6v5audo77lrJXSEp0y2Ux+5NX7JjfJEJRbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P/g9g3cicDjwXv86a/QJWITL6TK1+gn+ufKrk2tFwx3X87oPhO7lWuVDYGJsZDMuQ
	 39xxCoH0IsFd3BOO0ibr9Kb1/I0LQ2g6ggIlNg0CuZ3KqhOXSstO6VQQTnM6jdiAOO
	 qmN2PujwTMYvkwsTS9ZMeZQTqLB1YZnOOMBuTXWwQElKuRH/fvCqB35TKi5eJuEPkZ
	 ya0Kqq/dVAISixxRxF2pXyWImbW/96GM5cieECsysW0oTYNeMd9GFgHGGzUVmpoqHi
	 Hq7V2wI/ZiO8Z5JNGyU/BlXowdhAq2JDHvnU/tjfK+ncKiSviAETG+D5hdQ3PT9IsW
	 fosEAtWWH99Ag==
Date: Fri, 28 Aug 2026 14:10:06 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Unwind partial PHY power-on failures
Message-ID: <apF3QT5VJQU-Bf8c@orome>
References: <20260828091747.7976-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsysh2pbjmnneq3y"
Content-Disposition: inline
In-Reply-To: <20260828091747.7976-1-pengpeng@iscas.ac.cn>


--vsysh2pbjmnneq3y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PCI: tegra: Unwind partial PHY power-on failures
MIME-Version: 1.0

On Fri, Aug 28, 2026 at 05:17:47PM +0800, Pengpeng Hou wrote:
> The Tegra PCIe PHY setup has two nested acquisition loops.  Failure in a
> per-port loop leaves earlier PHYs in that port powered, while failure in
> the outer loop leaves all earlier ports powered.
>=20
> Unwind the successfully powered PHYs in reverse order at both levels
> before returning the original error.
>=20
> The issue was identified via static analysis and manually reviewed.
>=20
> Fixes: 6fe7c187e026 ("PCI: tegra: Support per-lane PHYs")
>=20
> Assisted-by: LLM
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)

We technically could do something like this, but honestly I don't see
the point. If this ever happened, it'd mean that either the system is
improperly designed, badly configured in device tree or somehow broken.
In either case the unwind isn't really going to save you.

Thierry

--vsysh2pbjmnneq3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqRepkACgkQ3SOs138+
s6ER/BAAjajaXP77leTWjrIV68TKvt74Z65CkDwzzIP6wx0TiYqwUXBgGzCyGFs8
XhYwTNPGygr7YnRI4eGkYZ3Er168LDDeco2jU6WWrMPwBvUg111rHD3X5hRIYvsH
6xky8ZKLM8R8codbio4/LEI42SIAG541F3UhBIDiZhahY55/e37ZgJik5Yf7orYV
Y2Uu48nHIy7lkLNibxXNc8seSrGI63l99YxMqMsMcmZBeIIzPM31wk4sDcvlmrFt
F8NdV5RIRnlrgWEFeb6Fzef8Wkq51MTWyl+CT8caLkH7c+BX2A7ESphTdmm3IrSD
q6n5LWUCs8rmTb8ePSctBwpnzzBf09T5bx+w6Y7fMYem7l1NIbqPx6sHWLvg7yAm
Vdp6xh2iEhYSiJ10Y6vMg5I7++x3z77icTOIQDqQicNLwVw6c6WdL24egQx82rqh
LE3Vknp94vUaHUNvQjHt4mOOAFSF9fn9B/PAYjrWuEaUamjpvH5wt3a8L53JOzwK
xr+Ho/YAvDYNrmzpULy+h0w/DOBYCSh2vNEynX6DFI2VCZ9MTj5WecIzPmvn0Vue
nkboKZ9PakxOZp9QJxym7crWz/z/wrMvcSiXVLJ5qoJOyj4vEAW0MXu9JKsYBGra
Xg51gQWKr6fB5/l2t9L491yJzIlOYIsbJK9e1L3jkHfbmUDEqCI=
=Mv8m
-----END PGP SIGNATURE-----

--vsysh2pbjmnneq3y--
