Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601483D34BF;
	Wed, 15 Apr 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263304; cv=none; b=Zyr+snHi2MyZqudhWIDBxfguJINYwx4gFW91hiXIuPGb6qFvcHREbCMeWcIpxskZ4SVx0crG6BsOE+gq2GvxjZw7VQtQ+u9Eg1NIETcqoBnTXN2YwHz56dFKSyRvlIPVhZRnfLDue2xh/JHBQj9WiFWhqHdx/SDBzzXcFx8JUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263304; c=relaxed/simple;
	bh=KLZl5mWnQ/fLEg517Nj8h/rm6MAMa8dENX79Fq95dso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxzkIDwZPZOEpWY4P1PY5yRQBQZP95LkDDot9K3+FPOWi0ycFznIDsIhTdUQdosWOdKFQKPyjlzhn230rE1aTHIIUY3RBJ83Pv+mUJ5bABY1OzLY4pHEhxY18xqcWfFTKWnq0JVmUOe6ikdjC3FUQbIZKmlB90bEM18ia3vXGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/YX+RVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/YX+RVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35EBC19424;
	Wed, 15 Apr 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776263304;
	bh=KLZl5mWnQ/fLEg517Nj8h/rm6MAMa8dENX79Fq95dso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/YX+RVRFmDbZUEUouHLuZhFFOhEriVotbvOFw9wxSIAFOu1yin3oKr9hQA0Qc6pR
	 I+WFVtfV4rosaPXwqeX+Kw27EcgVj1wXrS3hkWJI6FDy6VzZ/VM4FeseN1YJUcOtKF
	 cIcgd6P3ftw6wMwBFE9Y5dT8LLZ8beEgm4Maazw7DT9d8U/b5MKbcLdDahzLWTvnq8
	 y/Ia9YUWY2hscVdDJP/lLNEJaYQz2XQGSMPfrI7GvlevKVswmJ/nF5Bl8wOzaYMnE3
	 3DB6G88J25UbvGy8+m0Peq0i8FqFF4fMf3+qxz5TJSxVacU/syZf5Hlb4HhAvCdLsO
	 GpYzCyeW8yc9A==
Date: Wed, 15 Apr 2026 15:28:18 +0100
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
Subject: Re: [PATCH v3 1/3] riscv: add UltraRISC SoC family Kconfig support
Message-ID: <20260415-craving-rubbing-bc8d389d19de@spud>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-1-73f06e972616@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8S0HS9rYZzLUqT+"
Content-Disposition: inline
In-Reply-To: <20260415-ultrarisc-pcie-v3-1-73f06e972616@ultrarisc.com>


--m8S0HS9rYZzLUqT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 03:21:17PM +0800, Jia Wang wrote:
> The first SoC in the UltraRISC series is UR-DP1000, containing octa
> UltraRISC CP100 cores.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index d621b85dd63b..0b4d06a7b4bf 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -84,6 +84,12 @@ config ARCH_THEAD
>  	help
>  	  This enables support for the RISC-V based T-HEAD SoCs.
> =20
> +config ARCH_ULTRARISC
> +	bool "UltraRISC RISC-V SoCs"
> +	help
> +	  This enables support for UltraRISC SoC platform hardware,
> +	  including boards based on the UR-DP1000.
> +
>  config ARCH_VIRT
>  	bool "QEMU Virt Machine"
>  	select POWER_RESET
>=20
> --=20
> 2.34.1
>=20

--m8S0HS9rYZzLUqT+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+gggAKCRB4tDGHoIJi
0k5KAP9cH8g7du35W2DxfKVlGZGBX5/qlVgxSMv7M3SiUrg/7wEA4Wam3N4GLDGE
WWQIvTM0dOVnQcN5PygYLDSqx+9yGQk=
=gd+p
-----END PGP SIGNATURE-----

--m8S0HS9rYZzLUqT+--
