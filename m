Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9211448D5;
	Tue, 31 Mar 2026 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979863; cv=none; b=QwTYj52ZkvZ3pHarR3z9mp6ucR8Yes2Yf1SqpcTYRrEANXLt8Uopg/5nkJTWAPHVTnbciQMNJb2jVnsLmnM0sYifiOD2fY6jGGccabEcp/lkH5D298b/kiAbtpTnWe4H+IOMVK5CF/zuNNLJcQb8sYzDwcWsGH8g6dqlWIMi2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979863; c=relaxed/simple;
	bh=jRshRvrfE1K59jC2hI9BuHoXj8it76oESI+BdTN4Kgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqIUjx+Qii8JXHm4KmXSVhP7Yd5i/B6lP0R4NZqWPRhEJF98tow2tczNiPzzRXkkh4IuhY1MDRoeYeKvWraoHniig6I96nZiX6lTX4CRb4MMJNXfphmiveirigyE0I08d+45+B4TqbZOgiF7tlJGFMXA2N4XDBZoQCPXuxoZvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRSW3mjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRSW3mjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3D1C19423;
	Tue, 31 Mar 2026 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774979863;
	bh=jRshRvrfE1K59jC2hI9BuHoXj8it76oESI+BdTN4Kgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRSW3mjQ48Dt/YlOJZnRKmYJu7Y2M4fgwblouezDaGCDM0um5+fik1vNIg59W0cXj
	 0cZvXUClUM4+UNePXX4WB0SJFTDN8iEHo9f56aJmOlDiOql3qGRKcRcMvN/mAiQOBZ
	 VaeXT05O0+C63Whi7bzNO0ZHVmRr2euuM7MUrrStZPJd64SaT0OxUec/z+YugZWkVA
	 77YgXyRYuSHmOf3M/WdQjfZG3fc0voAk9b1MBaMWAHYYMx8EFUO+P7800CuoUx7bkj
	 JJ7anQ/lJlIEO6+6J8f9y9IQfLGjiF7jGcUDogoN0t6y8G+pDwaohQ0l7Xw8PAiFt6
	 LvER2PUbeI4ug==
Date: Tue, 31 Mar 2026 18:57:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zixian Zeng <sycamoremoon376@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Han Gao <rabenda.cn@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe
 controllers
Message-ID: <20260331-outlet-molehill-939c0daacd06@spud>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
 <20260331171248.973014-3-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8oXAjQqyBqcuv3C"
Content-Disposition: inline
In-Reply-To: <20260331171248.973014-3-gaohan@iscas.ac.cn>


--m8oXAjQqyBqcuv3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 01:12:48AM +0800, Han Gao wrote:
> SG2042's PCIe root complexes are cache-coherent with the CPU. Mark all
> four PCIe controller nodes (pcie_rc0 through pcie_rc3) as dma-coherent
> so the kernel uses coherent DMA mappings instead of non-coherent bounce
> buffering.

Worth pointing out I guess that this property is needed, despite riscv
being coherent by default, because the whole bus is marked
dma-noncoherent.

>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts=
/sophgo/sg2042.dtsi
> index 9fddf3f0b3b9..3af770549742 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
>  			vendor-id =3D <0x1f1c>;
>  			device-id =3D <0x2042>;
>  			cdns,no-bar-match-nbits =3D <48>;
> +			dma-coherent;
>  			msi-parent =3D <&msi>;
>  			status =3D "disabled";
>  		};
> @@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
>  			vendor-id =3D <0x1f1c>;
>  			device-id =3D <0x2042>;
>  			cdns,no-bar-match-nbits =3D <48>;
> +			dma-coherent;
>  			msi-parent =3D <&msi>;
>  			status =3D "disabled";
>  		};
> @@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
>  			vendor-id =3D <0x1f1c>;
>  			device-id =3D <0x2042>;
>  			cdns,no-bar-match-nbits =3D <48>;
> +			dma-coherent;
>  			msi-parent =3D <&msi>;
>  			status =3D "disabled";
>  		};
> @@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
>  			vendor-id =3D <0x1f1c>;
>  			device-id =3D <0x2042>;
>  			cdns,no-bar-match-nbits =3D <48>;
> +			dma-coherent;
>  			msi-parent =3D <&msi>;
>  			status =3D "disabled";
>  		};
> --=20
> 2.47.3
>=20

--m8oXAjQqyBqcuv3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacwLDgAKCRB4tDGHoIJi
0rArAP4jBTmKxYWxfFJLKueDpo+mSl4SPqf6k8s8stuypnj0hgD+KEB3KaSC2+G8
0eWLoouJWr9QngLJgCKU1PJoXs9bvA8=
=eHvS
-----END PGP SIGNATURE-----

--m8oXAjQqyBqcuv3C--
