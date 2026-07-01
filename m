Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206E3F4830;
	Wed,  1 Jul 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903864; cv=none; b=hiWL4qRvGFkDksia83dLJHQjtbPyw8qdj5O2SlmFywgGzWkYsydewFT4zW9+x4TyRLlUG00G+iuVMlLA2f3yDSZdhVZxKM2BJOlbelOkleO2AgjyTen0c4D8jR4EFNoBSiIdZ8KRjMt47XloAHIjAKGLHBF72Pz4ElpCbXT43yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903864; c=relaxed/simple;
	bh=3qesG+9F/KdPht7/nQwVxS12U3O+N/hmSshuhQUcJq8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cifx1vzxz2TZSSvfyA8qre2lxm0tqfCQ441Rw5Ou8KBURBzFIbVWT5N6zXbQcfllu6OIzNhXzdxJLa+Tz8tfhopU4e6tdzZiN7o5UXKbq+g5nrrRwNvZsGeelJTajyu3N7hPiurX4Jo6Znf5dwiHcTFXmsKj3f4Yg9o3u9fjjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA1qXZu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA1qXZu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438D01F000E9;
	Wed,  1 Jul 2026 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903862;
	bh=HeoiFVV3lL3hREZrfPDaAqDcMsgmo+oIlOrM1bpGoFo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dA1qXZu+awCq5reIEzSwSY4jjksyHjSNplRxjpVKaE/pDlW5sCE9HAR5TL2598y8x
	 JfCC1ycLuUliHbRgRjKJGSJLKlHG/lwp6oCBzHPOkGqkzfZsnYgGYheWcmFUvZ6pan
	 Zq+Kut9KiV+bp9T+UIDqdHRGAz/UZIkhcK/eRVnODa2Y1xQAOYNi/TARRuOMSQD1e4
	 1+EFnCczeTNYa0XHs6K4baTgF65VPWZ54GArxWXdojcgIcdQ8GJwWyDLw1tXRh2nk7
	 /Jz7QyaSDvpDkafInHpt5/UTpPnxPox5jsxm+l7ey+i1oS1XW2BsTjqQS11YASCsZu
	 S9HDwCu46GIsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 1/7] arm: dts: imx6qdl-sabresd: Add power supply
 property to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701105234.198987-2-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:04:21 +0000
Message-Id: <20260701110422.438D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check for pwrseq_power_on() in slot_pwrctrl_power_on=
() leads to potential kernel panic.
--

commit 4b51e513820a111cd03554e7f701a9ce808be27b
Author: Sherry Sun <sherry.sun@nxp.com>

arm: dts: imx6qdl-sabresd: Add power supply property to Root Port node

This commit adds the power supply property to the Root Port child node to
support the new PCI pwrctrl framework. The legacy power supply property is
retained for backward compatibility.

> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/bo=
ot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> index fe9046c03ddd6..60fe0f973668b 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> @@ -756,12 +756,14 @@ &pcie {
>  	pinctrl-0 =3D <&pinctrl_pcie>;
>  	/* This property is deprecated, use reset-gpios from the Root Port node=
. */
>  	reset-gpio =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> +	/* This property is deprecated, use power supply from the Root Port nod=
e. */
>  	vpcie-supply =3D <&reg_pcie>;
>  	status =3D "okay";
>  };
> =20
>  &pcie_port0 {
>  	reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> +	vpcie3v3-supply =3D <&reg_pcie>;

[Severity: High]
This is a pre-existing issue, but does enabling the pwrctrl framework here
expose a regression where error checks are missing in the core code?

Looking at drivers/pci/pwrctrl/generic.c:slot_pwrctrl_power_on(), it drops
the error code from pwrseq_power_on() and unconditionally returns 0:

drivers/pci/pwrctrl/generic.c:slot_pwrctrl_power_on() {
        ...
        if (slot->pwrseq) {
                pwrseq_power_on(slot->pwrseq);
                return 0;
        }
        ...
}

If the power sequencer fails to power on the slot, the PCI subsystem is
falsely notified that the slot is ready. The PCI core will then enumerate
the bus and attempt to access the configuration space of the unpowered
device.=20

On ARM/ARM64 platforms, couldn't accessing unpowered PCIe registers result
in a synchronous external abort (SError) and an immediate kernel panic?

>  };
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701105234.1989=
87-1-sherry.sun@oss.nxp.com?part=3D1
