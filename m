Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647533DD854;
	Sun, 20 Sep 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887304; cv=none; b=Zi2/xMnLYOJgPPsQTW19oKSv13zQ5MA2+308sYGyVE9YX9t14r5bN6N0UZwfgiVy76eMfMf5DBHRW64pa7xP1rWbbD9UPGW/n3dG2Per+Cd2AOyHGEcJU3QE9N6gVc12qrjWRmiA2gfjcoiJ06BOlCvEcfX7ZCX0ww/T7kozt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887304; c=relaxed/simple;
	bh=WJA/M6LOqUAZN7ppbNZZxw68zowaZvhJ9rdn+DcUmX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUmCqaTOf6Uocj9/Du6tpfWtaeTznWPOwtnkdLyf4+MzKJdNd9p1c3FfNOpglwIrEMxcSvSgoWxXhZfiS6ZOwFHhwaiK3EHVm6DrUqcZY4MaEiTaO8zP+EEd51AjRdt5q/jAW8c2nfrWjI08rOm5JN2SA06849GmXk0k2hEWDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5xl/9Ws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5xl/9Ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE271F000FF;
	Sun, 20 Sep 2026 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887303;
	bh=8la79h/09COotf9SJuUZMJNnGvwYCOrKvgm/aP41I7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5xl/9WsZbLYYkEnB7VcqIIZyeuy7S4oq4PlIXvohJzkBTf6RIRCZaibqR3oOZ77l
	 Bif7oEh485c3HHoKSi/mO4KdvYJDejlwBYNfgWMOF1xnejS/xolKrYK6HmfgFkS7tT
	 bC/4ogge4YOb64yfmOf6zXR4FWgE2gf45wrfLwo+rmYmRHOXwAYcLxI4UwNXf3lnN/
	 eK6u6iP+y6QHbKPIKKcnibsx39rsNOoyHJqXULxDmV0lRBQOnYKWhn3FGT+yGAOUt/
	 pq52QSTo/MvR0VN8ePJz/YqxGRPWCGMJKCBc5I8uaZZDybaj06eY/gcPKJkqQ6tqMa
	 ET1E0f23F5VXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/12] arm64: dts: s32g: Add PCIe controller
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com, Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260919-s32g_serdes-v3-11-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-11-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:55:02 +0000
Message-Id: <20260920065502.6CE271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pcie: dt-bindings: invalid 32-bit space code for 64-bit PCI wind=
ow
--

commit 584612463291c6e4c640175e9ad62d085a5e585d
Author: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

arm64: dts: s32g: Add PCIe controller nodes

This commit adds the disabled PCIe controller nodes (pcie0 and pcie1)
for the S32G2 and S32G3 SoCs. It includes register mappings, interrupts,
and the ranges properties for mapping PCI addresses to CPU memory.

> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/d=
ts/freescale/s32g2.dtsi
> index 404913b208fb8..539840340318d 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
[ ... ]
> @@ -918,7 +918,88 @@ gic: interrupt-controller@50800000 {
[ ... ]
> +	pcie0: pcie@40400000 {
> +		compatible =3D "nxp,s32g2-pcie";
> +		reg =3D <0x00 0x40400000 0x0 0x00001000>,	/* dbi */
[ ... ]
> +		ranges =3D <0x01000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +			 <0x02000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
> +			 <0x02000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;

[Severity: Medium]
Does this ranges property use an incorrect 32-bit space code for a 64-bit P=
CI
window?

The third entry maps a 64-bit PCI address (0x1 0x00000000) and a size over =
4GB
(0x6 0xfffe0000), but starts with the 32-bit memory space code (0x02000000).

According to Open Firmware PCI bindings, regions with addresses or sizes
exceeding 32 bits should use the 64-bit memory space code (0x03000000 for
non-prefetchable or 0x43000000 for prefetchable).

Could this cause device tree parsers in the kernel or U-Boot to reject the
mapping or truncate the address, potentially leading to functional failures=
 for
devices needing memory in this range?

[ ... ]
> +	pcie1: pcie@44100000 {
> +		compatible =3D "nxp,s32g2-pcie";
> +		reg =3D <0x00 0x44100000 0x0 0x00001000>,	/* dbi */
[ ... ]
> +		ranges =3D <0x01000000 0x0 0x00000000 0x4f 0xfffe0000 0x0 0x00010000>,
> +			 <0x02000000 0x0 0x00000000 0x48 0x00000000 0x0 0x80000000>,
> +			 <0x02000000 0x1 0x00000000 0x49 0x00000000 0x6 0xfffe0000>;

[Severity: Medium]
Is this code also using a 32-bit memory space code (0x02000000) for a 64-bit
PCI window?

> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/d=
ts/freescale/s32g3.dtsi
> index 0d001b2895c61..fdf086363c020 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
[ ... ]
> @@ -1069,6 +1070,86 @@ gic: interrupt-controller@50800000 {
[ ... ]
> +	pcie0: pcie@40400000 {
> +		compatible =3D "nxp,s32g3-pcie", "nxp,s32g2-pcie";
> +		reg =3D <0x00 0x40400000 0x0 0x00001000>,	/* dbi */
[ ... ]
> +		ranges =3D <0x01000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +			 <0x02000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
> +			 <0x02000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;

[Severity: Medium]
Is this code also using a 32-bit memory space code (0x02000000) for a 64-bit
PCI window?

[ ... ]
> +	pcie1: pcie@44100000 {
> +		compatible =3D "nxp,s32g3-pcie", "nxp,s32g2-pcie";
> +		reg =3D <0x00 0x44100000 0x0 0x00001000>,	/* dbi */
[ ... ]
> +		ranges =3D <0x01000000 0x0 0x00000000 0x4f 0xfffe0000 0x0 0x00010000>,
> +			 <0x02000000 0x0 0x00000000 0x48 0x00000000 0x0 0x80000000>,
> +			 <0x02000000 0x1 0x00000000 0x49 0x00000000 0x6 0xfffe0000>;

[Severity: Medium]
Is this code also using a 32-bit memory space code (0x02000000) for a 64-bit
PCI window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D11
