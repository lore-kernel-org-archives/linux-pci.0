Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459696;
	b=TOVcWSVc5nnjYhiCgqTTmAXszC+S4xWbdBkVmG4Lt2HP4ZgvV+Bbc7aXPpWWgCciB1wg
	 tJ/diljXD+stYYyMEJJ4JR8+6xkc92rD/HbgmSfVSk+JolLJ9T5QBYlWs8KCOv8hsNLT/
	 F152VMpnuxxu/jCDQEf9wvXsqL6XUh8eFsA4QM6yQTuf17+Ko5j5Mikxyiw6zmNwUUNIJ
	 eSlPICD8Xf84W+lmks4TpYS2YzkdgnLBj8KwDSrHzgAhP53efwUVZs85a0fOACaHw1DBT
	 yOlBr6nt7DJ5Oq0BpiAfceOejlZxsx/3aanctTVXz1/cx/jgGjeqUdNVMd7FyiA2Low==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459696;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGqJMqBNSEIrXUkPGXlYgp70+bRooqpf5MsmH7CyCl4=;
	b=CseeuKvA42k3mEU68FzCV0Wm8JX6OrnVa0ODLKcMpQbHc1CEcA2p1vw4yHc+ythNeqmy
	 ggJGpCXcUsfFHFgY3fJyBvw5Dr5/eauDjmwyfJojWrPqxVVJjgTPqOJsoqpqLd9P+ZTSx
	 GXtfCMVl0guCVemEHbHbLoVyhaYG87uJZcBpcTgfjlyADLcXJshZ3jAkHKD5g+AbUjKsC
	 0u69kWUGg6av3zru43HVfE4ECphw95FOFy3uYKev2x9XghfMkb1DLoWtAJdT0e9uGUwlL
	 NU6WB4rJ22G1BrKXfPP4wUz27j3u3eT56oFF3GzgjCUu4Q8nOAUK6QoNj/GSYYK5lig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpAURQOo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367C606A31A;
	Mon, 23 Nov 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpAURQOo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DA31F000C0;
	Mon, 23 Nov 2026 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459695;
	bh=qGqJMqBNSEIrXUkPGXlYgp70+bRooqpf5MsmH7CyCl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lpAURQOoGAeb67wRO0gSaKTdZ9oWRpxlEAFayQqEDTvWZ8NoFDZDOwGzKJuV2dPdb
	 Ri4vrRwhta8nb4jwq+kt690HKNmkcTvysw6mYB+XakFarrUHgnXeeD70LOh8Y5jdyz
	 mjUUPrO/8HsixDr3oCtvkqsB3Zy0pli8QrXD74fDQkPNJjIvk+UKGLii/25/NvpawX
	 g8OuWNxsKqmovhj7udfkeiuBnZzivOjaMP11fzssgY/Zi8yVC9eMhfe640vNUOV6WL
	 AyEqmVNHyRjUkr4dIPkPs1CTHkLhIzH0SHffqH3Rqhtz2Ca9pwThUF6OeqI4W16nAL
	 RByFfYHAn24qA==
Message-ID: <sashiko-outbox-229870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] dt-bindings: PCI: Describe the CS7542 host
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261123-b4-cs7542-pcie-v1-6-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
 <20261123-b4-cs7542-pcie-v1-6-4cde5201d404@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:48:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: PCI: interrupts listed before clocks in
  cortina,cs7542-pcie.yaml
--

commit 7f66a931d3a9682495c9ee6049f36df0d2615a1f
Author: Fil Dunsky <filipp.dunsky@gmail.com>

dt-bindings: PCI: Describe the CS7542 host controller

This commit adds the Device Tree binding schema for the Cortina Systems
CS7542 PCIe host controller.

> diff --git a/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
> new file mode 100644
> index 0000000000000..8883b8d091398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
> @@ -0,0 +1,127 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: cortina,cs7542-pcie
> +
> +  reg:
> +    items:
> +      - description: DBI registers including the viewport iATU
> +      - description: Downstream configuration window
> +      - description: Application wrapper registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: app
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: msi
> +
> +  clocks:
> +    maxItems: 1

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks

[ ... ]

> +        interrupt-parent =3D <&gic>;
> +        interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "msi";
> +        clocks =3D <&pcie_control 0>;

[Severity: Low]
This isn't a bug, but DT binding schemas and example nodes place clocks
before interrupts and interrupt-names following the canonical property
order (compatible, reg, reg-names, clocks, interrupts, interrupt-names) in
properties, required, and examples.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v1-0-4cde5201d404@gmail.com?part=3D6
