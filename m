Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58F19CD1D;
	Tue, 30 Jun 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800455; cv=none; b=FR2M4sgAMZjrodELb/ufXzV81AMd4l/4wVqPIoQiuVRuM5pV6vt8y5tfNL7i3TyHDs0IqvD1C1CHu3DoTDU4iHNui5x4fgWdKMlZhaPhpmxUjR+qWFdOAdm619F/npmou1XZPN4OO2xfr+pnHgbWltllDPf6iNUXewurv/b1hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800455; c=relaxed/simple;
	bh=W6v2arCUDxMeE8XppBoiaUULPo0wHZC28kWmqDYqOlg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kc+iOG3xhX8kzpxi3qlP5EnoMFNs0QDLl1ipIZKHPLQaMoxkn6QFYMFg2CloTDEL8sbi4QJpXXU8PNshafmhNtCZis8i0Dy4cdx5vb/UcaqJ8EEn34cJ3cNn/ZU+gFsKgO590O/RydNWcOr/vGaPxb7ylJsC+MzZbU826Q1Dux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOJVF0JL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOJVF0JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2027C1F000E9;
	Tue, 30 Jun 2026 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782800454;
	bh=D0wlt4t0ByrjhkSEjBKvP1kLtnlekKW1YgIAd6pvwxU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XOJVF0JLiUN7dIdaUix/FmVObg4Ob8UCrvaEaSN/ihPoAiB4Apz8lvcTzNDGZTc5h
	 b1lhFMRjrMYZc8Hsa5gTFq+vK2fLqeiKBkdRm1FOZqRJDserqJKxX2quSeBnrd5z+l
	 /Mwn58ev1uxFRdgevY9MjNlYKixrte53Gzaf7ZL2SxJI0xo+P0oowuol5SC4/Tp077
	 4sG1LWN4ucvmnJ8oV8ceOpMP6PduxpCbQMGTAabaWeHIEgCKP+iKiKrFFU5E2EnVB1
	 DDw2xUfcwjVTwj0i8RG0dtbGUQQfyBcpgorZJdLkP+RMjZOwdHrSMoo2HIkLx+/F3T
	 6kqRSWIBcoEkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 5/7] arm64: dts: imx8mq-evk: Move power supply
 properties to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260630060710.3294811-6-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-6-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:20:53 +0000
Message-Id: <20260630062054.2027C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] DT ABI breakage: Removing `vpcie-supply` and `vpcie3v3aux-supp=
ly` from the PCIe controller node breaks PCIe functionality on older kernel=
s.

Pre-existing issues:
- [High] Resource and memory leak of regulators and `slot->supplies` array =
in `slot_pwrctrl_probe` error paths and driver teardown.
--

commit 331966289ddb574974fd80a80b3f1214ffc7055f
Author: Sherry Sun <sherry.sun@nxp.com>

arm64: dts: imx8mq-evk: Move power supply properties to Root Port node

This commit moves the vpcie-supply and vpcie3v3aux-supply properties from t=
he
PCIe controller node to the Root Port child node. The change is intended to
support the new PCI pwrctrl framework.

> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mq-evk.dts
> index e7d87ea81b697..541f6d5e9cefb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -403,8 +403,6 @@ &pcie1 {
>  		 <&pcie0_refclk>,
>  		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
>  		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
> -	vpcie-supply =3D <&reg_pcie1>;
> -	vpcie3v3aux-supply =3D <&reg_pcie1>;

[Severity: Critical]
Does removing these properties break DT ABI compatibility for older kernels?

If an older kernel lacks the new PCI pwrctrl framework, its pci-imx6.c driv=
er
will look for vpcie-supply and vpcie3v3aux-supply in the parent PCIe contro=
ller
node.

Without pci-pwrctrl to enable the child node's supplies, the regulators mig=
ht
never be turned on, causing PCIe devices to fail probing.

>  	vph-supply =3D <&vgen5_reg>;
>  	supports-clkreq;
>  	status =3D "okay";
> @@ -422,6 +420,8 @@ &pcie1_ep {
> =20
>  &pcie1_port0 {
>  	reset-gpios =3D <&gpio5 12 GPIO_ACTIVE_LOW>;
> +	vpcie3v3-supply =3D <&reg_pcie1>;
> +	vpcie3v3aux-supply =3D <&reg_pcie1>;
>  };

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing the PCI pwrctrl framework
that this DT change supports, I noticed a potential resource leak in the
probing path.

In drivers/pci/pwrctrl/generic.c:slot_pwrctrl_probe():

        slot->clk =3D devm_clk_get_optional(dev, NULL);
        if (IS_ERR(slot->clk))
                return dev_err_probe(dev, PTR_ERR(slot->clk),
                                     "Failed to enable slot clock\n");

If devm_clk_get_optional() fails (e.g., returns -EPROBE_DEFER), does this
return path leak the slot->supplies array allocated by
of_regulator_bulk_get_all(), as well as the regulator references?

Since devm_add_action_or_reset() has not yet been registered at this point,=
 it
appears the cleanup is skipped entirely on this failure path.

Additionally, looking at the driver teardown path:

drivers/pci/pwrctrl/generic.c:devm_slot_pwrctrl_release() {
        struct slot_pwrctrl *slot =3D data;

        regulator_bulk_free(slot->num_supplies, slot->supplies);
}

Does regulator_bulk_free() actually free the dynamically allocated array
itself, or does it only drop the regulator references, leaving the
slot->supplies array memory permanently leaked on unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060710.3294=
811-1-sherry.sun@oss.nxp.com?part=3D5
