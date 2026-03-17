Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63328165F1A;
	Tue, 17 Mar 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752548; cv=none; b=Q7WZURUXyAFvjnSNaRVIGV7z8HQOySbysdVSLCho7QNA2kWVfWFpRDXEXARf0Hjdr76/qi50nq5s52iew3nN7qeU8TjBu7acVgnlGiXtluXpWi7DEGcuWB+YSSxTEHOEOZOh4tQl7I+lEuNsIX7Gyifn7dlkpDC8givTbiNx1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752548; c=relaxed/simple;
	bh=1kjWo6lcePoSVB9RhThQ8BkYhXgZh+DY99yW5Ny2BnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHJ5HdVqy7T8KtPMvX0mCgVwv9C1zTk8dia9JpTZnHqsIdghiWBImb48q+3g0NdNIrnoh93/T3zXzLWcTvs/XIJaxs/yG0GEOWXwnFVLny+vyKH16/shpdfatxp8yhlyVt2PJZykwb7uNI2LTsagVOnAW+GUbxizPlw0jkuCf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz+UZOgq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz+UZOgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF432C4CEF7;
	Tue, 17 Mar 2026 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752548;
	bh=1kjWo6lcePoSVB9RhThQ8BkYhXgZh+DY99yW5Ny2BnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz+UZOgqs/blgC36znMmdAFW1p4kHpWqbxDMzOFXe4hsgJbRaoSlpWRboMaBp9a4N
	 Hh2TWTxbsBOuzM4rnRUXUakv+oGvXfa+iMKTDQ7h+D0Ak8I5D+Mx58jUH+KnEvtTzd
	 Mx07u1RngiEaA80DJPaRn1ZAO0iQNevK6DJPE2anpuylwOhPfpPBlFhSOLNqcIdPHb
	 UH26appZNdGHcyg9JR8GaazaJW+m4ff0HolYhQ79k+wR/QvD4Obp1MPNhFE369axVv
	 f4loloclWpi0MMKkCrtlfsMoZLv3EBFxdAHGfH0x7KfbIiVDY3ArU0LQ1TIKiVbsco
	 oaplZbbpwZOAA==
Date: Tue, 17 Mar 2026 13:02:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: add UltraRISC SoC family Kconfig support
Message-ID: <20260317-renewably-unroasted-45c63bd0c95e@spud>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>
 <20260316-powdery-unbundle-b1166d13f53b@spud>
 <177372998464.49340.13796019002628537253.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D0QXzGE76B8r3jSd"
Content-Disposition: inline
In-Reply-To: <177372998464.49340.13796019002628537253.b4-reply@b4>


--D0QXzGE76B8r3jSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 02:46:24PM +0800, Jia Wang wrote:
> On 2026-03-16 14:39 +0000, Conor Dooley wrote:
> > On Mon, Mar 16, 2026 at 03:06:57PM +0800, Jia Wang wrote:
> > > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > > UltraRISC C100 cores.
> > >=20
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > ---
> > >  arch/riscv/Kconfig.socs | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > index d621b85dd63b..f49d3ccaacde 100644
> > > --- a/arch/riscv/Kconfig.socs
> > > +++ b/arch/riscv/Kconfig.socs
> > > @@ -84,6 +84,16 @@ config ARCH_THEAD
> > >  	help
> > >  	  This enables support for the RISC-V based T-HEAD SoCs.
> > > =20
> > > +config ARCH_ULTRARISC
> > > +	bool "UltraRISC RISC-V SoCs"
> > > +	depends on MMU && !XIP_KERNEL
> >=20
> > Why do you depend on "MMU && !XIP_KERNEL"?
> >
> Hi Conor,
>=20
> Thanks for the review.
>=20
> The dependency on "MMU" was added conservatively, but the DP1000 hardware
> does not strictly require MMU. I will remove this dependency in the
> next version of the patch.
>=20
> The "!XIP_KERNEL" dependency is retained because the platform does not
> support executing the kernel directly from storage, so the kernel
> must be loaded into RAM before execution.

I would imagine the reason these are here is because you copied this
=66rom one of the other entries. They have "depends on MMU && !XIP_KERNEL"
is because they have errata that require alternatives to resolve, and
alternatives require those conditions. IMO you should remove these entirely,
especially since XIP_KERNEL is about to be removed for riscv soon
anyway.

--D0QXzGE76B8r3jSd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCablQ3gAKCRB4tDGHoIJi
0rylAP43F4xOqQmtmYS1yFMdltHxtv/9WjhXaTADiOrt/2nFlQD+NpU6v3eVJQFF
hSeFs/3ZkQMeFIsVbIw3qrFDDmmzzgM=
=WHT6
-----END PGP SIGNATURE-----

--D0QXzGE76B8r3jSd--
