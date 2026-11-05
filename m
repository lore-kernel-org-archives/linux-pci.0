Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879220;
	b=3umWfwylX/ay96IoLkRIIBLSqiwhc/fWbDSniDUle2Z+1zJ+Mu9YSQMLLG4Yz/1yuTkR
	 zdRpXiN9KPd5jbhsG7EB1jo6L7XEG05OEFFwr1G7gT7X7gJbRUiucsoASPHVAgeLlmt6D
	 ZGRTNrbk7Wp1hyINybcCvISwMEfTnIEFyueF+myet2a3ZifE3DNpMI/iiaqlZ2xCcYtQ8
	 GgDd9EH2/gCUr+VKaoik8v6fGSEzD1nIcBrQR8FIEMnx13fvJSh2qUz1GtiMjHqhoanGy
	 CWCh87oQPwxJQMGZyBLw1O45xNi0RpPGFo8PpU+okt2m0VYj3m56nHsdVeP59Zg2Q0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cMOX5EBfOyNRr2Oq99K3ZFUmNgaKXTiX7rtSTdwx/HI=;
	b=kG6RzrO78caOOPZRNXptsNdsZq1kveaCnFe/to3ufkBQvftmHHHyFP4syHn5zw0GeXdD
	 PMNXBhFgzG48RegkEeunNLi5lD18Ob+LXYNZVpfMIoaIGOdMHs+YPVloMn1d68zQk5MOA
	 h4pqG9ZwgMzflz+lfWgbud7HBG3lsLkBiSCN+dzUokUzS3rqAydOKA3VyeZ+WR5FL4rq2
	 B9PsHqXN15/ciQI9npJwgxd9Ge5znCIEPgf0/FbkTryVhGCHtKp84KTNuy8dG7cyErF2Z
	 52A2AJskOoOHSfjCSRwUEdu9/rA5mxjqxwYCdoktf+/RDEK8JATIZDzPew1h4qMpqOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7Ia2o1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26716606A335;
	Thu,  5 Nov 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7Ia2o1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DEF1F000C1;
	Thu,  5 Nov 2026 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879220;
	bh=cMOX5EBfOyNRr2Oq99K3ZFUmNgaKXTiX7rtSTdwx/HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7Ia2o1IO/2blC4gBnmMivRlGp7aphlRtAW7J6jItq9jZtAeHeeQAPfPgylvXM69c
	 tqq4GMpING+df+uKdxplysPsNCcsRx/E2Ga3bZnjfCdolCXbsWCF9COADBJKVifaMc
	 gkpHrK5Lu0Dc6cmGqtBcfHoUY2UajS6Xqyk5oO7RY3zwtho0pOwaGW/OcUnhfB6sUQ
	 kGvAudVVftGF/HRmpvOAibI6wb4K0ogp1/8vAs+Al8XMDXtqSL0rNe7tkZro1caMDw
	 d1x8uSoJuy7oRq8x5+MeMdh0EHk/lge6SpSVpSsm330srXkjZbLyk8LQxqwDHWYYEr
	 1YkcIbkKroD7w==
Message-ID: <sashiko-outbox-198972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: apple: t6032-j575d: Add PCIe device
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-7-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-7-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:46:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: apple: t6032-j575d: wrong BCM4387 compatibles on wif=
i0/bluetooth0
--

commit a9db7fb0da8155ad8eed2129e9cc8ce52e4427e3
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: t6032-j575d: Add PCIe device nodes

This commit adds PCIe device nodes for Wi-Fi, Bluetooth, the SD card reader,
Ethernet, and USB xHCI on the M3 Ultra Mac Studio.

> diff --git a/arch/arm64/boot/dts/apple/t6032-j575d.dts b/arch/arm64/boot/=
dts/apple/t6032-j575d.dts
> index 12991546d4bb2..f99fd47dfc8d5 100644
> --- a/arch/arm64/boot/dts/apple/t6032-j575d.dts
> +++ b/arch/arm64/boot/dts/apple/t6032-j575d.dts

[ ... ]

> @@ -46,3 +49,72 @@ memory@10000000000 {
>  &serial0 {
>  	status =3D "okay";
>  };
> +
> +/* PCIe devices */
> +
> +/*
> + * Force the bus number assignments so that we can declare some of the
> + * on-board devices and properties that are populated by the bootloader
> + * (such as MAC addresses).
> + */
> +&port00 {
> +	/* WLAN */
> +	bus-range =3D <1 1>;
> +
> +	wifi0: wifi@0,0 {
> +		compatible =3D "pci14e4,4433";
> +		reg =3D <0x10000 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-mac-address =3D [00 10 18 00 00 10];
> +		apple,antenna-sku =3D "XX";
> +		brcm,board-type =3D "apple,aruba";
> +	};
> +
> +	bluetooth0: bluetooth@0,1 {
> +		compatible =3D "pci14e4,5f71";
> +		reg =3D <0x10100 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-bd-address =3D [00 00 00 00 00 00];
> +		brcm,board-type =3D "apple,aruba";
> +	};
> +};

[Severity: Medium]
Should wifi0 and bluetooth0 under port00 in
arch/arm64/boot/dts/apple/t6032-j575d.dts (and in
arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi from the preceding patch in
this series) use the BCM4388 compatible strings ("pci14e4,4434" and
"pci14e4,5f72") instead of the BCM4387 compatible strings ("pci14e4,4433" a=
nd
"pci14e4,5f71")?

In Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
(commit 4fb80f2f90d6) and
Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
(commit ef4d6ea11df0), pci14e4,4433 and pci14e4,5f71 identify BCM4387, wher=
eas
pci14e4,4434 and pci14e4,5f72 identify BCM4388 used on M2 Pro/Max/Ultra and
later systems.

On the M2 Ultra Mac Studio (arch/arm64/boot/dts/apple/t6022-j475d.dts), the
inherited BCM4387 compatibles from t600x-j375.dtsi were overridden with
BCM4388:

    &wifi0 {
    	compatible =3D "pci14e4,4434";
    	brcm,board-type =3D "apple,canary";
    };

    &bluetooth0 {
    	compatible =3D "pci14e4,5f72";
    	brcm,board-type =3D "apple,canary";
    };

And the base M3 device tree in arch/arm64/boot/dts/apple/t8122-jxxx.dtsi al=
so
uses the BCM4388 compatibles under port00:

    	wifi0: wifi@0,0 {
    		compatible =3D "pci14e4,4434";
    		...
    	};

    	bluetooth0: bluetooth@0,1 {
    		compatible =3D "pci14e4,5f72";
    		...
    	};

Did copying the port00 child nodes from the M1 template (t600x-j375.dtsi and
t600x-j314-j316.dtsi) leave the older BCM4387 compatibles in place by mista=
ke?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D7
