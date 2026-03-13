Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1EC32A3DA
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382101; cv=none; b=f3h8nmySDafbPt+q1mcxDxWrCz/2NavyU42wSULAkHLy31Xni4YkEbJ9AjTGYhhEn2tlLcrx2Nb5t7NpECGhpxdGmLwdwhjE18nwaHcfROHC/WeGsQIG2AFawvgCKROP0GFSpV8XSMfM2lOSS6pkjTUbfHuThIKyVzro7ulz5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382101; c=relaxed/simple;
	bh=orM5K8/7CHqa8T7Py1fyX7mMHWEfOFajrWwcTwGiGbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj5lbgdvgsi9ou1Y7PLX4I1moPHDU6p0HP06NzKpYVYSr70M221OgO2h+MMUz0Do+EiDKZFH0LuAWOnnNr20dKUUn4IbZ4+gXoB+2ja/3THssQ8UWLPb4k3MCPzOX+UBCNlGlMYpG8nAkty6d1xROWY7QHFtheg+vO6piZEwsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM97ZEW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM97ZEW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18EEC2BCAF
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773382101;
	bh=orM5K8/7CHqa8T7Py1fyX7mMHWEfOFajrWwcTwGiGbo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=WM97ZEW/dU787GDBAOVCbEUV7wIXAuxHkjisG6RX7bDJmWx6rJpXUeZsZ33EmzATW
	 GbKfoc7u6z/r0qPatxS8Jx2MQiXxb96emzM1g1pK0uAF8Bh6K26vSbEr4zjwr8xyKN
	 k36RRr3eqMv+WDbgSo0JdvBOM89Take9aeHKfMy68XNIX7YWQv0G9OeK/o8J9GY8al
	 nRwbMDmMJ/MvKVrRe1WIKtCs9obZGJXh2UY0RjvxohbXiMwnI3w0XHHIsunscDjh4I
	 k7bew+KDGLN6/57RMIc0cnvDds+b35s2LNrHRHqzhtZJaCAh5YN/bMeWay17j14dGR
	 a+t3bK/seWkCQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a46657a9fso18462771fa.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 23:08:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkF9RV2mvs/jfMtTMdnf+fHd5q86UuR42WIhGVO/fg+6cqGcdNyd5NCdqy3lli8Z//F06Bp5BtJLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5NU7mOfUy5AG4NsE2J2QfGA3jsHkEjG0k4mFI61w0WY0rXfL
	+P093MA/vzrTrQe1/sIK8Ikx0OnzBuHaWNE9nIyVGN0zXk3yGGKwlHyde/NXQTyly1CWNPIBXz9
	9rfw9KVACpca1/iwQU16rlk29NtHus/c=
X-Received: by 2002:a2e:8a86:0:b0:387:2df:f3ee with SMTP id
 38308e7fff4ca-38a8978752fmr6557441fa.33.1773382099086; Thu, 12 Mar 2026
 23:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313020823.1592389-1-sherry.sun@nxp.com> <20260313020823.1592389-7-sherry.sun@nxp.com>
In-Reply-To: <20260313020823.1592389-7-sherry.sun@nxp.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 13 Mar 2026 14:08:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
X-Gm-Features: AaiRm52-YD_vTip-QztGRiYxgL7k6zRpm-Clb44P3TJreIxPFicxmd8vkCMHT1k
Message-ID: <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
Subject: Re: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST property
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	kernel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:08=E2=80=AFAM Sherry Sun <sherry.sun@nxp.com> wr=
ote:
>
> Since describing the PCIe PERST# property under Host Bridge node is now
> deprecated, it is recommended to add it to the Root Port node, so
> creating the Root Port node and add the reset-gpios property in Root
> Port.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
>  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
>  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/bo=
ot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> index ba29720e3f72..fe9046c03ddd 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> @@ -754,11 +754,16 @@ lvds0_out: endpoint {
>  &pcie {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_pcie>;
> +       /* This property is deprecated, use reset-gpios from the Root Por=
t node. */
>         reset-gpio =3D <&gpio7 12 GPIO_ACTIVE_LOW>;

I'd say just remove the old description.

You're asking for trouble by describing the same thing in two different pla=
ces.

>         vpcie-supply =3D <&reg_pcie>;

I would probably also take this chance to just convert to the proper PCI
slot supply, and just add pwrctrl support into your PCIe driver.


>         status =3D "okay";
>  };
>
> +&pcie_port0 {
> +       reset-gpios =3D <&gpio7 12 GPIO_ACTIVE_LOW>;
> +};
> +
>  &pwm1 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_pwm1>;
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/n=
xp/imx/imx6qdl.dtsi
> index 4dc2c410cf61..9438862b9927 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> @@ -302,6 +302,17 @@ pcie: pcie@1ffc000 {
>                                  <&clks IMX6QDL_CLK_PCIE_REF_125M>;
>                         clock-names =3D "pcie", "pcie_bus", "pcie_phy";
>                         status =3D "disabled";
> +
> +                       pcie_port0: pcie@0 {
> +                               compatible =3D "pciclass,0604";
> +                               device_type =3D "pci";
> +                               reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +                               bus-range =3D <0x01 0xff>;
> +
> +                               #address-cells =3D <3>;
> +                               #size-cells =3D <2>;
> +                               ranges;
> +                       };
>                 };
>
>                 aips1: bus@2000000 { /* AIPS1 */
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/bo=
ot/dts/nxp/imx/imx6qp-sabreauto.dts
> index c5b220aeaefd..6b12cab7175f 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> @@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ         0x000b1
>  };
>
>  &pcie {
> +       /* This property is deprecated, use reset-gpios from the Root Por=
t node. */
>         reset-gpio =3D <&max7310_c 5 GPIO_ACTIVE_LOW>;
>         status =3D "okay";
>  };
>
> +&pcie_port0 {
> +       reset-gpios =3D <&max7310_c 5 GPIO_ACTIVE_LOW>;
> +};
> +
>  &sata {
>         status =3D "okay";
>  };
> --
> 2.37.1
>
>
