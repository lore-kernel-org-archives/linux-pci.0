Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF13195EF;
	Tue, 28 Jul 2026 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223277; cv=none; b=Z3cZhzEbKDgl7Cf6aT7lhCtcRjVnE8qbf4hHrCHBgsJKWsaTPTDfrbhDCx/ZqeOjHj3KcYPQxtPWYf1jZL732TE3+/flIA6a9HaG0t8dlkaW2BN+xjQBZN01lny1PktlpP7YIbVxKMW0CZ0c25Jq2OUE85eu+dDRoZL1lGQXnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223277; c=relaxed/simple;
	bh=KzwjlKIFtfhVSuDtxtK7DoIzUO65l8p/nnwbgXSjqPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o3BLfqe2FJoO27xHjRKTsVIdxjKRUkL9w5WhPOK0Ju4Ruy8XTMu9DnCXCXwb1mkh1Rkv9oQZOum+ge4XXHAheVpPEhHeXhQ8l30bxVZX64t9EmAmVOsCdaXygOtESUprx9a5nR5SdOyXVxqUaclh8eW+AF8cPOvAeOyhDBdQVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/pjWbFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/pjWbFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF571F000E9;
	Tue, 28 Jul 2026 07:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223276;
	bh=44/3EATCFVjm1xqy9nZRUXGbpqi6LqiR8ozSdEUOm5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/pjWbFtIg6WwxC1JguNUanyLFOSJ5BRH4x3vyoC5v5s8uu8XNL2a+deNyzAHFgAz
	 ldjmO6ObR8cWjzXWdxHWs4RrjKfrB8r7llslGvPqGNpRguUH74HFaFQLcdmH1FgqF6
	 m3AYiN+QCEobuEfsd9rgcxrqUTT4zFluvSqv2X2nGyqLQ8gj+cyA3XJng1vrTlg6AT
	 LbfmXSHVP/w3X0iHOv3ft3fp2EqtYIF0SS5Vhzzec7Cq5RB6do10QPi/vqDTaovoAV
	 +6WhDytiBd5Y8oQjq++4w50of3u5QQ3g3HRuvB+28tVV931a3YiaBilMwR7FfuofbL
	 8BjjJe3WmIS9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with
 TC9563 PCIe switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
References: <20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com>
 <20260728-eliza_evk-v4-3-decc7fe5246e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 07:21:15 +0000
Message-Id: <20260728072115.5FF571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leaf PCI endpoints are incorrectly defined with PCI-to-PCI bridge p=
roperties.
--

--- Patch [3]: [PATCH v4 3/3] arm64: dts: qcom: eliza-evk: Add PCIe1 with T=
C9563 PCIe switch ---
commit 6015c0e26c5513007cdd5660f441396cf00de5ea
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

This commit adds support for a PCIe switch (TC9563) on the Eliza EVK board
connected to PCIe1. It overrides the base iommu-map to cover the downstream
ports and uses a TLMM GPIO for reset assertion instead of PERST#.

> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dt=
s/qcom/eliza-evk.dtsi
> index b35fffb509765..32a0fdd80c8a8 100644
> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
[ ... ]
> @@ -99,6 +119,99 @@ pcieport0_ep: endpoint {
[ ... ]
> +		pcie@3,0 {
> +			reg =3D <0x21800 0x0 0x0 0x0 0x0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			ranges;
> +			bus-range =3D <0x5 0xff>;
> +
> +			pci@0,0 {
> +				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};
> +
> +			pci@0,1 {
> +				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +				device_type =3D "pci";
> +				ranges;
> +			};

[Severity: Low]
Are these leaf PCI endpoints supposed to have PCI-to-PCI bridge properties?

The devicetree parser and schema validation tools might incorrectly interpr=
et
these leaf PCI endpoints as PCI-to-PCI bridges due to the presence of
device_type =3D "pci", #address-cells, #size-cells, and ranges properties on
nodes that represent endpoint functions rather than buses.

> +		};
> +	};
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-eliza_evk-=
v4-0-decc7fe5246e@oss.qualcomm.com?part=3D3
