Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267905;
	b=spaXA7dVUiYg38wKBvPrDcCZM8uzyjQ92y+oR2xJtslw+cocGtyN4ov6PbuEi/zvR8Fo
	 xy0HlhLsfD8jrfrzsnoVW1gsB7d8zHwlVtHET5rN6vveMKsQQgiBmC9qDL8Rm5X5oQuHQ
	 4a42/QIwulhlYW4nPS+IQxIumRPqXsImGyW0KfUY0/EKnLgtPMI1YtYl01kCUkRQbhtIF
	 F4txcE/+KYefvQV6Oh+tW/rTDo2qsXwVSbLQNmg4CXKUKKsv4nlMOxlDqATu56DG1trbF
	 gAjYy6b3jkMbqYme6VZUJVbOyqc+DbnvfoxKaHkH5sz6GOXYNXvAm4HnU+J4+JA2z/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SfRbMtxOF6OEnmFrytMC+J1bVdhclNgq5j+noxgaQSw=;
	b=L+G61R/f7i0BZ9/ja1VQjmcEjuu/QTznwLTzPrEBnzsw3KhrCE9N2s5QV38MvyuS1b6R
	 OjUTsD71jwMFyMaTpO4t7712AgLhTQEnl1r3WDls786Jn8iZ8yB2FK1HYps9bVhx0EPev
	 zmOKqRsUHMGAzlWDhse6pMy65JU1xvi475c1iFBtCttq9EzxqahMeM7YblS6ikYTkn3+U
	 g4jOopfYT2/YBOH0p94ek9L9Hn9gtZxLjsERxrrwYxO5wsaM5ybfDvVtpAVvdhGoqdeL6
	 I7/CMf2ZNzbBlcenooceIbEMjXgscveueVZxJ+0gK/ND9+nSHyHIkyxZSSdoUIB59Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nh/flU8v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E2606A325;
	Thu, 29 Oct 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nh/flU8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A61F01829;
	Thu, 29 Oct 2026 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267904;
	bh=SfRbMtxOF6OEnmFrytMC+J1bVdhclNgq5j+noxgaQSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nh/flU8vXEq4hpRjyd8qPXRFWGTygLf6fvyDZOEql0qiThUTwZrqLXIuPXQeADz8Y
	 TK9BC5ezAyTmecY48G4y2ZUl3C0hjOc8uRFTBWcBGFkbOXHfi3xYTPYlbTJeaY+2ZS
	 1hkp4XGZwKYfK0IACG3GCay0UWd/dfIs/27yks86cmFMqyfET6p75T0+1DbZ9swkk+
	 iVgXah1DTWFw5WCsWRJkKdryTJ8FKFmvmNKN7GwgZ81MjJceKh+IuX18v9v4zmhjDB
	 El2AerPcfNBmIJQ8LIz1zudX9teQYD9E3czfVPKyjduhH08ckRqycyU+MaVBLzsRqX
	 lyK0nw1tES1NQ==
Message-ID: <sashiko-outbox-189076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp: enable PCIe ECAM and
 64-bit memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-q8b-dts-v3-1-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
 <20261029-q8b-dts-v3-1-655696dfec45@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:58:24 +0000
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
- [High] arm64: dts: qcom: sa8540p: unpreserved PCIe address maps for pcie2=
b/3b/4
--

commit 367f523cda7b8c336244029f70635c13b0b90574
Author: Xilin Wu <sophon@radxa.com>

arm64: dts: qcom: sc8280xp: enable PCIe ECAM and 64-bit memory

This commit enables PCIe ECAM and 64-bit memory windows for all five PCIe
controllers in sc8280xp.dtsi, while preserving the 32-bit address map for
pcie2a in sa8540p.dtsi to avoid regressions on SA8540P platforms.

> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/=
qcom/sa8540p.dtsi
> index 23888029cc117..e5393a237497c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -180,6 +180,15 @@ &gpu_smmu {
> =20
>  &pcie2a {
>  	compatible =3D "qcom,pcie-sa8540p";
> +	reg =3D <0x0 0x01c20000 0x0 0x3000>,
> +	      <0x0 0x3c000000 0x0 0xf1d>,
> +	      <0x0 0x3c000f20 0x0 0xa8>,
> +	      <0x0 0x3c001000 0x0 0x1000>,
> +	      <0x0 0x3c100000 0x0 0x100000>,
> +	      <0x0 0x01c23000 0x0 0x1000>;
> +
> +	ranges =3D <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
> +		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;

[Severity: High]
Should the 32-bit reg and ranges properties also be preserved for pcie2b,
pcie3b, and pcie4 in arch/arm64/boot/dts/qcom/sa8540p.dtsi?

While pcie3a already defines its own reg and ranges overrides in
sa8540p.dtsi, the remaining controllers in that file do not:

arch/arm64/boot/dts/qcom/sa8540p.dtsi:
    &pcie2b {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <1>;

        interrupts =3D <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };
    ...
    &pcie3b {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <3>;

        interrupts =3D <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };

    &pcie4 {
        compatible =3D "qcom,pcie-sa8540p";

        linux,pci-domain =3D <4>;

        interrupts =3D <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-names =3D "msi";
    };

Boards such as arch/arm64/boot/dts/qcom/sa8295p-adp.dts include
sa8540p.dtsi and enable pcie3b and pcie4:

arch/arm64/boot/dts/qcom/sa8295p-adp.dts:
    &pcie3b {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pcie3b_default>;

        status =3D "okay";
    };
    ...
    &pcie4 {
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&pcie4_default>;

        status =3D "okay";
    };

Without reg and ranges overrides in sa8540p.dtsi, pcie2b, pcie3b, and pcie4
inherit the new 64-bit ECAM config regions (at 0x4_c0000000, 0x4_40000000,
and 0x4_00000000) and 64-bit MMIO windows from sc8280xp.dtsi. When
qcom_pcie_probe() -> dw_pcie_host_init() -> pci_host_probe() runs on
SA8540P/SA8295P platforms, won't accessing those SC8280XP 64-bit address
ranges cause a regression due to the differing SA8540P memory map and
firmware protection rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v3=
-0-655696dfec45@radxa.com?part=3D1
