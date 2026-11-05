Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878976;
	b=2y/YY/yf/5hLcD1QeJImfHKbu3l2uh52YtBh4JcspsbfWlUri/1YMwXjS9k9zKsyaLk6
	 O3GQBkVAEgOxl7blyQ2IoGykW6qb/DOYliQX3kp0rtcIr08O1ihfkLlFAgfpagOOR25cq
	 i9Y9PeRFuFBxokeikTDfDmnI6u/lxTWuZRN7O10iYlnNnwxmj8w3Gs5GhlQeUz1eo3qiV
	 UGI6IR7tMxWH5RWQRRh8FXBwag9U6DIBspRBctD64j5AqEhlaTpKjhuCra5sD6qp+t9fi
	 BxmVT4cG2TwQ8xdDN66zu13XfxifTGBQVm/qcXKnGpJ+tdyDHJd199imZ0+20WpXaPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vsz4UyjlY+BuhJV95kmX0T3HN6I+F+RhqHGin7cX1WU=;
	b=cTNoNvIUhxA0XZ9dCDYKrVvAe5ZfRQvwDIixEkU0zaAD48bWdP1n0wFuSWHKWjXuzBeZ
	 NVpasdN7fiOZJoiOp8XdvVvfNBa4hWoAHpgiKbo1L0wbbCTxp59IVlZ5Ir1gWgZ5bZQ87
	 290rjHIeosxWHfHhqbwYy7x7RXxQW4ZeisxYK4YqfvdMSa+U5pwHYrxJQnLs2KrXO7hH9
	 SlHMmhyNpcig3CHRNwncM9eSFvHckgXdaepHHP6gV1+88RJTPp3R+Fm8Nmnfznen6gP5H
	 nyZVaVRIHfRrm+LcyL7j5UouOW9TU1hsvQAB+DjN+bBnPynxHDqJodo4Ol+2KW1ELjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlFQJRRE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21422606EE9E;
	Thu,  5 Nov 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AlFQJRRE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701911F00A16;
	Thu,  5 Nov 2026 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878975;
	bh=Vsz4UyjlY+BuhJV95kmX0T3HN6I+F+RhqHGin7cX1WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AlFQJRRErFY6obqRNasqLcRdnazNttCrLasBkZYvMcuQxdkEH5D/Blt//Y7K/9g8E
	 4CR6pMqK24Eeg3g/0ImWyKD7XBeGS2lZz9gNiXoRc4yoiaqBMUuZ+kZYg2mAs/t5q0
	 7qP3RvaKAUtt68Jwld+KkxIHMkFGb8Wj1otOH+58USl+uxRDtESdnCTaGyHI6tMlqA
	 MJwAnAffnUAQMAEX3k0cAG0j45Qo2CkNEOBy85WneWAlZsSzbRKPM/GUI20Zz93Lwd
	 KpgjmbtaCZwmYU5jWlHAlqx6GOMSIfnJlekGIOwtkru+3vSJVLGDoiS3UDk95WCm0G
	 dIiu1YVKMDx7g==
Message-ID: <sashiko-outbox-198970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: apple: t603x-j514-j516: Add PCIe device
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-6-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-6-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:42:55 +0000
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
- [Medium] arm64: dts: apple: wrong wifi0/bluetooth0 PCI IDs in t603x-j514-=
j516.dtsi
--

commit 93b064f5082472a65526181caee83a837e8be25d
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: t603x-j514-j516: Add PCIe device nodes

This commit adds PCIe device nodes for Wi-Fi, Bluetooth, and the SD-card
reader to the M3 Pro and M3 Max MacBook Pro device trees, along with
board-specific brcm,board-type properties.

> diff --git a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi b/arch/arm64/=
boot/dts/apple/t603x-j514-j516.dtsi
> index bbee373044f94..403a9cb3979c7 100644
> --- a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
> +++ b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi
[ ... ]
> @@ -67,3 +69,42 @@ &serial0 {
>  &fpwm0 {
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
> +	};
> +
> +	bluetooth0: bluetooth@0,1 {
> +		compatible =3D "pci14e4,5f71";
> +		reg =3D <0x10100 0x0 0x0 0x0 0x0>;
> +		/* To be filled by the loader */
> +		local-bd-address =3D [00 00 00 00 00 00];
> +	};
> +};

[Severity: Medium]
Should wifi0 and bluetooth0 under port00 in
arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi use the Broadcom BCM4388
PCIe IDs ("pci14e4,4434" and "pci14e4,5f72") instead of the BCM4387 IDs
("pci14e4,4433" and "pci14e4,5f71")?

In arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi (M1 Pro/Max), wifi0 and
bluetooth0 use "pci14e4,4433" and "pci14e4,5f71", which
arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi (M2 Pro/Max) then
overrides for BCM4388:

&wifi0 {
	compatible =3D "pci14e4,4434";
};

&bluetooth0 {
	compatible =3D "pci14e4,5f72";
};

The base M3 MacBook Pro J504 in arch/arm64/boot/dts/apple/t8122-jxxx.dtsi
also uses "pci14e4,4434" and "pci14e4,5f72" for wifi0 and bluetooth0. It
looks like when the port00 node was copied from t600x-j314-j316.dtsi into
t603x-j514-j516.dtsi, the overrides from t602x-j414-j416.dtsi were missed,
leaving all six M3 Pro and M3 Max MacBook Pro device trees with the older
BCM4387 compatible strings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D6
