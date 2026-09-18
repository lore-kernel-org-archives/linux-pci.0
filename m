Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45ED50390C;
	Fri, 18 Sep 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745978; cv=none; b=gM6iwUW5TXEqalfwEiHwQQfw4u/UAC8tKiV3/ILJQsJwLU5GcXhVwOa8VLGhtQOTLlw+VPHns/4t9gNo4P5XdRnV4R2TFm9tNnGghekcaZJ+/VBibp8oFPZowcPE1q/r1qDGMvoVzQfxH36H9RMafM2oelMCE9nq4hrGcMoBWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745978; c=relaxed/simple;
	bh=VbFQrttl6wWCnLSauDugqZV0z7asYV0FAk+7m//rqyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYZaeWPw6HEuG0Oo/lEaEsHwNW3a9XauyagbTdpVr7I3ZSCAuHwyBqno2io7J4Z3sC6HYOnijCkS2mmy8ICxwlwzIJO7QUVUDilZE1WR8ybgS3Axo1KJnDLXjrgj7UNdS/PpOh33+K1wx63TsyzqrcG4a3QyKvHrwMxVGD1EnYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILJ6QFR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILJ6QFR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51901F000FF;
	Fri, 18 Sep 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745966;
	bh=Zd67yz0t4opoZtOCzi4ZtDnSMs+HiY6s7KjTGc+vLFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILJ6QFR79IkwD/s0ca47aQrNFZmKlMqCAX7wsynPY7GAq682IgHccGBRxKtcxpDXX
	 ngfO4+HxCqbfwRjSGvTH07kNCLjHnbgYHlX4+RBLJykNhRIpt6wi3O4/Aptm+WC14I
	 GgR/66taCh2fpytJU1KH/WNFrCeUC/fwDy8dP+hzq4GjgRlNJ1P0uNoNjhoQugbaja
	 tlvKP7Zkxt77MifTtC577/A7SFaDayZWidTJlnK4cIrk2bOj5ykEaWF1PWjm59kUVN
	 iqJSRd9hXYHjngOFD3z8e0e1/4e0nJbzPMZt/7mFQeHjpYtr5Cjdyh5CF8ORy5XFOq
	 IME0J6CyIQkEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918152659.413268-4-elder@riscstar.com>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:39:25 +0000
Message-Id: <20260918153925.E51901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: MMIO translation failure due to static dummy ranges bypassing=
 dynamic update
--

commit 07e53b54e0b29671e1a08f764661a81fe5484062
Author: Alex Elder <elder@riscstar.com>

arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses

This commit adds devicetree nodes for a PCIe endpoint and its peripheral
buses on the QCS6490 RB3gen2 platform. It also defines static ranges for
the endpoint BARs, with the expectation that these will be updated
dynamically.

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index 3bb5fca8e2b13..5b7f5292a8864 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -955,11 +955,41 @@ pcie@3,0 {
>  			bus-range =3D <0x5 0xff>;
> =20
>  			dev@0,0 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,

[Severity: High]
Does defining these dummy ranges statically bypass the dynamic update?

During PCI enumeration, pci_set_of_node() binds existing nodes like dev@0,0
to the corresponding pci_dev. Later, when the PCI quirk calls
of_pci_make_dev_node() to dynamically update the ranges,
of_pci_make_dev_node() checks if (pci_device_to_OF_node(pdev)) and returns
immediately without calling of_pci_add_properties().

As a result, the dummy ranges are left intact, which causes child devices
on the PCI endpoint bus to use these static ranges instead of the actual
BAR addresses assigned by the PCI core. Will this lead to invalid memory
accesses or driver probe failures?

> +					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
> +					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;
> +
> +				pci-ep-bus@4 {
> +					compatible =3D "simple-bus";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +					/* Map 0x0-0x1fffff to BAR 4 */
> +					ranges =3D <0x0  0x4 0x0 0x0  0x200000>;
> +				};
>  			};
> =20
>  			dev@0,1 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				/* Ranges will be updated dynamically */
> +				ranges =3D <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,

[Severity: High]
This appears to have the same issue. Because the dev@0,1 node is already
present, the dynamic update logic in of_pci_make_dev_node() will bypass it.

Child devices under this node will then attempt to translate MMIO addresses
using these static dummy ranges instead of the actual BAR addresses assigned
by the PCI core.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918152659.4132=
68-1-elder@riscstar.com?part=3D3
