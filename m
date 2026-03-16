Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C42D3A7B;
	Mon, 16 Mar 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671962; cv=none; b=WQ8UpUwpdaf18dRwetc5+9+XPKEE8bOeToYzZ92y7zFGAqoMN3sd0emzgwff0pwvGvfv4c/gbn+UwkbFdLs8CDcQbomFWf0axElY+kTl/ddoJPW3g9TgeHsJ131FDKVqjti0G/qjanZ9Uog+w6V3srDYUfAlon/a1uhuYFDfkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671962; c=relaxed/simple;
	bh=+mvv7r3Vkd9Ef/iLR0Zs1FGWEywTSdXOK8C9f6GXNSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+Uui6paPLtNsDzxuGUojoGX04eBfR9v3akcg2j0/1ZC/CQTJOAwG1mxj52E44T3mjhwgCVOsbZuhkiIe37AKfViK9tSrW+CMU4z1h/rBRX4h5LyT3DUnRqpku250/Xolmq5BkU3ljOj1CaAfPfX2Dgr6cjp0h1FUHhdyO8GyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7q4TnA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7q4TnA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BA8C19421;
	Mon, 16 Mar 2026 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773671962;
	bh=+mvv7r3Vkd9Ef/iLR0Zs1FGWEywTSdXOK8C9f6GXNSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7q4TnA1YJVeSMZKWRHqWJntFiKHntjL3mVZo3SuqW51s1AChvtvBT8nYvvcvAAjI
	 fsj6r2vqsrheQ4r9PBsMqL01RphqK2bpmYyydtgdCa8PZq1QSXjC6JzSNnHxVye2Dz
	 6fwkPL1BaE8hOnstgJ7mP7Y07bZ+XgcrVH3hjQXSzAvd5tp2y/ahYfl2ARZ5xen7yt
	 Ppex/MfYnJd05CkYPuk3JeP4VCYwErCK2IkRG+GT6S3Er9mANKkb0bHeplh1VEuSdm
	 0+t5/Yzi3dmDi1b4ADLGdb3m+fmRs0XBzoGzo35esXKRW6jGxErseGSdpNnEQs3dMH
	 zU7gUYfZyKubg==
Date: Mon, 16 Mar 2026 14:39:16 +0000
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
Message-ID: <20260316-powdery-unbundle-b1166d13f53b@spud>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77NVXxmwy8lu9z90"
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>


--77NVXxmwy8lu9z90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 03:06:57PM +0800, Jia Wang wrote:
> The first SoC in the UltraRISC series is UR-DP1000, containing octa
> UltraRISC C100 cores.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  arch/riscv/Kconfig.socs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index d621b85dd63b..f49d3ccaacde 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -84,6 +84,16 @@ config ARCH_THEAD
>  	help
>  	  This enables support for the RISC-V based T-HEAD SoCs.
> =20
> +config ARCH_ULTRARISC
> +	bool "UltraRISC RISC-V SoCs"
> +	depends on MMU && !XIP_KERNEL

Why do you depend on "MMU && !XIP_KERNEL"?

> +	help
> +	 This enables support for UltraRISC SoC platform hardware,
> +	 including boards based on the UR-DP1000.
> +	 UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
> +	 the RV64GCBHX ISA. It supports Hardware Virtualization
> +	 and RISC-V RV64 ISA H(v1.0) Extension.
> +
>  config ARCH_VIRT
>  	bool "QEMU Virt Machine"
>  	select POWER_RESET
>=20
> --=20
> 2.34.1
>=20

--77NVXxmwy8lu9z90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabgWFAAKCRB4tDGHoIJi
0kfCAQC+/WgX8p/XaK/3hhi3OD3wO0xX5tzs8Ld0kia5edHwsgD/aJNp0dlufRCQ
PfW5xC/axFIwCGfzQ4P9VfKIqzzeyg8=
=b552
-----END PGP SIGNATURE-----

--77NVXxmwy8lu9z90--
