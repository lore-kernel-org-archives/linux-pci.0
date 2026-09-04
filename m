Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E93D969D;
	Fri,  4 Sep 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538114; cv=none; b=RrXJMhVYNEXBLRQ21dWlhdj0S+ohJYA/bs8OLmT3RQkxdFfGFgygu8mDkeEz22NYJXfLUiyN8bEIEJD1VP4KOvEpvARCyK4oHJpm1QBNXbCtTVRBHMwXpRMTuLGdI1qOfY6OpPYaIqmWwRvGV8b0E1pY5Jl2AeWDHHxfsz44prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538114; c=relaxed/simple;
	bh=tQYwM88qmegnt6nV1iv9g7c1VlyruLz2UJIsoGKWgLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gxf57b8wQtI/NHExjc5IiBCYbF7f+ezjydtKSMMl3jKHLFtZkO4s9cl3bvQvCM85TZs+cmURKiBuZTxw//rl8q8Bb6L+/8VDh9XxacFzs4VXfZutr1DUoiJobnbc4UYWAHEyROl836VQLL7FO9NyZmoEOQPlUXLIqc9PCnjw9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJRKSBjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJRKSBjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B921F00A3E;
	Fri,  4 Sep 2026 16:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788538110;
	bh=bR3EsiJTcuG3wyeb0fOsQnAa+YeQ/ZyAmPX0sUBGkaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJRKSBjH+RINzRvUmkobmkRKdF1tdwljmc+SrE1L4vGlgvUCbINhNksh5sTYo4Pdy
	 7qs95sEpuAVH5AtJey95YkPm1ftP/weZucHr/sxgZXlOpzlTXQHXOEGtae6b6ugpBr
	 PhLEFnX3hjYCYSMR5/PSe49k0FSqhJehXQJ1aDjuVzpNcfTFscQBJW4QjnmseO+lC3
	 J8m/Eu2OMuNMhBdbyemr5MB9vIaX42cLlObAd+gBbknmbVapkw2jvPWUC1seDHwdP8
	 6j00umimLBbk58lPxzvDYgLD9BwHmzvfoftbOlEsVX+2qOplKBAZNPQZuAuDIn9Qy+
	 +MWyWYbKcu7dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/11] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-11-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-11-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:08:29 +0000
Message-Id: <20260904160830.38B921F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Invalid bus-range property for PCI-to-PCI bridge (pcie@1,0).
--

commit 44e277594358ae378b8bf12010e21f9f5a15795b
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

This commit adds support for the QCA2066 WiFi/Bluetooth module on the
Arduino VENTUNO Q board. It introduces a wireless LGA connector node
and a downstream PCIe port node so the power sequencer can enable the
M.2 slot.

> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm=
64/boot/dts/qcom/monaco-arduino-monza.dts
> index 299d0da15a150..afa6f0ecbf602 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts

[ ... ]

> @@ -429,6 +463,22 @@ pcie@0,0 {
>  		ranges;
>  		reg =3D <0x010000 0x00 0x00 0x00 0x00>;
> =20
> +		pcie@1,0 {
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			device_type =3D "pci";
> +			compatible =3D "pciclass,0604";
> +			bus-range =3D <0x00 0xff>;

[Severity: Low]
Does this bus-range property create an invalid PCI topology loop?

The pcie@1,0 downstream port is configured as a PCI-to-PCI bridge. Based on
its reg property (0x020800), it sits on primary bus 2. However, the bus-ran=
ge
property here defines a secondary bus of 0.

Because a downstream secondary bus must be strictly greater than its upstre=
am
primary bus, having a secondary bus of 0 creates an impossible PCI
topological loop.

While Linux's PCI core currently ignores the bus-range property for downstr=
eam
P2P bridges and relies on dynamic enumeration instead (avoiding any runtime
impact), this still introduces a logically incorrect hardware description i=
nto
the device tree.

Should this property be omitted or updated to accurately reflect the
downstream bus topology?

> +			ranges;
> +			reg =3D <0x020800 0x00 0x00 0x00 0x00>;
> +
> +			port {
> +				pcie_ep: endpoint {
> +					remote-endpoint =3D <&lga_pcie_ep>;
> +				};
> +			};
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D11
