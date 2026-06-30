Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22E2727FD;
	Tue, 30 Jun 2026 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800853; cv=none; b=Yx6sIkMI387B4wJSeQ4ck7SL41gjHgS8rAOtI2VLcMwKxCxrlUjkbb8JQH4YIizqPoThHcbRx7s28lgZVEkseL+dDAEOMB9TIicZ9fn30L/sJK+3mVOmQCtPwIK4IPPSkStiyWnlppbI5C/5X9NI7wjWmFuZbxcxkHUDeabHRDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800853; c=relaxed/simple;
	bh=6i/+mIz6fiaCmPQbwnlgXBB6+QZaE3Reo3MUAYiWcGY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HmdUZKhPu//FglDxgJFZutuYENl12beCkX1+tL9U5Wa9NCTJzvVlaWyQJ+M++Il6lrpzVVkBw+XGo2ritre6pMcLRbaPq94kBJa7UIgtLRm77xjr5aIhPCYTCC6yJPlulnO4A4G/H3waO4FhZvCPg8KGTLbHEWzBe9XNXRj0kVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtEGoDYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtEGoDYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7AA1F000E9;
	Tue, 30 Jun 2026 06:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782800851;
	bh=xJkiOYeiK27PJ9Tsx0PkVRNWzWe8gtgZDPWwwZcCkNg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YtEGoDYzU9D8L0d9+/N0zNP+gliK88vuF8kAP+vre+tFzjCjpz2T/X1L4OGjfXTUA
	 Pw0iqdMdstMUFaKWfRc8rKTdezM59Yaps++KwH7A9c6Opwe9R+II37plt0kCMHAHV+
	 pdgJdpl2LdR86e11VuneJC7Ovur7tozV1LM9PEEpMOg7+PkfJ66c9bzjE+VvlHhbS2
	 h9qLZ0wrr0tWxOTKqyU1YaNuQzcGOIVI8cum2KlRy/YhPCncYXoFdf0x9Bp9bas8bk
	 AA7AteLcXnuuLcOjCXOQ/ZkvG23J0/d9wvx3wJlkqOCcxBtKf9aaqXp8+F/+8D8L/e
	 agy72GAV6zxLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/7] arm: dts: imx6qdl-sabresd: Move power supply
 property to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260630060710.3294811-2-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:27:30 +0000
Message-Id: <20260630062731.3C7AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing the legacy `vpcie-supply` property breaks PCIe initializa=
tion on older kernels and non-pwrctrl environments.
- [Medium] Adding `vpcie3v3-supply` to the Root Port node without documenti=
ng it in the binding schema causes a schema validation failure.
--

commit 1190644448a0f1a3780ae7b3d2a75e1606ab6017
Author: Sherry Sun <sherry.sun@nxp.com>
arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node

This commit moves the power supply property from the PCIe controller node
to the Root Port child node. This change aims to support the new PCI pwrctrl
framework.

> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/bo=
ot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> index fe9046c03ddd6..c52b8897f9995 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> @@ -756,12 +756,12 @@ &pcie {
>  	pinctrl-0 =3D <&pinctrl_pcie>;
>  	/* This property is deprecated, use reset-gpios from the Root Port node=
. */
>  	reset-gpio =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> -	vpcie-supply =3D <&reg_pcie>;

[Severity: High]
Will removing the legacy vpcie-supply property break backward compatibility
with older drivers?

Older drivers, such as pci-imx6.c, looking for this property via
devm_regulator_get_optional("vpcie") in the host bridge node will receive
an error code and silently skip enabling the PCIe regulator. Because the
regulator lacks an always-on constraint, it will remain off, which can cause
PCIe link failures on older kernels or when booting with the generic PCI po=
wer
control framework disabled.

Device trees generally act as stable hardware descriptions. Can this proper=
ty
be kept in the parent node while adding vpcie3v3-supply to the child node,
since the regulator core can safely handle multiple consumers?

>  	status =3D "okay";
>  };
> =20
>  &pcie_port0 {
>  	reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> +	vpcie3v3-supply =3D <&reg_pcie>;

[Severity: Medium]
Could adding vpcie3v3-supply here without documenting it in the binding
schema cause a schema validation failure?

The pcie@0 node definition in the fsl,imx6q-pcie.yaml binding schema
uses "unevaluatedProperties: false", meaning all properties must be explici=
tly
documented. Since vpcie3v3-supply is not documented in that file or in the
core PCI schemas, the schema validator will likely reject it.

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060710.3294=
811-1-sherry.sun@oss.nxp.com?part=3D1
