Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EC364943;
	Thu, 30 Jul 2026 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388233; cv=none; b=Mq4gZ/KO/5pSem8/rXGnOEUI1hJWso4aj6CAnPYffOM46/c6/Qgrh3ZeBbCpSIcFFAXjlGrvluKTyaM2yWmjdPSw/uLv3gUpQUMfAMj1YOCXTH0ofJjo9saQJsPVw95CeA/ARlFosL21BQDkOJXUng5kehVh7M/xqT56oaclqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388233; c=relaxed/simple;
	bh=P4WkClPZ2aFZydwQmz4VtsMDwea1K+ni2l+QsGlvpbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfMNHRhfIh3f9m0aTK+hbHeOYqqpfTem1OeRzeUngkTFnS5QdBTUcEjzj2BbR0Rizenscv8EWQT0RahAXkbwLEP0rlS1ZkfpvGoV3HEZmRyuu1g2Oy3weUkOMuWAWVsk6rBZvn3PoPLe0PAKVewwllhrioufjAQRdvgkI3GRdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGqFBwi7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGqFBwi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D8E1F000E9;
	Thu, 30 Jul 2026 05:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785388231;
	bh=P4KGqEOd/xzvcHhvU4Yb0KDKlNKeCizBoKV+iyITICk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGqFBwi7ht5JCc/PeGoHzI/tji98DmHr4Z68cPq5o5AmXiM9flrqTq4tJFoNGIW6C
	 50k3AS9k6Utw9s5tlxz32W6E2g9ul6JJpsIINon4PhM/Q3Oh6mZzHLpUlWsXnYEDys
	 YPkKqKhyCpCi8lrW2t5bBXYmABjxd4BPOM8lQRml3PGUD1RLHLD5EKknYwvRZFiY6F
	 P7JvH99CQmyr2CPZD/MsrkfA9wbGKlYFGlPla3SxWK2Q2/JKAoSLMjphmOKoTrYmtp
	 o9ETAWdqpQCQUi2+1N9VC+ptoe3euqyeptQz72J+QYmjzw1JSZKVtqi6XT+WQf1OVy
	 Jf6X8Dn9ObK2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
References: <20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com>
 <20260730-eliza_evk-v6-3-40ece2d33114@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:10:30 +0000
Message-Id: <20260730051031.20D8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Endpoint devices incorrectly define PCI bridge properties (`devi=
ce_type =3D "pci"`, `ranges`, etc.).
- [Low] The comment explaining that PERST# and RESX# share the same GPIO is=
 misplaced, causing confusion about pin assignments.
--

--- Patch [3]: [PATCH v6 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with T=
C9563 PCIe switch ---
commit 86f389de1416cf57b1a057c5cc8316c6fc164073
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563 PCIe
switch. Enable PCIe1, QMP PHY nodes, and TC9563 nodes on I2C and PCIe.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index b35fffb509765..419e737c54e6f 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
[ ... ]
> +&pcie1_port0 {
> +	wake-gpios =3D <&tlmm 53 GPIO_ACTIVE_LOW>;
> +	/* Same GPIO is used for both PERST# and resx-gpio */

[Severity: Low]
Is this comment placed correctly?

The comment implies that wake-gpios (TLMM 53) is the shared reset GPIO, but
resx-gpios is defined as TLMM 54 further down in the tc9563 node. Should th=
is
comment be moved above resx-gpios or the omitted reset-gpios property to av=
oid
confusion?

> +
> +	tc9563: pcie@0,0 {
> +		compatible =3D "pci1179,0623";
> +		reg =3D <0x10000 0x0 0x0 0x0 0x0>;
[ ... ]
> +		pcie@3,0 {
> +			reg =3D <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x5 0xff>;
> +
> +			pcie@0,0 {
> +				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};
> +
> +			pcie@0,1 {
> +				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};

[Severity: Medium]
Are pcie@0,0 and pcie@0,1 leaf endpoints?

If these child nodes represent leaf endpoints (like Ethernet MAC devices), =
they
should not include properties strictly reserved for PCI-to-PCI bridges or R=
oot
Ports such as #address-cells, #size-cells, ranges, or device_type =3D "pci".

Will this cause dtbs_check validation errors or cause the OF/PCI subsystem =
to
misinterpret these leaf nodes as PCI bridges?

> +		};
> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-eliza_evk-=
v6-0-40ece2d33114@oss.qualcomm.com?part=3D3
