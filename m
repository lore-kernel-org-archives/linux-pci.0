Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2D3D2FFC;
	Mon,  6 Jul 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378717; cv=none; b=Jov1m5mQyKz6d0AOovHjnLwf/UTdLT1Tn/LSU65ASieFoeQPRYrnfkVBnk2cQ1Gy0oGeqra4J4QrZ6h5W8Cys7ATjqvX9sEoMQmpfRCIOvPVK0aAFORfb8hV9CtGgTnBuuzNwqUbUcdou4xsgcgN0+ziewgHLsAY06aNvST7qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378717; c=relaxed/simple;
	bh=YQ8U9xvmniz5vi39E0l1c8YRPF3r9m//I9Tf+jPH43U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f01wMAH0VkAyM5H1wCWFoIMpPw2LMax0nPnlj7u/ivB1tF6x+TbrTyrYHyRU+3suKhdUynNgtz4r0NWHe1yl6zmuXA+6A/TY8U/Ks+MGu1zeAW1BGmz9kw1jSdeIRiKLyGTovXoMenYlZWLTPcke06keBClWbIYqGXJFKTi4OEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc6p3p7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc6p3p7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2261D1F000E9;
	Mon,  6 Jul 2026 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378716;
	bh=UohOdC3VB/uU6Ice+PZTZY1IottMYvMEedbYR6HBD80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xc6p3p7FfJ1MtRb9kY8cotEWvjjBiobz8qBDqrhXvun7PX/cSz19HZZAZAAVjzpm3
	 4C1kFIbO7C4yazpXw2N0So9ICkGwLD1BfGm/CsEmv8LIkv0szqQW25eaRchj8ELEF2
	 O2WV2LG7z+LPw3s3SkjGlHQyXrtCKdOIfPLWy5R1pFx5kAWlepbH3W9bIzRNse3kDQ
	 bsp1SaIL9LiUy0bUqSErPuY8gbaZTQbQGz7a4gxOToOYVoKvF/BH4+4kiZqgWKuhbZ
	 rTqdBVEpssavbBgs5iHtdnwsk5gmXIJLConAg0h4P2KxbVQZ//84uXJTCdKaa+qybc
	 lMZtZP7rcSFDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: apple: t600x: Add PCIe pwren gpios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260707-apple-pcie-pwren-v1-2-5a281b182fe2@cyberchaos.dev>
References: <20260707-apple-pcie-pwren-v1-0-5a281b182fe2@cyberchaos.dev>
 <20260707-apple-pcie-pwren-v1-2-5a281b182fe2@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:58:35 +0000
Message-Id: <20260706225836.2261D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The device tree changes are non-functional because the Apple PCIe =
controller driver lacks the required `pci-pwrctrl` framework integration, l=
eaving the endpoints unpowered.
- [High] The fixed regulator nodes for the PCIe ports omit the `startup-del=
ay-us` property, which will cause a violation of the PCIe CEM specification=
 T_PVPERL timing constraint when enabled.
--

--- Patch [2]: [PATCH 2/2] arm64: dts: apple: t600x: Add PCIe pwren gpios -=
--
commit b2b3991e65bd2ca1aa384e079e00556daa346284
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: t600x: Add PCIe pwren gpios
   =20
This commit adds fixed regulators to enable PCIe peripherals (WiFi, SD card
reader, and USB xHCI) on Apple M1 Pro/Max/Ultra SoCs. It sets these regulat=
ors
as the power-supply for the respective PCIe ports and adds the pciclass,0604
compatible string to allow the pci-pwrctrl-generic driver to bind.

> diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/=
dts/apple/t600x-die0.dtsi
> index f715b19efd167..53a633a3c6527 100644
> --- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
[ ... ]
> @@ -449,6 +449,7 @@ pcie0: pcie@590000000 {
>  		pinctrl-names =3D "default";
> =20
>  		port00: pci@0,0 {
> +			compatible =3D "pciclass,0604";

[Severity: High]
Will this generic power control driver actually be probed?

The pci-pwrctrl-generic driver requires the PCIe host controller to explici=
tly
call pci_pwrctrl_create_devices() to instantiate platform devices for these
child nodes.

Looking at drivers/pci/controller/pcie-apple.c, this API is never invoked. =
As
a result, the pci-pwrctrl device is never created, the power-supply propert=
ies
will be ignored, and the connected endpoints will remain unpowered.

>  			device_type =3D "pci";
>  			reg =3D <0x0 0x0 0x0 0x0 0x0>;
>  			reset-gpios =3D <&pinctrl_ap 4 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/=
boot/dts/apple/t600x-j314-j316.dtsi
> index fee84f809a9cc..7954cbbe45140 100644
> --- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
[ ... ]
> @@ -55,6 +55,20 @@ led-0 {
>  			default-state =3D "keep";
>  		};
>  	};
> +
> +	vreg_pcie0_port0: regulator-pcie0-port0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pwren-pcie0-port0";
> +		gpio =3D <&smc_gpio 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

[Severity: High]
Does this regulator need a startup-delay-us property to meet PCIe timing?

When the generic power control framework eventually manages this regulator
(either once the pci-pwrctrl driver is supported or via direct host control=
ler
control), it will enable it without implicit delays.=20

Without startup-delay-us =3D <100000>, regulator_enable() returns immediate=
ly.
The apple_pcie_setup_port() function then asserts PERST#, waits only 100us,
and deasserts PERST#.=20

Could this result in a T_PVPERL of ~100us instead of the spec-mandated 100m=
s,
causing the PCIe endpoints to fail initialization or act erratically? (This
also applies to the other fixed regulators introduced in this patch).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-apple-pcie=
-pwren-v1-0-5a281b182fe2@cyberchaos.dev?part=3D2
