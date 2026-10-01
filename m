Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE503C3443;
	Thu,  1 Oct 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840415; cv=none; b=QOEZmwrENLLeSR/FmgH1esivSt+c+0q+P8UeOdUV7rmHLHt3tbLSZgU3QEs28WQTqs1Nx7v/CrVM9Jap/WrPqlXfXwZyZEwDBFPxMH3FlzxnIapth/ijbSpqzzclSzY7hTskErdpL0xnETYFHIBDBfQGZdbrP0avFqr7DA9Om/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840415; c=relaxed/simple;
	bh=jotN6m5nU8nYPjDMM9WVZMrLbyza1vz8+jUpXvCkUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzNsFMOumod3U9GnMf1XBij/RUh9V3u6dADGpnGh4A+CoPWKeWdiwaGi/AZMdi+Ot9K9Sa4X7BFoDb+XEyhVEoavo7Lkm0/Q0UesUftkrKWL5V2DvwwjdzctJF05PumiMcB29zHsLxNx3k6ntjLRV+CP4ubpndbFHVvXUWvZz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBSZ/pYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBSZ/pYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612871F000FF;
	Thu,  1 Oct 2026 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790840413;
	bh=6ktmrJL5cgwV/9yuQLoWQZt4/L51Fhu4UDh2q/A/JtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TBSZ/pYx9Gr1/LiCELZfeJ+HPhJ3zTek+MmFh+0d1RoG9dfKhUhtZ4P89JCyHU1WJ
	 nF7ldQ/4344BGn1BnKTr6nNWLXwhFYVWOx2KZbJoHWG4YhsXpBTKgqcj8Dfnt3OQN6
	 Z2XaWR9Dwu72L3W+8xdOcU1JtWKfrCACEx9XV4fayFxdj4Kh8N2Eu/E6H8YYvyYZ2s
	 qErl+UF1ZlpXeVfuG3txG7YbgkYoDTGZ0DfEImQhoQ97ctx4Pkbr8I90r/djB19fDq
	 hMP+cMzlITZVogcEpCJ8j+/o9R6q7iAzLDczrPoqeyltZRh1Hb3sPjx7qlA0njqX3e
	 v9LXmBx1NmwDw==
Date: Thu, 1 Oct 2026 09:40:11 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linmao Li <lilinmao@kylinos.cn>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <ar4Nhd_mJ-NmUavQ@orome>
References: <20260923195719.1933175-2-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7igr2kzo3fstsvmx"
Content-Disposition: inline
In-Reply-To: <20260923195719.1933175-2-bhelgaas@google.com>


--7igr2kzo3fstsvmx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] PCI: tegra264: Fix Link Capabilities register offset
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 02:57:20PM -0500, Bjorn Helgaas wrote:
> The PCI Express Capability begins at 0x48.  Link Capabilities is a 32-bit
> register at offset 0xc, and Link Status is a 16-bit register at offset
> 0x12:
>=20
>   Link Capabilities is at 0x48 + 0xc  =3D 0x54
>   Link Status       is at 0x48 + 0x12 =3D 0x5a
>=20
> Previously the driver read Link Capabilities with a 16-bit read from
> XTL_RC_PCIE_CFG_LINK_CAPS (0x56), which incorrectly read just the upper
> half of the register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
>=20
> Correct the Link Capabilities usage by adding a XTL_RC_PCIE_CAP definition
> for the base of the PCIe Capability, using the existing PCI_EXP_LNKCAP
> (0xc) and PCI_EXP_LNKSTA (0x12) offsets so they're easily searchable, and
> reading the entire 32 bits of Link Capabilities.
>=20
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Based-on-patch-by: Linmao Li <lilinmao@kylinos.cn>
> Link: https://lore.kernel.org/20260827093919.2825467-1-lilinmao@kylinos.cn
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>=20
> This fixes a real bug, so I'd like to get this in pci/next for v7.4.  I
> can't test this though, so need a review and test from somebody with the
> hardware.
>=20
>  drivers/pci/controller/pcie-tegra264.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Sorry for the late reply, I had missed the patch you sent out. I've run
this on the Jetson AGX Thor DevKit and it still boots fine, all the PCI
devices show up:

Tested-by: Thierry Reding <treding@nvidia.com>

Also, the offsets do match what the register documentation says, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--7igr2kzo3fstsvmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmq+DlsACgkQ3SOs138+
s6Fxfw/9EWdvJTKrr7EilL2GK28StDkbw65WN0mzF/TbxGhoTelDKY3EKe7IFO3O
MqSQyPCIHnm7M/RnLxtRfOvBYJwO+jHUySK5YZzKjXyTPld74fP+dr/kcObBD8/R
VkMD0EeIX6rAxPJK7uAVE/UgWJsQVeR4LFKtjCrnC6BfxRTFqRtJGkDLWCXl3El1
JKkxbaTndVelF+jiJnXCN2R5WaJm9oAwa40fcDepw6BdX5AZwlcwXok0aTzGX0u5
a+B9eTqhBx2jJbT2azD5r02tXq67SWgoN/NKhP9yQtqTTD8WQMWEeDlnncE7Isn8
48AhMb3gnJ2RHnDg6bOEVNvhn9V61dl7hE+w3Uo0gCZyrfbd0TnlTVRYjADauEJR
wKz1Ete4vNtXezQ/F62wVYEyfGdcq+0OP5pXkV9PZ9iEeKCGsRQlnlCmw5/QTI3S
EhsLG0KVe8Xh8a/B8qff6stOQ0ywOzbi5mF86appSVqqdRfHAdFwggYn/5zxxgi0
jHQ6jrEEqwdKpc9AfmN2FE4e1mxQkfAZQMkVBWZYIaEZ3q4UQ3GKlUzXF9uFPpDL
npzCDicmFepW6RJsNXr/Mvttr84CjTCZY15YYWNyOvuwVUBN/OCL7yp1bQw0nKVp
UWlhAZut3L+QNwtHBUwJlag2PHfTwe2HaZDTEz2WenDOdVpEOI4=
=INV7
-----END PGP SIGNATURE-----

--7igr2kzo3fstsvmx--
