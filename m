Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD0368D70;
	Mon,  1 Jun 2026 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309498; cv=none; b=nxFVrFUXOiJCp2y0pMzu0fEnSs9pDEV71RG/VG6Uu8LMlH5fcHNmev2DL4CsYJ0CMvPYqlxBVYgQa7r2vWCd9RgCKvR6JR0tBuiMJgoimP77hFp+5YDi6ucguiCI2tPmOG14USgUJ4WllEE95iZi4giSd3U6PyAcz9VPmG2b8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309498; c=relaxed/simple;
	bh=6iRgNS09sQ4do+x5OhkNqeXNF21+tFdLPObDSIdnjOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pvql/F/N6cPai2F2S2MrVczZEFazcTUObkgNia21zr4/Rctslo5+E9aBZ+bEGDyAI92O47DvcJwSpyVak4vZ0WZZjpiAwe0iCzH1dpJgXbrP0/p0MN9KUSbvkW3ZF4Wd+Ket6gYN3Hkg2IcRSm0tCheQTuOu4VmcbtAcjWgLTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy/CDZTH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy/CDZTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223FF1F00893;
	Mon,  1 Jun 2026 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309497;
	bh=Kd+b7IPMvghSHa1qWGJjseRqfRO2oSR4soYgR7GjtZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dy/CDZTHTrFBIPrjJFwQOKC6TyWG+L7yXV7N4fDSuNq5xB7jpIz0SnTR6L1wCAR72
	 k7EHz63NQUHgk1Wi8bSSAqBzgnxNvUdU5ErvH0yyl/OqtWOR0tyL0hXeq/+C3cXIDI
	 DxTwAFCpxhjS17ug1Bfey7EEzlyEhUrBqjciYVxXDZwH9UrYX/5uiNQBobeER4eth2
	 eN6+shYTkxtGBxlUOQ521pw17Z72H7INt1lB8W3QeqpnBwZDpdzKjOZ39w0UnPFjmC
	 /nQ6b5IlLIlZEGIICDUN6LXbUwL/I59Hco+V0ETJHBfiZBhoHeohlrsnZ5tT0R3v/2
	 kIP51JhfGr2Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:24:56 +0000
Message-Id: <20260601102457.223FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but moving the reset=
 GPIO lookup to the root port node exposes a pre-existing resource leak in =
`qcom_pcie_parse_port()`. The function initializes the PHY via `phy_init(ph=
y)`. Immediately afterward, it calls `qcom_pcie_parse_perst()` to acquire t=
he reset GPIO. If `qcom_pcie_parse_perst()` fails (e.g., returning `-EPROBE=
_DEFER` because the GPIO controller is not yet ready), `qcom_pcie_parse_por=
t()` exits immediately and returns the error without calling `phy_exit(phy)=
`. Because the `port` structure is only added to the `pcie->ports` list at =
the very end of the function, the cleanup block in the caller `qcom_pcie_pa=
rse_ports()` skips this newly allocated port and fails to execute `phy_exit=
()`. This results in leaked PHY initialization references.
--

commit d344e05b9227f3ae995aa63413819de4bd38ce62
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

arm64: dts: qcom: sm8350: modernize PCIe entries

This commit modernizes the device tree for the SM8350 platform by moving
the PERST# / WAKE pins and PHYs to the PCIe port instead of the RC device
to resolve recent kernel warnings.

> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dt=
s/qcom/sm8350-hdk.dts
> index 5f975d0094658..4973a3eb11b5b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts

[ ... ]

> @@ -493,12 +493,14 @@ &pcie0 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pcie0_default_state>;
> =20
> -	perst-gpios =3D <&tlmm 94 GPIO_ACTIVE_LOW>;
> -	wake-gpios =3D <&tlmm 96 GPIO_ACTIVE_HIGH>;
> -
>  	status =3D "okay";
>  };
> =20
> +&pcie0_port0 {
> +	reset-gpios =3D <&tlmm 94 GPIO_ACTIVE_LOW>;
> +	wake-gpios =3D <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +};

[Severity: High]
This is a pre-existing issue, but moving the reset GPIO lookup to the root
port node exposes a resource leak in the driver's error handling.

If the GPIO controller is not yet ready and qcom_pcie_parse_perst() defers,
does the driver leak the PHY initialization reference?

Looking at drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_parse_port(),
the function initializes the PHY:

    ret =3D phy_init(phy);
    if (ret)
        return ret;
   =20
    INIT_LIST_HEAD(&port->perst);
   =20
    ret =3D qcom_pcie_parse_perst(pcie, port, node);
    if (ret)
        return ret;

When qcom_pcie_parse_perst() returns an error, the function returns
immediately without calling phy_exit(phy). Because the port structure is on=
ly
added to the pcie->ports list at the very end of the function, the cleanup
block in the caller qcom_pcie_parse_ports() skips this newly allocated port
and fails to execute phy_exit().

Could this keep the PHY permanently enabled across probe deferrals, and
should the error path be updated to ensure phy_exit() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-sm8350-wif=
i-v1-0-242917d88031@oss.qualcomm.com?part=3D6
